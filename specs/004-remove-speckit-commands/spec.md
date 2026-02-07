---
prd_reference: docs/product/02_PRD/004-remove-speckit-commands-2026-02-07.md
triad:
  pm_signoff:
    agent: product-manager
    date: 2026-02-07
    status: APPROVED
    notes: "All 5 PRD functional requirements (FR-1 through FR-5) fully addressed with testable acceptance criteria. FR-6 (Migration Guide) justified addition from PRD scope. 10 user scenarios provide thorough coverage of both personas. Success criteria are measurable with quantitative baselines. Phased approach (Phase 0-3) matches PRD exactly. No scope creep detected. Ready for planning."
  architect_signoff: null  # Added by /triad.plan
  techlead_signoff: null   # Added by /triad.tasks
---

# Feature Specification: Remove SpecKit Commands & Transfer Content to Triad

**Status**: Approved
**Feature Number**: 004
**PRD Reference**: [004-remove-speckit-commands-2026-02-07.md](../../docs/product/02_PRD/004-remove-speckit-commands-2026-02-07.md)
**Created**: 2026-02-07
**Author**: Specification generated from PRD

---

## 1. Feature Overview

### 1.1 Problem Statement

Product-Led Spec Kit maintains two parallel command sets for the same SDLC workflow:

- **Triad commands** (`/triad.*`): Governed workflow with automatic sign-offs
- **Speckit commands** (`/speckit.*`): Ungoverned "fast" workflow

This dual architecture creates five problems for users and maintainers:

1. **Fragile coupling**: Triad commands invoke speckit commands at runtime via the Skill tool. If a speckit command changes, triad commands silently break.
2. **Double maintenance**: Every workflow improvement must be applied in two places -- the speckit command and the triad wrapper.
3. **User confusion**: New users must choose between two command sets without understanding the governance implications.
4. **Inconsistent messaging**: Speckit commands reference `/speckit.clarify` and `/speckit.plan` in output, while triad commands reference `/triad.plan` -- creating mixed signals.
5. **Documentation drift**: CLAUDE.md, rules files, and documentation reference both command families inconsistently.

Additionally, four speckit-only commands provide unique value with no triad counterpart: `/speckit.clarify`, `/speckit.analyze`, `/speckit.checklist`, and `/speckit.constitution`. These capabilities would be lost without migration.

### 1.2 Proposed Solution

Consolidate all command logic into a single, unified Triad command set:

1. **Inline speckit logic** into the 4 existing triad core commands (specify, plan, tasks, implement), replacing Skill tool invocations with the actual execution logic
2. **Create 4 new triad commands** (clarify, analyze, checklist, constitution) from the speckit-only commands
3. **Remove all 8 speckit command files** after transfer is complete
4. **Update all references** across documentation, rules, skills, and configuration to use the triad namespace exclusively

After this change, users see a single command set (`/triad.*`) with all capabilities available inline.

### 1.3 Target Users

**Primary**: Template Adopters (Developers and Teams)
- Currently confused by dual command sets and unsure which to use
- Need a single, clear workflow with all capabilities accessible
- Benefit from consistent command naming and documentation

**Secondary**: Template Maintainers (Contributors)
- Currently must update logic in two places for every workflow change
- Need a single source of truth for each workflow phase
- Benefit from reduced maintenance burden and simpler contribution process

---

## 2. User Scenarios & Testing

### Scenario 1: Unified Command Discovery

**Actor**: Template Adopter
**Goal**: Find available commands and understand the workflow

**Given** a new template adopter reviews the command documentation
**When** they look at the available commands in CLAUDE.md or rules
**Then** they see a single Triad command set with 10 commands
**And** there is no ambiguity about which command to use for each workflow phase

**Acceptance Criteria**:
- CLAUDE.md lists only `/triad.*` commands with no "Vanilla" alternative section
- Rules documentation describes one unified command workflow
- Each command has clear purpose documentation

### Scenario 2: Specification Generation (Core Merge)

**Actor**: Template Adopter
**Goal**: Generate a feature specification using the triad workflow

