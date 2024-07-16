# File: instruqt_functions.sh
# Author: Joe Titra
# Version: 0.2.2
# Description: Common Functions used across the Instruqt SE Workshops
# History:
#   Version    |    Author    |    Date    |  Comments
#   v0.1.0     | Joe Titra    | 04/19/2024 | Intial version
#   v0.1.5     | Joe Titra    | 04/29/2024 | Minor updates to standardize curl command across functions
#   v0.1.6     | Joe Titra    | 04/30/2024 | Added GCP functions
#   v0.1.7     | Joe Titra    | 05/02/2024 | Added setup_vs_code and verify_harness_login functions
#   v0.1.8     | Joe Titra    | 05/09/2024 | Added create_harness_delegate function
#   v0.2.0     | Joe Titra    | 05/10/2024 | Standardized Harness functions to always have api_key first
#   v0.2.1     | Joe Titra    | 06/14/2024 | Added add_k8s_service_to_hosts and updated create_harness_delegate
#   v0.2.2     | Joe Titra    | 06/19/2024 | Added get_k8s_loadbalancer_ip and render_manifest_from_template

####################### BEGIN FUNCTION DEFINITION #######################
#### AWS ####
function is_valid_aws_account_id() { # Function to check if the input is a valid AWS account ID
    local account_id=$1

    echo "Validating AWS Account ID."
    [[ "$account_id" =~ ^[0-9]{12}$ ]]
}

function verify_aws_account_created() { # Function to verify that an AWS account has been provisioned
    local max_retries=10
    local retry_interval=10
    local retry_count=0

    echo "Verifying AWS Account has been created..."
    while true; do
        local aws_account_id=$(eval echo "\${INSTRUQT_AWS_ACCOUNT_${INSTRUQT_AWS_ACCOUNTS}_ACCOUNT_ID}")
        echo "    DEBUG: AWS Account ID: $aws_account_id"
        if is_valid_aws_account_id "$aws_account_id"; then
            echo "Valid AWS Account ID found: $aws_account_id"
            break
        else
            echo "Waiting for a valid AWS Account ID..."
            local retry_count=$((retry_count + 1))

            if [ "$retry_count" -ge "$max_retries" ]; then
                echo "Maximum retries reached without obtaining a valid AWS Account ID."
                exit 1
            fi
            sleep "$retry_interval"
        fi
    done
    echo "Proceeding with operations on AWS Account ID: $aws_account_id"
}

#### GCP ####
function is_valid_gcp_project_id() { # Function to check if the input is a valid GCP project ID
    local project_id=$1
    [[ "$project_id" =~ ^[a-z][-a-z0-9]{4,28}[a-z0-9]$ ]]
}

function verify_gcp_project_created() { # Function to verify that a GCP project has been provisioned
    local max_retries=10
    local retry_interval=10
    local retry_count=0

    echo "Verifying GCP Project has been created..."
    while true; do
        local gcp_project_id=$INSTRUQT_GCP_PROJECT_HARNESS_PROJECT_ID
        echo "    DEBUG: GCP Project ID: $gcp_project_id"
        if is_valid_gcp_project_id "$gcp_project_id"; then
            echo "Valid GCP Project ID found: $gcp_project_id"
            break
        else
            echo "Waiting for a valid GCP Project ID..."
            local retry_count=$((retry_count + 1))

            if [ "$retry_count" -ge "$max_retries" ]; then
                echo "Maximum retries reached without obtaining a valid GCP Project ID."
                exit 1
            fi
            sleep "$retry_interval"
        fi
    done
    echo "Proceeding with operations on GCP Project ID: $gcp_project_id"
}

#### KEYCLOAK ####
function generate_keycloak_token() { # Function to generate bearer token
    local keycloak_endpoint="$1"
    local keycloak_admin_user="$2"
    local keycloak_admin_pwd="$3"

    echo "Generating Keycloak Token..."
    local response=$(curl --silent --request POST \
        --location "${keycloak_endpoint}/realms/master/protocol/openid-connect/token" \
        --header "Content-Type: application/x-www-form-urlencoded" \
        --data-urlencode "username=${keycloak_admin_user}" \
        --data-urlencode "password=${keycloak_admin_pwd}" \
        --data-urlencode "grant_type=password" \
        --data-urlencode "client_id=admin-cli")
  
    if [ $? -ne 0 ]; then
        echo "Curl command failed."
        if [ "$CLEANUP" = true ]; then
            echo "Attempting to continue the cleanup process..."
        else
            exit 1
        fi
    fi

    local keycloak_token=$(echo $response | jq -r ".access_token")

    if [ "$keycloak_token" == "null" ] || [ -z "$keycloak_token" ]; then
        echo "Token generation has failed. Response was:"
        echo "$response"
        if [ "$CLEANUP" = true ]; then
            echo "Attempting to continue the cleanup process..."
        else
            exit 1
        fi
    else
        echo "Token generation complete"
        KEYCLOAK_TOKEN="$keycloak_token"
    fi
}

