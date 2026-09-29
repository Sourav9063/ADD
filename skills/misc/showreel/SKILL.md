---
name: showreel
description: Raise the quality bar to portfolio level when the user explicitly asks for it, with phrases like "go all out", "showreel", "impress me", "portfolio quality", or "make it exceptional". Applies to code, UI, and design work. Do not use by default; ordinary tasks keep the normal scope and YAGNI rules.
---

# Showreel

Treat the result as your showreel for a resume: work that shows what an incredible
software engineer you are. Go all out on craft, not on scope.

## Where the ambition goes

- **Correctness**: handle edge cases, empty, error, loading, and boundary states the task
  implies. No happy-path-only work.
- **Design of the code**: clear names, sharp module boundaries, types that make invalid
  states unrepresentable, no dead code.
- **Verification**: tests that prove the behavior, including the awkward cases. Run them.
- **Experience**: for UI, finish polish, motion, hierarchy, responsiveness, and
  accessibility past the functional baseline. Follow `design-foundations`.
- **Performance**: no obvious waste; measure before claiming speed.

## Where it does not go

- No features, screens, options, or abstractions the user did not ask for. Suggest them
  instead.
- No rewrites of neighbouring code outside the task.
- No flourish that hurts clarity, accessibility, or performance.

## Before finishing

Review the work as a skeptical hiring panel would. Fix what would embarrass you, then
report what you raised above baseline and what you deliberately left out.
