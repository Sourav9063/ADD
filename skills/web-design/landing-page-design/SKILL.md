---
name: landing-page-design
description: Build or review a marketing or conversion page. Use when creating a landing page, homepage, hero section, pricing page, feature section, testimonial or social-proof block, FAQ, or final call to action, when deciding section order or what goes above the fold, or when a page looks generic and does not convert.
---

# Landing Page Design

Assumes `design-foundations` for tokens and hierarchy, `microcopy` for wording,
`frontend-performance` for load speed, and `motion-design` for scroll effects. A landing
page is not an app screen: it has one job, and every section either advances it or is cut.

Decide the job first, in one sentence: *"A technical founder evaluating tools should start
a free trial."* Audience, moment, single action. Two goals on one page means neither
happens.

## Before the first section

Collect these, in one batch rather than one question at a time. Where the user cannot
answer, state a reasonable assumption in a line and keep building rather than stalling.

- **The offer.** What exactly do they get, and what counts as the conversion: a click, a signup, a purchase?
- **The audience.** Who they are, what they are trying to solve, and the top three reasons they do not buy today.
- **The traffic source.** Ads, search, social, or email, and what the visitor already knows on arrival. **Match the message to the source**: a page reached from an ad mirrors that ad's headline, promise, and visual tone, or the visitor thinks they clicked the wrong link.
- **The proof and assets that exist.** Logos, testimonials, numbers, case studies, screenshots, demo video, guarantees. What proof you actually have decides which sections are real and which would have to be invented. Invented proof is not an option; cut the section instead.

Then pick the page type deliberately and say why:

| Type | Use when |
| --- | --- |
| Classic hero plus sections | The product is understandable from one hero screenshot. The default. |
| Long-form story | The reader needs educating, or skepticism is the main obstacle. |
| Minimal conversion page | High-intent traffic from a known list, or a short offer like a waitlist or download. |
| Comparison page | Search intent already includes alternatives ("X vs Y", "best for"). |

The skeleton below is the classic form. The others reorder it; they do not skip proof.
See `visual-direction` for choosing the page's shape and visual register before the copy
lands in it.

## Section skeleton

The order is the argument. It works because it answers objections in the sequence people
raise them:

1. **Hero** — what it is, who it is for, one primary CTA.
2. **Social proof strip** — logos, user count, or rating, immediately after the claim.
3. **Problem** — name the pain in the reader's words so they know they are on the right page.
4. **Solution / how it works** — three steps or three pillars, each with a visual.
5. **Features as outcomes** — what it does, framed as what they get. Cap the headline benefits at three and make each one concrete ("save 10 hours a week", not "advanced automation"); a grid of nine features is a spec sheet, and nobody reads it.
6. **Proof** — testimonials with names, faces, roles, and specific results; case numbers.
7. **Pricing** — visible, with the recommended plan isolated.
8. **Objection handling / FAQ** — the real questions from sales and support.
9. **Final CTA** — the same action as the hero, restated with the value.

Cut, do not reorder casually. A page missing proof or pricing loses more than a page
missing a feature grid.

## Hero

- **Headline states the outcome, not the category.** "Ship your API docs in an afternoon" beats "Developer documentation platform". No jargon, no cleverness that costs comprehension.
- One subheadline of a single sentence: who it is for and how it works.
- **One primary CTA**, repeated verbatim at the bottom of the page. A secondary CTA may sit beside it as a ghost button ("See how it works"), never as an equal.
- Set expectations under the button: "Free for 14 days. No card." Removes the biggest hesitation at the moment of the click.
- A product visual beats an abstract illustration: a real screenshot, a short muted loop, or an interactive demo. Stock photography of people at laptops signals nothing.
- **No hero carousel.** A slider guarantees most visitors never see slides two through five and costs you the one message you control. Pick the strongest claim and commit to it.
- Above the fold means the value proposition and the CTA are visible without scrolling at 1280×720 **and** on a 375px phone. Test both, not one.

## Proof

- Specific beats superlative: "Cut onboarding from 3 weeks to 4 days" beats "Loved by teams everywhere".
- Testimonials need a name, a role, a company, and a photo. Anonymous quotes read as invented.
- Put logos near the claim they support, in grayscale at consistent optical size, with permission to use them.
- Numbers get context: "12,000 teams" means something; "millions of events" does not.

