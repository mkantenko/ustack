---
name: u-merge
description: Use when the user says U-merge.
---

# U-merge

Miley is not watching you work. Do everything `u-stop` does, then merge instead of stopping. "U-merge" is the merge authorization.

## Merge gate

All must hold on the current head SHA:
- the last complete `review-loop` round ran on this SHA and came back clean. If the head moved after that round, run `review-loop` again.
- every required CI check has passed. If checks are still running, call `watch_pull_request` and end your turn, then check the gate again on wake-up.
- GitHub reports the PR open, not a draft, and mergeable

## Merge

Use the method the repo uses (`gh pr list --state merged -L 5`): `gh pr merge <n> --merge|--squash|--rebase --match-head-commit <sha>`. Never pass `--admin` or bypass protections.

If the merge is blocked (permission check, branch protection, conflicts), don't route around it through the API or a local merge. Ask with the question tool (`AskUserQuestion` in Claude Code, `request_user_input` in Codex). Include the PR link, the blocker, and the exact command.

After the merge, call `unwatch_pull_request`, fast-forward local `main`, and report the merge commit. Deploy, rebuild, or release only if Miley asked, and check the real host before touching it.

## Several PRs

Read each thread, gate each PR, and merge in dependency order. Stop at the first one that conflicts.

## Briefing another thread

Write "Use `u-merge`" into the brief. Never write "merging is yours" into it. Send a report back only if Miley named a target, and only after the merge.