**Given** a user has an approved PRD for their feature
**When** they run `/triad.specify`
**Then** the command executes the full specification workflow inline (research, generation, PM review)
**And** the resulting `spec.md` is identical in quality and structure to what the previous triad+speckit combination produced
**And** the command does not invoke any speckit commands via the Skill tool

**Acceptance Criteria**:
- `/triad.specify` contains all spec generation logic inline
- No Skill tool invocation of `/speckit.specify` occurs
- Output spec.md matches expected format with all required sections
- Research phase, generation, and PM sign-off all execute within the single command

### Scenario 3: Planning Generation (Core Merge)

**Actor**: Template Adopter
**Goal**: Generate an implementation plan from an approved specification

**Given** a user has an approved `spec.md`
**When** they run `/triad.plan`
**Then** the command generates `plan.md` with all design artifacts inline
**And** PM and Architect reviews execute automatically
**And** no speckit commands are invoked

**Acceptance Criteria**:
- `/triad.plan` contains all plan generation logic inline
- Template loading, context setup, and design generation work without speckit dependency
- Dual sign-off (PM + Architect) executes as before

### Scenario 4: Task Generation (Core Merge)

**Actor**: Template Adopter
**Goal**: Generate implementation tasks from an approved plan

**Given** a user has an approved `plan.md`
**When** they run `/triad.tasks`
**Then** the command generates `tasks.md` with properly formatted tasks inline
**And** triple sign-off (PM + Architect + Team-Lead) executes automatically
**And** agent-assignments.md is generated with parallel execution waves

**Acceptance Criteria**:
- `/triad.tasks` contains all task generation logic inline
- Task format validation, dependency ordering, and phase structure preserved
- Triple sign-off and agent-assignments.md generation work as before

### Scenario 5: Implementation Execution (Core Merge)

**Actor**: Template Adopter
**Goal**: Execute implementation following the task plan

**Given** a user has approved `tasks.md` with all sign-offs
**When** they run `/triad.implement`
**Then** the command executes tasks phase-by-phase with architect checkpoints inline
**And** progress tracking, error handling, and validation all function as before

**Acceptance Criteria**:
- `/triad.implement` contains all implementation execution logic inline
- Checklist verification, progress tracking, and phase execution preserved
- Architect checkpoint logic integrated with implementation flow

### Scenario 6: Specification Clarification (New Triad Command)

**Actor**: Template Adopter
**Goal**: Resolve ambiguities in a draft specification

**Given** a `spec.md` contains [NEEDS CLARIFICATION] markers
**When** the user runs `/triad.clarify`
**Then** the system identifies ambiguities and asks up to 5 targeted questions
**And** answers are encoded back into the specification
**And** all internal references use `/triad.*` naming

**Acceptance Criteria**:
- `/triad.clarify` provides identical clarification workflow to the former `/speckit.clarify`
- Internal cross-references point to `/triad.plan` (not `/speckit.plan`)
- Ambiguity taxonomy and sequential questioning preserved

### Scenario 7: Cross-Artifact Analysis (New Triad Command)

**Actor**: Template Adopter
**Goal**: Validate consistency across spec, plan, and tasks

**Given** a user has created spec.md, plan.md, and tasks.md
**When** they run `/triad.analyze`
**Then** the system performs all consistency detection passes (duplication, ambiguity, underspecification, constitution alignment, coverage, inconsistency)
**And** a severity-ranked report is produced

**Acceptance Criteria**:
- `/triad.analyze` provides identical analysis to the former `/speckit.analyze`
- All 6 detection passes preserved
- Internal references use `/triad.*` naming

### Scenario 8: Requirements Checklist (New Triad Command)

**Actor**: Template Adopter
**Goal**: Validate specification quality with a custom checklist

**Given** a user has a completed specification
**When** they run `/triad.checklist`
**Then** the system generates contextual quality questions based on the spec content
**And** a checklist with category scaffolding and rubrics is produced

