---
triad:
  pm_signoff:
    agent: product-manager
    date: 2026-02-07
    status: APPROVED
    notes: "All 10 user scenarios from spec.md fully covered with clear traceability annotations. All 6 FRs (FR-1 through FR-6) addressed with granular, actionable tasks. No scope creep detected. All 5 success criteria verifiable through validation tasks T082-T088. MVP scope (Phases 1-3) correctly prioritizes eliminating fragile Skill tool coupling before cleanup work."
  architect_signoff:
    agent: architect
    date: 2026-02-07
    status: APPROVED_WITH_CONCERNS
    notes: "Dependencies correctly ordered, merge pattern consistent across all 4 core commands, 500-line verification gates properly placed, archive tag precedes all deletions. Concerns addressed: (1) T050 [P] marker added, (2) T088 discoverability validation task added for 4 new commands in CLAUDE.md and commands.md."
  techlead_signoff:
    agent: team-lead
    date: 2026-02-07
    status: APPROVED
    notes: "Task granularity appropriate. Critical path correctly identified. Parallelization maximized at 60%. 88-task count proportional to scope (25+ files, 4 merges, 4 new commands, comprehensive cleanup). Feasible in 1-2 sessions. Recommended 5-wave execution strategy with single executing agent plus orchestrator coordination."
---

# Tasks: Remove SpecKit Commands & Transfer Content to Triad

**Feature ID**: 004
**Feature Name**: Remove SpecKit Commands & Transfer Content to Triad
**Status**: Ready for Implementation
**Generated**: 2026-02-07
**Spec Reference**: specs/004-remove-speckit-commands/spec.md
**Plan Reference**: specs/004-remove-speckit-commands/plan.md

---

## Phase 1: Setup & Reference Audit

**Objective**: Create a comprehensive reference inventory to drive all subsequent phases
**Maps to**: Plan Phase 0 (Reference Audit)

### Tasks

- [X] T001 Run `grep -r "/speckit\." --include="*.md" -l` across entire repo and document all files containing speckit references in specs/004-remove-speckit-commands/reference-audit.md
- [X] T002 Run `grep -r "compatible_with_speckit\|last_tested_with_speckit" --include="*.md" -l` and add frontmatter marker inventory to specs/004-remove-speckit-commands/reference-audit.md
- [X] T003 Run `grep -ri "vanilla" --include="*.md" -l` and add "vanilla" terminology inventory to specs/004-remove-speckit-commands/reference-audit.md
- [X] T004 Categorize all references in specs/004-remove-speckit-commands/reference-audit.md into: historical (preserve), active (update), command files (merge/delete)

**Phase 1 Completion Criteria**:
- [X] reference-audit.md contains file-by-file inventory with action for each reference
- [X] All 142+ references across 39+ files accounted for
- [X] Historical exceptions clearly marked (CHANGELOG.md, PRD 004, specs/001-003)

---

## Phase 2: Foundational — Read All Source Files

**Objective**: Read and understand all speckit and triad command files before any modifications
**Dependencies**: Phase 1 complete

### Tasks

- [X] T005 [P] Read .claude/commands/speckit.specify.md and .claude/commands/triad.specify.md side by side, identify the Skill tool invocation point at triad.specify.md line 91
- [X] T006 [P] Read .claude/commands/speckit.plan.md and .claude/commands/triad.plan.md side by side, identify the Skill tool invocation point at triad.plan.md line 30
- [X] T007 [P] Read .claude/commands/speckit.tasks.md and .claude/commands/triad.tasks.md side by side, identify the Skill tool invocation point at triad.tasks.md line 30
- [X] T008 [P] Read .claude/commands/speckit.implement.md and .claude/commands/triad.implement.md side by side, identify implementation logic to inline
- [X] T009 [P] Read .claude/commands/speckit.clarify.md and identify all /speckit.* cross-references to update
- [X] T010 [P] Read .claude/commands/speckit.analyze.md and identify all /speckit.* cross-references to update
- [X] T011 [P] Read .claude/commands/speckit.checklist.md and identify all /speckit.* cross-references to update
- [X] T012 [P] Read .claude/commands/speckit.constitution.md and identify all /speckit.* cross-references to update

