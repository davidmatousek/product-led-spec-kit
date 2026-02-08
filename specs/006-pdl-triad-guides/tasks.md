---
triad:
  pm_signoff:
    agent: product-manager
    date: 2026-02-07
    status: APPROVED
    notes: "Complete coverage of all spec requirements with zero scope creep. All four user stories (US-001 through US-003, plus Scenario 4) mapped to dedicated task phases. All functional requirements (FR-1 through FR-4) have specific, granular tasks. All non-functional requirements (NFR-1 through NFR-4) verified in Phase 6 cross-validation. Every acceptance criterion from the spec has a directly traceable task. Dependency ordering, parallel execution identification, and phase completion criteria are sound."
  architect_signoff:
    agent: architect
    date: 2026-02-07
    status: APPROVED
    notes: "Technically sound and implementation-ready. Dependencies correctly ordered with Phase 1 (Setup) preceding all writing phases, Phase 5 (Cleanup) correctly depending on Phases 2-4. Plan phases map correctly to task phases with full traceability to spec FR-1 through FR-4, NFR-1 through NFR-4. All technical constraints (line counts, preservation rules, cross-reference requirements, command syntax verification) have explicit enforcement tasks. Both Architect concerns from plan sign-off (artifact example line budget monitoring and link target verification) have dedicated verification tasks. Historical file preservation has double verification at Phases 5 and 6."
  techlead_signoff:
    agent: team-lead
    date: 2026-02-07
    status: APPROVED
    notes: "Well-structured, fully traceable to spec requirements, and executable by a single documentation writer agent in sequential phases. Dependency chain correct, MVP scope properly defined, each task contains sufficient detail for LLM agent execution without ambiguity. Task count (50) proportional to scope given 1:1 mapping to spec requirements. Timeline estimate: approximately 50 minutes for single-agent sequential execution."
---

# Tasks: PDL + Triad Guide Consolidation

**Feature ID**: 006
**Feature Name**: PDL + Triad Guide Consolidation
**Status**: Ready for Implementation
**Generated**: 2026-02-07
**Spec Reference**: specs/006-pdl-triad-guides/spec.md
**Plan Reference**: specs/006-pdl-triad-guides/plan.md

---

## Phase 1: Setup — Content Sources & Preparation

**Objective**: Read all content sources and verify prerequisites before writing
**Maps to**: Plan Technical Context (Dependencies)

### Tasks

- [X] T001 Read existing `docs/guides/PDL_QUICKSTART.md` and extract reusable content (ICE scoring, PDL commands, workflow patterns)
- [X] T002 [P] Read existing `docs/guides/PDL_TRIAD_LIFECYCLE.md` and catalog existing 205-line structure for preservation during Phase 4
- [X] T003 [P] Read PDL skill definitions (`.claude/skills/pdl-run/SKILL.md`, `pdl-idea/SKILL.md`, `pdl-score/SKILL.md`, `pdl-validate/SKILL.md`) and extract verified command syntax
- [X] T004 [P] Read `docs/SPEC_KIT_TRIAD.md` and extract Triad command references, role definitions, and sign-off requirements
- [X] T005 Read CISO_Agent reference implementations for structure inspiration (`/Users/david/Projects/CISO_Agent/docs/guides/PDL_QUICKSTART.md`, `TRIAD_QUICKSTART.md`, `PDL_TRIAD_LIFECYCLE.md`, `PDL_TRIAD_LIFECYCLE_INFOGRAPHIC.md`)
- [X] T006 Compile a terminology glossary from all sources to ensure consistent terms across all three guides (e.g., "Product Backlog" vs "Backlog", "auto-defer" vs "Auto-Defer Gate")

**Phase 1 Completion Criteria**:
- [X] All content sources read and key content extracted
- [X] Command syntax verified against skill definitions
- [X] Terminology glossary compiled for consistency enforcement

---

## Phase 2: User Story 1 — Unified Quickstart (PDL_TRIAD_QUICKSTART.md)

**Objective**: Create the single "start here" onboarding document covering both PDL and Triad
**Maps to**: Plan Phase 1, Spec FR-1, Scenario 1 (New User Onboarding)
**Story Goal**: A new user can understand the complete PDL + Triad workflow from a single starting document
**Independent Test**: Open the file and verify all 13 required sections are present with accurate command syntax

