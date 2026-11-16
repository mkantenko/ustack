---
name: review-loop
description: Use when the user says review loop, or when u-stop or u-merge calls for it.
---

# Review Loop

Each round, a T3 delegate reviewer runs against the pushed head. You verify every finding yourself, then fix and repeat until a round comes back clean.

## Panel

Do not use Opus in this workflow; it belongs to `council`. Use the other models the user names. Otherwise use Sol only:

| Lane | target |
|---|---|
| Sol | `{"providerInstanceId":"codex","model":"gpt-6.1-sol","options":{"reasoningEffort":"max","serviceTier":"default"}}` |

Call `orchestrator_capabilities` once before round 1 to confirm ids and option names. If a model is missing, drop that lane and say so; don't substitute.

## Each round

1. Commit and push the branch so the reviewers see a real head SHA. A PR doesn't need to exist yet.
2. In one turn, start one `delegate_task` per lane with `role:"review"`, `mode:"async"`, `isolation:"shared"`, `runtimeMode:"auto"`, and a new `clientRequestId` (`<slug>-r<N>-<lane>`). Reviewers use your checkout so they can run tests without reinstalling dependencies.
3. End your turn. Don't poll, and read each result when its notification arrives. Leave the checkout alone until every lane has finished.
4. Lanes are independent. A lane that ends without a findings list has failed (usage limit, insufficient funds, interrupted, provider blocked). It is not a clean review, and it does not stop the round. Retry an interrupted or blocked lane once. Leave a usage-limit or funds lane out for the rest of the session. The round is complete once every lane has reported or failed.
5. Confirm your branch HEAD and `git status` are unchanged.

## Reviewer prompt

Each round is a fresh review: from round 2 on, send the same parts with the new SHA and nothing from earlier rounds. Fill in these parts, in this order:
1. Role and limits: independent reviewer, round N, REVIEW ONLY, no edits, commits, pushes, or GitHub posts, findings as the final answer. It shares the author's checkout, so it may run tests and checks but must leave HEAD and the working tree as it found them.
2. Target: repo, PR URL if one exists, branch, head SHA, `git fetch origin && git diff origin/main...<sha>`, and the newest commit to focus on.
3. The original issue brief and the user's decisions, verbatim.
4. Hard constraints from AGENTS.md/CLAUDE.md, marked "do not recommend violating".
5. Output: for each finding, give severity, file:line, the defect in one sentence, a concrete failure scenario, and a fix. No style nits or speculation. Say explicitly if nothing material remains, and end with a numbered list (`R<N>-F1`...).

## Judging findings

Dedupe across lanes. Accept a finding only after you've read the code and confirmed or reproduced a concrete failure. Reject findings that are speculative, contradict the brief or repo rules, or add tests or comments. Also reject defects that predate the PR; send real ones to a follow-up thread. Record the reason for each decision. A re-raised rejected finding stays rejected without new evidence. Fix accepted findings, run the repo checks, and push.

## Stop or repeat

- Substantive code fixes → new round, with every lane that is still usable.
- Doc or wording fixes only → no new round.
- A complete round with at least one lane reporting and no accepted findings → done.
- Every lane failed → the round failed. Report that and stop; don't call the PR reviewed.
- The user says "stop them" or "use X this time" → `task_cancel` the running lanes and follow the new panel.

After each round, keep an accepted/rejected table. Put it in the PR description, or in the PR body when the PR is filed, and send the user one short status: the round number, the lanes that reported or failed, the decisions, and the next step.