**Phase 2 Completion Criteria**:
- [X] All 14 command files read and understood
- [X] Coupling points identified for each of the 4 core merges
- [X] Cross-reference update points documented for each of the 4 new commands

---

## Phase 3: Inline Core Commands (US1–US4)

**Objective**: Make 4 triad commands self-contained by inlining speckit logic and removing Skill tool coupling
**Maps to**: Plan Phase 1, Scenarios 2–5 (FR-1)
**Dependencies**: Phase 2 complete
**User Stories**: US1 (Specify), US2 (Plan), US3 (Tasks), US4 (Implement)

### 3.1 Merge triad.specify (Scenario 2)

- [X] T013 [US1] Replace the `Invoke /speckit.specify using the Skill tool` directive at line 91 of .claude/commands/triad.specify.md with inline spec generation logic from speckit.specify.md (PRD traceability, script invocation, template loading, execution flow, quality validation)
- [X] T014 [US1] Remove `compatible_with_speckit` and `last_tested_with_speckit` frontmatter from .claude/commands/triad.specify.md
- [X] T015 [US1] Update overview/description text in .claude/commands/triad.specify.md to remove "Wraps /speckit.specify" phrasing
- [X] T016 [US1] Replace all remaining `/speckit.*` references within .claude/commands/triad.specify.md with `/triad.*` equivalents
- [X] T017 [US1] Condense "General Guidelines" and "For AI Generation" sections (deduplicate with template content) to keep merged file under 420 lines in .claude/commands/triad.specify.md
- [X] T018 [US1] Verify .claude/commands/triad.specify.md is under 500 lines with `wc -l`

### 3.2 Merge triad.plan (Scenario 3)

- [X] T019 [US2] Replace the `Invoke /speckit.plan using the Skill tool` directive at line 30 of .claude/commands/triad.plan.md with inline plan generation logic from speckit.plan.md (script invocation, context loading, plan workflow, design artifacts, agent context update)
- [X] T020 [US2] Remove `compatible_with_speckit` and `last_tested_with_speckit` frontmatter from .claude/commands/triad.plan.md
- [X] T021 [US2] Update overview/description text in .claude/commands/triad.plan.md to remove "Wraps /speckit.plan" phrasing
- [X] T022 [US2] Replace all remaining `/speckit.*` references within .claude/commands/triad.plan.md with `/triad.*` equivalents
- [X] T023 [US2] Verify .claude/commands/triad.plan.md is under 500 lines with `wc -l`

### 3.3 Merge triad.tasks (Scenario 4)

- [X] T024 [US3] Replace the `Invoke /speckit.tasks using the Skill tool` directive at line 30 of .claude/commands/triad.tasks.md with inline task generation logic from speckit.tasks.md (prerequisites, document loading, task generation workflow, task generation rules, checklist format, phase structure)
- [X] T025 [US3] Remove `compatible_with_speckit` and `last_tested_with_speckit` frontmatter from .claude/commands/triad.tasks.md
- [X] T026 [US3] Update overview/description text in .claude/commands/triad.tasks.md to remove "Wraps /speckit.tasks" phrasing
- [X] T027 [US3] Replace all remaining `/speckit.*` references within .claude/commands/triad.tasks.md with `/triad.*` equivalents
- [X] T028 [US3] Verify .claude/commands/triad.tasks.md is under 500 lines with `wc -l`

### 3.4 Merge triad.implement (Scenario 5)

- [X] T029 [US4] Inline speckit.implement.md logic into .claude/commands/triad.implement.md: add checklist status checking, incomplete checklist user prompt, implementation context loading (data-model.md, contracts/, research.md, quickstart.md), and project setup verification (ignore files)
- [X] T030 [US4] Remove `compatible_with_speckit` and `last_tested_with_speckit` frontmatter from .claude/commands/triad.implement.md
- [X] T031 [US4] Update overview/description text in .claude/commands/triad.implement.md to remove any speckit phrasing
- [X] T032 [US4] Replace all remaining `/speckit.*` references within .claude/commands/triad.implement.md with `/triad.*` equivalents
- [X] T033 [US4] Verify .claude/commands/triad.implement.md is under 500 lines with `wc -l`

### Phase 3 Validation