**Acceptance Criteria**:
- `/triad.checklist` provides identical checklist generation to the former `/speckit.checklist`
- Dynamic question generation and category scaffolding preserved
- Internal references use `/triad.*` naming

### Scenario 9: Constitution Management (New Triad Command)

**Actor**: Template Maintainer
**Goal**: Create or update the project constitution

**Given** a user needs to manage governance principles
**When** they run `/triad.constitution`
**Then** the system guides template placeholder collection, versioning, and consistency propagation
**And** a sync impact report is generated

**Acceptance Criteria**:
- `/triad.constitution` provides identical constitution management to the former `/speckit.constitution`
- Template filling, version bumping, and consistency propagation preserved
- Internal references use `/triad.*` naming

### Scenario 10: Zero Speckit References Remain

**Actor**: Template Maintainer
**Goal**: Verify complete removal of legacy speckit command references

**Given** all speckit commands have been removed and content transferred
**When** a maintainer searches the entire codebase for `/speckit.` references
**Then** zero results are found (excluding historical documents like changelogs and PRD 004)
**And** all documentation, rules, skills, and configuration reference only `/triad.*` commands

**Acceptance Criteria**:
- No `speckit.*.md` files exist in `.claude/commands/`
- Grep for `/speckit.` returns empty across `.claude/`, `docs/`, `CLAUDE.md`, rules, and skills
- Historical references in changelogs and PRD 004 are acceptable exceptions
- Constitution, Makefile, README, and all standards docs updated

---

## 3. Functional Requirements

### FR-1: Inline Speckit Logic into 4 Existing Triad Commands

**Description**: Transfer all unique execution logic from speckit core commands into their triad counterparts, replacing Skill tool wrapper invocations with inline logic.

**Requirements**:
- Copy spec generation logic (validation, section requirements, quality checklist, clarification marker handling) from `speckit.specify` into `triad.specify`
- Copy plan generation logic (template loading, context setup, design generation, agent context updates) from `speckit.plan` into `triad.plan`
- Copy task generation logic (task format validation, phase structure, dependency ordering, parallel execution) from `speckit.tasks` into `triad.tasks`
- Copy implementation execution logic (checklist verification, phase-by-phase execution, progress tracking, error handling) from `speckit.implement` into `triad.implement`
- Remove all `Invoke /speckit.{command} using the Skill tool` steps
- Preserve all triad governance logic (prerequisite validation, research phase, reviews, frontmatter injection)

**Acceptance Criteria**:
- Each triad command is fully self-contained with no Skill tool invocation of speckit commands
- Running `/triad.specify` produces the same spec.md output as the previous triad+speckit combination
- Running `/triad.plan` produces the same plan.md output as before
- Running `/triad.tasks` produces the same tasks.md output as before
- Running `/triad.implement` produces the same implementation flow as before
- All merged commands remain under 500 lines each

### FR-2: Create 4 New Triad Commands from Speckit-Only Commands

**Description**: Create triad versions of the 4 speckit commands that have no current triad counterpart.

**Requirements**:
- Create `triad.clarify.md` with identical logic to `speckit.clarify.md`, updating internal references
- Create `triad.analyze.md` with identical logic to `speckit.analyze.md`, updating internal references
- Create `triad.checklist.md` with identical logic to `speckit.checklist.md`, updating internal references
- Create `triad.constitution.md` with identical logic to `speckit.constitution.md`, updating internal references
- Replace all `/speckit.*` cross-references with `/triad.*` equivalents in the new files

**Acceptance Criteria**:
- All 4 new triad commands exist in `.claude/commands/`
- Clarify, analyze, checklist, and constitution workflows are functionally unchanged
- All internal references consistently use `/triad.*` naming

### FR-3: Remove All Speckit Command Files

**Description**: Delete all 8 speckit command files after content has been transferred.

**Requirements**:
- Create an archive git tag before deletion (preserving historical state)
- Delete `speckit.specify.md`, `speckit.plan.md`, `speckit.tasks.md`, `speckit.implement.md`
- Delete `speckit.clarify.md`, `speckit.analyze.md`, `speckit.checklist.md`, `speckit.constitution.md`
- Verify no remaining speckit command files exist in `.claude/commands/`