function create_keycloak_user() { # Function to create workshop user
    local keycloak_endpoint="$1"
    local keycloak_realm="$2"
    local keycloak_token="$3"
    local user_email="$4"
    local user_name="$5"
    local user_pwd="$6"

    echo "Creating Keycloak User..."
    local response=$(curl --silent --request POST \
        --location "${keycloak_endpoint}/admin/realms/${keycloak_realm}/users" \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${keycloak_token}" \
        --write-out %{http_code} --output /dev/null \
        --data-raw '{
            "email": "'$user_email'",
            "username": "'$user_email'",
            "firstName": "'$user_name'",
            "lastName": "Student",
            "emailVerified": true,
            "enabled": true,
            "requiredActions": [],
            "groups": [],
            "credentials": [
                {
                    "type": "password",
                    "value": "'$user_pwd'",
                    "temporary": false
                }
            ]
        }')
  
    echo "HTTP status code: $response"
  
    if [[ "$response" -ne 201 ]] ; then
        echo "The user creation API is not returning 201... this was the response: $response"
        exit 1
    fi
}

function get_keycloak_user_id() { # Function to lookup workshop user id in Keycloak
    local keycloak_endpoint="$1"
    local keycloak_realm="$2"
    local keycloak_token="$3"
    local search_term="$4"

    echo "Getting Keycloak User ID..."
    local response=$(curl --silent --request GET \
        --location "${keycloak_endpoint}/admin/realms/${keycloak_realm}/users?briefRepresentation=true&first=0&max=11&search=${search_term}" \
        --header "Authorization: Bearer ${keycloak_token}")
  
    KEYCLOAK_USER_ID=$(echo $response | jq -r ".[0].id")
    echo "Keycloak User ID: $KEYCLOAK_USER_ID"
}

function delete_keycloak_user() { # Function to delete workshop user from Keycloak
    local keycloak_endpoint="$1"
    local keycloak_realm="$2"
    local keycloak_token="$3"
    local user_email="$4"

    # Get the workshop user ID from Keycloak
    get_keycloak_user_id $keycloak_endpoint $keycloak_realm $keycloak_token $user_email
    if [ "$KEYCLOAK_USER_ID" == "null" ]; then
        echo "Failed to determine the User ID."
    else
        echo "Deleting Keycloak User ID: $KEYCLOAK_USER_ID"
        local response=$(curl --silent --request DELETE \
            --location "${keycloak_endpoint}/admin/realms/${keycloak_realm}/users/${KEYCLOAK_USER_ID}" \
            --header "Authorization: Bearer ${keycloak_token}" \
            --write-out %{http_code} --output /dev/null)
      
        echo "HTTP status code: $response"
      
        if [[ "$response" -ne 204 ]] ; then
            echo "The user deletion API is not returning 204... this was the response: $response"
            if [ "$CLEANUP" = true ]; then
                echo "Attempting to continue the cleanup process..."
            else
                exit 1
            fi
        fi
    fi    
}

#### HARNESS ####
function create_harness_project() { # Function to create project in Harness
    local api_key="$1"
    local account_id="$2"
    local org_id="$3"
    local project_name="$4"

    echo "Creating Harness project '$project_name'..."
    local response=$(curl --silent --request POST \
        --location "https://app.harness.io/gateway/ng/api/projects?accountIdentifier=${account_id}&orgIdentifier=${org_id}" \
        --header "Content-Type: application/json" \
        --header "x-api-key: ${api_key}" \
        --data-raw '{
            "project":{
                "name":"'$project_name'",
                "orgIdentifier":"'$org_id'",
                "description":"Automated build via Instruqt.",
                "identifier":"'$project_name'",
                "tags":{
                    "automated": "yes",
                    "owner" : "instruqt"
                }
            }
        }')

    local response_status=$(echo $response | jq -r ".status")

    if [ "$response_status" == "SUCCESS" ]; then
        echo "Project '$project_name' created successfully."
    else
        echo "Failed to create project '$project_name'. Response: $response"
        exit 1
    fi
}

