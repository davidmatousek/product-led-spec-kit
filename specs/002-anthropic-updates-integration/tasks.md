# Tasks: Anthropic Claude Code Updates Integration

## Metadata

- **Feature ID**: 002
- **Feature Name**: Anthropic Claude Code Updates Integration
- **Status**: Complete
- **Created**: 2026-01-24
- **Plan Reference**: specs/002-anthropic-updates-integration/plan.md
- **Spec Reference**: specs/002-anthropic-updates-integration/spec.md
- **Total Tasks**: 35
- **Estimated Duration**: 2-3 weeks (parallel execution)
- **pm_signoff**: APPROVED
- **pm_signoff_date**: 2026-01-24
- **pm_signoff_notes**: Tasks well-structured with proper prioritization by user value. MVP scope (US1-US2) correctly delivers 80% value. All 5 FRs mapped to phases. Minor metadata inconsistency (task count) corrected.
- **architect_signoff**: APPROVED_WITH_CONCERNS
- **architect_signoff_date**: 2026-01-24
- **architect_signoff_notes**: Technically sound with proper phase structure and dependency management. Concerns: shell script complexity for dependency parsing, missing explicit code review checkpoints. Recommends ADR-001 for dependency wrapper decision.
- **teamlead_signoff**: APPROVED
- **teamlead_signoff_date**: 2026-01-24
- **teamlead_signoff_notes**: Well-structured with clear dependencies. Optimized agent assignments (T010-T014 reassigned to architect). 7 waves with 31% parallelization. Wave 3A/3B can run in full parallel for 38% time savings.

---

## Phase 1: Setup

**Objective**: Initialize project structure and establish foundation for feature development.

### Tasks

- [x] T001 Create version detection utility directory structure at `.claude/lib/version/`
- [x] T002 Create context forking skills directory at `.claude/skills/triad/`
- [x] T003 [P] Create feature flag configuration file at `.claude/config/feature-flags.json`
- [x] T004 [P] Create test fixtures directory at `specs/002-anthropic-updates-integration/test-fixtures/`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Objective**: Implement core version detection and feature flag system that all other phases depend on.

**Story Goal**: Enable runtime detection of Claude Code version to conditionally enable/disable v2.1.16 features.

**Independent Test Criteria**:
- Version detection correctly identifies Claude Code v2.1.16
- Feature flags accurately reflect version capabilities
- Graceful degradation messaging works for v2.1.15

### Tasks

- [x] T005 Implement version detection via CLAUDECODE env var check in `.claude/lib/version/detect.sh`
- [x] T006 Implement CLI version parsing fallback in `.claude/lib/version/detect.sh`
- [x] T007 [P] Implement feature flag computation based on detected version in `.claude/lib/version/feature-flags.sh`
- [x] T008 [P] Implement graceful degradation messaging utilities in `.claude/lib/version/degradation.sh`
- [x] T009 Create version detection integration tests in `specs/002-anthropic-updates-integration/test-fixtures/version-detection-test.sh`

---

## Phase 3: User Story 1 - Context Forking (FR-2)

**Story Goal**: As a user running parallel Triad reviews, I want each agent to operate in an isolated context fork, so I can prevent context pollution between agents.

**User Story Reference**: US-002 (Context Forking for Agent Isolation)

**Independent Test Criteria**:
- PM review skill executes in forked context
- Architect review skill executes in forked context
- Context pollution is prevented (PM cannot see Architect context)
- Results correctly merge back to parent context

### Tasks

- [x] T010 [US1] Create PM review skill with `context: fork` frontmatter at `.claude/skills/triad/pm-review.md`
- [x] T011 [US1] Create Architect review skill with `context: fork` frontmatter at `.claude/skills/triad/architect-review.md`
- [x] T012 [P] [US1] Create Team-Lead review skill with `context: fork` frontmatter at `.claude/skills/triad/teamlead-review.md`
- [x] T013 [US1] Implement result merging logic for forked context reviews in `.claude/lib/triad/merge-results.sh`
- [x] T014 [US1] Create context forking validation test at `specs/002-anthropic-updates-integration/test-fixtures/fork-test.sh`

---

## Phase 4: User Story 2 - Parallel Execution (FR-3, US-003)

