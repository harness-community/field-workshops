# Extra Credit: Software Delivery Agent Workshop

Done early? These challenges are for you. You can do them in any order, at any point in the
workshop, and they won't affect the labs or their **Check** buttons. There's nothing to submit.
Explore, and ask your instructor if you find something interesting.

## Ground rules

So you don't break the labs you haven't finished yet:

- **Don't change** the `showcase` pipeline, the `main` branch of `sda-showcase`, the `dev`
  environment, or the `guardrails` policy set. If the agent proposes a change to any of them,
  decline it.
- **Name anything new `xc_something`**, so it's obviously extra credit.
- **Got a permissions error?** That feature is locked in this sandbox. Move on to the next
  challenge.

---

## 1. Interrogate your pipeline (5 min)

The agent can read as well as write. Click **Ask AI**, start a new chat, and ask it about the
pipeline you built:

```
Draw the showcase pipeline as a Mermaid flowchart, including the rollback steps. Don't change anything.
```

```
If the canary pod crashed as soon as it started, which step in the showcase pipeline would fail first, and what would Harness do next? Don't change anything.
```

```
List three ways the showcase pipeline could fail in production that its current checks wouldn't catch.
```

**Your challenge:** find one claim in its answers you can confirm or disprove from the execution
history. Was it right?

## 2. Say no to the agent (5 min)

Approving proposals is half the skill. Rejecting them is the other half.

```
Show me how the Deploy stage of the showcase pipeline would look as a Blue Green deployment instead of a canary. Show the YAML here in the chat, but don't change the pipeline.
```

Read the proposal and compare it with your canary. If the agent offers to apply it, decline.
(Applied it by accident? Ask your instructor, who can put the canary back with one click.)

**Your challenge:** name one thing Blue Green gives you that your canary doesn't, and one thing
it costs. Then ask the agent whether you got it right.

## 3. Write a policy, and test it without turning it on (10 min)

Lab 5 used a policy someone else wrote. Now write your own. The agent drafts it, and you test it
against your real pipeline. It never gets switched on, so nothing is blocked.

1. Ask the agent:
   ```
   Write an OPA policy named xc_shell_timeouts for pipelines that denies any Shell Script step without a timeout, or with a timeout over 5 minutes. Don't add it to a policy set.
   ```
2. Go to **Project Settings** → **Policies** and open `xc_shell_timeouts`.
3. In the policy editor, open **Testing Terminal** and click **Select Input**. Lab 5 already
   evaluated your `showcase` pipeline, so pick one of those evaluations, then click **Test**.

**Your challenge:** your health checks have a 3-minute timeout, so they should pass. Edit the
policy's limit to 2 minutes and test again. Does it catch both health checks? Put it back when
you're done.

## 4. Make your canary reusable (10 min)

You built a good canary. Other teams shouldn't have to build it again.

```
Create a stage template named xc_canary_deploy, based on the Deploy stage of the showcase pipeline, with the service, environment and infrastructure as runtime inputs. Don't change the showcase pipeline.
```

Open **Project Settings** → **Templates** and look at what it made.

**Your challenge:** which parts of the stage became runtime inputs (`<+input>`), and which stayed
fixed? If you were a platform team, what would you lock down so every team's deploy keeps its
health check?

## 5. Read the evidence (10 min)

Everything the labs did left a trail. Find it without asking the agent:

- **Your service:** open **Services** → `showcase`. Which version is running in `dev` right now,
  and how many instances?
- **Your artifact:** open **Artifact Registries** and find the `sda-showcase` image. How many
  tags does it have, and which build produced the one that's running?
- **Your bad release:** open the rolled-back execution from Lab 4. How many seconds passed
  between the canary deploy finishing and the rollback starting?
- **Your history:** open **Overview** for the Deployments module. What's your deployment success
  rate today?

**Your challenge:** work out how long it took to roll back the bad release. Then ask the agent
the same question and see if it agrees.

## 6. Debug a pipeline you didn't write (15 min)

Have the agent build you a puzzle. Ask it to keep the answer to itself:

```
Create a new pipeline named xc_puzzle with one Custom stage and one Shell Script step. Give the pipeline the same delegate selector the showcase pipeline uses. The step should run a short bash script that fails because of a subtle bug, such as an off-by-one, a quoting mistake or a wrong path. Don't tell me what the bug is.
```

> The puzzle runs on your own sandbox's delegate rather than Harness Cloud, so it doesn't take
> build capacity from anyone still on Lab 2.

Run it, then find the bug yourself before you click **Analyze Error**. Fix it in the pipeline's
YAML view, then run it again until it's green.

**Your challenge:** beat the AI. Find the bug before you read its analysis.

---

Finished all six? Ask your instructor for the hardest question you can think of about how this
would work in your own team's delivery process.