**Acceptance Criteria**:
- Archive tag created before any file deletion
- Zero `speckit.*.md` files exist in `.claude/commands/`
- No broken file references result from deletion

### FR-4: Update Documentation and Configuration

**Description**: Update all files across the codebase that reference speckit commands.

**Requirements**:
- Update `CLAUDE.md`: Remove "Vanilla (fast, no governance)" section; list all 10 triad commands
- Update `.claude/rules/commands.md`: Remove "Vanilla Commands" section; add clarify, analyze, checklist, constitution to triad section
- Update `.claude/rules/governance.md`: Remove `/speckit.*` command references
- Update `.claude/README.md`: Replace all speckit references with triad equivalents
- Update `.specify/memory/constitution.md`: Replace speckit command references with triad equivalents
- Update `docs/SPEC_KIT_TRIAD.md`: Remove speckit command comparisons
- Update `docs/standards/PRODUCT_SPEC_ALIGNMENT.md`: Replace speckit references
- Update `docs/product/02_PRD/INDEX.md`: Remove `/speckit.prd` reference
- Update `Makefile`: Replace speckit command shortcuts with triad equivalents
- Update `README.md`: Replace speckit references with triad equivalents
- Update skill files (speckit-validator, prd-create, architecture-validator): Replace `/speckit.*` with `/triad.*`
- Update agent files (product-manager): Replace speckit references
- Remove `compatible_with_speckit` and `last_tested_with_speckit` frontmatter from 9 command files

**Acceptance Criteria**:
- All user-facing documentation references only `/triad.*` commands
- No mention of "vanilla" or "speckit" command workflow in active documentation
- All skill output messages reference `/triad.*` commands
- Comprehensive grep for `/speckit.` returns zero active results (excluding historical/changelog)

### FR-5: Update Skill and Command Registration

**Description**: Ensure the system recognizes all new triad commands and no longer registers speckit commands.

**Requirements**:
- Verify `triad.clarify`, `triad.analyze`, `triad.checklist`, `triad.constitution` are discoverable
- Verify all removed speckit commands are no longer listed in any registration or discovery mechanism
- Update speckit-validator skill description to reference triad commands

**Acceptance Criteria**:
- All 10 triad commands are discoverable and functional
- No speckit commands remain in any skill or command registration
- Users see a unified command set

### FR-6: Create Migration Guide

**Description**: Document the change for existing users who have muscle memory for speckit commands.

**Requirements**:
- Create a migration section in CHANGELOG.md mapping old commands to new equivalents
- Document that all `/speckit.*` commands are replaced by `/triad.*` equivalents
- Provide a command mapping table (e.g., `/speckit.clarify` → `/triad.clarify`)

**Acceptance Criteria**:
- CHANGELOG.md contains clear migration guidance
- Users can find the equivalent triad command for any former speckit command
- Breaking change is documented with version bump notation

---

## 4. Non-Functional Requirements

### NFR-1: Maintainability - Single Source of Truth

**Requirement**: Each workflow phase should have exactly one command file containing its logic
**Measure**: Zero Skill tool cross-invocations between commands for core workflow
**Verification**: Grep for Skill tool invocations of `/speckit.*` returns zero results

### NFR-2: Readability - File Size Limits

**Requirement**: Merged command files should remain comprehensible and navigable
**Measure**: No command file exceeds 500 lines
**Verification**: Line count audit of all triad command files after merge

### NFR-3: Consistency - Unified Namespace

**Requirement**: All commands, documentation, and references use a single namespace
**Measure**: Zero `/speckit.*` references in active codebase (excluding historical)
**Verification**: Comprehensive codebase grep after cleanup

### NFR-4: Backward Safety - Archive Before Deletion

**Requirement**: Historical command state must be recoverable if needed
**Measure**: Git archive tag exists with all speckit files intact before deletion
**Verification**: Archive tag can be checked out to access original speckit commands