**Story Goal**: As a user running multiple agent workflows concurrently, I want the parallel execution fixes from v2.1.16 to eliminate memory leaks and orphaned tool results.

**User Story Reference**: US-003 (Parallel Execution Reliability)

**Independent Test Criteria**:
- PM and Architect reviews execute simultaneously
- Total review time is max(PM time, Architect time) + overhead (not sum)
- No orphaned tool results after completion
- Memory usage remains stable

### Tasks

- [x] T015 [US2] Update `/triad.plan` command to launch parallel PM + Architect Task calls at `.claude/commands/triad.plan.md`
- [x] T016 [US2] Update `/triad.tasks` command to launch parallel triple reviews at `.claude/commands/triad.tasks.md`
- [x] T017 [P] [US2] Implement timing metrics collection for parallel vs sequential comparison in `.claude/lib/triad/timing-metrics.sh`
- [x] T018 [US2] Create parallel execution validation test at `specs/002-anthropic-updates-integration/test-fixtures/parallel-test.sh`

---

## Phase 5: User Story 3 - Task Dependency Wrapper (FR-1)

**Story Goal**: As a user executing a Triad workflow, I want to define dependencies declaratively using the native task system, so I can automatically prevent agents from starting work before prerequisites complete.

**User Story Reference**: US-001 (Native Task Dependency Tracking)

**Independent Test Criteria**:
- Dependencies can be defined in tasks.md `depends_on` field
- Circular dependencies are detected and rejected
- Tasks block until dependencies complete
- Dependency graph is queryable

### Tasks

- [x] T019 [US3] Implement dependency parser for tasks.md format in `.claude/lib/dependencies/parser.sh`
- [x] T020 [US3] Implement circular dependency detection algorithm in `.claude/lib/dependencies/validator.sh`
- [x] T021 [P] [US3] Implement blocking/ready status computation in `.claude/lib/dependencies/resolver.sh`
- [x] T022 [US3] Integrate dependency tracking with TodoWrite for visibility in `.claude/lib/dependencies/todowrite-sync.sh`
- [x] T023 [US3] Create dependency validation tests at `specs/002-anthropic-updates-integration/test-fixtures/dependency-test.sh`

---

## Phase 6: User Story 4 - Version Detection & Degradation (FR-4)

**Story Goal**: As a user on an older Claude Code version, I want the system to detect my version and enable/disable features accordingly with clear messaging.

**User Story Reference**: FR-4 (Version Detection and Graceful Degradation)

**Independent Test Criteria**:
- System detects Claude Code version at startup
- Features requiring v2.1.16 are auto-enabled when detected
- v2.1.15 users receive clear message about limited functionality
- All existing workflows continue to function

### Tasks

- [x] T024 [US4] Integrate version detection into Triad command startup at `.claude/commands/_triad-init.md`
- [x] T025 [P] [US4] Implement feature-gated command paths in `.claude/lib/version/feature-gate.sh`
- [x] T026 [US4] Create user notification messages for unavailable features in `.claude/lib/version/user-messages.md`
- [x] T027 [US4] Create graceful degradation integration test at `specs/002-anthropic-updates-integration/test-fixtures/degradation-test.sh`

---

## Phase 7: User Story 5 - Migration Documentation (FR-5)

**Story Goal**: As a user upgrading to leverage v2.1.16 features, I want clear documentation so I can complete the upgrade in under 15 minutes.

**User Story Reference**: FR-5 (Create Migration Documentation)

**Independent Test Criteria**:
- MIGRATION.md provides step-by-step upgrade instructions
- Feature availability matrix is accurate
- Troubleshooting section covers common issues
- Rollback instructions are documented

### Tasks

- [x] T028 [US5] Create MIGRATION.md with upgrade steps at `docs/devops/MIGRATION.md`
- [x] T029 [P] [US5] Create feature availability matrix at `docs/devops/FEATURE_MATRIX.md`
- [x] T030 [P] [US5] Add troubleshooting guide section to MIGRATION.md
- [x] T031 [US5] Document rollback instructions in MIGRATION.md

---

## Phase 8: Polish & Cross-Cutting Concerns

**Objective**: Finalize integration, update documentation, and ensure quality gates pass.

### Tasks