- [X] T034 Run `grep -n "/speckit\.\|Skill tool" .claude/commands/triad.specify.md .claude/commands/triad.plan.md .claude/commands/triad.tasks.md .claude/commands/triad.implement.md` and verify zero speckit Skill tool invocations remain

**Phase 3 Completion Criteria**:
- [X] All 4 triad core commands are fully self-contained
- [X] Zero Skill tool invocations of speckit commands remain
- [X] All 4 merged files are under 500 lines
- [X] All internal references use `/triad.*` naming

---

## Phase 4: Create New Triad Commands (US5–US8)

**Objective**: Create 4 new triad commands from speckit-only commands with no triad counterpart
**Maps to**: Plan Phase 2, Scenarios 6–9 (FR-2)
**Dependencies**: None (parallelizable with Phase 3)
**User Stories**: US5 (Clarify), US6 (Analyze), US7 (Checklist), US8 (Constitution)

### 4.1 Create triad.clarify (Scenario 6)

- [X] T035 [P] [US5] Copy .claude/commands/speckit.clarify.md to .claude/commands/triad.clarify.md
- [X] T036 [US5] Update frontmatter name/description in .claude/commands/triad.clarify.md to reflect triad namespace
- [X] T037 [US5] Replace `/speckit.plan` → `/triad.plan`, `/speckit.clarify` → `/triad.clarify`, `/speckit.specify` → `/triad.specify` in .claude/commands/triad.clarify.md

### 4.2 Create triad.analyze (Scenario 7)

- [X] T038 [P] [US6] Copy .claude/commands/speckit.analyze.md to .claude/commands/triad.analyze.md
- [X] T039 [US6] Update frontmatter name/description in .claude/commands/triad.analyze.md to reflect triad namespace
- [X] T040 [US6] Replace all `/speckit.*` references with `/triad.*` equivalents in .claude/commands/triad.analyze.md

### 4.3 Create triad.checklist (Scenario 8)

- [X] T041 [P] [US7] Copy .claude/commands/speckit.checklist.md to .claude/commands/triad.checklist.md
- [X] T042 [US7] Update frontmatter name/description in .claude/commands/triad.checklist.md to reflect triad namespace
- [X] T043 [US7] Replace `/speckit.checklist` → `/triad.checklist`, `/speckit.clarify` → `/triad.clarify`, `/speckit.plan` → `/triad.plan` in .claude/commands/triad.checklist.md

### 4.4 Create triad.constitution (Scenario 9)

- [X] T044 [P] [US8] Copy .claude/commands/speckit.constitution.md to .claude/commands/triad.constitution.md
- [X] T045 [US8] Update frontmatter name/description in .claude/commands/triad.constitution.md to reflect triad namespace
- [X] T046 [US8] Replace all `/speckit.*` references with `/triad.*` equivalents in .claude/commands/triad.constitution.md

### Phase 4 Validation

- [X] T047 Run `grep -rn "/speckit\." .claude/commands/triad.clarify.md .claude/commands/triad.analyze.md .claude/commands/triad.checklist.md .claude/commands/triad.constitution.md` and verify zero speckit references

**Phase 4 Completion Criteria**:
- [X] All 4 new triad command files exist in .claude/commands/
- [X] Zero `/speckit.*` references in any new file
- [X] All files under 500 lines
- [X] Functional logic unchanged from speckit originals

---

## Phase 5: Delete, Update References & Validate (Scenario 1 & 10)

**Objective**: Archive, delete speckit files, clean up all references, create migration guide, and validate zero active speckit references remain
**Maps to**: Plan Phase 3, Scenarios 1 & 10 (FR-3, FR-4, FR-5, FR-6)
**Dependencies**: Phases 3 and 4 complete

### 5.1 Archive & Delete (FR-3)

- [X] T048 Create archive git tag `v2.0.0-pre-speckit-removal` to preserve historical state
- [X] T049 Verify tag creation with `git tag -l "v2.0.0-pre-speckit-removal"`
- [X] T050 [P] Delete .claude/commands/speckit.specify.md
- [X] T051 [P] Delete .claude/commands/speckit.plan.md
- [X] T052 [P] Delete .claude/commands/speckit.tasks.md
- [X] T053 [P] Delete .claude/commands/speckit.implement.md
- [X] T054 [P] Delete .claude/commands/speckit.clarify.md
- [X] T055 [P] Delete .claude/commands/speckit.analyze.md
- [X] T056 [P] Delete .claude/commands/speckit.checklist.md
- [X] T057 [P] Delete .claude/commands/speckit.constitution.md

