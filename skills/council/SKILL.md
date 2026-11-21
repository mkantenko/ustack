---
name: council
description: Use when the user says council.
---

# council

Bring in a panel of models to review a user's descriptive request, plan or change. Call all models defined unless requested by the user.

## Panel

| Lane | Target |
|---|---|
| Opus | `{"providerInstanceId":"claudeAgent","model":"claude-opus-5-5","options":{"effort":"xhigh"}}` |
| Sol | `{"providerInstanceId":"codex","model":"gpt-6.2-sol","options":{"reasoningEffort":"xhigh","serviceTier":"default"}}` |
| Gemini | `{"providerInstanceId":"antigravity","model":"gemini-4-neon","options":{"thought_level":"xhigh"}}` |

Call `orchestrator_capabilities` first to confirm model IDs and options. Report an unavailable model; never substitute another.

## Run

Start one delegate subagent per model in parallel with `runtimeMode:"auto"`. For code reviews, run them in your checkout to allow for running tests easily. (`isolation:"shared"`)

Pass every delegate the original request, user corrections, constraints, and relevant artifacts. For code, add the repo, base, exact head SHA, scoped diff, and verification results. Reviewers are review-only: no edits, commits, pushes, or PR posts, and they leave the working tree as found. Don't show reviewers each other's answers before their independent first pass.

Ask for findings with severity, location, failure scenario, and suggested fix. For plans or decisions, ask for assumptions, tradeoffs, and supported objections. Ask code reviewers for a score out of 10 with a short justification; record `no score` when omitted.

Don't poll. A timeout, usage limit, provider error, or empty reply is a failed lane, not approval; retry an interrupted lane once.

## Judge and repeat

Verify and deduplicate findings yourself. Accept concrete defects within scope; reject unsupported claims and record why. A re-raised rejected finding stays rejected without new evidence. Don't let rounds expand the task.

After substantive fixes, run a fresh round on the new head with the same inputs as the first round and no prior findings or decisions. Doc or wording-only fixes need no new round. Leave the checkout alone while reviews run.

Council is complete only when every reviewer has returned a substantive opinion on the final diff and no accepted finding is unresolved. A failed lane leaves it incomplete; the others can't stand in. For plans and decisions, summarize recommendations and unresolved disagreements instead of forcing consensus.

## Report

Report each lane's result, confirmed findings and decisions, scores, and the round count. With a PR, put them in its description; otherwise in the final response. Council doesn't authorize filing, merging, or closing a PR.
