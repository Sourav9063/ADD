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

## Section skeleton

The order is the argument. It works because it answers objections in the sequence people
raise them:

1. **Hero** — what it is, who it is for, one primary CTA.
2. **Social proof strip** — logos, user count, or rating, immediately after the claim.
3. **Problem** — name the pain in the reader's words so they know they are on the right page.
4. **Solution / how it works** — three steps or three pillars, each with a visual.
5. **Features as outcomes** — what it does, framed as what they get.
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

- Alternate section density: text-heavy, then visual, then short. A page of uniform blocks reads as one long block.
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

## Checklist

- [ ] One audience, one action, stated in a sentence before any design.
- [ ] Hero states the outcome, names the user, and shows the product; CTA above the fold on mobile and desktop.
- [ ] Proof is specific and attributed; logos sit near the claim.
- [ ] Pricing visible, recommended plan isolated, money objections answered.
- [ ] Section order follows the objection sequence; one idea and one heading per section.
- [ ] Reveals fire once and never gate content; reduced motion respected.
- [ ] Hero image preloaded, third-party scripts audited, CTA and scroll depth instrumented.
- [ ] One `<h1>`, descriptive CTA names, contrast checked over imagery.
