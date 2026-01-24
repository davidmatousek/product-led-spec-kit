# Agent Assignments: Anthropic Claude Code Updates Integration

## Metadata

- **Feature ID**: 002
- **Feature Name**: Anthropic Claude Code Updates Integration
- **Created**: 2026-01-24
- **Author**: team-lead
- **Spec Reference**: specs/002-anthropic-updates-integration/spec.md
- **Plan Reference**: specs/002-anthropic-updates-integration/plan.md
- **Tasks Reference**: specs/002-anthropic-updates-integration/tasks.md
- **Total Tasks**: 35
- **Estimated Duration**: 2-3 weeks (optimized parallel execution)

---

## Executive Summary

### Task Distribution

| Metric | Count | Notes |
|--------|-------|-------|
| Total Tasks | 35 | Per tasks.md |
| Parallel-Capable Tasks | 11 | 31% can run in parallel |
| Sequential Tasks | 24 | 69% require dependencies |
| Execution Waves | 7 | Optimized from 8 phases |
| Agents Required | 5 | Specialized agents |

### Timeline Comparison

| Execution Mode | Duration | Notes |
|----------------|----------|-------|
| Sequential | ~45-50 hours | All tasks in series |
| Parallel (Optimized) | ~28-32 hours | 38% time reduction |
| Calendar Time | 2-3 weeks | With review cycles |

---

## Agent Assignment Matrix

### Primary Agent Assignments

| Agent | Task Count | Focus Areas | Utilization |
|-------|------------|-------------|-------------|
| **senior-backend-engineer** | 14 | Shell scripts, version detection, dependency wrapper, feature gating | 40% |
| **architect** | 10 | Skill files, documentation, system integration, validation | 29% |
| **devops** | 6 | Command integration, parallel execution, timing metrics | 17% |
| **tester** | 3 | Integration tests, validation report | 9% |
| **web-researcher** | 2 | Migration docs, troubleshooting guide | 6% |

### Agent Specialization Rationale

**senior-backend-engineer** (T005-T009, T019-T023, T025):
- Shell scripting expertise for `.sh` files
- Version detection logic requires backend engineering skills
- Dependency parser/validator requires algorithmic thinking
- Feature gating involves conditional logic

**architect** (T001-T004, T010-T014, T032-T033):
- Directory structure and skill template creation
- Context forking skill files (YAML frontmatter + markdown)
- System documentation updates
- Result merging logic (cross-system integration)

**devops** (T015-T018, T024, T026-T027):
- Command file integration (`.claude/commands/`)
- Parallel execution coordination
- Timing metrics and monitoring
- Feature-gated command paths

**tester** (T009, T014, T018, T023, T027, T034-T035):
- Test fixture creation and validation
- Integration test execution
- Validation report generation

**web-researcher** (T028-T031):
- Migration documentation (user-facing)
- Troubleshooting guide (external references)
- Feature matrix documentation

---

## Optimized Parallel Execution Waves

### Wave Structure Overview

```
Wave 1 (Setup)           [4 tasks, 2 parallel]  ~2 hours
    |
    v
Wave 2 (Foundation)      [5 tasks, 2 parallel]  ~4 hours
    |
    +------------------+------------------+
    |                  |                  |
    v                  v                  |
Wave 3A             Wave 3B               |
(Context Fork)      (Dependencies)        |
[5 tasks]           [5 tasks]             |
~5 hours            ~5 hours              |
    |                  |                  |
    +------------------+                  |
    |                                     |
    v                                     |
Wave 4 (Parallel Execution)  [4 tasks]   ~3 hours
    |                                     |
    +-------------------------------------+
    |
    v
Wave 5 (Degradation)     [4 tasks, 1 parallel]  ~3 hours
    |
    v
Wave 6 (Documentation)   [4 tasks, 2 parallel]  ~4 hours
    |
    v
Wave 7 (Polish)          [4 tasks, 1 parallel]  ~3 hours
```

---

### Wave 1: Setup (Parallel Foundation)

**Duration**: ~2 hours
**Parallel Factor**: 2 of 4 tasks can run in parallel

