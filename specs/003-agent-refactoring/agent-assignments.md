# Agent Assignments: Feature 003 - Agent Refactoring

**Feature ID**: 003
**Feature Name**: Agent Refactoring - CISO_Agent Best Practices
**Generated**: 2026-01-31
**Total Tasks**: 117
**Estimated Duration**: 14-20 hours (2-3 sessions)
**Sign-off**: team-lead

---

## Overview

This document maps all 117 tasks from Feature 003 to appropriate agents and organizes them into parallel execution waves within each phase. The feature follows a strictly sequential phase order (Phase 1 -> 2 -> 3 -> 4 -> 5 -> 6) but allows limited parallelism within phases where tasks are independent.

**Primary Agent**: architect (core refactoring work, 90% of tasks)
**Supporting Agents**: code-reviewer (quality validation), team-lead (sign-offs), product-manager (scope validation)

---

## Agent Assignment Matrix

| Task Range | Phase | Assigned Agent | Rationale |
|------------|-------|----------------|-----------|
| T001-T003 | Phase 1: Setup | architect | Git operations, baseline documentation |
| T004-T015 | Phase 2: Foundation | architect | Documentation creation, best practices |
| T016-T045 | Phase 3: P0 Agents | architect | Core refactoring (architect, team-lead split, product-manager) |
| T046-T081 | Phase 4: P1 Agents | architect | Standard agent refactoring |
| T082-T105 | Phase 5: P2 Agents | architect | Final agent refactoring |
| T106-T110 | Phase 6: Audits | code-reviewer | Quality validation, cross-reference checks |
| T111-T114 | Phase 6: Documentation | architect | Final documentation updates |
| T115-T117 | Phase 6: Cross-Reference | code-reviewer | Codebase validation |

### Agent Responsibility Summary

| Agent | Task Count | Responsibility |
|-------|------------|----------------|
| architect | 101 | Core refactoring, documentation creation, structure application |
| code-reviewer | 12 | Quality audits, cross-reference validation |
| team-lead | 4 | Phase sign-offs (end of Phase 2, 3, 4, 6) |
| product-manager | 2 | Scope validation (Phase 2, Phase 6) |

---

## Parallel Execution Waves

### Phase 1: Setup & Prerequisites (3 tasks, ~30 min)

**Wave 1.1** (Sequential - T001 -> T002 -> T003):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T001 | Verify all 12 agent files exist | architect | 5 min |
| T002 | Create backup branch | architect | 5 min |
| T003 | Document baseline line counts | architect | 20 min |

**Dependencies**: T002 depends on T001, T003 depends on T002
**Quality Gate**: Backup branch exists, baseline-metrics.md created

---

### Phase 2: Foundation Documentation (12 tasks, ~2-3 hours)

**Wave 2.1** (Parallel - T004, T005, T010):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T004 [P] | Create _AGENT_BEST_PRACTICES.md with 8 core principles | architect | 30 min |
| T005 [P] | Add 8-section structure template | architect | 20 min |
| T010 [P] | Create _README.md with agent roster table | architect | 30 min |

**Wave 2.2** (Sequential - T006 -> T007 -> T008 -> T009):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T006 | Add required metadata fields specification | architect | 15 min |
| T007 | Add quality evaluation checklist | architect | 15 min |
| T008 | Add preservation-first enhancement process | architect | 20 min |
| T009 | Add template variable guidance | architect | 10 min |

**Wave 2.3** (Sequential - T011 -> T012 -> T013 -> T014):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T011 | Add role/expertise/use-cases to _README.md | architect | 20 min |
| T012 | Add quick selection guidance | architect | 10 min |
| T013 | Add Triad governance participation matrix | architect | 15 min |
| T014 | Add agent collaboration patterns | architect | 15 min |

**Wave 2.4** (Validation - T015):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T015 | Validate foundation docs against FR-1 and FR-2 | product-manager | 15 min |

**Dependencies**: Wave 2.2 depends on Wave 2.1 (T004, T005), Wave 2.3 depends on T010, T015 depends on all

**Quality Gate (End of Phase 2)**:
- _AGENT_BEST_PRACTICES.md complete (~400 lines)
- _README.md complete (~150 lines)
- PM validation passed
- **Sign-off**: team-lead

