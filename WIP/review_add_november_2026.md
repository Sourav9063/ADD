# ADD knowledge, memory, and plan review

Reviewed: 2026-11-11. Target: `/Users/Sourav/Documents/Pathao/`.

Implementation (2026-11-11): the user approved the skill proposals, then requested compression of those additions. [The implementation record](../agents/plans/knowledge-memory-plan-refinements.md) tracks both revisions, bundle synchronization, and validation. Audit evidence below describes the pre-change snapshot; proposed Pathao cleanup and maintainer-managed synchronization remain separate work.

## Verdict

**The intended model is sound and mostly matches the current ADD skills. The files only partially match it.**

- Knowledge has useful decisions and constraints, but also large framework tutorials, copied implementation details, operational snapshots, and duplicate explanations.
- MEMORY is generally short and useful. Strike has the clearest scope leakage: feature-specific CRM rules have become always-loaded project guidance.
- Plans support implementation well in several projects. Their historical role is less consistent: completed work is sometimes unmarked, old instructions look current, and execution state is repeated across multiple documents.

The priority is to reconcile ownership and stale statements. Adding more workflow or more files would not address those problems.

## Expected ownership

I interpret “underlying decisions” as the reasoning and constraints needed to change a particular topic safely.

| Location | Intended role | Admission question |
| --- | --- | --- |
| `AGENTS.md` and scoped guides | Stable instructions for changing this repository | Does an agent need this whenever working in this scope? |
| `agents/MEMORY.md` | Learned, project-wide decisions and do/don't rules | Does this correction or decision apply across unrelated tasks in this project? |
| `agents/knowledge/<topic>.md` | Topic decisions, rationale, rejected alternatives, invariants, and scoped do/don't rules | What would a future agent otherwise have to rediscover, and when should it read this? |
| `agents/plans/<task>.md` | Implementation support, acceptance criteria, execution state, checks, and retained completion records | What is intended, what passed, what remains, and what is historical? |
| Source, tests, schemas, configuration | Current implemented behavior | Can this fact be read directly from its executable owner? |
| Human docs or an explicitly owned contract | Runbooks, tutorials, supplied API specifications, and reference material | Is this reference material rather than learned agent guidance or execution state? |

Project-wide relevance is the distinction between MEMORY and knowledge. Being durable or phrased as “do not” is insufficient to make a rule project-wide. A project-wide rule may name an existing helper; the test is its scope, not whether it contains a filename.

Completed plans should remain discoverable with a clear historical status. “Archive” does not require a new directory. Current ADD already supports retaining completed plans in `agents/plans/`.

## Coverage and limits

Recursively enumerated the workspace, including ignored project directories, while excluding dependency, build, VCS, tool-cache, and installed-skill trees from the document inventory. Found **12 project, template, or nested workspace roots plus the Pathao workspace root** with relevant `agents/` content. The discovered live folder spelling is `agents/plans/`; no separate live `agents/plan/` was found in this scan.

Inventory: **215 Markdown files, 36,024 lines**:

- 122 knowledge files, 25,209 lines.
- 83 files under plans, 10,230 lines: 80 task plans, one index, and two review reports.
- Nine MEMORY files and one `agents/OPEN_QUESTION.md`.

Also found three non-Markdown migration-evidence files under the workspace plans folder. Two `[DELETE]-agents*` snapshot trees inside `strike-ui-copy/[DELETE]-source-specific/` were excluded from live counts. Their names indicate old snapshots, not an additional current owner.

All inventoried files received size, path, heading/status, and exact-duplicate inspection. Read all nine memories and inspected applicable project guides, installed workflow variants, representative knowledge and plans, and selected source files. Semantic review is selective, especially for long tutorials and historical plans; this is not a line-by-line correctness certification of all 36,024 lines. No builds, live services, external contracts, or cluster states were revalidated. Recorded test results below belong to the documents' historical verification, not tests rerun in this audit.

File contents do not prove which model, prompt, or skill version generated them. The findings assess the current artifacts; attribution to a particular generation session would require history unavailable here.

## Project-by-project assessment