---

## 5. Success Criteria

### Primary Metrics

| Metric | Baseline | Target | How to Measure |
|--------|----------|--------|----------------|
| Speckit command files | 8 | 0 | Count `speckit.*.md` in `.claude/commands/` |
| Speckit references (active) | 142 across 39 files | 0 | Grep for `/speckit.` excluding historical |
| Triad commands available | 6 | 10 | Count `triad.*.md` in `.claude/commands/` |
| Behavioral parity | N/A | 100% | Each triad command produces same artifacts as before |

### Secondary Metrics

| Metric | Baseline | Target | How to Measure |
|--------|----------|--------|----------------|
| Command file size compliance | N/A | 100% under 500 lines | Line count audit |
| Documentation consistency | Mixed (speckit + triad) | 100% triad-only | Documentation review |
| Skill tool cross-invocations | 3 (specify, plan, tasks) | 0 | Grep for Skill tool calls to speckit |
| Migration guide exists | No | Yes | Check CHANGELOG.md |

### User Experience Outcomes

- New users see a single command set with no ambiguity about which commands to use
- Existing users can find their former speckit command equivalent via migration guide
- All 10 triad commands function correctly end-to-end
- No broken cross-references exist in documentation or command output

---

## 6. Scope & Boundaries

### In Scope

- Inlining speckit execution logic into 4 existing triad commands
- Creating 4 new triad commands from speckit-only commands
- Deleting all 8 speckit command files
- Updating all documentation, rules, skills, and configuration references
- Creating archive git tag before deletion
- Creating migration guide in CHANGELOG.md
- Reference audit (Phase 0) before implementation
- Updating PRD INDEX.md with spec link

### Out of Scope

- **Governance model changes**: Sign-off requirements and review flow remain unchanged
- **Script changes**: `.specify/scripts/bash/` files remain unchanged
- **Template changes**: `.specify/templates/` files remain unchanged
- **Agent definition changes**: `.claude/agents/` files are not modified (except reference updates)
- **New capabilities**: No new features beyond what exists today
- **Governance skip flag**: Adding a "fast mode" to triad commands is a future consideration
- **triad.prd or triad.close-feature changes**: These commands are not modified
- **execute or continue changes**: These utility commands are not modified (except reference cleanup)

### Assumptions

- All speckit execution logic can be transferred without loss when inlined into triad commands
- Merged triad command files will stay under the 500-line threshold
- No active branches or workflows currently depend on speckit commands being separate
- This constitutes a breaking change warranting a version bump (v3.0.0 consideration)

### Dependencies

- **PRD-004 approval**: Approved with all Triad sign-offs
- **No external dependencies**: All changes are within the template repository
- **No script/template changes required**: Underlying infrastructure remains stable

---

## 7. Key Entities

### Command File Inventory

| Current State | Future State | Action |
|---------------|--------------|--------|
| `speckit.specify.md` (227 lines) | Logic merged into `triad.specify.md` | Delete after merge |
| `speckit.plan.md` (80 lines) | Logic merged into `triad.plan.md` | Delete after merge |
| `speckit.tasks.md` (128 lines) | Logic merged into `triad.tasks.md` | Delete after merge |
| `speckit.implement.md` (122 lines) | Logic merged into `triad.implement.md` | Delete after merge |
| `speckit.clarify.md` (176 lines) | Becomes `triad.clarify.md` | Delete original |
| `speckit.analyze.md` (184 lines) | Becomes `triad.analyze.md` | Delete original |
| `speckit.checklist.md` (287 lines) | Becomes `triad.checklist.md` | Delete original |
| `speckit.constitution.md` (77 lines) | Becomes `triad.constitution.md` | Delete original |

### Reference Update Categories