---

### Phase 3: Priority Agents P0 (30 tasks, ~4-5 hours)

#### 3.1 architect.md Refactoring (7 tasks)

**Wave 3.1a** (Sequential - T016 -> T017 -> T018 -> T019 -> T020 -> T021 -> T022):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T016 | Read and inventory architect.md capabilities | architect | 15 min |
| T017 | Categorize sections: Keep, Condense, Reference, Remove | architect | 10 min |
| T018 | Remove embedded code examples (550+ lines) | architect | 20 min |
| T019 | Condense workflow sections to bullet points | architect | 15 min |
| T020 | Apply 8-section structure template | architect | 15 min |
| T021 | Add YAML frontmatter | architect | 10 min |
| T022 | Validate against 8/8 quality criteria | architect | 10 min |

#### 3.2 team-lead.md Split (11 tasks)

**Wave 3.2a** (Sequential - T023 -> T024 -> T025 -> T026):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T023 | Read and inventory team-lead.md capabilities | architect | 15 min |
| T024 | Categorize content: Governance vs Orchestration | architect | 15 min |
| T025 | Create new orchestrator.md from extracted content | architect | 30 min |
| T026 | Refactor team-lead.md to governance-only | architect | 30 min |

**Wave 3.2b** (Sequential - T027 -> T028 -> T029 -> T030):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T027 | Apply 8-section structure to team-lead.md | architect | 15 min |
| T028 | Apply 8-section structure to orchestrator.md | architect | 15 min |
| T029 | Add YAML frontmatter to team-lead.md | architect | 10 min |
| T030 | Add YAML frontmatter to orchestrator.md | architect | 10 min |

**Wave 3.2c** (Sequential - T031 -> T032 -> T033):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T031 | Document handoff pattern between team-lead and orchestrator | architect | 15 min |
| T032 | Validate team-lead.md against 8/8 quality criteria | architect | 10 min |
| T033 | Validate orchestrator.md against 8/8 quality criteria | architect | 10 min |

#### 3.3 product-manager.md Refactoring (6 tasks)

**Wave 3.3a** (Sequential - T034 -> T035 -> T036 -> T037 -> T038 -> T039):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T034 | Read and inventory product-manager.md capabilities | architect | 10 min |
| T035 | Condense verbose communication/documentation sections | architect | 15 min |
| T036 | Add skill references for PRD creation | architect | 10 min |
| T037 | Apply 8-section structure template | architect | 15 min |
| T038 | Add YAML frontmatter | architect | 10 min |
| T039 | Validate against 8/8 quality criteria | architect | 10 min |

#### Phase 3 Completion (6 tasks)

**Wave 3.4** (Validation - T040 -> T041 -> T042 -> T043 -> T044 -> T045):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T040 | Run line count audit for Phase 3 agents | code-reviewer | 10 min |
| T041 | Test architect.md with representative tasks | architect | 15 min |
| T042 | Test team-lead.md with representative tasks | architect | 15 min |
| T043 | Test orchestrator.md with representative tasks | architect | 15 min |
| T044 | Test product-manager.md with representative tasks | architect | 15 min |
| T045 | Update _README.md with orchestrator agent entry | architect | 10 min |

**Dependencies**: All Wave 3.x sequential within agent refactoring, Wave 3.4 depends on all prior

**Quality Gate (End of Phase 3)**:
- architect.md <= 250 lines
- team-lead.md <= 200 lines
- orchestrator.md <= 250 lines
- product-manager.md <= 250 lines
- All P0 agents pass 8/8 quality criteria
- Representative tasks pass
- **Sign-off**: team-lead

---

### Phase 4: Standard Agents P1 (36 tasks, ~5-6 hours)

#### 4.1 code-reviewer.md Refactoring (6 tasks)

**Wave 4.1a** (Sequential - T046 -> T047 -> T048 -> T049 -> T050 -> T051):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T046 | Read and inventory code-reviewer.md capabilities | architect | 15 min |
| T047 | Remove embedded review checklists (move to skill) | architect | 20 min |
| T048 | Condense review workflow to core steps | architect | 15 min |
| T049 | Apply 8-section structure template | architect | 15 min |
| T050 | Add YAML frontmatter | architect | 10 min |
| T051 | Validate against 8/8 quality criteria | architect | 10 min |

