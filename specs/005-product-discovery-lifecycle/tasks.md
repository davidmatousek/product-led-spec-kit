---
triad:
  pm_signoff:
    agent: product-manager
    date: 2026-02-07
    status: APPROVED
    notes: "All 62 tasks fully cover the spec's 6 user scenarios, 7 functional requirements (FR-1 through FR-7), and 4 non-functional requirements (NFR-1 through NFR-4). No scope creep detected — every task traces to a spec requirement, plan phase, or validation need. All primary and secondary success criteria verifiable through explicit tasks. Well-structured with clear phase dependencies, parallelization opportunities, and layered validation. [US*] traceability tags and [P] parallel markers demonstrate strong product-engineering alignment."
  architect_signoff:
    agent: architect
    date: 2026-02-07
    status: APPROVED
    notes: "Technically sound and implementation-ready. Dependencies correctly ordered with justified sequential Phase 2. Parallel execution opportunities correctly identified (39% parallelizable). Architectural patterns maintained: skill/command separation follows prd-create/triad.prd pattern, Anthropic Agent Skills standard compliance verified at task-level (T028) and cross-cutting level (T060), ICE consistency verified twice (T029, T058), no nested Skill tool invocations. Three-tier verification structure provides comprehensive coverage. Plan phase structure correctly implemented with full traceability."
  techlead_signoff:
    agent: team-lead
    date: 2026-02-07
    status: APPROVED
    notes: "Task granularity appropriate — proportional decomposition based on complexity. Critical path correctly identified with justified sequential Phase 2 constraint. Parallelization well maximized at 39%. Task count (62) proportional to scope (12 new files, 6 updates). MVP scope correctly defined as Phases 1+2+3.1, delivering all four user-facing commands. Feasible in 6-8 hours for single agent. All internal dependencies confirmed present. No external blockers."
---

# Tasks: Product Discovery Lifecycle (PDL)

**Feature ID**: 005
**Feature Name**: Product Discovery Lifecycle (PDL)
**Status**: Ready for Implementation
**Generated**: 2026-02-07
**Spec Reference**: specs/005-product-discovery-lifecycle/spec.md
**Plan Reference**: specs/005-product-discovery-lifecycle/plan.md

---

## Phase 1: Setup — Backlog Table Templates

**Objective**: Create the two backlog table files that all PDL commands will write to
**Maps to**: Plan Phase 1 (Foundation)

### Tasks

- [X] T001 [P] Create `docs/product/_backlog/01_IDEAS.md` with Ideas Backlog table header (ID, Idea, Source, Date, Status, ICE Score columns)
- [X] T002 [P] Create `docs/product/_backlog/02_USER_STORIES.md` with Product Backlog - User Stories table header (Priority, Story ID, Story, ICE Score, Source, Status columns)
- [X] T003 Verify both files exist at correct paths and table headers match spec FR-1 and FR-2 field definitions

**Phase 1 Completion Criteria**:
- [X] `01_IDEAS.md` exists with correct table header
- [X] `02_USER_STORIES.md` exists with correct table header
- [X] Existing individual backlog files preserved (not deleted)

---

## Phase 2: Foundational — Core Skills (Sequential)

**Objective**: Create the four PDL skill files with complete workflow logic
**Maps to**: Plan Phase 2 (Core Skills)
**Dependencies**: Phase 1 complete (skills reference backlog table structure)

### 2.1 pdl-idea Skill (Scenario 1: Capture and Score an Idea)

