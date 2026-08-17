---
name: create-action
description: Create a full 3-layer feature with types, repository, service, and server action following this repository's storage boundaries. Use when user asks to build CRUD, actions, service/repository layers, external API integrations, or a new backend feature.
---

# Create Action

Create a full 3-layer feature for requested entity or workflow.

Request: `$ARGUMENTS`

## Layer Rules

### `src/types/<name>.ts` - all types

- Domain interfaces, `<Entity>Row` (DB cols), filter types, sort unions, Zod schemas + inferred TS types
- Never define types in action/service/repo files
- Service imports types from `@/types/`, never from `@/action/`

### `src/repository/<name>.ts`

- Own every connection to external storage: PostgreSQL, HTTP APIs, or other persistence/network clients.
- Keep storage I/O, URL/query construction, transport cache options, and storage-level mapping here.
- Import all shared contracts from `@/types/<name>`; define no business rules.
- For SQL:
  - Import `query`, `withTransaction`, `handleDbError` from `@/lib/db`.
  - Use parameterized SQL only and whitelist dynamic sort fields.
  - Use `withTransaction` for multi-query writes.
  - Inside `withTransaction`, use `client.query()`, not module `query()`.
  - Route DB failures through `handleDbError(error)`.
- For external APIs:
  - Add `import "server-only"`.
  - Use configured API clients and centralized route/config helpers.
  - Return the raw response as `unknown` when service validation is required.
  - Keep request freshness, headers, and transport options here.
- Never place `query`, `fetch`, or `apiRequest` calls in services or actions.

### `src/services/<name>.ts`

- Import types from `@/types/<name>` and repository functions from `@/repository/<name>`.
- Keep only business logic, orchestration, and Zod runtime validation here.
- Validate request-independent domain rules and repository responses via `schema.safeParse()`.
- Throw `AppError(status, msg)` for expected failures (400/403/404/409/422/502...).
- Do not parse `FormData`, query-param arrays, cookies, headers, or other request shapes.
- Do not call DB/API clients, perform cache invalidation, or handle request concerns here.

### `src/action/<name>.ts`

- `"use server"` top
- Use `createAction` from `@/lib/create-action`; do not call `handleError` directly.
- Gate by level:
  - `createAction.public(async (...args) => ...)` - no auth
  - `createAction.user(async (user, ...args) => ...)` - any logged-in
  - `createAction.reviewer(async (user, ...args) => ...)` - reviewer or admin
  - `createAction.admin(async (user, ...args) => ...)` - admin only
- Non-public callbacks receive `user` first; prefix `_user` if unused.
- Parse and normalize request inputs here: `FormData`, query-param arrays, empty strings, headers, and action-state arguments.
- Call services only. Never call repositories or storage clients directly, including for trivial reads.
- Add `_prevState: FooState` after `user` only for `useActionState`.
- Keep action state types in `src/types/<name>.ts`.
- Keep `revalidatePath`/`revalidateTag` in actions after mutations.
- API routes perform equivalent request parsing and call services through `withApiHandler`.

Example:

```ts
"use server";

import { revalidatePath } from "next/cache";
import { createAction } from "@/lib/create-action";
import { listFoos, updateFooWorkflow } from "@/services/foo";

export const getFoos = createAction.reviewer(
  async (_user, rawLimit: unknown, rawOffset: unknown) => {
    const limit = Number(rawLimit) || 50;
    const offset = Number(rawOffset) || 0;
    return listFoos({ limit, offset });
  },
);

export const updateFoo = createAction.reviewer(
  async (user, id: number, patch: FooPatch) => {
    await updateFooWorkflow(id, patch, user);
    revalidatePath("/foo");
  },
);
```

## Output

Implement files directly. Note assumptions about columns/rules.