function invite_user_to_harness_project() { # Function to invite our new user to our new project
    local api_key="$1"
    local account_id="$2"
    local org_id="$3"
    local project_id="$4"
    local user_email="$5"
    #echo "Inviting the user to the project..."
    curl --silent --request POST \
        --location "https://app.harness.io/gateway/ng/api/user/users?accountIdentifier=${account_id}&orgIdentifier=${org_id}&projectIdentifier=${project_id}" \
        --header "Content-Type: application/json" \
        --header "x-api-key: ${api_key}" \
        --data-raw '{
            "emails":["'$user_email'"],
            "userGroups":["_project_all_users"],
            "roleBindings":[{
                "resourceGroupIdentifier":"_all_project_level_resources",
                "roleIdentifier":"_project_admin",
                "roleName":"Project Admin",
                "resourceGroupName":"All Project Level Resources",
                "managedRole":true
            }]
        }'
}

function invite_user_to_harness_project_loop() { # Function to handle inconsistent API calls
    local api_key="$1"
    local account_id="$2"
    local org_id="$3"
    local project_id="$4"
    local user_email="$5"
    local invite_attempts=0
    local max_attempts=4
    local invite_status=""

    echo "Inviting the user to the project..."
    local invite_response=$(invite_user_to_harness_project $api_key $account_id $org_id $project_id $user_email)
    local invite_status=$(echo $invite_response | jq -r ".status")
    echo "  DEBUG: Status: $invite_status"

    while [[ "$invite_status" != "SUCCESS" && $invite_attempts -lt $max_attempts ]]; do
        echo "User invite to project has failed. Retrying... Attempt: $((invite_attempts + 1))"
        local invite_response=$(invite_user_to_harness_project $api_key $account_id $org_id $project_id $user_email)
        local invite_status=$(echo $invite_response | jq -r ".status")
        echo "  DEBUG: Status: $invite_status"
        local invite_attempts=$((invite_attempts + 1))
        sleep 3
    done

    if [ "$invite_status" == "SUCCESS" ]; then
        echo "The API hit worked, your user was invited successfully."
    else
        echo "API hit to invite the user to the project has failed after $max_attempts attempts. Response: $invite_response"
        exit 1
    fi
}

function delete_harness_project() { # Function to delete project in Harness
    local api_key="$1"
    local account_id="$2"
    local org_id="$3"
    local project_id="$4"

    echo "Deleting Harness project '$project_id'..."
    local response=$(curl --silent --request DELETE \
        --location "https://app.harness.io/gateway/ng/api/projects/${project_id}?accountIdentifier=${account_id}&orgIdentifier=${org_id}" \
        --header "x-api-key: ${api_key}")

    local response_status=$(echo $response | jq -r ".status")

    if [ "$response_status" == "SUCCESS" ]; then
        echo "Project '$project_id' deleted successfully."
    else
        echo "Failed to delete project '$project_id'. Response: $response"
        if [ "$CLEANUP" = true ]; then
            echo "Attempting to continue the cleanup process..."
        else
            exit 1
        fi
    fi
}

function get_harness_user_id() { # Function to lookup workshop user id in Harness
    local api_key="$1"
    local account_id="$2"
    local search_term="$3"

    echo "Getting Harness User ID..."
    local response=$(curl --silent --request POST \
        --location "https://app.harness.io/gateway/ng/api/user/aggregate?accountIdentifier=${account_id}&searchTerm=${search_term}" \
        --header "Content-Type: application/json" \
        --header "x-api-key: ${api_key}")

    HARNESS_USER_ID=$(echo $response | jq -r '.data.content[0].user.uuid')
    echo "Harness User ID: $HARNESS_USER_ID"
}