## Pricing

- Show prices. A page that hides them behind "Contact sales" for a self-serve product loses the self-serve buyer.
- 3–4 plans maximum, ordered by price, with the recommended one visually isolated (see `design-foundations`) rather than merely badged.
- Feature lists compare the same rows across plans, in the same order, phrased as what the user gets.
- Annual/monthly toggle states the saving explicitly, and defaults to the plan you actually want compared.
- Answer the money objections in place: refunds, cancellation, overages, what happens at the limit.

## Rhythm and layout

- **Show it rather than describing it.** A wall of feature cards, each a heading plus two sentences, is the default failure of a marketing page. Before writing a paragraph to explain something, check whether a visual with a caption carries it: a real chart for a speed claim, three panels for a three-step flow, an annotated screenshot for a feature. Prose earns its place in headlines, subheads, and captions.
- Alternate section density: text-heavy, then visual, then short. A page of uniform blocks reads as one long block. Weight the vertical spacing by role too: the hero and the primary proof section get considerably more room than the connective ones.
- Build and revise **section by section**, in the order of the argument. Regenerating the whole page on each iteration loses the parts that were already right and makes the diff unreviewable.
- Generous vertical spacing between sections (64–120px desktop, 48–64px mobile) with tighter spacing inside them; proximity is what makes a section read as one idea.
- One idea per section, with a heading that states the idea as a sentence.
- Constrain measure to 60–75 characters; full-width paragraphs are unreadable at desktop widths.
- Keep the visual language consistent with the product; a marketing page that looks nothing like the app breaks trust at signup.

## Motion

Scroll-triggered reveals fire **once**, stay subtle (fade + 8–16px rise, 300–400ms), and
never gate content: if JS fails or motion is reduced, every word is still there and
readable. Parallax is a vestibular trigger and a frame-rate cost — use it on one element at
most. See `motion-design`.

## Performance and measurement

- The hero image is the LCP element: preload it, size it correctly, and never lazy-load it. A marketing page that takes 4s to paint loses the visitor before the copy matters (see `frontend-performance`).
- Third-party tags (analytics, chat, heatmaps, A/B tools) are usually the largest cost on a landing page. Inventory them, defer them, and delete the unowned ones.
- Instrument the primary CTA, scroll depth per section, and form starts vs. completions. Without those, section order is guesswork.
- Test one variable at a time, and let it run to significance; a headline test read after a day is noise.

## Forms and conversion

- Ask for the minimum the next step actually needs: email alone converts better than email + company + team size, and the rest can be collected after signup.
- Field-level rules follow `form-design`; the only landing-page addition is that every extra field costs conversion, so each one needs a reason.
- Never trap the reader: no entry popup, no scroll-jacking, no exit-intent modal over the content they came to read.

## Accessibility

- Real heading hierarchy: one `<h1>` (the hero headline), sections as `<h2>`. Marketing pages fail this constantly by styling headings visually only.
- Every CTA is a real `<a>` or `<button>` with a descriptive name; "Learn more" repeated six times is unusable by screen reader.
- Text over hero images or gradients meets contrast at its worst point, not its average.
- Video is muted by default, captioned, and pausable; nothing autoplays with sound.

## Indexing

Campaign-specific and time-bound offer pages are `noindex`, or they outlive the campaign
and rank for a promise the product no longer makes. Evergreen offers, where search intent
matches the promise, get indexed with a real title, meta description, and internal links
from the homepage and feature pages. Keep the FAQ in plain question-and-answer markup;
that is the form both search and answer engines can lift.

## Ship requirements

The things that get forgotten and make an otherwise finished page read as a draft:

- A branded favicon, `<title>`, meta description, and `og:image` for social sharing.
- A custom 404 that offers a way back, and a way back from every page.
- Privacy policy and terms in the footer; cookie consent where the jurisdiction requires it.
- Client-side validation on every form, and a real error state rather than a browser alert.
- No dead links: a control pointing at `#` is either wired up or visually disabled, and the current page is indicated in the navigation.
- Semantic landmarks (`<nav>`, `<main>`, `<article>`, `<aside>`), a skip link, and alt text on every meaningful image.
- Every interactive element ships its full state set: hover, active, focus, loading, empty, and error.
