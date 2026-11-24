package pipeline

# A Deployment stage passes if an Approval stage runs before it, or if its own
# execution includes a Harness Approval step.

deny[msg] {
	some i
	stage := input.pipeline.stages[i].stage
	not approved(stage, i)
	msg := denial(stage)
}

deny[msg] {
	some i, k
	stage := input.pipeline.stages[i].parallel[k].stage
	not approved(stage, i)
	msg := denial(stage)
}

approved(stage, i) {
	stage.type != "Deployment"
}

approved(stage, i) {
	approval_stage_before(i)
}

approved(stage, i) {
	has_approval_step(stage)
}

approval_stage_before(i) {
	some j
	j < i
	input.pipeline.stages[j].stage.type == "Approval"
}

has_approval_step(stage) {
	[_, node] := walk(stage.spec.execution.steps)
	node.type == "HarnessApproval"
}

denial(stage) = msg {
	msg := sprintf(
		"Stage '%s' deploys without a human approval. Add an Approval stage before it, or a Harness Approval step at the start of its execution.",
		[stage.name],
	)
}