| Task | Description | Agent | Parallel | Duration |
|------|-------------|-------|----------|----------|
| T001 | Create version detection directory `.claude/lib/version/` | architect | No | 15 min |
| T002 | Create context forking skills directory `.claude/skills/triad/` | architect | No | 15 min |
| T003 | [P] Create feature flag config `.claude/config/feature-flags.json` | architect | Yes | 30 min |
| T004 | [P] Create test fixtures directory `specs/002-*/test-fixtures/` | tester | Yes | 30 min |

**Execution Strategy**:
- T001-T002: Sequential (architect creates directory structure)
- T003-T004: Parallel (different agents, independent directories)

**Wave 1 Agent Utilization**:
- architect: 3 tasks (T001, T002, T003)
- tester: 1 task (T004)

---

### Wave 2: Foundational (Version Detection Core)

**Duration**: ~4 hours
**Parallel Factor**: 2 of 5 tasks can run in parallel
**Dependency**: Requires Wave 1 complete

| Task | Description | Agent | Parallel | Duration |
|------|-------------|-------|----------|----------|
| T005 | Implement version detection via CLAUDECODE env var | senior-backend-engineer | No | 1 hour |
| T006 | Implement CLI version parsing fallback | senior-backend-engineer | No | 45 min |
| T007 | [P] Implement feature flag computation | senior-backend-engineer | Yes | 1 hour |
| T008 | [P] Implement graceful degradation messaging | senior-backend-engineer | Yes | 45 min |
| T009 | Create version detection integration tests | tester | No | 1 hour |

**Execution Strategy**:
- T005-T006: Sequential (version detection must precede flag computation)
- T007-T008: Parallel (independent utilities using version detection)
- T009: Sequential (tests require T005-T008 complete)

**Wave 2 Agent Utilization**:
- senior-backend-engineer: 4 tasks (T005-T008)
- tester: 1 task (T009)

---

### Wave 3A: Context Forking (US-002)

**Duration**: ~5 hours
**Parallel Factor**: 1 of 5 tasks can run in parallel
**Dependency**: Requires Wave 2 complete
**Can Run In Parallel With**: Wave 3B (Task Dependencies)

| Task | Description | Agent | Parallel | Duration |
|------|-------------|-------|----------|----------|
| T010 | [US1] Create PM review skill with `context: fork` | architect | No | 1.5 hours |
| T011 | [US1] Create Architect review skill with `context: fork` | architect | No | 1.5 hours |
| T012 | [P] [US1] Create Team-Lead review skill with `context: fork` | architect | Yes | 1 hour |
| T013 | [US1] Implement result merging logic for forked reviews | architect | No | 1 hour |
| T014 | [US1] Create context forking validation test | tester | No | 1 hour |

**Execution Strategy**:
- T010-T011: Sequential (establish pattern, then replicate)
- T012: Parallel with T011 (third skill follows pattern)
- T013-T014: Sequential (merging, then testing)

**Wave 3A Agent Utilization**:
- architect: 4 tasks (T010-T013)
- tester: 1 task (T014)

---

### Wave 3B: Task Dependencies (US-001) - PARALLEL WITH 3A

**Duration**: ~5 hours
**Parallel Factor**: 1 of 5 tasks can run in parallel
**Dependency**: Requires Wave 2 complete
**Runs In Parallel With**: Wave 3A (Context Forking)

| Task | Description | Agent | Parallel | Duration |
|------|-------------|-------|----------|----------|
| T019 | [US3] Implement dependency parser for tasks.md | senior-backend-engineer | No | 1.5 hours |
| T020 | [US3] Implement circular dependency detection | senior-backend-engineer | No | 1 hour |
| T021 | [P] [US3] Implement blocking/ready status computation | senior-backend-engineer | Yes | 1 hour |
| T022 | [US3] Integrate dependency tracking with TodoWrite | senior-backend-engineer | No | 1 hour |
| T023 | [US3] Create dependency validation tests | tester | No | 1 hour |