#### 4.2 debugger.md Refactoring (7 tasks)

**Wave 4.2a** (Sequential - T052 -> T053 -> T054 -> T055 -> T056 -> T057 -> T058):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T052 | Read and inventory debugger.md capabilities | architect | 15 min |
| T053 | Preserve 5 Whys methodology reference | architect | 10 min |
| T054 | Condense debugging patterns to bullets | architect | 15 min |
| T055 | Remove verbose example debugging sessions | architect | 15 min |
| T056 | Apply 8-section structure template | architect | 15 min |
| T057 | Add YAML frontmatter | architect | 10 min |
| T058 | Validate against 8/8 quality criteria | architect | 10 min |

#### 4.3 tester.md Refactoring (6 tasks)

**Wave 4.3a** (Sequential - T059 -> T060 -> T061 -> T062 -> T063 -> T064):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T059 | Read and inventory tester.md capabilities | architect | 10 min |
| T060 | Add skill references for BDD testing patterns | architect | 10 min |
| T061 | Condense testing workflow sections | architect | 15 min |
| T062 | Apply 8-section structure template | architect | 15 min |
| T063 | Add YAML frontmatter | architect | 10 min |
| T064 | Validate against 8/8 quality criteria | architect | 10 min |

#### 4.4 devops.md Refactoring (6 tasks)

**Wave 4.4a** (Sequential - T065 -> T066 -> T067 -> T068 -> T069 -> T070):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T065 | Read and inventory devops.md capabilities | architect | 10 min |
| T066 | Balance template vars vs concrete values | architect | 15 min |
| T067 | Condense environment-specific sections | architect | 15 min |
| T068 | Apply 8-section structure template | architect | 15 min |
| T069 | Add YAML frontmatter | architect | 10 min |
| T070 | Validate against 8/8 quality criteria | architect | 10 min |

#### 4.5 senior-backend-engineer.md Refactoring (5 tasks)

**Wave 4.5a** (Sequential - T071 -> T072 -> T073 -> T074 -> T075):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T071 | Read and inventory senior-backend-engineer.md | architect | 10 min |
| T072 | Condense implementation guidance | architect | 15 min |
| T073 | Apply 8-section structure template | architect | 15 min |
| T074 | Add YAML frontmatter | architect | 10 min |
| T075 | Validate against 8/8 quality criteria | architect | 10 min |

#### Phase 4 Completion (6 tasks)

**Wave 4.6** (Validation - T076 -> T077 -> T078 -> T079 -> T080 -> T081):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T076 | Run line count audit for Phase 4 agents | code-reviewer | 10 min |
| T077 | Test code-reviewer.md with representative tasks | architect | 15 min |
| T078 | Test debugger.md with representative tasks | architect | 15 min |
| T079 | Test tester.md with representative tasks | architect | 15 min |
| T080 | Test devops.md with representative tasks | architect | 15 min |
| T081 | Test senior-backend-engineer.md with representative tasks | architect | 15 min |

**Dependencies**: All Wave 4.x sequential within agent refactoring, Wave 4.6 depends on all prior

**Quality Gate (End of Phase 4)**:
- All P1 agents <= 250 lines
- All P1 agents pass 8/8 quality criteria
- Representative tasks pass
- **Sign-off**: team-lead

---

### Phase 5: Final Agents P2 (24 tasks, ~3-4 hours)

#### 5.1 ux-ui-designer.md Refactoring (5 tasks)

**Wave 5.1a** (T082 [P] can start in parallel):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T082 [P] | Read and inventory ux-ui-designer.md | architect | 10 min |

**Wave 5.1b** (Sequential - T083 -> T084 -> T085 -> T086):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T083 | Apply 8-section structure template | architect | 15 min |
| T084 | Condense verbose sections | architect | 15 min |
| T085 | Add YAML frontmatter | architect | 10 min |
| T086 | Validate against 8/8 quality criteria | architect | 10 min |

#### 5.2 security-analyst.md Refactoring (5 tasks)