Paths below are relative to the Pathao root. K/P/M are knowledge files, files under plans, and MEMORY lines. A missing MEMORY is not itself a defect: an empty memory need not be created without a learned project-wide rule.

| Root | K | P | M | Assessment and first action |
| --- | ---: | ---: | ---: | --- |
| `data-pass-ui` | 16 | 2 | 18 | Mixed. Concise workflow/deployment knowledge and explicit mock-versus-live status are strong. Remove generic tutorial bulk, fix stale scaffold wording, reconcile the workflow plan's older sections, and move feature-only UI preferences out of MEMORY. |
| `alexander` | 2 | 3 | 5 | Closest overall fit. Short knowledge, compact memory, and explicit permission supersession. Reconcile the old root guide with current SDD; add a top status to the completed local migration record. |
| `strike-repo/strike-ui-copy` | 9 | 2 | absent | Mostly inherited reference material and unmarked plans. Establish whether this copy remains an active project before spending effort curating it. Keep old snapshot trees out of current-document discovery. |
| `strike-repo/strike-ui` | 16 | 19 | 24 | Largest combination of ownership problems: CRM rules in MEMORY, source duplication in knowledge, stale deployment guidance, and overlapping plan generations. Reconcile confirmed contradictions first. |
| `strike-repo/TEMPLATE_JOTAI` | 14 | 4 | 11 | Good template-scoped memory and concise deployment knowledge. Contains a Strike-specific implementation plan despite its reusable-platform scope. Separate inherited reference history from template work before distributing it again. |
| `TEMPLATE` | 8 | 2 | absent | Consul migration knowledge is updated, but deployment material remains lengthy and tutorial-shaped. Keep the boundary decisions; move reusable operator instructions to an owned runbook. |
| `engineroom` | 2 | 7 | 16 | Good cross-repository ownership and explicit risks. Execution state sprawls across plans, their index, OPEN_QUESTION, and some knowledge sections. Keep current state in the owning plan and shorten navigation documents. |
| `engineroom/strike-ui` | 16 | 20 | 24 | Shares much Strike documentation, plus a cohort-policy plan. Same MEMORY/topic boundary issue. Verify this checkout separately: its CI differs from `strike-repo/strike-ui`. |
| Pathao workspace root | 0 | 1 | 28 | Valid home for cross-project execution and machine-readable evidence. MEMORY mixes broad workspace rules with detailed Consul migration choices and inventory-specific facts. Move those narrower details to workspace knowledge or the owning plan. |
| `ytb` | 2 | 6 | absent | Good implementation slices and clear top statuses. Knowledge often narrates algorithms and constants. Preserve input/coordinate constraints, cancellation, durability, and duplicate-export rationale; point to source for mechanics. Reconcile the H3 plan's remaining unchecked item. |
| `route-repo/mapsense` | 17 | 10 | 3 | Minimal MEMORY fits well. Knowledge includes useful domain invariants but also duplicate contribution docs and a long operational procedure. Plans include review reports and many documents with no execution status. |
| `AGENT ROUTING/safar-app` | 19 | 6 | 7 | MEMORY is scoped well. Useful map/carousel constraints coexist with inherited tutorials. Several plans distinguish superseded and locally verified work correctly; others have no status. |
| `bigbang` | 1 | 1 | absent | Clear superseded-plan banner and links to successor work. Knowledge repeats retired alternatives and includes rollout sequencing better owned by the Engineroom migration plan. Keep the legacy boundary and retirement dependency discoverable. |

## Findings

### 1. Confirmed contradictions need attention before compression

**Strike deployment guidance contradicts this checkout's executable configuration.**

In `strike-repo/strike-ui`, [the migration guide](/Users/Sourav/Documents/Pathao/strike-repo/strike-ui/agents/knowledge/deployment-migration-from-base64-env.md:18) prescribes raw multiline GitLab dotenv. [Deployment flow](/Users/Sourav/Documents/Pathao/strike-repo/strike-ui/agents/knowledge/gitlab-ci-helm-deployment-flow.md:90) repeats raw writing and env-hash image tags; [deployment secrets](/Users/Sourav/Documents/Pathao/strike-repo/strike-ui/agents/knowledge/deployment-secrets-knowledge.md:7) describes runtime credentials baked into the image.