**Execution Strategy**:
- T019-T020: Sequential (parser, then validator)
- T021: Can start once T019 complete (parallel with T020)
- T022-T023: Sequential (integration, then testing)

**Wave 3B Agent Utilization**:
- senior-backend-engineer: 4 tasks (T019-T022)
- tester: 1 task (T023)

**CRITICAL OPTIMIZATION**: Waves 3A and 3B can run in complete parallel because:
- Different agents (architect vs senior-backend-engineer)
- Different file paths (`.claude/skills/` vs `.claude/lib/dependencies/`)
- No shared dependencies (both depend only on Wave 2)

---

### Wave 4: Parallel Execution (US-003)

**Duration**: ~3 hours
**Parallel Factor**: 1 of 4 tasks can run in parallel
**Dependency**: Requires Wave 3A complete (uses forked skills)

| Task | Description | Agent | Parallel | Duration |
|------|-------------|-------|----------|----------|
| T015 | [US2] Update `/triad.plan` for parallel PM + Architect Task calls | devops | No | 1 hour |
| T016 | [US2] Update `/triad.tasks` for parallel triple reviews | devops | No | 1 hour |
| T017 | [P] [US2] Implement timing metrics collection | devops | Yes | 45 min |
| T018 | [US2] Create parallel execution validation test | tester | No | 45 min |

**Execution Strategy**:
- T015-T016: Sequential (command updates build on each other)
- T017: Parallel (metrics collection is independent)
- T018: Sequential (tests require T015-T017)

**Wave 4 Agent Utilization**:
- devops: 3 tasks (T015-T017)
- tester: 1 task (T018)

---

### Wave 5: Version Detection & Degradation (FR-4)

**Duration**: ~3 hours
**Parallel Factor**: 1 of 4 tasks can run in parallel
**Dependency**: Requires Wave 4 complete

| Task | Description | Agent | Parallel | Duration |
|------|-------------|-------|----------|----------|
| T024 | [US4] Integrate version detection into Triad command startup | devops | No | 1 hour |
| T025 | [P] [US4] Implement feature-gated command paths | senior-backend-engineer | Yes | 1 hour |
| T026 | [US4] Create user notification messages for unavailable features | devops | No | 30 min |
| T027 | [US4] Create graceful degradation integration test | tester | No | 45 min |

**Execution Strategy**:
- T024: Sequential (startup integration first)
- T025: Parallel with T024 (feature gating is independent)
- T026-T027: Sequential (messaging, then testing)

**Wave 5 Agent Utilization**:
- devops: 2 tasks (T024, T026)
- senior-backend-engineer: 1 task (T025)
- tester: 1 task (T027)

---

### Wave 6: Migration Documentation (FR-5)

**Duration**: ~4 hours
**Parallel Factor**: 2 of 4 tasks can run in parallel
**Dependency**: Requires Wave 5 complete

| Task | Description | Agent | Parallel | Duration |
|------|-------------|-------|----------|----------|
| T028 | [US5] Create MIGRATION.md with upgrade steps | web-researcher | No | 1.5 hours |
| T029 | [P] [US5] Create feature availability matrix | web-researcher | Yes | 1 hour |
| T030 | [P] [US5] Add troubleshooting guide section | web-researcher | Yes | 1 hour |
| T031 | [US5] Document rollback instructions | web-researcher | No | 45 min |

**Execution Strategy**:
- T028: Sequential (main migration doc first)
- T029-T030: Parallel (independent sections)
- T031: Sequential (rollback after main doc)

**Wave 6 Agent Utilization**:
- web-researcher: 4 tasks (T028-T031)

---

### Wave 7: Polish & Cross-Cutting Concerns

**Duration**: ~3 hours
**Parallel Factor**: 1 of 4 tasks can run in parallel
**Dependency**: Requires Wave 6 complete

| Task | Description | Agent | Parallel | Duration |
|------|-------------|-------|----------|----------|
| T032 | Update CLAUDE.md with new Triad capabilities | architect | No | 1 hour |
| T033 | [P] Update `.claude/rules/governance.md` with parallel review info | architect | Yes | 45 min |
| T034 | Run full integration test suite | tester | No | 1 hour |
| T035 | Create validation report | tester | No | 30 min |

