---
name: grilling
description: Resolve material user-owned decisions through dependency-tree interviews and require concrete technical designs before presenting engineering specifications or implementation plans. Use for specification/planning work, consequential ambiguity, conflicting requirements, or requests to grill or stress-test a design. Investigate discoverable facts and settle low-risk reversible details without interviewing.
license: MIT
metadata:
  upstream: mattpocock/skills@85f83d3fde1d3a90d5c9a657f6998c79a6c37308
  upstream-path: skills/productivity/grilling
  vendored-via: dmmulroy/.dotfiles@d0b81835146e03a42e374312de47ef9b303f6205
  adapted: "2026-11-12"
---

# Grilling

Resolve material ambiguity before implementation. Router Mode still chooses the execution state once; this skill resolves user-owned decisions inside that state. Plan Mode, when active, turns the resolved design into the reviewed implementation plan.

## 1. Ground the tree in evidence

Map the design as a dependency tree: each material decision branches into the decisions that depend on it.

Separate **facts** from **decisions**:

- Investigate discoverable facts with current source, documentation, tools, and bounded subagents when useful. Current repository and external-system evidence outranks remembered context.
- Ask the user for intent, preferences, observable behavior, risk acceptance, consequential tradeoffs, and permission for destructive or externally visible effects.
- Resolve low-risk reversible details from repository conventions, choose the conservative default, and record the assumption instead of adding a question.

A pending fact-finding task is an unsettled prerequisite. Continue with independent frontier questions; hold only branches that depend on that fact.

## 2. Ask the current frontier in rounds

The **frontier** is every unresolved material decision whose prerequisites are settled. Freeze that original frontier for the round, ask every decision in it, then wait. Do not ask downstream questions whose answers depend on this round, including through `showWhen`.

Prepare each frontier decision as a numbered, self-contained question:

- Keep its stable `Q<number>` identity and use a distinct header of at most 12 characters.
- Offer 2-4 meaningful choices with stable values and concise labels.
- Mark the recommended choice with `recommended: true` and put the brief reason in its description or the question context.
- Use `multiSelect: true` only when multiple choices may be combined.
- Let the automatic **Other** row carry a custom answer or comment where appropriate; never add an `Other` option manually.
- Use `required: false` only for a genuinely skippable single-choice question. The reviewed `pi-ask@0.1.15` cannot correctly skip an optional multi-select question, so make that combination required, reshape it, or use prose fallback.

When `ask_user_question` is active and interactive TUI input is available, use it for the round so the user reviews all answers before submission. The tool accepts at most four questions:

1. If the frontier has 1-4 decisions, submit one questionnaire.
2. If it has more than four independent decisions, partition the frozen frontier into ordered same-frontier batches of at most four. Complete every batch before recomputing the tree. Do not drop remaining decisions or advance to downstream branches after an early batch.
3. If a batch is unavailable, invalid, dismissed, aborted, or cancelled, ask that unresolved batch in the prose format below and wait. Absence of UI is never approval; do not advance to later batches until the current batch is settled.

In RPC, JSON, print/headless operation, or when the tool is not active, use concise numbered prose directly:

```text
❓ Q1 - <short header>: <self-contained question and concrete options>

➡️ Recommended: <answer and reason>

---

❓ Q2 - <short header>: <self-contained question and concrete options>

➡️ Recommended: <answer and reason>
```

After the entire original frontier is settled, update the dependency tree, mark settled branches, and compute the next frontier. Do not repeat settled questions unless new evidence invalidates an answer.

## 3. Require an implementation-grade technical design

For engineering work, put material storage, interface, ownership and concurrency decisions into the tree. Inspect the current schema and public contracts before proposing changes. Do the technical legwork and recommend the smallest concrete design; ask the user to settle consequential choices, not to invent the design for you.

Before presenting or publishing an engineering specification, implementation plan or technical design for review, satisfy every applicable item below. This gate applies to drafts too. A user should not have to ask whether a feature needs a new table or how it works.

1. **Current versus proposed design.** Name the existing components being reused or changed. State exactly which tables, entities, columns, endpoints and services are new, changed or unchanged. Explain ownership, cardinality and why this design is needed.
2. **Storage contracts.** Show concrete SQL or typed schema shapes for changed data. Include field types, required/nullable values, defaults, identities, foreign keys, uniqueness, relevant indexes, lifecycle/deletion rules and organization/version/run scope where applicable. Explain relationships and membership. If no storage changes are needed, say so and name the existing representation used instead.
3. **Interface contracts.** Specify routes or function signatures, complete new/changed request and response shapes, authorization, actor/version selection, success behavior and errors. Use typed shapes or valid example payloads with fabricated identifiers. Reference unchanged contracts precisely rather than duplicating them. "Extend the API" is not a contract.
4. **End-to-end operation.** Trace input and producer output through validation, workflow/activity boundaries where relevant, services, persistence, reads and UI/export consumers. Show who assigns identities and metadata, when records are created and how retries find the same records. Explain how the feature actually works, not only its desired outcome.
5. **Write correctness.** Define transaction boundaries, atomicity, stale-write checks, shared concurrency/locking rules, retries/idempotency and failure behavior. Distinguish different version counters. State when notifications and external effects occur, including what rollback suppresses.
6. **Consumer behavior.** Make rendering, counts, filtering, action target sets and downstream report/export behavior explicit where affected. Preserve individual identities and histories unless a change is agreed. Explain how grouped, aggregate or derived views relate to their underlying records.
7. **Compatibility and rollout.** State migration/backfill decisions, old-data behavior, deployment order, old reader/writer compatibility, workflow replay implications and recovery boundaries where applicable. Distinguish proposed migrations from migrations actually applied.
8. **Observable proof.** Give testable acceptance criteria and name the public integration, API, browser or artifact seam that proves each one. Include relevant failure, concurrency and legacy cases. Distinguish planned tests from checks actually run.

Mark an inapplicable item N/A with a concrete reason. This checklist does not require new tables, endpoints or abstractions when existing ones suffice. A non-engineering interview does not need an invented software design.

Separate verified current facts, proposed designs, agreed decisions and open blockers. If a material choice is unresolved, show concrete alternatives and tradeoffs, then keep it open. A review draft must still contain the concrete design known so far and clearly bounded alternatives; the word "draft" is not permission to publish vague prose or placeholders as a technical specification. Missing applicable contracts block completion and implementation readiness.

## 4. Converge without endless questioning

Only material branches belong in the tree. Merge equivalent choices, recommend a default where appropriate, and omit questions whose answers cannot change observable requirements, risk, cost, or architecture.

The interview is complete when:

1. every material branch is resolved;
2. facts, assumptions, proposals and agreed decisions are distinguished;
3. any engineering specification or plan passes the technical-design gate above, with concrete contracts and justified N/A items;
4. the resulting design, constraints and accepted risks are summarized; and
5. the user explicitly confirms the shared understanding.

Do not mutate files, run side-effecting commands, start implementation agents, or submit an implementation-ready Plan Mode completion before that confirmation. After confirmation, return control to the selected Router state; if Plan Mode is active, produce the complete reviewed plan there before implementation.