- [X] T004 [US1] Create `.claude/skills/pdl-idea/SKILL.md` with frontmatter (name: pdl-idea, description per plan 2.1)
- [X] T005 [US1] Implement auto-create backlog files logic in `.claude/skills/pdl-idea/SKILL.md` — check for `01_IDEAS.md`, create with header if absent (FR-7)
- [X] T006 [US1] Implement idea capture flow in `.claude/skills/pdl-idea/SKILL.md` — parse input, generate IDEA-NNN ID (read table, find highest, increment), capture source via AskUserQuestion (Brainstorm/Customer Feedback/Team Idea/User Request)
- [X] T007 [US1] Implement ICE scoring flow in `.claude/skills/pdl-idea/SKILL.md` — present quick-assessment table via AskUserQuestion (Impact H9/M6/L3, Confidence H9/M6/L3, Effort H9/M6/L3), allow custom numeric override
- [X] T008 [US1] Implement auto-defer gate and table append in `.claude/skills/pdl-idea/SKILL.md` — compute total, apply <12 auto-defer, set status, append row, report result with ICE breakdown and priority tier
- [X] T009 [US1] Add ICE Scoring Reference section to `.claude/skills/pdl-idea/SKILL.md` with priority tiers (P0: 25-30, P1: 18-24, P2: 12-17, Deferred: <12)
- [X] T010 [US1] Verify `.claude/skills/pdl-idea/SKILL.md` is under 500 lines with `wc -l`

### 2.2 pdl-score Skill (Scenario 4: Re-Score an Existing Idea)

- [X] T011 [US4] Create `.claude/skills/pdl-score/SKILL.md` with frontmatter (name: pdl-score, description per plan 2.2)
- [X] T012 [US4] Implement idea lookup and re-scoring flow in `.claude/skills/pdl-score/SKILL.md` — parse IDEA-NNN, find row in `01_IDEAS.md`, display current scores, present new ICE scoring via AskUserQuestion
- [X] T013 [US4] Implement status update and row replacement in `.claude/skills/pdl-score/SKILL.md` — compute new total, update status based on threshold crossings (preserve Validated), update row in place, update date, report old vs new
- [X] T014 [US4] Verify `.claude/skills/pdl-score/SKILL.md` is under 500 lines with `wc -l`

### 2.3 pdl-validate Skill (Scenario 3: Validate a Deferred Idea)

- [X] T015 [US3] Create `.claude/skills/pdl-validate/SKILL.md` with frontmatter (name: pdl-validate, description per plan 2.3)
- [X] T016 [US3] Implement auto-create backlog files logic and idea lookup in `.claude/skills/pdl-validate/SKILL.md` — check for both backlog files, parse IDEA-NNN, find row, error if not found/Rejected/Validated
- [X] T017 [US3] Implement PM validation launch in `.claude/skills/pdl-validate/SKILL.md` — use Task tool with product-manager subagent_type, pass idea details, ICE score, and evaluation criteria per plan 2.3 step 5
- [X] T018 [US3] Implement rejection handling in `.claude/skills/pdl-validate/SKILL.md` — update status to Rejected in `01_IDEAS.md`, display rationale
- [X] T019 [US3] Implement approval handling in `.claude/skills/pdl-validate/SKILL.md` — generate user story ("As a [persona], I want [action], so that [benefit]"), present for user confirmation, generate US-NNN ID, determine priority from ICE tier
- [X] T020 [US3] Implement backlog entry and status sync in `.claude/skills/pdl-validate/SKILL.md` — append to `02_USER_STORIES.md`, update idea status to Validated in `01_IDEAS.md`, document PM override rationale if auto-deferred
- [X] T021 [US3] Verify `.claude/skills/pdl-validate/SKILL.md` is under 500 lines with `wc -l`

### 2.4 pdl-run Skill (Scenario 2: Run Full Discovery Flow)