### 5.2 Remove Frontmatter Metadata (FR-4)

- [X] T058 [P] Remove `compatible_with_speckit` and `last_tested_with_speckit` frontmatter lines from .claude/commands/triad.prd.md
- [X] T059 [P] Remove `compatible_with_speckit` and `last_tested_with_speckit` frontmatter lines from .claude/commands/triad.close-feature.md
- [X] T060 [P] Remove `compatible_with_speckit` and `last_tested_with_speckit` frontmatter lines from .claude/commands/continue.md
- [X] T061 [P] Remove `compatible_with_speckit` and `last_tested_with_speckit` frontmatter lines from .claude/commands/execute.md

### 5.3 Update Core Documentation (FR-4)

- [X] T062 Update CLAUDE.md: remove "Vanilla (fast, no governance)" section, replace `/speckit.analyze` → `/triad.analyze`, list all 10 triad commands
- [X] T063 [P] Update README.md: remove "Vanilla Commands" section, update to triad-only workflow
- [X] T064 [P] Update Makefile: replace all speckit command shortcuts with triad equivalents

### 5.4 Update Rules Files (FR-4)

- [X] T065 [P] Update .claude/rules/commands.md: remove entire "Vanilla Commands" section, add clarify, analyze, checklist, constitution to triad section
- [X] T066 [P] Update .claude/rules/governance.md: replace `/speckit.specify`, `/speckit.plan`, `/speckit.tasks` references with `/triad.*` equivalents
- [X] T067 [P] Update .claude/rules/scope.md: replace "Vanilla (fast)" workflow references with unified triad workflow description

### 5.5 Update Skill and Agent Files (FR-4, FR-5)

- [X] T068 [P] Update .claude/skills/speckit-validator/SKILL.md: replace `/speckit.plan` → `/triad.plan`, `/speckit.clarify` → `/triad.clarify`
- [X] T069 [P] Update .claude/skills/architecture-validator/SKILL.md: replace `/speckit.tasks` → `/triad.tasks`
- [X] T070 [P] Update .claude/skills/prd-create/skill.md: replace any speckit command references with triad equivalents
- [X] T071 [P] Update .claude/agents/product-manager.md: replace speckit references with triad equivalents

### 5.6 Update Documentation Files (FR-4)

- [X] T072 [P] Update .specify/memory/constitution.md: replace `/speckit.analyze` → `/triad.analyze` and all other `/speckit.*` references with `/triad.*`
- [X] T073 [P] Update docs/SPEC_KIT_TRIAD.md: remove speckit command comparisons, update to triad-only workflow
- [X] T074 [P] Update docs/standards/PRODUCT_SPEC_ALIGNMENT.md: replace all 13 `/speckit.*` references
- [X] T075 [P] Update docs/standards/TRIAD_COLLABORATION.md: replace `/speckit.specify` → `/triad.specify`, `/speckit.prd` → `/triad.prd`
- [X] T076 [P] Update docs/product/02_PRD/INDEX.md: replace `/speckit.prd` → `/triad.prd`, add spec link for feature 004
- [X] T077 [P] Update docs/product/01_Product_Vision/README.md: replace `/speckit.specify` → `/triad.specify`
- [X] T078 [P] Update .claude/README.md: remove Vanilla Commands sections, replace ~24 speckit references with triad equivalents
- [X] T079 [P] Update docs/devops/MIGRATION.md: replace `/speckit.analyze` → `/triad.analyze`
- [X] T080 [P] Update .claude/INFRASTRUCTURE_SETUP_SUMMARY.md: replace ~10 speckit references with triad equivalents

### 5.7 Migration Guide (FR-6)

- [X] T081 Add v3.0.0 breaking change section to CHANGELOG.md with command mapping table (8 speckit → triad mappings) per plan.md Phase 3.5 template

### 5.8 Final Validation (Scenario 10)

