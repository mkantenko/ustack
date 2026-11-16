# ustack

My essential skills for agentic work. Forked from [tstack](https://github.com/t3dotgg/tstack), excluding outgoing-messages.

## Skills

| Skill | Say | What it does |
|---|---|---|
| `u-stop` | "U-stop" | Do your task, run `review-loop`, file the PR, stop. |
| `u-merge` | "U-merge" | Do your task, run `review-loop`, file the PR, merge. |
| `council` | "council" | Opus, Sol, and [third model TBD] do reviews, every opinion is required. |
| `review-loop` | "review loop" | Sol reviews through T3 `delegate_task`, round after round until one comes back clean. |
| `takeover` | "takeover" or "take over" | Continue inherited work, preserve contributor credit, and finish through the requested PR workflow. |
| `outgoing-messages` | (automatic) | Signs and formats anything sent on user's behalf.|

- `u-merge` uses `u-stop`.
- `u-stop` uses `review-loop` and `outgoing-messages`.
- `takeover` uses `u-stop`, or `u-merge` when merging is authorized.

## Install

```bash
bash install.sh
```

Links each skill into `~/.agents/skills/<name>` (read by Codex & other agents), then `~/.claude/skills/<name>` to that. Run it again after adding or renaming a skill.

## Requirements

- An authenticated `gh`.
- T3 Code, for `delegate_task`, `watch_pull_request`, and `link_pull_request`.
