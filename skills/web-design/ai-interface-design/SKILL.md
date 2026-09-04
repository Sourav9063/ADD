---
name: ai-interface-design
description: Build or review AI and LLM product surfaces. Use when adding a chat or assistant panel, prompt composer, streaming response, suggested prompts, citations or confidence signals, regenerate and response feedback, tool-call or agent approval steps, model pickers, or token, cost, and rate-limit displays.
---

# AI Interface Design

Assumes `design-foundations` for tokens, motion, and focus. A model's output is
probabilistic; the interface is not. Its job is to set an honest expectation, show work in
progress, keep the user in control of anything irreversible, and stay usable when the answer
is wrong.

## Before the first prompt

- Say what this assistant can do, in specifics, in the surface itself. "Ask me anything" sets an expectation the model will not meet; three concrete examples of in-scope work set a reachable one.
- Offer starter prompts as buttons that fill the composer, not as prose the user has to retype. Keep them scoped to what the product actually does well.
- State the boundary once, plainly: what data it can see, what it cannot do, that output can be wrong. Do not bury it in a disclaimer nobody reads, and do not repeat it under every message.
- **One assistant per product.** Two entry points - a support bot and a product copilot - leave people asking the wrong one and blaming the product. If the surface is worth having, it is reachable from every page and keeps its thread when the user navigates.

## The composer

- Multiline by default, growing to a cap then scrolling. Enter sends, Shift+Enter breaks the line, and say so in the placeholder or a hint the first time.
- Dock it. A floating composer that overlays the last message is the most common mobile bug in this surface; pad the transcript by composer height and let the keyboard push it rather than jump it.
- Attachments, mode switches, and model choice live in the composer, not in a settings page. Show attached context as removable chips so the user can see exactly what is being sent.
- Keep the draft. Navigating away, an error, or a rejected request must never eat typed text.
- Disable send only for an empty composer. During generation the send button becomes **Stop** (see `button` for the busy-state rule).

## Streaming

Stream anything that takes more than a beat. Streaming reduces perceived latency, proves the
system is alive, and lets people skim and stop early. Do not stream tiny deterministic
results or anything that must paint as a unit, like a chart or a table.

- **Never autoscroll to the end of a streaming response.** The user is reading the top while tokens land at the bottom; yanking them down makes a long answer unreadable. Pin the scroll where they left it, follow only while they are already at the bottom, and offer a "Jump to latest" control.
- Reserve the growing container so surrounding content does not shift with every token, and buffer incomplete markdown - a half-open bold tag or an unclosed code fence must not restyle the message. Render code blocks when the closing fence arrives, or render them progressively with a visible in-progress marker.
- **Stop must be present the whole time and must keep the partial output.** Discarding what was generated punishes the user for interrupting. Offer Continue where it makes sense.
- Distinguish thinking from generating. Reasoning, retrieval, and tool steps get a collapsed status line naming the current step; do not fake a progress bar for work with no known duration (see `feedback-design`).
- Latency budget still applies: acknowledge the send in under 100ms with the message appearing in the transcript, whatever the model does next.

## The response

- Long-form answers get a real reading measure (~65-75 characters) and generous line height. A chat panel that stretches text edge to edge is unreadable at desktop width; see `typography-design`.
- **Cite where a claim can be checked.** Link the source inline, make it openable without leaving the thread, and never synthesize a citation the retrieval step did not return. No sources is an honest state; fabricated ones destroy the surface.
- Express uncertainty in words attached to the claim, not as a percentage the model cannot justify. Confidence chrome that is always green teaches people to ignore it.
- Per-message actions: copy, regenerate, edit-and-resend, and save or share. Regenerating keeps the previous answer reachable rather than overwriting it - people frequently prefer the first one.
- Feedback controls (thumbs, report) are optional for the user and must say what happens next; asking for a rating on every message trains people to ignore all of them.
- Collapse long output behind progressive disclosure only when the summary is genuinely usable alone. Collapsing the answer to keep the thread short just adds a click.
- Let people take the output with them: copy as markdown, download, or share the thread. This is the most frequently requested and most frequently missing feature in chat products.
- Allow resizing or expanding the panel when responses contain tables, code, maps, or images.

## Agents and tool use

- Show the plan before the actions when a request will take multiple steps, and keep a live step list with what succeeded, what failed, and what is running.
- **Gate by consequence, not by category.** Reads run freely; writes to the user's data, spend, and anything sent outside the product need an explicit confirm that names the exact action and target - the same rule as `destructive-actions`.
- Give long-running agents a budget the user sets and can see burn down: steps, time, or spend. Stop at the ceiling and ask, rather than continuing quietly.
- Checkpoint before each consequential step and expose an undo or restore path. Where a step cannot be undone, say so in the confirm.
- Pause, resume, and abandon must all work, and an abandoned run must leave the system in a state the user can understand.

## When it is wrong

- **Always leave the manual path in place.** The non-AI way to do the task is the fallback when the model is down, rate-limited, or simply wrong, and it should not be hidden behind the assistant.
- Distinguish the failure modes, because the recovery differs: no answer found, refused, tool failed, rate-limited, context too long, service down. A single "Something went wrong" leaves the user with nothing to try.
- Refusals state what was declined and offer the nearest thing the product can do. Retry preserves the original prompt.
- Content too long for the context window is a product problem, not a user problem: trim, summarize, or say which parts were dropped.

## Cost, limits, and models

- Warn before the limit, not at it: a visible remaining count as it gets close, with the reset time and the upgrade path.
- If the user pays per use, show the running cost where the spending happens and let them cap it. Cost revealed only on the invoice is a trust failure.
- A model picker needs a plain-language difference (faster, deeper, cheaper) and a sensible default. Most people will never change it; the default is the real decision.

## Accessibility

- Announce, do not narrate. Streaming tokens into a live region floods a screen reader; keep the transcript out of `aria-live`, and announce start ("Generating"), completion, and errors as short polite messages. `role="log"` on the transcript suits assistive tech that supports it.
- The transcript is a list of messages with each turn's author in text, not conveyed by bubble alignment or color alone.
- Every streamed answer must be reachable and readable after it finishes; keyboard users need focus to stay in the composer during generation and to be able to reach Stop.
- Voice input is an alternative, never the only input. Transcripts and captions apply to any spoken output; see `media-design`.
- Suggested-prompt chips are real buttons in the tab order, and the composer keeps its label.
