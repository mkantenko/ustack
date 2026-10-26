---
name: outgoing-messages
description: Must be used before drafting or sending any message, reply, or comment on the user's behalf. Load this skill before composing the final text.
---

# Agent communication

This applies to direct messages, email, comments, and other communications sent on the user's behalf. Know which model and agent you are before signing. The recipient should be able to tell who wrote the message, and the message should sound like a person rather than generated copy.

Treat this as a pre-send requirement. Finish the exact message, including its signature, before calling a send or reply tool. Do not send first and add the signature or other required content in a second message. If a sent message needs a correction and the available tools cannot edit it, explain that to the user and wait for authorization before sending a follow-up correction.

## Format the message

- Preserve the user's intent and tone. Keep the message concise and specific to the context.
- Unless the user asks for different signature wording or asks for no signature, put an authorship line at the end, separated from the body by one blank line (two newline characters). Use this format, selecting the verb below and replacing the identity placeholders: `[Verb] by [model] via [agent].`
- Choose the signature verb automatically: `Created` for code proposals/PRs, `Posted` for posts/comments, `Sent` for email/messages, `Drafted` when the user will deliver it, otherwise `Written`. Use the intended delivery verb in approval drafts. User-specified wording takes precedence.
- Before sending, determine your model identity and agent identity from the current runtime or system instructions. Never copy the example identities as if they were yours, guess, or substitute a harness or platform name for either identity.
- If you cannot determine one of the identities, do not invent it. Use the identity you can establish and tell the user that the other identity was unavailable before sending, unless the user specifies different wording.
- If the message is in another language, translate the signature naturally while keeping the model and agent identities clear.

Example sent message for Opus 5.5 running via Claude Code:

```text
Hi, I can meet at 2. See you then.

Sent by Claude Opus 5.5 via Claude Code.
```

Ukrainian sent-message example for GPT-6.1 Sol running via Codex:

```text
Привіт! Я можу зустрітися о 14:00. Тобі підходить цей час?

Надіслав GPT-6.1 Sol через Codex.
```

## Group chats

Do not send or reply in a group chat unless the user explicitly asks you to post in that group. A request to find, read, summarize, or draft a group message does not authorize posting it. A direct request to send a message to a named group does.

If the destination is ambiguous, inspect the available conversation details and choose only when they identify the intended recipient or group clearly. Ask the user when multiple plausible destinations remain.

## Follow the user's signature instructions

The user may specify different authorship wording or ask to omit the signature. Follow that instruction for the requested message.
