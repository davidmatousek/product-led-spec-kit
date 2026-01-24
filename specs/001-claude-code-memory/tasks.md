# Tasks: Claude Code Memory Features Enhancement

## Metadata

- **Feature ID**: 001
- **Feature Name**: Claude Code Memory Features Enhancement
- **Status**: Draft
- **Created**: 2025-12-15
- **Author**: team-lead
- **Spec Reference**: specs/001-claude-code-memory/spec.md
- **Plan Reference**: specs/001-claude-code-memory/plan.md
- **Priority**: P1
- **pm_signoff**: APPROVED
- **pm_signoff_date**: 2025-12-15
- **pm_signoff_notes**: Excellent prioritization with clear MVP scope (US1+US2+US3). 100% spec fidelity, no scope creep. 63 tasks appropriately sized, 55% parallelizable. Dependencies logical. Ready for implementation.
- **architect_signoff**: APPROVED_WITH_CONCERNS
- **architect_signoff_date**: 2025-12-15
- **architect_signoff_notes**: Tasks technically sound, consistent with plan, best practices followed. Documentation excellent. Non-blocking concerns: add automated tests (T064-T066) for Constitution Principle VI compliance, enhance T058 with automated diff, expand T061 error handling tests.
- **teamlead_signoff**: APPROVED
- **teamlead_signoff_date**: 2025-12-15
- **teamlead_signoff_notes**: 63 tasks, 2 agents (architect 89%, devops 11%). 8 waves, 55% parallelizable. Timeline 12-14 hours (44-58% time savings). Phase 7 runs parallel with Phases 2-6. agent-assignments.md created.

---

## Phase 1: Setup (Project Initialization)

**Objective**: Create the directory structure for modular rules

### Tasks

- [X] T001 Create `.claude/rules/` directory for modular governance files
- [X] T002 Create empty `governance.md` file with header in `.claude/rules/governance.md`
- [X] T003 [P] Create empty `git-workflow.md` file with header in `.claude/rules/git-workflow.md`
- [X] T004 [P] Create empty `deployment.md` file with header in `.claude/rules/deployment.md`
- [X] T005 [P] Create empty `scope.md` file with header in `.claude/rules/scope.md`
- [X] T006 [P] Create empty `commands.md` file with header in `.claude/rules/commands.md`
- [X] T007 [P] Create empty `context-loading.md` file with header in `.claude/rules/context-loading.md`

### Phase 1 Completion Criteria

- [X] `.claude/rules/` directory exists
- [X] All 6 rule files exist with headers
- [X] `ls .claude/rules/*.md | wc -l` returns 6

---

## Phase 2: Foundational (Content Migration - Blocking)

**Objective**: Extract governance content from CLAUDE.md to modular rule files

### Tasks

- [X] T008 Extract Governance Workflow (MANDATORY) section content from CLAUDE.md to `.claude/rules/governance.md`
- [X] T009 Extract SDLC Triad Workflow section content and append to `.claude/rules/governance.md`
- [X] T010 [P] Extract Git Workflow content from Core Constraints section to `.claude/rules/git-workflow.md`
- [X] T011 [P] Extract Deployment Policy (MANDATORY) section content to `.claude/rules/deployment.md`
- [X] T012 [P] Extract Scope Boundaries section content to `.claude/rules/scope.md`
- [X] T013 [P] Extract Commands (Triad + Vanilla) section content to `.claude/rules/commands.md`
- [X] T014 [P] Extract Context Loading (READ AS NEEDED) section content to `.claude/rules/context-loading.md`

### Phase 2 Completion Criteria

- [X] Each rule file contains focused, single-topic content
- [X] All content is valid CommonMark markdown
- [X] No content duplication across files
- [X] Total extracted content matches original CLAUDE.md sections (~142 lines → 154 lines with headers)

---

## Phase 3: User Story 1 - Modular Rules for Template Customization (US-001)

**Story Goal**: Template adopters can edit topic-specific rule files without affecting unrelated governance features

**User Story**: When I'm adopting Product-Led Spec Kit and need to customize git workflow for my team, I want to edit only `.claude/rules/git-workflow.md` without touching deployment or governance rules, so I can customize git policies without risk of breaking unrelated governance features.

### Independent Test Criteria

- [ ] Given modular rules structure exists, editing git-workflow.md does NOT affect deployment.md or governance.md
- [ ] Given I'm new to the template, `.claude/rules/` shows clearly named topic files
- [ ] User can locate and edit a specific governance rule in under 30 seconds

### Tasks