function delete_harness_user() { # Function to delete workshop user from Harness
    local api_key="$1"
    local account_id="$2"
    local user_email="$3"

     # Get the workshop user ID from Harness
    get_harness_user_id $api_key $account_id $user_email
    if [ "$HARNESS_USER_ID" == "null" ]; then
        echo "Failed to determine the User ID."
    else
        echo "Deleting Harness User ID: $HARNESS_USER_ID"
        local response=$(curl --silent --request DELETE \
            --location "https://app.harness.io/gateway/ng/api/user/$HARNESS_USER_ID?accountIdentifier=${account_id}" \
            --header "x-api-key: ${api_key}")
      
        local response_status=$(echo $response | jq -r ".status")

        if [ "$response_status" == "SUCCESS" ]; then
            echo "User deleted successfully."
        else
            echo "Failed to delete user. Response: $response"
            if [ "$CLEANUP" = true ]; then
                echo "Attempting to continue the cleanup process..."
            else
                exit 1
            fi
        fi
    fi    
}

function verify_harness_login() { # Function to create project in Harness
    local api_key="$1"
    local account_id="$2"
    local user_name="$3"
    local time_filter=$(expr $(date +%s%N | cut -b1-13) - 300000)

    echo "Validating Harness login for user '$user_name'..."
    local response=$(curl --silent --request POST \
        --location "https://app.harness.io/gateway/audit/api/audits/list?accountIdentifier=${account_id}" \
        --header "Content-Type: application/json" \
        --header "x-api-key: ${api_key}" \
        --data-raw '{
            "actions": [
                "LOGIN"
            ],
            "principals": [{
                "type": "USER",
                "identifier": "'$user_name'"
            }],
            "filterType": "Audit",
            "startTime": "'$time_filter'"
        }')

    local response_items=$(echo $response | jq -r ".data.totalItems")

    if [ $response_items -ge 1 ]; then
        echo "Successful login found in audit trail."
    else
        echo "No Logins were found in the last 5 minutes"
        fail-message "No Login events were found for your user via the Harness API."
        #exit 1
    fi
}

function create_harness_delegate() { # Function to create project level delegate in Harness
    local api_key="$1"
    local account_id="$2"
    local org_id="$3"
    local project_id="$4"

    echo "Creating delegate for Harness project '$project_id'..."
    local response=$(curl --silent --request POST \
        --location "https://app.harness.io/gateway/ng/api/download-delegates/kubernetes?accountIdentifier=${account_id}&orgIdentifier=${org_id}&projectIdentifier=${project_id}" \
        --header "Content-Type: application/json" \
        --header "x-api-key: ${api_key}" \
        --write-out "%{http_code}" \
        --output instruqt-delegate.yaml \
        --data-raw '{
            "name": "instruqt-workshop-delegate",
            "description": "Automatically created for this lab",
            "clusterPermissionType": "CLUSTER_ADMIN"
        }')

    # If the request was successful, check if the response is valid YAML
    if [ "$response" -ge 200 ] && [ "$response" -lt 300 ]; then
        # Using a YAML parser like yq to validate YAML content
        if ! command -v yq &> /dev/null; then
            echo "  INFO: Skipping yaml validation as yq is not installed."
        else
            echo "  INFO: Validating YAML file with yq."
            if yq eval instruqt-delegate.yaml &>/dev/null; then
                echo "  INFO: Valid YAML file received. Applying it."
                kubectl apply -f instruqt-delegate.yaml
            else
                echo "  ERROR: The file is not a valid YAML."
            fi
        fi

    else
        echo "  ERROR: Request failed. Status Code: $response"
    fi
}

#### MISC ####
function setup_vs_code() { # Function to setup VS Code
    local service_port="$1"
    local code_server_directory="$2"

    function run_install() { # Function to handle positional parameters
        . /tmp/install.sh
    }
    # Download VSC
    if [ -x "$(which code-server)" ]; then
        echo "VS Code already installed."
    else
        echo "Installing VS Code..."
        curl --silent --request GET \
            --location "https://raw.githubusercontent.com/cdr/code-server/main/install.sh" \
            --output /tmp/install.sh
        chmod +x /tmp/install.sh
        run_install
    fi

    # Setup VSC
    sleep 2
    mkdir -p /home/harness/.local/share/code-server/User/
    chown -R harness:harness /home/harness/.local/share
    curl --silent --request GET \
        --location "https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/misc/vs_code/settings.json" \
        --output /home/harness/.local/share/code-server/User/settings.json
    curl --silent --request GET \
        --location "https://raw.githubusercontent.com/harness-community/field-workshops/main/assets/misc/vs_code/code-server.service" \
        --output /etc/systemd/system/code-server.service

    # Update VSC Service
    sed -i "s#EXAMPLEPORT#${service_port}#g; s#EXAMPLEDIRECTORY#${code_server_directory}#g" /etc/systemd/system/code-server.service
    systemctl daemon-reload        # Reload systemd to read new service
    systemctl enable code-server   # Enable service to start on boot
    systemctl start code-server    # Start the service
    # Add the VS Code extension for HCL files
    code-server --install-extension hashicorp.terraform
}