- [x] T032 Update CLAUDE.md with new Triad capabilities at `CLAUDE.md`
- [x] T033 [P] Update .claude/rules/governance.md with parallel review information
- [x] T034 Run full integration test suite across all test fixtures
- [x] T035 Create validation report at `specs/002-anthropic-updates-integration/VALIDATION_REPORT.md`

---

## Dependencies

### Dependency Graph

```
Phase 1 (Setup)
    │
    ▼
Phase 2 (Version Detection) ─────────────────────────────────────┐
    │                                                             │
    ├──────────────────┬─────────────────────┐                   │
    ▼                  ▼                     ▼                   │
Phase 3             Phase 4              Phase 5                 │
(Context Fork)    (Parallel Exec)    (Task Dependencies)         │
    │                  │                     │                   │
    └──────────────────┴─────────────────────┴───────────────────┤
                                                                  │
                                                                  ▼
                                                         Phase 6 (Degradation)
                                                                  │
                                                                  ▼
                                                         Phase 7 (Docs)
                                                                  │
                                                                  ▼
                                                         Phase 8 (Polish)
```

### Task Dependencies

| Task | Depends On | Reason |
|------|------------|--------|
| T005-T009 | T001-T004 | Setup must complete first |
| T010-T014 | T005-T009 | Context forking needs version detection |
| T015-T018 | T010-T014 | Parallel execution uses forked skills |
| T019-T023 | T005-T009 | Dependency wrapper needs version detection |
| T024-T027 | T015-T018, T019-T023 | Degradation integrates all features |
| T028-T031 | T024-T027 | Docs need final feature set |
| T032-T035 | T028-T031 | Polish after all implementation |

### Parallel Execution Waves

**Wave 1** (Setup): T001, T002, T003, T004
**Wave 2** (Foundation): T005, T006, T007, T008, T009
**Wave 3** (Features): T010-T014 ‖ T019-T023 (parallel phases)
**Wave 4** (Integration): T015-T018 (depends on Wave 3)
**Wave 5** (Degradation): T024-T027
**Wave 6** (Docs): T028-T031
**Wave 7** (Polish): T032-T035

---

## Implementation Strategy

### MVP Scope (P0)

**User Stories 1-2** (Context Forking + Parallel Execution):
- T001-T004: Setup
- T005-T009: Version Detection (foundation)
- T010-T018: Context Forking + Parallel Execution

This delivers the highest-value capability: parallel Triad reviews with context isolation.

### Phase 2 Scope (P1)

**User Stories 3-4** (Task Dependencies + Full Degradation):
- T019-T027: Task Dependency Wrapper + Version Detection Integration

### Phase 3 Scope (P2)

**User Story 5** (Documentation):
- T028-T035: Migration Docs + Polish

---

## Task Summary

| Phase | Tasks | Parallel | User Story |
|-------|-------|----------|------------|
| 1. Setup | 4 | 2 | - |
| 2. Foundational | 5 | 2 | - |
| 3. Context Forking | 5 | 1 | US-002 |
| 4. Parallel Execution | 4 | 1 | US-003 |
| 5. Task Dependencies | 5 | 1 | US-001 |
| 6. Version Detection | 4 | 1 | FR-4 |
| 7. Documentation | 4 | 2 | FR-5 |
| 8. Polish | 4 | 1 | - |
| **Total** | **35** | **11** | **5** |

---

## Agent Assignments (Suggested)

| Agent | Tasks | Focus |
|-------|-------|-------|
| senior-backend-engineer | T005-T009, T019-T023 | Version detection, dependency wrapper |
| frontend-developer | T010-T014 | Skill creation (markdown/YAML) |
| devops | T015-T018, T024-T027 | Command integration, feature gating |
| web-researcher | T028-T031 | Documentation |
| team-lead | T032-T035 | Polish, validation |

---

## Validation Checklist

- [x] All 35 tasks follow checklist format (checkbox, ID, labels, file paths)
- [x] Each user story has independent test criteria
- [x] Dependencies are logical and avoid cycles
- [x] Parallel opportunities marked with [P]
- [x] User story labels [US1-US5] applied correctly
- [x] File paths specified for each task
- [x] MVP scope clearly identified (US1-US2)

## Completion Summary

- **Completed**: 2026-01-24
- **Tests Passing**: 97/97 (100%)
- **Architect Checkpoints**: 3/3 APPROVED
- **Validation Report**: [validation-report.md](validation-report.md)