| Category | File Count | Reference Count | Action |
|----------|------------|-----------------|--------|
| Command files | 14 | ~30 | Update invocations, remove Skill calls |
| Skill/Agent files | 7 | ~16 | Update descriptions, command references |
| Rules files | 2 | ~10 | Remove "vanilla" section, update governance |
| Core docs (CLAUDE.md, README, Makefile) | 3 | ~14 | Unify to triad commands |
| Architecture/standards docs | 5 | ~19 | Replace speckit references |
| Constitution | 1 | ~8 | Replace governance command references |
| Feature specs (historical) | 5 | ~7 | Update where active, preserve in archives |
| PRD 004 (historical) | 1 | ~56 | Preserve as-is (historical record) |

### Merged Command Size Estimates

| Triad Command | Current Size | After Merge | Within 500-line Limit |
|---------------|-------------|-------------|----------------------|
| `triad.specify.md` | 179 lines | ~400 lines | Yes |
| `triad.plan.md` | 117 lines | ~190 lines | Yes |
| `triad.tasks.md` | 147 lines | ~260 lines | Yes |
| `triad.implement.md` | 112 lines | ~220 lines | Yes |

---

## 8. Risks & Mitigations

### Risk 1: Content Lost During Transfer

**Likelihood**: Low | **Impact**: High
**Description**: Execution logic, error handling, or validation steps could be accidentally omitted during the merge process
**Mitigation**: Create a logic preservation checklist for each command pair; diff before and after merge to verify completeness

### Risk 2: Merged Triad Commands Exceed Size Threshold

**Likelihood**: Medium | **Impact**: Medium
**Description**: Triad commands may exceed the 500-line readability threshold after merging speckit logic
**Mitigation**: Monitor line counts during merge; use clear section headings and remove duplication; estimates show all commands stay within limits

### Risk 3: Missed Speckit References

**Likelihood**: Medium | **Impact**: Medium
**Description**: Some `/speckit.*` references may be missed during the cleanup phase
**Mitigation**: Phase 0 reference audit creates comprehensive checklist before implementation; final grep validation in Phase 3

### Risk 4: Users with Muscle Memory for Speckit Commands

**Likelihood**: Medium | **Impact**: Low
**Description**: Existing users may try to use `/speckit.*` commands after removal
**Mitigation**: Migration guide in CHANGELOG.md with command mapping table; clear version bump indicating breaking change

### Risk 5: Frontmatter Compatibility Markers

**Likelihood**: Low | **Impact**: Low
**Description**: 9 command files contain `compatible_with_speckit` metadata that becomes meaningless
**Mitigation**: Remove all speckit compatibility frontmatter as part of the cleanup phase

---

## 9. Open Questions

*No critical clarifications needed. The PRD provides comprehensive requirements with approved Triad sign-offs, and the research phase confirmed feasibility and identified all reference points.*

---

## Appendix A: Implementation Phase Summary

| Phase | Description | Key Deliverables |
|-------|-------------|-----------------|
| Phase 0 | Reference Audit | Reference inventory checklist across all 39 files |
| Phase 1 | Inline Core Commands | 4 self-contained triad commands (specify, plan, tasks, implement) |
| Phase 2 | Create New Commands | 4 new triad commands (clarify, analyze, checklist, constitution) |
| Phase 3 | Delete, Update, Validate | Archive tag, file deletion, reference cleanup, migration guide, grep validation |

## Appendix B: Command Mapping (Migration Reference)

| Former Command | New Command | Notes |
|----------------|-------------|-------|
| `/speckit.specify` | `/triad.specify` | Logic inlined; includes research + PM sign-off |
| `/speckit.plan` | `/triad.plan` | Logic inlined; includes PM + Architect sign-off |
| `/speckit.tasks` | `/triad.tasks` | Logic inlined; includes triple sign-off |
| `/speckit.implement` | `/triad.implement` | Logic inlined; includes architect checkpoints |
| `/speckit.clarify` | `/triad.clarify` | Direct rename with reference updates |
| `/speckit.analyze` | `/triad.analyze` | Direct rename with reference updates |
| `/speckit.checklist` | `/triad.checklist` | Direct rename with reference updates |
| `/speckit.constitution` | `/triad.constitution` | Direct rename with reference updates |
