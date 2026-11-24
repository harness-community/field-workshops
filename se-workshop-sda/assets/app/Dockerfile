FROM golang:1.27-alpine AS build
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o /sda-showcase .

FROM scratch
COPY --from=build /sda-showcase /sda-showcase
USER 65532:65532
EXPOSE 8080
ENTRYPOINT ["/sda-showcase"]