**Execution Strategy**:
- T032-T033: Parallel (different documentation files)
- T034-T035: Sequential (full test suite, then report)

**Wave 7 Agent Utilization**:
- architect: 2 tasks (T032-T033)
- tester: 2 tasks (T034-T035)

---

## Critical Path Analysis

### Critical Path (Longest Dependency Chain)

```
Wave 1 (2h) -> Wave 2 (4h) -> Wave 3A (5h) -> Wave 4 (3h) -> Wave 5 (3h) -> Wave 6 (4h) -> Wave 7 (3h)
Total Critical Path: ~24 hours
```

### Parallel Opportunity: Waves 3A + 3B

The most significant optimization is running Waves 3A (Context Forking) and 3B (Task Dependencies) in parallel:

- **Without parallel 3A/3B**: 24h + 5h = ~29 hours
- **With parallel 3A/3B**: ~24 hours (5h overlap absorbed)
- **Time Saved**: ~5 hours (17% reduction)

### Blocking Dependencies

| Blocker | Impact | Mitigation |
|---------|--------|------------|
| Wave 2 (Version Detection) | Blocks all feature waves | Prioritize, assign best backend engineer |
| T013 (Result Merging) | Blocks Wave 4 parallel execution | Have architect ready immediately after T012 |
| T024 (Triad Startup) | Blocks degradation testing | DevOps focus on this task |

---

## Weekly Sprint Plan

### Week 1: Foundation + Features (MVP Scope)

**Goal**: Complete Waves 1-4 (Version Detection + Context Forking + Parallel Execution)

| Day | Wave | Tasks | Agents Active |
|-----|------|-------|---------------|
| Mon | Wave 1 | T001-T004 | architect, tester |
| Mon-Tue | Wave 2 | T005-T009 | senior-backend-engineer, tester |
| Wed-Thu | Wave 3A | T010-T014 | architect, tester |
| Wed-Thu | Wave 3B | T019-T023 | senior-backend-engineer, tester |
| Fri | Wave 4 | T015-T018 | devops, tester |

**Week 1 Go/No-Go Gate** (per PRD):
- Version detection working (T005-T009 complete)
- Context forking validated (T014 passes)
- Parallel execution tested (T018 passes)

### Week 2: Integration + Documentation

**Goal**: Complete Waves 5-7 (Degradation + Docs + Polish)

| Day | Wave | Tasks | Agents Active |
|-----|------|-------|---------------|
| Mon | Wave 5 | T024-T027 | devops, senior-backend-engineer, tester |
| Tue-Wed | Wave 6 | T028-T031 | web-researcher |
| Thu | Wave 7 | T032-T035 | architect, tester |
| Fri | Buffer | Reviews, fixes, validation | All agents |

### Week 3: Buffer & Release (if needed)

**Goal**: Handle overflow, final validation, release preparation

| Day | Activity | Agents |
|-----|----------|--------|
| Mon-Tue | Bug fixes from testing | As needed |
| Wed | Final integration testing | tester |
| Thu | Documentation review | web-researcher, architect |
| Fri | Release preparation | team-lead, devops |

---

## Workload Distribution Analysis

### Agent Workload by Hours

| Agent | Hours | Tasks | Avg Hours/Task | Status |
|-------|-------|-------|----------------|--------|
| senior-backend-engineer | ~14h | 9 | 1.5h | Balanced |
| architect | ~10h | 10 | 1.0h | Balanced |
| devops | ~6h | 6 | 1.0h | Light (available for support) |
| tester | ~8h | 6 | 1.3h | Balanced |
| web-researcher | ~4h | 4 | 1.0h | Light (documentation focus) |

### Workload Balancing Recommendations

1. **senior-backend-engineer** is the most loaded agent (14h). If blocked, Wave 2 and Wave 3B will slip.
   - **Mitigation**: Have devops available as backup for shell scripting tasks.