**Wave 5.2a** (T087 [P] can start in parallel):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T087 [P] | Read and inventory security-analyst.md | architect | 10 min |

**Wave 5.2b** (Sequential - T088 -> T089 -> T090 -> T091):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T088 | Preserve security patterns | architect | 10 min |
| T089 | Apply 8-section structure template | architect | 15 min |
| T090 | Add YAML frontmatter | architect | 10 min |
| T091 | Validate against 8/8 quality criteria | architect | 10 min |

#### 5.3 web-researcher.md Refactoring (5 tasks)

**Wave 5.3a** (T092 [P] can start in parallel):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T092 [P] | Read and inventory web-researcher.md | architect | 10 min |

**Wave 5.3b** (Sequential - T093 -> T094 -> T095 -> T096):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T093 | Apply 8-section structure template | architect | 15 min |
| T094 | Condense verbose sections | architect | 15 min |
| T095 | Add YAML frontmatter | architect | 10 min |
| T096 | Validate against 8/8 quality criteria | architect | 10 min |

#### 5.4 frontend-developer.md Refactoring (4 tasks)

**Wave 5.4a** (T097 [P] can start in parallel):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T097 [P] | Read and inventory frontend-developer.md | architect | 10 min |

**Wave 5.4b** (Sequential - T098 -> T099 -> T100):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T098 | Apply 8-section structure template | architect | 15 min |
| T099 | Add YAML frontmatter | architect | 10 min |
| T100 | Validate against 8/8 quality criteria | architect | 10 min |

#### Phase 5 Completion (5 tasks)

**Wave 5.5** (Parallel Audits - T101 can run with tests):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T101 | Run line count audit for Phase 5 agents | code-reviewer | 10 min |

**Wave 5.6** (Parallel Tests - T102, T103, T104, T105):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T102 | Test ux-ui-designer.md with representative tasks | architect | 15 min |
| T103 | Test security-analyst.md with representative tasks | architect | 15 min |
| T104 | Test web-researcher.md with representative tasks | architect | 15 min |
| T105 | Test frontend-developer.md with representative tasks | architect | 15 min |

**Dependencies**: T082, T087, T092, T097 can run in parallel (initial reads), subsequent tasks sequential

**Quality Gate (End of Phase 5)**:
- All P2 agents <= 250 lines
- All P2 agents pass 8/8 quality criteria
- Representative tasks pass

---

### Phase 6: Final Validation & Documentation (12 tasks, ~1-2 hours)

#### Final Quality Audit

**Wave 6.1** (Parallel Audits - T106, T107, T108, T109, T110):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T106 [P] | Run comprehensive line count audit for all 13 agents | code-reviewer | 15 min |
| T107 [P] | Verify total line count <= 3,500 | code-reviewer | 10 min |
| T108 [P] | Run structure audit: All use 8-section format | code-reviewer | 15 min |
| T109 [P] | Run metadata audit: All have required YAML fields | code-reviewer | 15 min |
| T110 | Create quality-report.md | architect | 20 min |

#### Documentation Updates

**Wave 6.2** (Sequential - T111 -> T112 -> T113 -> T114):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T111 | Update _README.md with final agent line counts | architect | 10 min |
| T112 | Verify _AGENT_BEST_PRACTICES.md reflects lessons learned | architect | 15 min |
| T113 | Update CLAUDE.md if any agent references need updating | architect | 10 min |
| T114 | Create completion-summary.md with metrics | architect | 20 min |

#### Cross-Reference Validation

**Wave 6.3** (Sequential - T115 -> T116 -> T117):
| Task | Description | Agent | Duration |
|------|-------------|-------|----------|
| T115 | Search codebase for team-lead references needing updates | code-reviewer | 15 min |
| T116 | Update any skills that reference refactored agents | architect | 15 min |
| T117 | Verify Triad command references work with refactored agents | code-reviewer | 15 min |

**Dependencies**: Wave 6.1 parallel, Wave 6.2 depends on T110, Wave 6.3 sequential

**Quality Gate (End of Phase 6)**:
- All 13 agents pass 8/8 quality criteria
- Total line count <= 3,500 (target ~3,000)
- quality-report.md and completion-summary.md created
- All cross-references updated
- **Final Sign-off**: team-lead + product-manager

