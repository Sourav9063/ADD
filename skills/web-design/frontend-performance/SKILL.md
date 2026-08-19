---
name: frontend-performance
description: Diagnose and fix web performance. Use when a page or interaction feels slow, when working on Core Web Vitals (LCP, INP, CLS), bundle size, images, fonts, caching, hydration, re-renders, list virtualization, or when setting performance budgets and checking regressions in CI.
---

# Frontend Performance

Measure, then fix the largest cost, then re-measure. Performance work without a profile is
decoration.

## Targets

| Metric | Good | What it measures |
| --- | --- | --- |
| **LCP** | < 2.5s | When the main content appears |
| **INP** | < 200ms | Responsiveness across all interactions |
| **CLS** | < 0.1 | Layout stability |
| TTFB | < 800ms | Server and network before anything renders |
| JS shipped | < 170KB gzip on the critical path | Parse + execute cost |

Judge on p75 of real users on mid-tier Android over 4G, not on your laptop. Lab tools
(Lighthouse, DevTools) find causes; field data (RUM, CrUX, `web-vitals`) decides
priorities. Perceived speed is its own target: anything over ~400ms of silence loses the
user's attention regardless of what the numbers say (see `feedback-design`).

## Diagnose first

1. Reproduce on throttled CPU (4–6×) and network: most regressions are invisible unthrottled.
2. DevTools Performance trace for interactions; the long-task list names the culprit.
3. Coverage tab for unused JS/CSS; the bundle analyzer for what is actually in the chunk.
4. React Profiler / `why-did-you-render` for re-render storms.
5. Network waterfall for request chains: a serialized chain of three round trips beats any micro-optimization for badness.

Write down the number before and after. "Feels faster" is not a result.

## LCP

- Identify the LCP element in DevTools; it is almost always a hero image or a headline blocked by a font.
- Preload it, serve it at the right size, and never lazy-load it. Lazy-loading the hero is a top-three LCP regression.
- Kill render-blocking resources: inline critical CSS, defer the rest, `async`/`defer` scripts.
- Remove request chains: the LCP image should be discoverable in the initial HTML, not fetched by JS after hydration.
- Cache aggressively: immutable hashed assets, a CDN in front, `stale-while-revalidate` for data.

## INP and main-thread work

- Break long tasks (>50ms). Yield with `scheduler.yield()` or chunk the work.
- Defer non-urgent state updates (`startTransition`), debounce input handlers (~300ms for search), and throttle scroll/resize with `requestAnimationFrame`.
- Move heavy parsing, diffing, or crypto to a Web Worker.
- Virtualize lists past ~100 rows with stable item heights.
- Memoize the expensive parts only; blanket `memo`/`useMemo` adds cost and hides the real problem, which is usually an unstable context value or a new object literal in props.
- Animate `transform` and `opacity` exclusively; anything triggering layout drops frames.

## CLS

- Reserve space for images and video with `width`/`height` or `aspect-ratio`.
- Reserve space for anything that arrives late: ads, embeds, banners, error text under form fields, and skeleton→content swaps that change shape.
- `font-display: swap` plus `size-adjust` on the fallback so the swap does not reflow.
- Never insert content above existing content unless the user asked for it.

## JavaScript

- Ship less: audit dependencies before adding them (a date library at 70KB for one format call), prefer platform APIs (`Intl`, `URLPattern`, `structuredClone`), and check for a modern lighter alternative.
- Code-split by route, and dynamic-import anything heavy and below the fold (editors, charts, maps, modals).
- Tree-shake properly: deep imports, `sideEffects: false`, no barrel files re-exporting a whole library into every page.
- Keep polyfills targeted to actually supported browsers.
- In React Server Component frameworks, keep `"use client"` at the leaves; a client boundary high in the tree drags everything beneath it into the bundle.
- Third-party scripts are usually the single largest cost. Inventory them, load them lazily or via a worker, and delete the ones nobody can name an owner for.

## Images, fonts, media

- Modern formats (AVIF/WebP), responsive `srcset`/`sizes`, `loading="lazy"` on everything except the LCP element, `fetchpriority="high"` on that one.
- Serve at display resolution: a 3000px image in a 400px slot is the most common waste in any codebase.
- Self-host fonts, subset them, preload only the weights used above the fold, and cap the family at 2 weights + 1 italic.
- Video: `preload="none"`, a poster image, and never autoplay above the fold on mobile.

## Data and rendering

- Render static content statically; stream the rest. Do not block the shell on slow data; stream it in with Suspense boundaries.
- Fetch in parallel, not in a waterfall; collapse N+1 client requests into one endpoint.
- Prefetch the likely next route on hover/focus.
- Cache with explicit invalidation, and dedupe in-flight identical requests.
- Paginate or virtualize; never ship 10,000 rows and filter on the client.

## Hold the line

- Set budgets in CI (bundle size per route, Lighthouse CI thresholds) and fail the build on regressions, otherwise every fix decays within a quarter.
- Track field vitals continuously; a lab score is a snapshot, not a trend.
- Note the measured before/after in the PR description so the next person knows what the change bought.

## Checklist

- [ ] Profiled before changing anything; numbers recorded before and after.
- [ ] LCP element preloaded, correctly sized, never lazy-loaded, discoverable in HTML.
- [ ] No long tasks over 50ms on the primary interaction; heavy work off the main thread.
- [ ] Every image, embed, and late-arriving element reserves its space.
- [ ] Route-level code splitting; client boundaries at the leaves; third parties audited.
- [ ] Requests parallel, not chained; long lists virtualized.
- [ ] Budgets enforced in CI and field vitals monitored.
