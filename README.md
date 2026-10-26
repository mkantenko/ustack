# ustack

My agent skills for Claude Code and Codex. Shaped after [tstack](https://github.com/t3dotgg/tstack), built for my workflow.

## Skills

| Skill | Say | What it does |
|---|---|---|
| `u-stop` | "U-stop" | Do the work, run `review-loop`, file the PR, stop. Never merges. |
| `u-merge` | "U-merge" | Everything `u-stop` does, then merges once the merge gate passes. |
| `council` | "council" | Opus, Sol, DeepSeek, and GLM review independently in parallel; every opinion is required. |
| `review-loop` | "review loop" | Codex, GLM, and DeepSeek review in parallel through T3 `delegate_task`, round after round until one comes back clean. |
| `takeover` | "takeover" or "take over" | Continue inherited work, preserve contributor credit, and finish through the requested PR workflow. |
| `outgoing-messages` | (automatic) | Signs and formats anything sent on my behalf, PR text included. |

- `council` is separate from `review-loop`; Opus is only in council.
- `u-merge` uses `u-stop`.
- `u-stop` uses `review-loop` and `outgoing-messages`.
- `takeover` uses `u-stop`, or `u-merge` when merging is authorized.

`takeover` is adapted from tstack; its MIT notice is included in `skills/takeover/LICENSE`.

## Install

```bash
bash install.sh
```

Links each skill into `~/.agents/skills/<name>` (read by Codex), then `~/.claude/skills/<name>` to that. Run it again after adding or renaming a skill.

## Requirements

- An authenticated `gh`.
- T3 Code, for `delegate_task`, `watch_pull_request`, and `link_pull_request`.