- [X] T022 [US2] Create `.claude/skills/pdl-run/SKILL.md` with frontmatter (name: pdl-run, description per plan 2.4)
- [X] T023 [US2] Implement auto-create and inlined pdl-idea logic in `.claude/skills/pdl-run/SKILL.md` — auto-create backlog files, capture idea, generate ID, get ICE score (all inline, not via Skill tool)
- [X] T024 [US2] Implement auto-defer gate in `.claude/skills/pdl-run/SKILL.md` — if score <12 display auto-defer result with guidance to use `/pdl.validate IDEA-{NNN}` and STOP flow
- [X] T025 [US2] Implement inlined pdl-validate logic in `.claude/skills/pdl-run/SKILL.md` — launch PM validation, generate user story on approval, append to backlog (all inline)
- [X] T026 [US2] Implement complete flow summary report in `.claude/skills/pdl-run/SKILL.md` — display IDEA-NNN, ICE score, PM result, US-NNN (if approved), next step `/triad.prd`
- [X] T027 [US2] Verify `.claude/skills/pdl-run/SKILL.md` is under 500 lines with `wc -l`

### Phase 2 Validation

- [X] T028 Verify all 4 SKILL.md files have only `name` and `description` in frontmatter (no triggers, allowed-tools, or non-standard fields)
- [X] T029 Verify ICE scoring is consistent across all 4 skills — same thresholds (12), same tier definitions (P0/P1/P2/Deferred), same quick-assessment anchors (H9/M6/L3)

**Phase 2 Completion Criteria**:
- [X] All 4 skill files created at correct paths
- [X] All under 500 lines
- [X] Frontmatter follows Anthropic Agent Skills open standard
- [X] ICE scoring consistent across all skills
- [X] No Skill tool invocations within skills (inline logic only)

---

## Phase 3: Commands & Integration (Scenarios 1-5)

**Objective**: Create command wrappers and add PDL → Triad handoff integration
**Maps to**: Plan Phase 3
**Dependencies**: Phase 2 complete

### 3.1 Command Wrappers

- [X] T030 [P] [US1] Create `.claude/commands/pdl.idea.md` with YAML frontmatter (description: "Capture a new feature idea with ICE scoring into the Ideas Backlog"), $ARGUMENTS parsing, overview, steps delegating to pdl-idea skill logic, quality checklist
- [X] T031 [P] [US4] Create `.claude/commands/pdl.score.md` with YAML frontmatter (description: "Re-score an existing idea's ICE rating when circumstances change"), IDEA-NNN argument validation, steps delegating to pdl-score skill logic, quality checklist
- [X] T032 [P] [US3] Create `.claude/commands/pdl.validate.md` with YAML frontmatter (description: "PM validation gate for ideas with user story generation"), IDEA-NNN argument validation, steps delegating to pdl-validate skill logic, quality checklist
- [X] T033 [P] [US2] Create `.claude/commands/pdl.run.md` with YAML frontmatter (description: "Full product discovery flow: capture, score, validate, and add to backlog in one step"), $ARGUMENTS parsing, steps delegating to pdl-run skill logic, quality checklist

### 3.2 PDL → Triad Handoff (FR-5, Scenario 5)

- [X] T034 [US5] Read `.claude/skills/prd-create/skill.md` and identify location for source traceability fields
- [X] T035 [US5] Update `.claude/skills/prd-create/skill.md` — add optional `source` frontmatter fields (idea_id, story_id) to PRD template, add step to check `02_USER_STORIES.md` for "Ready for PRD" entries and present to user
- [X] T036 [US5] Read `.claude/commands/triad.prd.md` and identify location for status update logic
- [X] T037 [US5] Update `.claude/commands/triad.prd.md` — after PRD is written, if frontmatter contains source.story_id, update corresponding entry in `02_USER_STORIES.md` from "Ready for PRD" to "In PRD" (skip gracefully if story ID not found)

### Phase 3 Validation

- [X] T038 Verify all 4 command files exist in `.claude/commands/` with valid YAML frontmatter
- [X] T039 Verify prd-create skill includes optional source traceability fields and backlog item presentation logic
- [X] T040 Verify triad.prd command includes user story status update logic with graceful skip on missing story ID

