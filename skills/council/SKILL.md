---
name: council
description: Use when the user says council.
---

# council

Bring independent reviewers to the user's request, plan, or code change. Use all three models below unless the user explicitly changes the panel. Council is separate from `review-loop`; requesting one does not automatically run the other.

## Panel

| Lane | Target |
|---|---|
| Opus | `{"providerInstanceId":"claudeAgent","model":"claude-opus-5-5","options":{"effort":"xhigh"}}` |
| Sol | `{"providerInstanceId":"codex","model":"gpt-6.1-sol","options":{"reasoningEffort":"xhigh"}}` |
| GLM | `{"providerInstanceId":"opencode","model":"opencode-go/glm-5.3-flash","options":{"variant":"max"}}` |

Call `orchestrator_capabilities` before delegating to confirm model IDs and supported options. Report unavailable models; do not substitute Muse, Gemini, another model, or an OpenCode Zen route for the configured Go routes. Every selected reviewer is required. If any reviewer cannot run, report council as incomplete. Attempt every available lane even if another fails.

## Run the council

Start one T3 `delegate_task` per available model in parallel, with `role:"review"`, `mode:"async"`, and a fresh `clientRequestId` for each lane and round. Put the model settings in `target.options`. For code reviews, use `isolation:"shared"` so reviewers can run tests in your checkout without reinstalling dependencies.

Give each delegate the same original request, user corrections, constraints, and relevant artifacts. For code, include the repo, intended base, exact head SHA, scoped diff, and verification results. Request review only: no edits, commits, pushes, PR posts, or subagents. Code reviewers share your checkout, so they may run tests and checks but must leave HEAD and the working tree as they found them. Do not expose other reviewers' current answers before their independent first pass.

Ask for concrete findings with severity, location, failure scenario, and suggested fix. For plans or decisions, request assumptions, tradeoffs, and supported objections. Ask code reviewers for a score out of 10 with a short justification; record `no score` when omitted. A score is reporting metadata, not an approval threshold.

Follow each delegate's returned `next` instructions and notifications. Do not poll. A timeout, usage limit, provider error, or reply without a substantive review is a failed lane, not approval. Retry an interrupted or blocked lane once; do not retry exhausted usage or funds in the same session. Cancel a run you replace or no longer need with `task_cancel`.

## Judge and repeat

Verify and deduplicate findings yourself. Accept concrete defects within the requested scope; reject unsupported claims and record why. Respect the user's test and code-comment constraints. Do not let repeated reviews expand the task. More votes do not make an unsupported claim correct, and agreement does not prove the absence of bugs.

Fix accepted defects, run relevant checks, commit, and push when the requested workflow calls for a remote branch. Substantive fixes require a fresh council round on the new head, with prior findings and decisions supplied to every available reviewer. Each recheck uses new `delegate_task` calls. Leave the checkout alone while reviews run. Documentation or wording-only corrections do not require another round.

Council is complete only when every selected reviewer has returned a substantive opinion. A failed or unavailable lane leaves council incomplete; never drop it from the completion gate or let the other reviewers stand in for it. Only the user can explicitly change the panel. For a code review to pass, every selected reviewer must have reviewed the final substantive diff, and no accepted finding from any reviewer may remain unresolved. Apply the same completion requirement to plans and decisions: every opinion is required even when reviewers disagree.

For feedback on plans or decisions, summarize useful recommendations and unresolved disagreements rather than manufacturing consensus. Escalate a material decision you cannot resolve through the harness's question tool.

## Report

Report the reviewed head or artifact, round count, each lane's completion or failure, confirmed findings and decisions, scores when supplied, and remaining limitations. If a PR exists, keep the results and per-round table in its description using [outgoing-messages](../outgoing-messages/SKILL.md); otherwise include them in the final response. Council itself does not authorize filing, merging, or closing a PR.