- [X] T015 [US1] Format governance.md with clear sections: Overview, Sign-off Requirements, Triad Roles in `.claude/rules/governance.md`
- [X] T016 [P] [US1] Format git-workflow.md with clear sections: Branch Naming, Commit Standards, PR Policies in `.claude/rules/git-workflow.md`
- [X] T017 [P] [US1] Format deployment.md with clear sections: DevOps Agent Policy, Verification Requirements in `.claude/rules/deployment.md`
- [X] T018 [P] [US1] Format scope.md with clear sections: What This Is, What This Isn't in `.claude/rules/scope.md`
- [X] T019 [P] [US1] Format commands.md with clear sections: Triad Commands, Vanilla Commands in `.claude/rules/commands.md`
- [X] T020 [P] [US1] Format context-loading.md with clear sections: Session Start, By Domain, Feature Context in `.claude/rules/context-loading.md`

---

## Phase 4: User Story 2 - Instant Context Loading with @-references (US-002)

**Story Goal**: Agents can load governance context instantly using @-syntax without manual bash commands

**User Story**: When an agent needs to load deployment policy context, I want to reference `@.claude/rules/deployment.md` in CLAUDE.md, so I can load context instantly without manual bash commands.

### Independent Test Criteria

- [ ] @-references in CLAUDE.md load inline when agent reads the file
- [ ] Context loads in under 1 second (vs 5-10 seconds with cat commands)
- [ ] `/memory` command shows all rule file content loaded

### Tasks

- [X] T021 [US2] Add @-reference syntax for governance.md in CLAUDE.md Governance Workflow section
- [X] T022 [P] [US2] Add @-reference syntax for git-workflow.md in CLAUDE.md Git Workflow section
- [X] T023 [P] [US2] Add @-reference syntax for deployment.md in CLAUDE.md Deployment Policy section
- [X] T024 [P] [US2] Add @-reference syntax for scope.md in CLAUDE.md Scope Boundaries section
- [X] T025 [P] [US2] Add @-reference syntax for commands.md in CLAUDE.md Commands section
- [X] T026 [P] [US2] Add @-reference syntax for context-loading.md in CLAUDE.md Context Loading section

---

## Phase 5: User Story 3 - Reduced CLAUDE.md Size (US-003)

**Story Goal**: CLAUDE.md is reduced from 192 lines to 80 lines or fewer while preserving 100% of content

**User Story**: When I open CLAUDE.md to understand template governance, I want to see a concise overview (80 lines or fewer) with clear topic references, so I can quickly understand governance structure without scrolling through 192 lines.

### Independent Test Criteria

- [ ] `wc -l CLAUDE.md` returns ≤80
- [ ] Each section has 1-2 sentence summary plus @-reference
- [ ] 100% of original content preserved in modular structure (compare old vs new)

### Tasks

- [X] T027 [US3] Reduce Core Constraints section to summary (4 bullet points) + @-reference in CLAUDE.md
- [X] T028 [US3] Reduce Governance Workflow section to summary (1-2 sentences) + @-reference in CLAUDE.md
- [X] T029 [US3] Reduce SDLC Triad Workflow section to summary (1-2 sentences) referencing governance.md in CLAUDE.md
- [X] T030 [US3] Reduce Deployment Policy section to summary (1-2 sentences) + @-reference in CLAUDE.md
- [X] T031 [P] [US3] Reduce Git Workflow section to summary (3 bullet points) + @-reference in CLAUDE.md
- [X] T032 [P] [US3] Reduce Scope Boundaries section to summary (brief intro) + @-reference in CLAUDE.md
- [X] T033 [P] [US3] Reduce Commands section to summary (brief intro) + @-reference in CLAUDE.md
- [X] T034 [P] [US3] Reduce Context Loading section to summary (brief intro) + @-reference in CLAUDE.md
- [X] T035 [US3] Keep Project Structure section inline (essential orientation, ~15 lines) in CLAUDE.md
- [X] T036 [US3] Keep Key Principles section inline (quick reference, ~5 lines) in CLAUDE.md
- [X] T037 [US3] Keep Tips, Tech Stack, Recent Changes, Active Technologies inline (project-specific) in CLAUDE.md
- [X] T038 [US3] Verify final CLAUDE.md is ≤80 lines using `wc -l CLAUDE.md`

---

## Phase 6: User Story 4 - Topic-Specific Rule Editing (US-004)

**Story Goal**: Users can update specific governance topics without navigating unrelated content

**User Story**: When I need to update deployment policy for my project, I want to edit only `.claude/rules/deployment.md`, so I can change deployment rules without navigating unrelated governance content.

### Independent Test Criteria

- [ ] User can find and edit deployment policy in under 30 seconds
- [ ] No merge conflicts when teammates edit different rule files
- [ ] Users can create custom `.claude/rules/custom.md` without modifying core files

### Tasks