### Tasks

- [X] T007 [US1] Create `docs/guides/PDL_TRIAD_QUICKSTART.md` with header, version number (Version: 1.0.0), and Related links section pointing to PDL_TRIAD_LIFECYCLE.md, PDL_TRIAD_INFOGRAPHIC.md, and docs/SPEC_KIT_TRIAD.md
- [X] T008 [US1] Add unified workflow overview diagram in `docs/guides/PDL_TRIAD_QUICKSTART.md` — ASCII art showing PDL discovery (Idea → Score → Validate → Backlog) flowing into Triad delivery (PRD → Specify → Plan → Tasks → Implement)
- [X] T009 [US1] Add "What is PDL?" section (2-3 sentences) and "What is Triad?" section (2-3 sentences with roles) in `docs/guides/PDL_TRIAD_QUICKSTART.md`
- [X] T010 [US1] Add Quick Start section in `docs/guides/PDL_TRIAD_QUICKSTART.md` — fastest path from idea to implementation (`/pdl.run` → `/triad.prd` → `/triad.specify` → `/triad.plan` → `/triad.tasks` → `/triad.implement`)
- [X] T011 [US1] Add PDL Command Reference table in `docs/guides/PDL_TRIAD_QUICKSTART.md` — 4 commands (`/pdl.run`, `/pdl.idea`, `/pdl.score`, `/pdl.validate`) with Purpose, Input, Output columns; syntax must match skill definitions
- [X] T012 [US1] Add Triad Command Reference table in `docs/guides/PDL_TRIAD_QUICKSTART.md` — 6 commands (`/triad.prd`, `/triad.specify`, `/triad.plan`, `/triad.tasks`, `/triad.implement`, `/triad.close-feature`) with descriptions
- [X] T013 [US1] Add ICE Scoring Quick Reference in `docs/guides/PDL_TRIAD_QUICKSTART.md` — dimension anchors (Impact H9/M6/L3, Confidence H9/M6/L3, Effort H9/M6/L3), priority tiers (P0: 25-30, P1: 18-24, P2: 12-17, Deferred: <12), auto-defer gate
- [X] T014 [US1] Add PDL → Triad Handoff section in `docs/guides/PDL_TRIAD_QUICKSTART.md` — explain how backlog item becomes PRD with source traceability (idea_id, story_id fields)
- [X] T015 [US1] Add Triad Roles Summary in `docs/guides/PDL_TRIAD_QUICKSTART.md` — PM (What & Why), Architect (How), Team-Lead (When & Who) with authority descriptions
- [X] T016 [US1] Add Sign-off Requirements table in `docs/guides/PDL_TRIAD_QUICKSTART.md` — phase → required sign-offs mapping (spec: PM, plan: PM+Architect, tasks: PM+Architect+Team-Lead)
- [X] T017 [US1] Add File Locations Reference in `docs/guides/PDL_TRIAD_QUICKSTART.md` — PDL artifacts (docs/product/_backlog/) and Triad artifacts (.specify/, specs/) paths
- [X] T018 [US1] Add Troubleshooting section in `docs/guides/PDL_TRIAD_QUICKSTART.md` — common issues (idea not scoring, validation gate failures, command not found) with solutions
- [X] T019 [US1] Verify `docs/guides/PDL_TRIAD_QUICKSTART.md` is under ~270 lines with `wc -l` and contains all 13 required content sections

**Phase 2 Completion Criteria**:
- [X] `PDL_TRIAD_QUICKSTART.md` exists with all 13 content sections
- [X] Command syntax matches skill definitions
- [X] ICE scoring consistent with PDL skill definitions
- [X] Cross-references use relative paths from `docs/guides/`
- [X] Under ~270 lines (191 lines)

---

## Phase 3: User Story 2 — Visual Reference (PDL_TRIAD_INFOGRAPHIC.md)

**Objective**: Create single-page ASCII infographic showing complete PDL → Triad flow
**Maps to**: Plan Phase 2, Spec FR-2, Scenario 2 (Quick Visual Reference)
**Story Goal**: A user can see the complete workflow at a glance without reading narrative documentation
**Independent Test**: Open the file and confirm it is purely visual (no narrative paragraphs), shows all sign-off gates, and fits in one continuous scan