**Phase 3 Completion Criteria**:
- [X] All 4 PDL command wrappers created
- [X] Each command has valid YAML frontmatter with description
- [X] prd-create skill updated with source traceability
- [X] triad.prd command updates user story status on PRD creation

---

## Phase 4: Documentation & Registration (FR-6)

**Objective**: Create guide documentation and update existing docs
**Maps to**: Plan Phase 4
**Dependencies**: Phase 3 complete

### 4.1 PDL Quickstart Guide

- [X] T041 [P] Create `docs/guides/PDL_QUICKSTART.md` with sections: What is PDL, Quick Start example (`/pdl.run`), Commands Reference table, ICE Scoring Reference (tiers, auto-defer), File Structure, Common Workflows (4 patterns), PDL → Triad Handoff, Known Limitations (NFR-4 single-user), FAQ

### 4.2 PDL + Triad Lifecycle Guide

- [X] T042 [P] Create `docs/guides/PDL_TRIAD_LIFECYCLE.md` with sections: Complete Lifecycle Overview (ASCII flow), Stage 1-4 (Idea Capture through Product Backlog), Stage 5 (Triad Handoff), Stages 6-10 (Triad Workflow summary), Traceability Model (IDEA→US→PRD→spec→plan→tasks), Status Flow Diagram, End-to-End Example

### 4.3 Backlog README Update

- [X] T043 Read `docs/product/_backlog/README.md` to understand current content
- [X] T044 Update `docs/product/_backlog/README.md` — add PDL section at top explaining table-based backlog structure, preserve existing content about individual files, add migration guidance, document single-user assumption (NFR-4), update review cadence

### 4.4 PRD INDEX Update

- [X] T045 [P] Update `docs/product/02_PRD/INDEX.md` — add row for feature 005: Product Discovery Lifecycle with PRD and Spec links

### 4.5 Register PDL Commands

- [X] T046 [P] Update `CLAUDE.md` — add PDL workflow commands to Commands section: `/pdl.run` → `/pdl.idea` → `/pdl.score` → `/pdl.validate`
- [X] T047 [P] Update `.claude/rules/commands.md` — add "PDL Commands (Optional Discovery)" section after Triad Commands with all 4 PDL commands and descriptions

### Phase 4 Validation

- [X] T048 Verify all documentation files exist at correct paths (PDL_QUICKSTART.md, PDL_TRIAD_LIFECYCLE.md)
- [X] T049 Verify PDL Quickstart covers all 4 commands with examples and ICE scoring reference
- [X] T050 Verify PDL + Triad Lifecycle guide shows complete traceability chain
- [X] T051 Verify Backlog README preserves existing content and adds PDL structure with migration guidance
- [X] T052 Verify PRD INDEX updated with feature 005 entry
- [X] T053 Verify CLAUDE.md lists PDL commands in Commands section
- [X] T054 Verify `.claude/rules/commands.md` includes PDL Commands section

**Phase 4 Completion Criteria**:
- [X] All documentation created with accurate content
- [X] Documentation references only `/pdl.*` and `/triad.*` commands
- [X] Migration guidance in Backlog README
- [X] PDL commands registered in CLAUDE.md and commands.md

---

## Phase 5: Polish & Cross-Cutting Concerns

**Objective**: Final validation across all deliverables
**Maps to**: Plan validation steps
**Dependencies**: Phases 1-4 complete

### Tasks