function add_k8s_service_to_hosts() { # Function to add a Kubernetes service IP to the /etc/hosts file
    local service_name="$1"
    local namespace="$2"
    local hostname="$3"
    local retries=0
    local max_retries=5
    local retry_delay=10  # seconds

    echo "Adding '$service_name' to the hosts file."
    # Loop to get the IP address with retries
    while :; do
        # Get the IP address of the service
        local ip_address=$(kubectl get service "$service_name" -n "$namespace" -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')

        # Check if the IP address was retrieved
        if [[ -n "$ip_address" && "$ip_address" != "<none>" && "$ip_address" != "None" ]]; then
            echo "Successfully retrieved IP address: $ip_address"
            break
        fi

        # Increment retries and check if maximum retries reached
        ((retries++))
        if ((retries == max_retries)); then
            echo "Failed to retrieve IP for service $service_name in namespace $namespace after $max_retries attempts."
            return 1
        fi

        # Wait before retrying
        echo "Retrying in $retry_delay seconds... ($retries/$max_retries)"
        sleep $retry_delay
    done

    # Check if the entry already exists and remove it
    if grep -q "$hostname" /etc/hosts; then
        sed -i "/$hostname/d" /etc/hosts
    fi

    # Add the new hosts entry
    echo "$ip_address $hostname" | tee -a /etc/hosts > /dev/null

    echo "Added $hostname with IP $ip_address to /etc/hosts"
}

function get_k8s_loadbalancer_ip() { # Function to get the external IP of a K8s LoadBalancer service
  local service_name=$1
  local namespace=${2:-""} # Default to current namespace
  local max_attempts=${3:-30} # Default to 30 attempts
  local sleep_time=${4:-2} # Default to 2 seconds between attempts

  echo "Waiting for LoadBalancer IP for service ${service_name}..."
  for ((i=1; i<=max_attempts; i++)); do
    if [[ -n "$namespace" ]]; then
      local external_ip=$(kubectl get svc ${service_name} -n ${namespace} -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
    else
      local external_ip=$(kubectl get svc ${service_name} -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
    fi

    if [[ -n "$external_ip" ]]; then
      echo "Service ${service_name} has an external IP: ${external_ip}"
      EXTERNAL_IP=$external_ip
      return 0
    fi
    echo "Attempt $i/$max_attempts: LoadBalancer IP not yet available, retrying in ${sleep_time}s..."
    sleep $sleep_time
  done

  echo "Failed to get LoadBalancer IP for service ${service_name} after ${max_attempts} attempts."
  exit 1
}

function render_manifest_from_template() { # Function to replace placeholders in the template
    local template_file=$1
    local output_path=$2
    local apps_string=$3

    function replace_values() {
        local template_file=$1
        local output_file=$2
        local app_name=$3
        local app_port=$4
        local ip_address=$5

        sed \
            -e "s/{{ APP_NAME }}/${app_name}/g" \
            -e "s/{{ APP_PORT }}/${app_port}/g" \
            -e "s/{{ HOSTNAME }}/$HOST_NAME/g" \
            -e "s/{{ PARTICIPANT_ID }}/$INSTRUQT_PARTICIPANT_ID/g" \
            -e "s/{{ IP_ADDRESS }}/$ip_address/g" \
            "${template_file}" > "${output_file}"
    }
    ORIGINAL_IFS=$IFS
    IFS="," read -r -a apps <<< "$apps_string"
    echo "$apps"
    for app in "${apps[@]}"; do
        echo "Rendering template for ${app}"
        IFS=":" read -r app_name app_port ip_address <<< "$app"
        local output_file="nginx-${app_name}.yaml"
        replace_values "$template_file" "${output_path}/$output_file" "$app_name" "$app_port" "$ip_address"
    done
    IFS=$ORIGINAL_IFS
}

######################## END FUNCTION DEFINITION ########################