---

## Quality Gates Summary

| Gate | Phase End | Validation Agent | Criteria |
|------|-----------|------------------|----------|
| QG-1 | Phase 1 | architect | Backup branch exists, baseline-metrics.md created |
| QG-2 | Phase 2 | product-manager, team-lead | Foundation docs complete, FR-1 and FR-2 met |
| QG-3 | Phase 3 | code-reviewer, team-lead | P0 agents at target, 8/8 quality, tests pass |
| QG-4 | Phase 4 | code-reviewer, team-lead | P1 agents at target, 8/8 quality, tests pass |
| QG-5 | Phase 5 | code-reviewer | P2 agents at target, 8/8 quality, tests pass |
| QG-6 | Phase 6 | code-reviewer, product-manager, team-lead | All agents pass, docs complete, cross-refs valid |

### Quality Gate Checklist Template

```markdown
## Quality Gate: [QG-X] Phase [N] Completion

**Date**: [YYYY-MM-DD]
**Validator**: [agent]

### Validation Criteria

- [ ] Line count targets met
- [ ] 8-section structure applied
- [ ] YAML frontmatter complete
- [ ] Representative tasks pass
- [ ] No capability regression

### Sign-off

**Status**: [PASS / FAIL]
**Notes**: [any exceptions or issues]
**Signed**: [agent name]
```

---

## Timeline Summary

| Phase | Tasks | Duration | Agent(s) | Cumulative |
|-------|-------|----------|----------|------------|
| Phase 1: Setup | 3 | 0.5 hr | architect | 0.5 hr |
| Phase 2: Foundation | 12 | 2-3 hr | architect, product-manager | 2.5-3.5 hr |
| Phase 3: P0 Agents | 30 | 4-5 hr | architect, code-reviewer | 6.5-8.5 hr |
| Phase 4: P1 Agents | 36 | 5-6 hr | architect, code-reviewer | 11.5-14.5 hr |
| Phase 5: P2 Agents | 24 | 3-4 hr | architect, code-reviewer | 14.5-18.5 hr |
| Phase 6: Validation | 12 | 1-2 hr | code-reviewer, architect, team-lead, product-manager | 15.5-20.5 hr |
| **TOTAL** | **117** | **14-20 hr** | | |

### Session Breakdown Recommendation

| Session | Phases | Duration | Focus |
|---------|--------|----------|-------|
| Session 1 | Phase 1-2 | 3-4 hours | Foundation documentation |
| Session 2 | Phase 3 | 4-5 hours | P0 critical agents |
| Session 3 | Phase 4-5 | 5-6 hours | P1 + P2 standard agents |
| Session 4 | Phase 6 | 1-2 hours | Final validation and docs |

---

## Risk Mitigation

### Risk 1: Architect Agent Overload

**Risk**: architect assigned 101/117 tasks (86%)
**Mitigation**:
- Sequential execution ensures focus
- Quality gates provide natural breaks
- Can pause between phases if needed

### Risk 2: Limited Parallelism

**Risk**: Only 11/117 tasks marked parallel
**Mitigation**:
- Consistency requires single-thread execution
- Parallel opportunities within Phase 5 and 6
- Consider additional parallelism in Phase 4 after approach validated

### Risk 3: Testing Bottleneck

**Risk**: Representative task testing may reveal issues late
**Mitigation**:
- Test immediately after each agent refactoring
- Early testing in Phase 3 validates approach
- Quality gates catch issues before scaling

---

## Notes

1. **Single Architect Thread**: The plan explicitly requires single architect expertise for consistency. Do not parallelize agent refactoring across multiple architect instances.

2. **Team-Lead Concerns**: Per team-lead sign-off notes, consider Phase 4 parallelism after Phase 3 approach validation. This assignment assumes sequential execution for MVP.

3. **Testing Prompts**: Team-lead recommends adding specific test prompts for validation tasks. These should be defined during Phase 2 foundation documentation.

4. **Baseline Metrics Update**: Per architect review notes, add task to update baseline-metrics.md with final metrics at Phase 6 completion.

---

**End of Agent Assignments**