- [ ] T082 Verify zero `speckit.*.md` files exist in .claude/commands/ with `ls .claude/commands/speckit.*.md`
- [ ] T083 Run `grep -r "/speckit\." --include="*.md"` across entire codebase and verify zero active results (exceptions: CHANGELOG.md, specs/004-*, PRD 004, specs/001-003 historical)
- [ ] T084 Verify exactly 10 `triad.*.md` files exist in .claude/commands/ with `ls .claude/commands/triad.*.md`
- [ ] T085 Run `wc -l .claude/commands/triad.*.md` and verify all merged commands are under 500 lines
- [ ] T086 Run `grep -r "compatible_with_speckit\|last_tested_with_speckit" --include="*.md"` and verify zero results
- [ ] T087 Run `grep -ri "vanilla commands" --include="*.md"` and verify zero results in active documentation (exceptions: historical specs, CHANGELOG)
- [ ] T088 Verify that all 4 new triad commands (clarify, analyze, checklist, constitution) are listed in both CLAUDE.md and .claude/rules/commands.md

**Phase 5 Completion Criteria**:
- [ ] Archive tag `v2.0.0-pre-speckit-removal` exists
- [ ] Zero speckit command files remain
- [ ] 10 triad command files exist and all under 500 lines
- [ ] Zero active speckit references in codebase
- [ ] Migration guide in CHANGELOG.md
- [ ] PRD INDEX updated with spec link

---

## Dependencies

```
Phase 1 (Audit) ──→ Phase 2 (Read Sources) ──→ Phase 3 (Inline Core)
                                                        │
                                                        ├──→ Phase 5 (Delete/Update/Validate)
                                                        │
                    Phase 4 (Create New) ───────────────┘
```

**Notes**:
- Phase 4 (Create New Commands) can run in parallel with Phase 3 (Inline Core Commands) since they touch different files
- Within Phase 3, merges are sequential (1A → 1B → 1C → 1D) for pattern consistency
- Within Phase 4, all 4 command creations are parallelizable (different files, no dependencies)
- Phase 5 must wait for both Phase 3 and Phase 4 to complete

---

## Parallel Execution Opportunities

| Phase | Parallel Tasks | Rationale |
|-------|---------------|-----------|
| Phase 1 | T001, T002, T003 can run in parallel | Independent grep scans |
| Phase 2 | T005–T012 all parallelizable | Independent file reads |
| Phase 3 | None — sequential merges for consistency | Each merge informs the next |
| Phase 4 | T035+T038+T041+T044 (initial copies) | Different target files |
| Phase 4 | T036-T037, T039-T040, T042-T043, T045-T046 per command | Independent reference updates |
| Phase 5 | T050–T057 (deletions) | Independent file operations |
| Phase 5 | T058–T061 (frontmatter) | Different files |
| Phase 5 | T062–T080 (reference updates) | Most are independent files |
| Phase 5 | T082–T087 (validations) | Independent grep/wc checks |

---

## Implementation Strategy

### MVP Scope
- **Phase 1 + Phase 2**: Audit and read all source files (low risk, high information)
- **Phase 3 (US1–US4)**: Inline core commands — this is the highest-value change, eliminating the fragile Skill tool coupling

### Incremental Delivery
1. After Phase 3: Core commands are self-contained (main value delivered)
2. After Phase 4: All 10 triad commands exist (feature parity)
3. After Phase 5: Clean codebase with zero legacy references (polish)

### Risk Mitigation
- Archive tag before any deletion (Phase 5.1)
- Side-by-side reading before any merge (Phase 2)
- Line count verification after every merge (T018, T023, T028, T033)
- Comprehensive grep validation at the end (T082–T087)

---

## Summary

| Metric | Value |
|--------|-------|
| **Total Tasks** | 88 |
| **Phase 1 (Audit)** | 4 tasks |
| **Phase 2 (Read Sources)** | 8 tasks |
| **Phase 3 (Inline Core — US1-US4)** | 22 tasks |
| **Phase 4 (New Commands — US5-US8)** | 13 tasks |
| **Phase 5 (Delete/Update/Validate)** | 41 tasks |
| **Parallelizable Tasks** | 53 (60%) |
| **User Stories Covered** | US1–US8 (all 8 mapped to Scenarios 2–9) |
| **Functional Requirements** | FR-1 through FR-6 (all 6 addressed) |