- [X] T039 [US4] Validate governance.md is self-contained with single responsibility in `.claude/rules/governance.md`
- [X] T040 [P] [US4] Validate git-workflow.md is self-contained with single responsibility in `.claude/rules/git-workflow.md`
- [X] T041 [P] [US4] Validate deployment.md is self-contained with single responsibility in `.claude/rules/deployment.md`
- [X] T042 [P] [US4] Validate scope.md is self-contained with single responsibility in `.claude/rules/scope.md`
- [X] T043 [P] [US4] Validate commands.md is self-contained with single responsibility in `.claude/rules/commands.md`
- [X] T044 [P] [US4] Validate context-loading.md is self-contained with single responsibility in `.claude/rules/context-loading.md`
- [X] T045 [US4] Document custom rule extension pattern in MIGRATION.md showing how to add `.claude/rules/custom.md`

---

## Phase 7: Migration Documentation (FR-4)

**Objective**: Create comprehensive MIGRATION.md guide for users migrating from monolithic to modular structure

### Tasks

- [X] T046 Create MIGRATION.md file at repository root in `/MIGRATION.md`
- [X] T047 Add Overview section explaining benefits of migration in MIGRATION.md
- [X] T048 Add Prerequisites section with requirements checklist in MIGRATION.md
- [X] T049 Add Step-by-step Migration Guide section with numbered instructions in MIGRATION.md
- [X] T050 Add Before/After Examples section with diff comparisons in MIGRATION.md
- [X] T051 Add Validation Steps section with verification commands in MIGRATION.md
- [X] T052 Add Rollback Instructions section explaining how to revert in MIGRATION.md
- [X] T053 Add Troubleshooting section for common issues in MIGRATION.md
- [X] T054 Add FAQ section for frequently asked questions in MIGRATION.md

---

## Phase 8: Validation & Polish

**Objective**: Verify all requirements met and ensure quality

### Tasks

- [X] T055 Verify all 6 rule files exist using `ls .claude/rules/*.md | wc -l`
- [X] T056 Verify CLAUDE.md line count ≤80 using `wc -l CLAUDE.md`
- [X] T057 Verify all @-references resolve to existing files in CLAUDE.md
- [X] T058 Verify 100% content preservation by manual comparison of original vs new structure
- [X] T059 Test @-syntax loading with `/memory` command
- [X] T060 Verify context load time is under 1 second
- [X] T061 Test error handling: delete a rule file temporarily and verify clear error message
- [X] T062 Verify backward compatibility: old CLAUDE.md pattern documentation is preserved
- [X] T063 Final review: ensure all acceptance criteria from spec.md are met

---

## Dependencies

### Task Dependencies

```
Phase 1 (Setup)
    ↓
Phase 2 (Content Migration) - Blocking for all user stories
    ↓
┌───────────────────────────────────────────────────────────────┐
│  Phase 3 (US1)  │  Phase 4 (US2)  │  Phase 5 (US3)  │ Phase 6 │
│  Modular Rules  │  @-references   │  Size Reduction │  Topic  │
│                 │                 │                 │  Editing│
└───────────────────────────────────────────────────────────────┘
                           ↓
                  Phase 7 (Migration Docs) - Can run parallel with US phases
                           ↓
                  Phase 8 (Validation) - Final
```

### Critical Path

Phase 1 → Phase 2 → Phase 5 (US3) → Phase 8

### Parallel Opportunities

1. **Phase 1**: Tasks T003-T007 can run in parallel (creating empty files)
2. **Phase 2**: Tasks T010-T014 can run in parallel (extracting content)
3. **Phase 3-6**: User story phases can partially overlap
4. **Phase 7**: Migration documentation can run parallel with Phases 3-6
5. **Within each phase**: Tasks marked [P] can run in parallel

---

## Implementation Strategy

### MVP Scope (User Story 1 + 2 + 3)

1. **Must Have**: Modular rule files (US1)
2. **Must Have**: @-reference syntax working (US2)
3. **Must Have**: CLAUDE.md ≤80 lines (US3)
4. **Should Have**: Topic editing validation (US4)
5. **Should Have**: Migration documentation (FR-4)

### Incremental Delivery

- **Increment 1**: Phase 1 + Phase 2 (Setup + Content Migration)
- **Increment 2**: Phase 3 + Phase 4 (US1 + US2)
- **Increment 3**: Phase 5 + Phase 6 (US3 + US4)
- **Increment 4**: Phase 7 + Phase 8 (Docs + Validation)

---

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 63 |
| Setup Phase | 7 tasks |
| Foundational Phase | 7 tasks |
| US1 Tasks | 6 tasks |
| US2 Tasks | 6 tasks |
| US3 Tasks | 12 tasks |
| US4 Tasks | 7 tasks |
| Migration Docs | 9 tasks |
| Validation | 9 tasks |
| Parallelizable | ~35 tasks (55%) |

---

**End of Tasks**
