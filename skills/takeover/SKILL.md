---
name: takeover
description: Use when the user says takeover or take over.
---

# takeover

Take responsibility for finishing the original goal while preserving the original contributors' credit. Do not defend an implementation just because another agent already built it.

Read the source PR, branch, or thread, including review findings and the user's later corrections. Use `t3_thread_read` for a source T3 thread. Resolve the handoff to the actual code and current head, and account for uncommitted work. Treat the handoff as context, not proof. Link any PR you take over with `link_pull_request` before continuing PR work.

Honor the requested in-place, replacement, or stacked continuation. For a replacement PR, import the original commits onto a new branch and add your fixes separately. Do not overwrite unrelated work or change the original PR when the user asked for a separate continuation.

Preserve Git authorship and existing co-author trailers. Credit the original contributors in the PR description and link the original PR when there is one. If the work will be squashed, preserve human author/co-author credit in the merge commit too, using verified identities rather than guessed emails. Model attribution is not a substitute for contributor credit.

Check the continuation against its intended base and current architecture. Rework what is necessary to finish the same goal, not unrelated features. Simplify the implementation without dropping intended behavior or surfaces. Recheck the source PR before finalizing: it may have improved while you were working.

Independently verify the original failure and realistic workflows, following repository guidance and permissions. Respect the user's test and code-comment constraints. State what remains unverified.

When the requested finish includes a PR, follow [u-stop](../u-stop/SKILL.md), including [review-loop](../review-loop/SKILL.md), to leave a reviewed PR open and unmerged. If the user authorizes merging, follow [u-merge](../u-merge/SKILL.md) instead. Takeover alone does not authorize merging or closing the original PR. Use [outgoing-messages](../outgoing-messages/SKILL.md) for PR text and any replies the user authorizes.

Report what you inherited, what you changed, how you verified it, how credit was preserved, and any remaining decision.
