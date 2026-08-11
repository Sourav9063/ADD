---
name: diagnosing-bugs
description: Diagnose bugs, test or build failures, unexpected behavior, and performance regressions with an evidence-first loop. Use when the user reports something broken, failing, throwing, flaky, or slow, or explicitly asks to diagnose, debug, find a root cause, or fix a defect. Diagnosis alone does not authorize implementation.
---

## Diagnosing Bugs

Separate authority first: a request to diagnose authorizes investigation and explanation; implement a fix only when requested or clearly included in the task.

Protect evidence. Redact secrets, credentials, tokens, personal data, and sensitive headers from commands, logs, fixtures, and reports. Quote only decisive output.

### Evidence Loop

1. Reproduce the user's exact symptom with the tightest reliable pass/fail signal available: a focused test, command, request, browser check, replay, or minimal harness. If reproduction is unavailable, state what was tried and request the smallest missing artifact or access instead of guessing.
2. Minimize the reproduction. Remove inputs, callers, configuration, data, and steps one at a time while preserving the failure.
3. Inspect the affected path, recent relevant changes, boundaries, and a nearby working example. For performance failures, establish a measured baseline before proposing optimization.
4. Form a small ranked set of falsifiable hypotheses. State the prediction for each and test one variable at a time with the least invasive probe.
5. Identify the root cause supported by evidence. Distinguish it from symptoms, correlated failures, and speculation.

### Fix and Verify

When authorized to fix:

- Change the narrowest root-cause seam; avoid bundled refactors and adjacent cleanup.
- Turn the minimal reproduction into focused regression coverage at an observable seam when practical. Confirm it fails before the fix and passes after it.
- Re-run the original, unminimized reproduction and relevant surrounding checks.
- Remove temporary logs, probes, fixtures, and harnesses unless they became intentional tests or diagnostics.

Done means the root cause is evidence-backed; when a fix was authorized, the original symptom no longer reproduces, regression coverage passes or its absence is explained, and temporary instrumentation is gone.
