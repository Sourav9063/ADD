---
name: unslop
description: Strip AI tells from prose and add human voice. Use when writing or editing any prose the user will read or publish: docs, READMEs, commits, issues, pull requests, reviews, posts, emails. Also use when asked to unslop, de-AI, or make writing sound human. Skip code, config, and data.
---

## Unslop

Edit text to remove AI patterns and add human voice.

### Process

1. Scan for the patterns below.
2. Rewrite. Preserve meaning, match intended tone.
3. Add voice (next section).
4. Self-audit: "what makes this obviously AI generated?" Fix what remains.

### Adding voice

Removing patterns is half the job. Sterile, voiceless writing is just as obvious.

- Hold opinions. React to facts instead of listing neutral pros and cons.
- Vary rhythm. Short sentences. Then longer ones that take their time.
- Admit complexity. "Impressive but also kind of unsettling" beats "impressive."
- Use "I" when it fits. First person is not unprofessional.
- Let some mess in. Perfect structure looks machine-made.
- Be specific. Not "this is concerning" but "there's something unsettling about agents churning away at 3am."

### Content

1. Puffery: `pivotal moment`, `testament to`, `evolving landscape`, `setting the stage for`, `indelible mark`, `deeply rooted`. Cut it, state what happened.
2. Name-dropping: listing outlets or tools without context. Pick one, say what it said.
3. Superficial `-ing` tails: `highlighting...`, `ensuring...`, `reflecting...`, `showcasing...`, `fostering...`. Delete, or expand with a real source.
4. Promotional language: `nestled`, `vibrant`, `breathtaking`, `groundbreaking`, `renowned`, `stunning`, `must-visit`. Describe neutrally.
5. Vague attribution: `experts believe`, `industry reports suggest`, `some critics argue`. Name the source or delete.
6. Formulaic challenge arcs: "despite challenges, X continues to thrive." Replace with specific facts.

### Language

7. AI vocabulary: `additionally`, `crucial`, `delve`, `enduring`, `enhance`, `fostering`, `garner`, `interplay`, `intricate`, `landscape` (abstract), `pivotal`, `showcase`, `tapestry` (abstract), `testament`, `underscore`, `vibrant`. Use plain words.
8. Fancy ways to say "is": `serves as`, `stands as`, `boasts`, `features`. Say "is" or "has".
9. "Not just X, but Y." State the point directly.
10. Rule of three: ideas forced into groups of three. Use the natural number.
11. Synonym cycling: protagonist, main character, central figure, hero in one paragraph. Pick one, repeat it.
12. False ranges: `from X to Y` where X and Y sit on no real scale. List the items.

### Style

13. Em dashes: avoid entirely. Periods or commas only. No parentheses, en dashes, or hyphen-as-dash substitutes, since swapping one tell for another still reads as AI. If a thought needs separation, end the sentence.
14. Colons: fine before a list or example, not as mid-sentence connectors. "If you're coming from traditional automation: instead of registering event handlers, you describe conditions" gains nothing from the colon. Drop the comparison framing and let the point stand: "Describing when the scheduler should fire works best as plain English."
15. Boldface: don't bold every proper noun or acronym.
16. Inline-header lists: the tell is a bold label and colon restating the line, `**Performance:** Performance improved...`. Convert to prose. A bold lead-in ending in a period that names the item and is followed by genuinely new detail (`**Schema in TypeScript.** Tables live in one file.`) is fine.
17. Headings: sentence case, not title case.
18. Decorative emoji: remove from headings and bullets.
19. Quotes: straight, not curly.

### Communication artifacts

20. Chatbot phrases: `I hope this helps!`, `Let me know if...`, `Of course!`, `Certainly!`, `Found the smoking gun!`. Remove.
21. Cutoff disclaimers: "while specific details are limited...". Find sources or remove.
22. Sycophancy: `Great question!`, `You're absolutely right!`. Respond directly.

### Filler

23. Filler phrases: `in order to` becomes "to", `due to the fact that` becomes "because", `it is important to note that` gets deleted.
24. Excessive hedging: "could potentially possibly be argued that it might" becomes "may".
25. Generic conclusions: "the future looks bright." State specific plans or facts.

### Jargon

26. Abstract metaphor nouns read technical but have a plainer concrete word: `substrate` (base), `wedge in` (add), `vector` (way, method), `gold-plating` (more than the job needs), `ratchet` (the mechanism's real name, or "a limit that only tightens"), `evacuate` (move out), `endgame` (the last phase), plus `locus`, `vantage`, `nexus`, `primitive` (as noun), `harness`, `surface` (as in "API surface"), `bedrock`, `scaffolding`, `modality`, `paradigm`, `north star`, `flywheel`. Pick the concrete word.

### Plain speech

27. Say what it does, not how it feels. "The database stays close at hand", "SQL you can read", "types that follow your schema" name feelings. Name the mechanism or a number instead: "`.toSQL()` returns the exact string sent to the database", "a column rename fails the build". Ask what the sentence tells the reader to do or know, then write that. If you can't restate it as a concrete instruction, fact, or number, cut it. Second check: if the sentence could appear unchanged in another project's docs, it says nothing about this one. Cut it.
28. Shorten or split dense sentences. If the reader has to backtrack to parse it, break it in two or drop clauses. One idea per sentence.
29. Prefer active voice. Catch "is/are/was/were + past participle" and name the actor: "queries are validated" becomes "the compiler validates queries", "the file is parsed by the loader" becomes "the loader parses the file". Passive is fine only when the actor is unknown or genuinely doesn't matter.
30. Cut adverbs, or use a stronger verb. "Runs quickly" becomes "is fast" or the number. "Significantly improves" becomes the measured delta. An adverb propping up a weak verb means the verb is wrong.
31. Prefer the plain word: `utilize` and `leverage` become "use", `facilitate` becomes "help", `numerous` becomes "many", `in the event that` becomes "if". The fancier synonym is rarely clearer.