2. **devops** is underutilized (6h). Can absorb overflow from other agents.
   - **Recommendation**: Assign T025 (feature gating) to devops instead of senior-backend-engineer if needed.

3. **tester** has scattered tasks across all waves. Ensure dedicated testing windows.
   - **Recommendation**: Schedule tester in afternoon blocks to batch test execution.

---

## Risk Register

### Timeline Risks

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Claude Code v2.1.16 API instability | Medium | High | Week 1 go/no-go gate; fallback to docs-only |
| Context forking complexity | Medium | Medium | Start with simple PM+Architect; extend gradually |
| Parallel execution bugs | Low | Medium | Require v2.1.16; monitor memory in tests |

### Resource Risks

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| senior-backend-engineer overloaded | Medium | High | devops as backup; task rebalancing |
| Testing bottleneck | Low | Medium | Batch test windows; parallel test execution |
| Documentation delay | Low | Low | web-researcher dedicated to Wave 6 |

---

## Optimization Recommendations

### 1. Maximize Wave 3A/3B Parallelism (High Impact)

**Current**: tasks.md shows Wave 3 as single phase
**Recommended**: Split into 3A (Context Forking) + 3B (Task Dependencies) running in parallel

**Impact**: ~5 hours saved (17% reduction)

### 2. Batch Testing Windows (Medium Impact)

**Current**: Tester tasks scattered across waves
**Recommended**: Schedule tester for afternoon blocks to batch test execution

**Impact**: Reduced context switching, faster test cycles

### 3. DevOps as Flex Resource (Medium Impact)

**Current**: DevOps underutilized (6h vs 14h for backend)
**Recommended**: Cross-train devops on shell scripting for Wave 2/3B backup

**Impact**: Risk mitigation for critical path tasks

### 4. Early Documentation Start (Low Impact)

**Current**: Documentation in Wave 6 (late)
**Recommended**: Start MIGRATION.md outline in Week 1 (parallel with development)

**Impact**: Earlier feedback on docs, smoother release

### 5. Task Reordering for T012 (Low Impact)

**Current**: T012 marked [P] but depends on T010/T011 pattern
**Recommended**: Start T012 after T010 completes (parallel with T011)

**Impact**: Better utilization, 30 min earlier completion

---

## Sign-Off

### Team-Lead Review

**Status**: APPROVED

**Agent Assignments**:
- Total tasks: 35
- Agents required: 5 specialized agents (senior-backend-engineer, architect, devops, tester, web-researcher)
- Workload distribution: Balanced (senior-backend-engineer slightly heavy at 40%)

**Parallel Execution**:
- Wave count: 7 (with 3A/3B parallel optimization)
- Parallelization: 31% of tasks can run in parallel within waves; Waves 3A+3B can run fully parallel
- Critical path: Wave 1 -> Wave 2 -> Wave 3A -> Wave 4 -> Wave 5 -> Wave 6 -> Wave 7 (~24h)

**Timeline Estimation**:
- Sequential execution: ~45-50 hours
- Parallel execution: ~28-32 hours
- Time savings: 38% reduction
- Calendar time: 2-3 weeks (aligned with PRD/plan estimates)

**Optimization Recommendations**:
1. Run Waves 3A and 3B in full parallel (different agents, no shared files)
2. Cross-train devops as backup for shell scripting tasks
3. Batch tester windows in afternoon blocks
4. Start MIGRATION.md outline early for feedback loop
5. Reorder T012 to start parallel with T011

**Critical Issues**: None

**Concerns**:
- senior-backend-engineer is on critical path for Waves 2 and 3B; if blocked, timeline slips
- Week 1 go/no-go gate (per PRD) is essential before continuing to Week 2

**Approval**: APPROVED

**Justification**: Task breakdown is well-structured with clear dependencies. Agent assignments match specializations. Parallel execution opportunities are correctly identified. Timeline of 2-3 weeks is realistic with optimizations. Ready for implementation.

---

**Team-Lead Approval**: Claude (team-lead agent)
**Date**: 2026-01-24
**Version**: 1.0.0