- [X] T055 Run `wc -l .claude/skills/pdl-*/SKILL.md` and verify all 4 skill files are under 500 lines
- [X] T056 Run `ls .claude/skills/pdl-*/SKILL.md` and verify all 4 skill directories exist (pdl-idea, pdl-score, pdl-validate, pdl-run)
- [X] T057 Run `ls .claude/commands/pdl.*.md` and verify all 4 command wrappers exist (pdl.idea.md, pdl.score.md, pdl.validate.md, pdl.run.md)
- [X] T058 Verify ICE scoring consistency: grep all 4 SKILL.md files for threshold value "12" and tier definitions (P0/P1/P2/Deferred)
- [X] T059 Verify no Skill tool invocations within skill files: grep for "Skill tool" in `.claude/skills/pdl-*/SKILL.md`
- [X] T060 Verify frontmatter compliance: grep for `triggers\|allowed-tools` in `.claude/skills/pdl-*/SKILL.md` — expect zero matches
- [X] T061 Verify PDL → Triad handoff: grep for `source.idea_id\|source.story_id` in `.claude/skills/prd-create/skill.md`
- [X] T062 Verify PDL commands discoverable: grep for `pdl.run\|pdl.idea\|pdl.score\|pdl.validate` in `CLAUDE.md` and `.claude/rules/commands.md`

**Phase 5 Completion Criteria**:
- [X] All skills under 500 lines (NFR-3)
- [X] All deliverables exist at correct paths
- [X] ICE scoring consistent across all skills
- [X] Frontmatter follows Anthropic standard
- [X] PDL → Triad handoff functional
- [X] PDL commands registered and discoverable

---

## Dependencies

```
Phase 1 (Setup) ──→ Phase 2 (Core Skills — sequential)
                                    │
                                    └──→ Phase 3 (Commands & Integration)
                                                     │
                                                     └──→ Phase 4 (Documentation)
                                                                      │
                                                                      └──→ Phase 5 (Polish)
```

**Notes**:
- Phase 1 tasks T001-T002 are parallelizable (different files)
- Phase 2 skills are sequential (2.1→2.2→2.3→2.4) — each builds on ICE patterns from previous
- Phase 3.1 command wrappers (T030-T033) are parallelizable (different files)
- Phase 3.2 handoff tasks are sequential (read → update for each file)
- Phase 4 documentation tasks (T041, T042, T045, T046, T047) are parallelizable
- Phase 5 validation tasks are all parallelizable

---

## Parallel Execution Opportunities

| Phase | Parallel Tasks | Rationale |
|-------|---------------|-----------|
| Phase 1 | T001, T002 | Different files, no dependencies |
| Phase 2 | None — sequential skill creation | Each skill builds on ICE pattern established in previous |
| Phase 3.1 | T030, T031, T032, T033 | Different command wrapper files |
| Phase 4 | T041, T042, T045, T046, T047 | Independent documentation files |
| Phase 5 | T055-T062 | Independent validation checks |

---

## Implementation Strategy

### MVP Scope
- **Phase 1 + Phase 2**: Backlog templates and core skills (highest value — the PDL logic)
- **Phase 3.1**: Command wrappers (makes skills user-invocable)

### Incremental Delivery
1. After Phase 2: Core PDL logic exists (skills functional but not yet command-invocable)
2. After Phase 3: PDL commands usable + Triad handoff works (feature-complete)
3. After Phase 4: Documentation complete (adopter-ready)
4. After Phase 5: Validated and polished (production-ready)

### Risk Mitigation
- Line count verification after each skill (T010, T014, T021, T027)
- ICE consistency verification across all skills (T029, T058)
- Frontmatter compliance checks (T028, T060)
- End-to-end validation in Phase 5

---

## Summary

| Metric | Value |
|--------|-------|
| **Total Tasks** | 62 |
| **Phase 1 (Setup)** | 3 tasks |
| **Phase 2 (Core Skills)** | 26 tasks |
| **Phase 3 (Commands & Integration)** | 11 tasks |
| **Phase 4 (Documentation)** | 14 tasks |
| **Phase 5 (Polish)** | 8 tasks |
| **Parallelizable Tasks** | 24 (39%) |
| **User Stories Covered** | US1-US5 (all 5 scenarios + Scenario 6 first-time setup) |
| **Functional Requirements** | FR-1 through FR-7 (all 7 addressed) |
| **Non-Functional Requirements** | NFR-1 through NFR-4 (all 4 verified) |