### Tasks

- [X] T020 [US2] Create `docs/guides/PDL_TRIAD_INFOGRAPHIC.md` with title banner, version number, and Related links section pointing to PDL_TRIAD_QUICKSTART.md and PDL_TRIAD_LIFECYCLE.md
- [X] T021 [US2] Add Triad Roles Legend in `docs/guides/PDL_TRIAD_INFOGRAPHIC.md` — PM (What & Why: Scope & requirements), Architect (How: Technical decisions), Team-Lead (When & Who: Timeline & resources) using box-drawing characters
- [X] T022 [US2] Add PDL Section in `docs/guides/PDL_TRIAD_INFOGRAPHIC.md` — Idea → Score → Validate → Backlog flow boxes with ICE dimensions detail and auto-defer gate visualization using Unicode box-drawing (┌─┐│└├─┤)
- [X] T023 [US2] Add Handoff Visual in `docs/guides/PDL_TRIAD_INFOGRAPHIC.md` — clear ═══ HANDOFF ═══ separator between PDL and Triad sections
- [X] T024 [US2] Add Triad Section in `docs/guides/PDL_TRIAD_INFOGRAPHIC.md` — Phase 1: PRD (triple sign-off), Phase 2: Specify (PM sign-off), Phase 3: Plan (dual sign-off), Phase 4: Tasks (triple sign-off), Phase 5: Implement (wave visualization), Phase 6: Review & Deploy (parallel validation) using box-drawing and flow indicators (→, ↓, ═══▶)
- [X] T025 [US2] Add Artifact Trail Summary in `docs/guides/PDL_TRIAD_INFOGRAPHIC.md` — one-line chain: IDEAS → User Stories → PRD → spec → plan → tasks → code
- [X] T026 [US2] Verify `docs/guides/PDL_TRIAD_INFOGRAPHIC.md` is under ~160 lines with `wc -l`, contains no narrative paragraphs, and all sign-off gates are shown

**Phase 3 Completion Criteria**:
- [X] `PDL_TRIAD_INFOGRAPHIC.md` exists with complete PDL + Triad flow
- [X] All Triad sign-off gates shown at correct phases
- [X] Auto-defer gate shown in PDL section
- [X] Artifact trail visible
- [X] Under ~160 lines (118 lines)
- [X] No narrative text — purely visual with labels

---

## Phase 4: User Story 3 — Lifecycle Enhancement (PDL_TRIAD_LIFECYCLE.md)

**Objective**: Enhance existing lifecycle guide with visual diagram, sign-off details, artifact examples, and reference tables
**Maps to**: Plan Phase 3, Spec FR-3, Scenario 3 (Deep Lifecycle Understanding)
**Story Goal**: A user can understand stage-by-stage transformation with concrete examples and Triad sign-off context
**Independent Test**: Verify existing 205-line content is preserved, new enhancements are present, and file is under ~400 lines

### Tasks

