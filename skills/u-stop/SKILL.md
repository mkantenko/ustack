---
name: u-stop
description: Use when the user says U-stop.
---

# U-stop

Miley is not watching you work. Finish the requested work, prove it, run [review-loop](../review-loop/SKILL.md), file the reviewed PR, and stop. Leave it open and unmerged.

## Finish and verify

Work on a task branch, preserve unrelated changes, and make the smallest change that completes the request. Commit finished changes promptly. You may push, rebase, resolve conflicts, and use `--force-with-lease` on this task's branch when needed.

Use evidence observed in this session: reproduce the failure and verify the fix, run the relevant repo checks, and inspect UI or runtime behavior directly when the change requires it. Include screenshots in the PR when they help demonstrate the result and can be uploaded. Respect the user's testing constraints: do not add tests unless adding new functionality; update or remove tests for intentionally changed behavior before changing the code. Do not add code comments.

## Review and file

1. Run `review-loop` on the pushed head before filing the PR. A PR is reviewed only when the loop completes with at least one reporting lane and no accepted findings remaining. Failed lanes alone do not constitute approval.
2. Fix accepted findings and verify each fix. Review must cover the final diff; substantive changes or conflict resolutions after review require another round.
3. File the PR, or update the existing one. Lead with the concrete problem and resulting behavior, include verification evidence and the review decisions, and disclose any remaining limitations. Link the PR to the T3 thread with `link_pull_request` immediately after creating or pushing it.
4. Mark it ready only once it is actually reviewed. Confirm the live PR is open, its head matches the reviewed commit, and it is not a draft. Report checks and mergeability accurately; do not describe pending or failed checks as passing.

## Prevent accidental merging

Never merge, enable auto-merge, enter a merge queue, push to the default branch, bypass protections, or delegate those actions under U-stop.

For an existing PR, disable auto-merge and remove it from any merge queue before starting; check again before each push and before handoff. Report any such changes. If you cannot prevent automatic merging, stop and explain the blocker. If someone else already merged the PR, report that state.

## Handoff or blocker

Stop after filing the reviewed PR. Do not start a GitHub bot-review or babysitting workflow. Call `unwatch_pull_request` for any active watch before handing back.

Report the PR link, final head SHA, verification, review outcome, and any remaining blockers. State that the PR remains open and unmerged. Distinguish a reviewed PR from one that is also ready to merge; identify pending checks, conflicts, or required human approval.

If you cannot finish or verify the work, the review loop fails, or a material ambiguity requires Miley's decision, use the harness's question tool. Include the PR link if available, the blocker, what you tried, and options with your recommendation first. If no question tool is available, explain the blocker in the final response and leave the PR unmerged; do not claim it is reviewed.
