---
name: create-component-agnostic
description: Create or update Next.js UI components. Use when asked to build a Server Component, Client Component, form, table, filter, dashboard section, provider, or reusable UI using the current repo's established patterns.
---

# Create Component

Request: `$ARGUMENTS`

## Placement

- Put route-specific pieces in the route's local component folder, often `_component/`.
- Put cross-feature UI in the shared components area.
- Put global hooks in the shared hooks area; keep feature-only hooks near the feature.
- For multi-file components, use direct imports. Avoid barrels unless the repo already uses them there.

## Server vs Client

- Default to Server Components.
- Add `"use client"` only for hooks, browser APIs, event handlers, client state, or client-only libraries.
- Let Server Components fetch/prepare data and pass typed props into Client Components.
- Keep URL-driven filters/pagination in `searchParams` when the state should be shareable.
- Wrap browser-only dependencies in a Client Component; use `next/dynamic({ ssr: false })` only when SSR is unsafe.

## Forms, Mutations, State

- Use existing action/service/state helpers before adding new patterns.
- Reuse the repo's pending, error, toast, loader, and field-error conventions.
- Show field errors next to fields and request-level errors separately.
- Use existing shared stores or context helpers for cross-component state.
- Keep purely local UI state inside the component.

## UI Rules

- Match nearby components for layout, density, naming, and imports.
- Use the repo's UI primitives, icon library, class helpers, and route helpers.
- Use explicit prop types. Avoid `any`; use `unknown` plus narrowing when needed.
- Keep components pure and comments sparse.

## Verification

- Run the narrowest relevant check after editing.
- If checks cannot run, report why.