- [X] T027 [US3] Add cross-references section at top of `docs/guides/PDL_TRIAD_LIFECYCLE.md` — Related links to PDL_TRIAD_QUICKSTART.md, PDL_TRIAD_INFOGRAPHIC.md, and docs/SPEC_KIT_TRIAD.md
- [X] T028 [US3] Add visual flow diagram at top of `docs/guides/PDL_TRIAD_LIFECYCLE.md` (after title, before "Complete Lifecycle Overview") — ASCII art matching quickstart overview style showing complete PDL + Triad flow (~25 lines)
- [X] T029 [US3] Add Triad sign-off details to Stages 6-10 in `docs/guides/PDL_TRIAD_LIFECYCLE.md` — inline additions showing which roles sign off at each stage (Stage 6/Specify: PM, Stage 7/Plan: PM+Architect, Stage 8/Tasks: PM+Architect+Team-Lead, Stage 9/Implement: Architect checkpoints) (~30 lines)
- [X] T030 [US3] Add concrete artifact example at Stage 1 (Idea Capture) in `docs/guides/PDL_TRIAD_LIFECYCLE.md` — example `01_IDEAS.md` table row showing IDEA-NNN with ICE scores
- [X] T031 [US3] Add concrete artifact example at Stage 3 (PM Validation) in `docs/guides/PDL_TRIAD_LIFECYCLE.md` — example user story in "As a... I want... so that..." format
- [X] T032 [US3] Add concrete artifact example at Stage 5 (Triad Handoff) in `docs/guides/PDL_TRIAD_LIFECYCLE.md` — example PRD frontmatter with source traceability fields (idea_id, story_id)
- [X] T033 [US3] Add concrete artifact example at Stage 6 (Specify) in `docs/guides/PDL_TRIAD_LIFECYCLE.md` — example spec.md section header structure
- [X] T034 [US3] Add concrete artifact examples at Stage 7 (Plan) and Stage 8 (Tasks) in `docs/guides/PDL_TRIAD_LIFECYCLE.md` — example plan.md architecture decision and example task entry with wave assignment
- [X] T035 [US3] Add commands-by-stage reference table in `docs/guides/PDL_TRIAD_LIFECYCLE.md` — PDL and Triad commands mapped side by side to each stage (~25 lines)
- [X] T036 [US3] Add summary table in `docs/guides/PDL_TRIAD_LIFECYCLE.md` — Stage → Artifact → Purpose → Owner mapping for all 10 stages (~20 lines)
- [X] T037 [US3] Verify `docs/guides/PDL_TRIAD_LIFECYCLE.md` preserves all existing content (stage descriptions, traceability model, status flows, end-to-end example) and is under ~400 lines with `wc -l`

**Phase 4 Completion Criteria**:
- [X] Existing 205-line content preserved
- [X] Visual flow diagram added at top
- [X] Triad sign-off details for applicable stages
- [X] At least 4 of 6 concrete artifact examples included (6 of 6 included)
- [X] Commands-by-stage reference table present
- [X] Summary table present
- [X] Cross-references present
- [X] Under ~400 lines (339 lines)

---

## Phase 5: File Cleanup (FR-4)

**Objective**: Remove old quickstart and verify references
**Maps to**: Plan Phase 4, Spec FR-4, Scenario 4 (Old Quickstart Removal)
**Dependencies**: Phases 2-4 complete (new guides must exist before deleting old file)

### Tasks

- [X] T038 Delete `docs/guides/PDL_QUICKSTART.md` (content consolidated into PDL_TRIAD_QUICKSTART.md)
- [X] T039 Search for `PDL_QUICKSTART.md` references in active codebase files (excluding `specs/005-*/` historical files) and update any active references to point to `PDL_TRIAD_QUICKSTART.md`
- [X] T040 Verify `specs/005-*/` historical files are NOT modified — run `git diff specs/005-product-discovery-lifecycle/` to confirm zero changes
- [X] T041 Evaluate whether `CLAUDE.md` context discovery section should reference `PDL_TRIAD_QUICKSTART.md` and update if appropriate

**Phase 5 Completion Criteria**:
- [X] `PDL_QUICKSTART.md` deleted
- [X] No active codebase references to deleted file remain (zero active references; 13 found are all historical or self-referencing)
- [X] Historical references in `specs/005-*/` preserved unchanged
- [X] CLAUDE.md evaluated — no update needed (guides discoverable via docs/guides/ directory)

---

## Phase 6: Cross-Validation & Polish

**Objective**: Verify consistency, accuracy, and cross-references across all three guides
**Maps to**: Plan Phase 5, Spec NFR-1 through NFR-4
**Dependencies**: Phases 2-5 complete

### Tasks