Current [CI](/Users/Sourav/Documents/Pathao/strike-repo/strike-ui/.gitlab-ci.yml:30) decodes base64 build dotenv and passes Consul configuration. The [Dockerfile](/Users/Sourav/Documents/Pathao/strike-repo/strike-ui/Dockerfile:48) links runtime `.env` to `/tmp/.env`; [the fetcher](/Users/Sourav/Documents/Pathao/strike-repo/strike-ui/env-fetcher.sh:4) loads runtime dotenv from Consul. These documents can direct an agent or operator toward the previous deployment design.

Reconcile around one concise deployment knowledge owner, using DataPass's structure as an example. Preserve the old migration as explicitly historical only if its rationale still matters.

Do this per checkout. [Engineroom's Strike CI](/Users/Sourav/Documents/Pathao/engineroom/strike-ui/.gitlab-ci.yml:40) still writes raw dotenv. Identical document text across the two Strike trees does not imply identical current behavior.

**Mapsense has an obsolete contribution explanation beside the newer one.**

[The compressed document](/Users/Sourav/Documents/Pathao/route-repo/mapsense/agents/knowledge/user-contributions-tracking-compress.md:23) explains the two trigger calls through an ownership change from reviewer to admin. [The newer document](/Users/Sourav/Documents/Pathao/route-repo/mapsense/agents/knowledge/user-contributions-tracking.md:70) says review preserves resolver ownership and tracks reviewer outcomes separately. [Current repository code](/Users/Sourav/Documents/Pathao/route-repo/mapsense/src/repository/anomaly.ts:103) updates `reviewed_by` without replacing `resolved_by` during admin review.

Merge into one decision-focused contribution document. Preserve the distinction between resolver and reviewer attribution, current distributions versus event counts, and intentional behavior after deletion. Remove the competing compressed owner after checking incoming references.

**DataPass retains a stale setup statement.**

[Setup knowledge](/Users/Sourav/Documents/Pathao/data-pass-ui/agents/knowledge/project-setup.md:3) says the example dashboard remains until features are specified. [Current dashboard source](</Users/Sourav/Documents/Pathao/data-pass-ui/src/app/(dashboard)/page.tsx:3>) redirects to `/requests`, and the workflow knowledge records the delivered portal. Remove that completed bootstrap-state sentence; keep reusable setup constraints.

**Strike's completed integration plan contains superseded instructions.**

[The plan](/Users/Sourav/Documents/Pathao/strike-repo/strike-ui/agents/plans/crm-configuration-api-integration.md:15) says updates derive codes from names, Tag Mapping sends `tags_code`, and in-place mutations avoid tree refresh. Current [domain knowledge](/Users/Sourav/Documents/Pathao/strike-repo/strike-ui/agents/knowledge/ticket-configuration-ui-domain.md:44) instead preserves stored update codes and omits `tags_code` for mappings. [Services](/Users/Sourav/Documents/Pathao/strike-repo/strike-ui/src/services/crm-configuration-api.ts:299) preserve the supplied existing code on updates, while [the mutation runner](/Users/Sourav/Documents/Pathao/strike-repo/strike-ui/src/hooks/use-crm-action-runner.ts:28) refreshes the route.

Mark the plan historical at the top and identify which later decisions supersede those instructions. Keep the acceptance and verification record; avoid maintaining its implementation description as another current contract.

### 2. Knowledge frequently exceeds the intended role

The two largest generic document families account for **10,457 lines, about 41.5% of all knowledge lines**:

| Family | Copies | Total lines | Useful residue to retain locally |
| --- | ---: | ---: | --- |
| `jotai-knowledge.md` | 6 | 6,494 | Project state ownership, hydration constraints, adopted async/cache decisions, and costly version-specific pitfalls actually encountered. |
| `node-cron-docker-kubernetes-knowledge.md` | 7 | 3,963 | Confirmed scheduler ownership and duplicate-execution constraints where the project actually has scheduled work. |

For example, [Jotai notes](/Users/Sourav/Documents/Pathao/data-pass-ui/agents/knowledge/jotai-knowledge.md:76) teach installation and basic atom creation. [Cron notes](/Users/Sourav/Documents/Pathao/data-pass-ui/agents/knowledge/node-cron-docker-kubernetes-knowledge.md:7) list hypothetical jobs, then supply extensive Docker, Compose, and Kubernetes examples. These are mainly learning/reference resources. Their presence does not establish that those jobs or architectures exist in each application.

Move worthwhile reusable teaching material to one owned reference or task-triggered resource. Do not split a 1,100-line tutorial into ten knowledge files with the same content. Keep only the project's actual decisions in its knowledge folder. A library URL plus a narrow local exception is often enough.

Other common cases:

- `api-implementation.md` reproduces route constants and client behavior. Keep upstream quirks, client selection, trust boundaries, and mapping rationale; use source links for route inventories and helper mechanics.
- Mapsense's [database schema sync guide](/Users/Sourav/Documents/Pathao/route-repo/mapsense/agents/knowledge/database-schema-query-sync.md:8) is predominantly an operational procedure with embedded scripts. Keep the unusual manual-schema ownership decision in knowledge; put the procedure in a runbook, or extract reusable scripts if later authorized and worthwhile.
- [User-session knowledge](/Users/Sourav/Documents/Pathao/data-pass-ui/agents/knowledge/user-session-jotai.md:3) contains a useful server-versus-client trust boundary, but much of the surrounding login/store sequence can be read in source. Preserve why browser state must remain volatile and non-authoritative.
- Layout knowledge earns its place when it records a demonstrated failure and its constraint. Safar's [carousel explanation](</Users/Sourav/Documents/Pathao/AGENT ROUTING/safar-app/agents/knowledge/agent-route-carousel-card-layout.md:13>) has that value. Compress copied class strings and current component grouping while preserving the scroll ownership and equal-height rationale.

Length is evidence of review cost, not automatic proof of bad knowledge. Short documents can also restate source; long cross-repository maps can preserve expensive discoveries.

### 3. MEMORY has feature-scoped rules that should load with their topic

[Strike MEMORY](/Users/Sourav/Documents/Pathao/strike-repo/strike-ui/agents/MEMORY.md:14) stores Tag name editability, Ticket Configuration country policy, the CRM-specific client, hidden code transport behavior, expanded mapping relations, archival status, and list request locking. These rules govern a subsystem. Several are already repeated in `ticket-configuration-ui-domain.md`.

Keep project-wide Git ownership, constant naming, general feature composition, and local-versus-shared state guidance in MEMORY if they represent confirmed project-wide preferences. Move the CRM rules into their existing knowledge owner. A single conditional navigation pointer can remain if needed; do not repeat the rules beside it.

[DataPass MEMORY](/Users/Sourav/Documents/Pathao/data-pass-ui/agents/MEMORY.md:13) similarly mixes broad UI preferences with dropdown selection, validation reflow, selected-field tags, and a particular Refresh-button behavior. Retain compact spacing/shared primitive preferences if intended across the app. Put workflow-specific presentation constraints with workflow knowledge. Its `Documentation` heading currently covers API, mock, and UI rules too; regroup surviving project-wide rules by meaning.

[Workspace MEMORY](/Users/Sourav/Documents/Pathao/agents/MEMORY.md:8) contains detailed migration mechanics and inventory-specific aliases. Keep broad inventory coverage, explicit branch targeting, and evidence standards here. Put Consul implementation choices in topic knowledge and task-specific project mappings with the relevant inventory artifact.

Alexander, Mapsense, TEMPLATE_JOTAI, and Safar show that a useful MEMORY can remain small. Avoid filling it merely to satisfy a template or moving rules solely to hit a line count.

### 4. Plan history is retained, but often looks executable

Of the 80 task-plan files, **34 lack an explicit `Status:` line within their first ten lines**. This is a mechanical discoverability measure, not a claim that all 34 are unfinished or invalid. For example:

- [Alexander's Consul migration](/Users/Sourav/Documents/Pathao/alexander/agents/plans/consul-runtime-configuration-migration.md:25) records all implementation checkpoints complete near its end, but lacks a top status and still includes “no prior memory, knowledge, or plan files exist” as an undated inspection statement.
- [Strike's country-lock plan](/Users/Sourav/Documents/Pathao/strike-repo/strike-ui/agents/plans/ticket-configuration-zone-country-lock.md:20) has checked execution and recorded verification but no completion banner.
- Mapsense's eight task plans have only one top status, `Final`; that expresses plan approval, not whether implementation is planned, active, completed, or superseded.
- Several `create-action-factory.md` files describe work without a status even though `src/lib/create-action.ts` exists. File existence is not sufficient to declare the plan complete; reconcile the acceptance checks before assigning its state.

Good examples already exist:

- [Alexander's earlier manual-run plan](/Users/Sourav/Documents/Pathao/alexander/agents/plans/super-admin-manual-live-run.md:3) is complete and explicitly points to the permission change that superseded part of it.
- [BigBang's migration plan](/Users/Sourav/Documents/Pathao/bigbang/agents/plans/cx-inspector-k8s-migration.md:3) says superseded immediately, names the successor, and identifies its old content as past reasoning.
- [DataPass's workflow plan](/Users/Sourav/Documents/Pathao/data-pass-ui/agents/plans/datapass-request-workflow.md:343) distinguishes mock-complete slices from unfinished real integration. That distinction should survive any shortening.

Use a short status at the top, with the completion boundary and remaining external work where relevant. Keep a completed plan as a historical acceptance, decision, rejected-path, and verification record. Maintain current reusable rules in knowledge rather than updating the archive into a second implementation manual.

The DataPass workflow plan also needs internal reconciliation: its top records optional headers and streamed same-origin downloads, while older sections still describe a strictly headerless input experience and an earlier download model. Link the current behavior's knowledge owner and label historical slices. Do not erase the original acceptance record or silently relax remaining real-backend acceptance criteria.

### 5. Engineroom has too many places reporting current execution state

[The plan index](/Users/Sourav/Documents/Pathao/engineroom/agents/plans/README.md:15) repeats detailed task progress, endpoint discoveries, and blockers. [OPEN_QUESTION](/Users/Sourav/Documents/Pathao/engineroom/agents/OPEN_QUESTION.md:3) says it contains only undecided questions, but retains closed answers and an obsolete “last revised” date. [Inspector knowledge](/Users/Sourav/Documents/Pathao/engineroom/agents/knowledge/rastamapo-inspector.md:50) records a dated live outage and deployment snapshot.

These are useful discoveries, but their owners should differ:

- Keep goal, task/checkpoint state, blockers, release prerequisites, and dated verification evidence in the owning plan.
- Keep stable cross-repository boundaries, upstream quirks, and rationale in knowledge.
- Keep the index primarily navigational. If it includes status, make it brief and reconcile it whenever the owning plan changes.
- Keep OPEN_QUESTION only for unresolved questions shared across plans, with explicit affected-plan links. Single-plan questions can stay in that plan. Move settled decisions to knowledge or retained plan history, then remove their competing “current answer.”

For a concrete discrepancy, the index says Force Suspend stage checking is pending, while [the plan](/Users/Sourav/Documents/Pathao/engineroom/agents/plans/05-judy-plugin-force-suspend.md:110) records a stage experiment. That experiment may not satisfy the entire stage checkpoint. Reconcile its exact coverage instead of declaring either fully complete or wholly untested.

Keep the inspector's backend failure as dated execution evidence until release is verified. Do not present the October observation as freshly confirmed November infrastructure state.

### 6. Templates and copied trees spread unrelated context

There are 79 unique byte sequences among 122 knowledge files and 59 among 83 plan-folder files. Copies are not independent failures, and independent repositories may reasonably retain local knowledge. The problem is unexamined carryover and competing ownership.

[TEMPLATE_JOTAI MEMORY](/Users/Sourav/Documents/Pathao/strike-repo/TEMPLATE_JOTAI/agents/MEMORY.md:3) excludes Strike-specific domain features. Its [433-line Strike plan](/Users/Sourav/Documents/Pathao/strike-repo/TEMPLATE_JOTAI/agents/plans/strike-api-integration-implementation-plan.md:5) nevertheless directs building Strike on the template. The plan also points to `agents/plans/strike-api-review-plan.md`, which is absent there and in `strike-repo/strike-ui`.

The completed [DataPass platform sync plan](/Users/Sourav/Documents/Pathao/strike-repo/TEMPLATE_JOTAI/agents/plans/datapass-platform-sync.md:11) explicitly retained existing historical plans. Therefore, the inherited Strike plan is a distribution-design issue, not proof that this sync introduced it against instructions.

Before creating another application from a template, retain reusable platform decisions, replace identity-specific guidance, and exclude unrelated application execution plans. Retain useful implementation provenance in an explicitly historical location or banner. Resolve incoming references before moving files. Avoid introducing hard-coded links between independent local clones as a substitute for a distribution policy.

The two Mapsense `CODEX_*_REPORT.md` files are review artifacts, not implementation plans. Keep them in an established review/docs location and link remediation tasks from plans. The workspace's JSON/CSV migration evidence is different: it directly supports the owning migration plan and can stay adjacent without being treated as agent instructions.

### 7. Skill distribution and older guides complicate the result

Current [SDD](/Users/Sourav/Documents/Personal/ADD/skills/agent-driven-development/spec-driven-development/SKILL.md:12) already says source owns current behavior, knowledge records reasoning, and plans retain completion records. Current [project-memory](/Users/Sourav/Documents/Personal/ADD/skills/agent-driven-development/project-memory/SKILL.md:25) already excludes implementation specifics and directs domain knowledge elsewhere. Much of the observed output violates an existing boundary rather than exposing a missing concept.

Installed guidance varies:

- Pathao root, DataPass, and Alexander have SDD bytes matching current canonical ADD. Engineroom and BigBang have close variants.
- Both Strike checkouts and Mapsense have an older 43-line SDD variant and the older `memory` skill name. That SDD lacks the current explicit completion-retention instructions.
- Alexander's `.agents/skills/` contains both `memory` and `project-memory`; its `.claude/skills/` has `project-memory`. Two overlapping memory procedures remain available in one harness.
- No local SDD/memory installation was found in several template/app roots. Parent-workspace guidance may still be available depending on the harness; absence locally does not prove the skill never ran.
- ADD itself has drift: canonical `project-memory` is 29 lines, while both installed ADD copies are 27 lines. They differ in repeated-correction diagnosis and scoped learning/enforcement guidance. Report for maintainer sync; do not edit installed copies automatically.

[Alexander's root guide](/Users/Sourav/Documents/Pathao/alexander/AGENTS.md:3) still says knowledge and plans are both contracts and only finalized plans should be saved. [Ytb's guide](/Users/Sourav/Documents/Pathao/ytb/AGENTS.md:3) also treats both as contracts. These conflict with the newer distinction between implemented behavior, intended requirements, and helper documents. Updating only installed skills would leave conflicting higher-priority project guidance in place.

Skill/version drift plausibly contributes to inconsistency. The file audit cannot establish it as the cause of every generated artifact, especially files predating the current rules.

## Recommended changes to ADD guidance

Keep `project-memory` responsible for MEMORY and SDD responsible for both knowledge and plans. Their lifecycles are related enough that three new skills would add coordination cost. Make a few targeted clarifications in the canonical skill bodies, then synchronize the standalone bundle and let the maintainer handle installed copies.

### Clarify routing at the moment a lesson is recorded

Suggested addition to `project-memory`, next to its scope rule:

> Before recording a lesson, check its scope. Put a rule in MEMORY only when it applies across unrelated tasks in this repository. Put feature, integration, and subsystem decisions and do/don't rules in the existing topic knowledge file, even when learned from a user correction. Use a conditional pointer when broader discovery needs it; keep the rule itself in one place.

This addresses the observed Strike failure without weakening immediate learning. A correction can deserve immediate persistence while belonging outside MEMORY.

### Make the knowledge boundary concrete

Suggested refinement to SDD's knowledge section:

> Record the decision, why it holds, rejected alternatives when useful, and constraints a future change must preserve. Name the source owners. Keep tutorials, full API inventories, copied implementation, and dated task progress in their appropriate reference or execution artifact. A general best practice becomes project knowledge only when a verified local choice or costly failure makes its application non-obvious.

Preserve narrow examples when they explain an otherwise ambiguous constraint. The goal is lower rediscovery cost, not a blanket ban on all code symbols or diagrams.

Clarify that “never restate code” targets duplication of current implementation. A small proposed contract example can still be necessary in an implementation plan. Distinguish intended requirements from current behavior so plans do not become too vague to implement.

### Tighten plan status and retention

Suggested refinement to SDD's plan lifecycle:

> Keep current execution status near the top, including the remaining checkpoint or external dependency when implementation and release differ. On completion, link the durable knowledge owner and retain the plan as history with its acceptance and verification record. Mark superseded plans and identify the successor. Remove a plan only when its remaining rationale, verification evidence, and rejected paths are preserved and the repository permits removal.

Current ADD permits deletion when nothing else remains after knowledge absorption. That mostly fits the user's model, but “durable decisions moved” must not be mistaken for “all historical value preserved.” A separate archive folder is optional; top status is the smallest useful change.

### Add a small ownership example, not a mandatory document template

| Observed material | Destination |
| --- | --- |
| “Leave the Git index untouched unless explicitly requested.” | MEMORY, if a learned project-wide preference. |
| “CRM updates preserve stored codes because the upstream requires them.” | Ticket Configuration knowledge. |
| “Server authentication remains authoritative; browser state is presentation only.” | Session/auth knowledge, with source owners. |
| “Stage verification is blocked by the backend; mock checks passed.” | Owning plan, with its next checkpoint. |
| Full atom API tutorial or copied Helm installation example | Reusable reference/runbook, loaded for that task. |
| Supplied backend request/response specification | One explicitly owned contract, linked by knowledge and plan. |

DataPass's `API_CONTRACT.md` is an important exception to careless pruning. Its plan treats it as an integration draft with separate ownership. Move it to an established contract/reference location only if that improves discovery and the owner agrees; preserve its requirements and update references. Do not delete it as “duplicated code” merely because it contains schemas and examples.

## Suggested cleanup slices

These are proposed follow-up changes, not changes performed by this audit. Each can be reviewed independently.

| Order | Slice | Completion evidence |
| --- | --- | --- |
| 1 | Reconcile confirmed stale statements in the affected checkout: Strike deployment, CRM plan supersession, Mapsense contributions, DataPass scaffold wording. | Each current claim agrees with its executable owner; historical instructions have explicit scope/status; links resolve. |
| 2 | Move Strike CRM rules from MEMORY to the existing knowledge owner; review DataPass and workspace scope leakage. | Project-wide constraints remain discoverable; each moved topic rule has one owner; no rule is weakened or lost. |
| 3 | Reconcile lifecycle state for existing plans without assuming code presence proves completion. | Every reviewed task plan says whether it is active, complete, blocked, or superseded and identifies its remaining checks where applicable. |
| 4 | Consolidate Engineroom execution state and settled questions. | Index and open-question navigation point to their owners; dated snapshots and partial stage evidence are labeled accurately. |
| 5 | Prune template carryover and generic tutorial bulk. | New-app guidance contains platform decisions and relevant constraints; application-specific history is explicitly historical or excluded; incoming references remain valid. |
| 6 | Apply the small canonical skill clarifications and reconcile older project guides. | Canonical skills and standalone bodies align; maintainer sync addresses installed drift; no root guide retains a conflicting source-of-truth rule. |

For a guidance change, compare old and proposed wording in fresh sessions on a small set of realistic cases: a CRM-only correction, a project-wide Git preference, locally complete work with a blocked rollout, a supplied external API contract, and a reusable layout failure. Inspect where the lesson lands, whether prior acceptance evidence survives, and whether an unrelated task loads unnecessary context. Include a nearby case where no file should be created. These trials would test the proposal; no such behavioral trial was run in this audit.

The strongest existing models to reuse are DataPass's concise deployment owner, Alexander's permission supersession record, and BigBang's superseded migration banner. Keep their useful distinctions while removing stale statements and duplicate ownership elsewhere.