- [X] T042 [P] Verify command syntax consistency — all PDL commands (`/pdl.run`, `/pdl.idea`, `/pdl.score`, `/pdl.validate`) identical across all three guides and match skill definitions
- [X] T043 [P] Verify Triad command syntax consistency — all Triad commands identical across all three guides
- [X] T044 [P] Verify file paths consistency — artifact paths (docs/product/_backlog/, .specify/, specs/) consistent across all three guides
- [X] T045 [P] Verify terminology consistency — same terms used across all three guides (check glossary from T006)
- [X] T046 [P] Verify cross-references — each guide links to the other two plus `docs/SPEC_KIT_TRIAD.md`; all links use correct relative paths from `docs/guides/`
- [X] T047 [P] Verify line counts — `wc -l` on each file: PDL_TRIAD_QUICKSTART.md (191), PDL_TRIAD_LIFECYCLE.md (339), PDL_TRIAD_INFOGRAPHIC.md (118)
- [X] T048 [P] Verify historical files unchanged — `git diff specs/005-product-discovery-lifecycle/` shows no changes
- [X] T049 [P] Verify old file deleted — `ls docs/guides/PDL_QUICKSTART.md` confirms not found
- [X] T050 Verify local-first compliance (NFR-4) — all content is pure markdown with ASCII art, no external images or dependencies

**Phase 6 Completion Criteria**:
- [X] Command syntax identical across all three guides and matches skill definitions
- [X] File paths consistent across all three guides
- [X] Terminology consistent across all three guides
- [X] Cross-references complete and correct
- [X] Line counts within target ranges
- [X] Historical files unchanged
- [X] Old quickstart deleted
- [X] Local-first compliance confirmed

---

## Dependencies

```
Phase 1 (Setup) ──→ Phase 2 (US1: Quickstart) ──→ Phase 3 (US2: Infographic)
                                                          │
                                                          └──→ Phase 4 (US3: Lifecycle Enhancement)
                                                                          │
                                                                          └──→ Phase 5 (Cleanup)
                                                                                        │
                                                                                        └──→ Phase 6 (Cross-Validation)
```

**Notes**:
- Phases 2-4 are sequential per plan (cross-references must be consistent, infographic structure informs quickstart diagram)
- Phase 1 tasks T002, T003, T004 are parallelizable (reading different source files)
- Phase 6 tasks T042-T049 are all parallelizable (independent verification checks)
- Phase 5 depends on Phases 2-4 (new guides must exist before deleting old file)

---

## Parallel Execution Opportunities

| Phase | Parallel Tasks | Rationale |
|-------|---------------|-----------|
| Phase 1 | T002, T003, T004 | Reading different source files |
| Phase 2 | None — sequential content writing | Each section builds on previous |
| Phase 3 | None — sequential content writing | Each section builds on previous |
| Phase 4 | None — sequential enhancement | Additions must fit line budget |
| Phase 5 | None — sequential cleanup | Delete before reference check |
| Phase 6 | T042-T049 | Independent verification checks |

---

## Implementation Strategy

### MVP Scope
- **Phase 1 + Phase 2 + Phase 3**: Setup + Quickstart + Infographic (highest value — new user onboarding and visual reference)

### Incremental Delivery
1. After Phase 2: Unified quickstart exists (primary onboarding document)
2. After Phase 3: Visual reference available (infographic for quick scanning)
3. After Phase 4: Lifecycle guide enhanced (deep reference complete)
4. After Phase 5: Old file removed (clean guide directory)
5. After Phase 6: Validated and consistent (production-ready)

### Risk Mitigation
- Line count verification after each writing phase (T019, T026, T037)
- Terminology glossary compiled upfront (T006) for consistency enforcement
- Historical file preservation verified at cleanup (T040) and cross-validation (T048)
- Sequential writing ensures cross-reference consistency without reconciliation pass

---

## Summary

| Metric | Value |
|--------|-------|
| **Total Tasks** | 50 |
| **Phase 1 (Setup)** | 6 tasks |
| **Phase 2 (US1: Quickstart)** | 13 tasks |
| **Phase 3 (US2: Infographic)** | 7 tasks |
| **Phase 4 (US3: Lifecycle)** | 11 tasks |
| **Phase 5 (Cleanup)** | 4 tasks |
| **Phase 6 (Cross-Validation)** | 9 tasks |
| **Parallelizable Tasks** | 11 (22%) |
| **User Stories Covered** | US-001 (Onboarding), US-002 (Visual Reference), US-003 (Deep Lifecycle) |
| **Functional Requirements** | FR-1 through FR-4 (all 4 addressed) |
| **Non-Functional Requirements** | NFR-1 through NFR-4 (all 4 verified) |
| **Scenarios Covered** | Scenarios 1-4 (all 4) |
