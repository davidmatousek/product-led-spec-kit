---
prd:
  number: 004
  topic: remove-speckit-commands
  created: 2026-02-07
  status: Approved
  type: feature
triad:
  pm_signoff:
    agent: product-manager
    date: 2026-02-07
    status: APPROVED
    notes: "PRD drafted by PM with full speckit/triad inventory analysis"
  architect_signoff:
    agent: architect
    date: 2026-02-07
    status: APPROVED_WITH_CONCERNS
    notes: "Technically sound. Concerns: create archive branch before deletion; add merge validation checklist; monitor file length (500-line threshold); consider v3.0.0 version bump for breaking change."
  techlead_signoff:
    agent: team-lead
    date: 2026-02-07
    status: APPROVED_WITH_CONCERNS
    notes: "Feasible in 1.5 business days. Concerns: add Phase 0 reference audit; add migration guide; add logic preservation validation; confirm no active branches using speckit."
---

# PRD 004: Remove SpecKit Commands & Transfer Content to Triad

**Created**: 2026-02-07
**Author**: Product Manager (product-manager)
**Type**: Feature (Restructuring)
**Status**: Approved

---

## 1. Problem Statement

Product-Led Spec Kit currently maintains **two parallel command sets** for the same SDLC workflow:

- **Triad commands** (`/triad.specify`, `/triad.plan`, `/triad.tasks`, `/triad.implement`) -- governed workflow with automatic sign-offs
- **Speckit commands** (`/speckit.specify`, `/speckit.plan`, `/speckit.tasks`, `/speckit.implement`) -- ungoverned "fast" workflow

This dual command architecture creates several problems:

1. **Fragile coupling**: Triad commands depend on speckit commands at runtime (via Skill tool invocations). If a speckit command changes, triad commands silently break.
2. **Maintenance burden**: Every core workflow improvement must be applied in two places -- the speckit command AND the triad wrapper.
3. **User confusion**: New users must choose between two command sets without understanding governance implications.
4. **Inconsistent references**: Speckit commands reference `/speckit.clarify` and `/speckit.plan` in their output, while triad commands reference `/triad.plan` -- creating mixed messaging.
5. **Documentation drift**: CLAUDE.md, rules files, and INDEX.md reference both command families.

**Additionally**, 4 speckit-only commands have **no triad counterpart** and provide unique value that must be preserved:
- `/speckit.clarify` -- interactive spec clarification
- `/speckit.analyze` -- cross-artifact consistency analysis
- `/speckit.checklist` -- requirements quality validation ("unit tests for English")
- `/speckit.constitution` -- governance document management

---

## 2. Target Users

### Primary Persona: Spec Kit Template Adopter
- **Who**: Developers and teams using Product-Led Spec Kit to structure their SDLC
- **Pain Point**: Confused by dual command sets; unsure which to use
- **Goal**: Single, clear workflow with all capabilities
- **How This Helps**: One command set (`/triad.*`) with all capabilities inline

### Secondary Persona: Spec Kit Maintainer
- **Who**: Contributors maintaining the template repository
- **Pain Point**: Must update logic in two places for every workflow improvement
- **Goal**: Single source of truth for each workflow phase
- **How This Helps**: Eliminates speckit commands entirely; all logic lives in triad commands

---

## 3. Solution Overview

**Transfer all unique speckit command content into their triad counterparts, then remove speckit commands entirely.**

### What Changes

| Current State | Future State |
|---------------|--------------|
| `triad.specify` wraps `speckit.specify` via Skill tool | `triad.specify` contains all spec generation logic inline |
| `triad.plan` wraps `speckit.plan` via Skill tool | `triad.plan` contains all plan generation logic inline |
| `triad.tasks` wraps `speckit.tasks` via Skill tool | `triad.tasks` contains all task generation logic inline |
| `triad.implement` references `speckit.implement` patterns | `triad.implement` contains all implementation logic inline |
| `speckit.clarify` -- standalone, no triad version | `triad.clarify` -- new command with same logic |
| `speckit.analyze` -- standalone, no triad version | `triad.analyze` -- new command with same logic |
| `speckit.checklist` -- standalone, no triad version | `triad.checklist` -- new command with same logic |
| `speckit.constitution` -- standalone, no triad version | `triad.constitution` -- new command with same logic |
| CLAUDE.md lists both command families | CLAUDE.md lists only triad commands |
| rules/commands.md documents both workflows | rules/commands.md documents only triad workflow |

### What Does NOT Change

- Triad governance flow (research -> generate -> review -> sign-off)
- Sign-off requirements (PM, Architect, Team-Lead)
- Underlying scripts (`.specify/scripts/bash/`)
- Templates (`.specify/templates/`)
- Skills that are NOT speckit-specific (kb-create, kb-query, prd-create, etc.)
- Agent definitions (`.claude/agents/`)
- The `/triad.prd` and `/triad.close-feature` commands
- The `/execute` and `/continue` commands

---

## 4. Requirements

### FR-1: Inline Speckit Logic into Triad Commands

For each of the 4 paired commands (`specify`, `plan`, `tasks`, `implement`):

1. Copy all unique content from the speckit command into the corresponding triad command
2. Replace `Invoke /speckit.{command} using the Skill tool` steps with the actual inline logic
3. Preserve ALL speckit execution logic (script calls, template loading, validation, error handling)
4. Preserve ALL triad governance logic (prerequisite validation, research, reviews, frontmatter injection)
5. The merged command must produce identical artifacts to the current triad+speckit combination

**Acceptance Criteria**:
- Each triad command is fully self-contained (no Skill tool invocation of speckit commands)
- Running `/triad.specify "feature description"` produces the same spec.md output as today
- Running `/triad.plan` produces the same plan.md output as today
- Running `/triad.tasks` produces the same tasks.md output as today
- Running `/triad.implement` produces the same implementation flow as today
- Logic preservation validated: all validation flows, error handling, and checklist generation from speckit commands are present in merged triad commands

### FR-2: Create Triad Versions of Speckit-Only Commands

For each of the 4 speckit-only commands:

1. Create new triad command files:
   - `triad.clarify.md` (from `speckit.clarify.md`)
   - `triad.analyze.md` (from `speckit.analyze.md`)
   - `triad.checklist.md` (from `speckit.checklist.md`)
   - `triad.constitution.md` (from `speckit.constitution.md`)
2. Content should be identical to the speckit version
3. Update any internal cross-references from `/speckit.*` to `/triad.*`

**Acceptance Criteria**:
- All 4 new triad commands exist and are functional
- Internal references use `/triad.*` naming consistently
- The `clarify`, `analyze`, `checklist`, and `constitution` workflows are unchanged

### FR-3: Remove All Speckit Command Files

After FR-1 and FR-2 are complete:

1. Delete all `speckit.*.md` files from `.claude/commands/`
2. Verify no remaining references to `/speckit.*` commands in:
   - `.claude/commands/` (all triad files)
   - `.claude/skills/` (all skill files)
   - `.claude/rules/` (all rule files)
   - `docs/` (all documentation)
   - `CLAUDE.md`
   - `.specify/templates/` (all templates)

**Acceptance Criteria**:
- No `speckit.*.md` files exist in `.claude/commands/`
- Zero references to `/speckit.*` across the entire codebase (grep returns empty, excluding historical/changelog)

### FR-4: Update Documentation and Configuration

1. **CLAUDE.md**: Remove "Vanilla (fast, no governance)" section; update command list to show only triad commands including new ones
2. **rules/commands.md**: Remove "Vanilla Commands" section; add `clarify`, `analyze`, `checklist`, `constitution` to triad section
3. **rules/governance.md**: Remove references to `/speckit.*` commands
4. **docs/product/02_PRD/INDEX.md**: Remove `/speckit.prd` reference
5. **docs/SPEC_KIT_TRIAD.md**: Update if it references speckit commands
6. **speckit-validator skill**: Update description and any internal `/speckit.*` references
7. **Any other files**: Search and replace remaining `/speckit.*` references

**Acceptance Criteria**:
- All documentation references only `/triad.*` commands
- No mention of "vanilla" or "speckit" command workflow in user-facing docs
- Users see a single, unified command set

### FR-5: Update Skill Registration

1. Update the skills list in any configuration that registers available skills
2. Ensure the system recognizes new commands:
   - `triad.clarify`
   - `triad.analyze`
   - `triad.checklist`
   - `triad.constitution`
3. Remove registration of all `speckit.*` skills/commands

**Acceptance Criteria**:
- All new triad commands are discoverable and functional
- No speckit commands remain in skill registration

---

## 5. Scope

### In Scope
- Inlining speckit logic into 4 existing triad commands
- Creating 4 new triad commands from speckit-only commands
- Deleting 8 speckit command files
- Updating all documentation and cross-references
- Updating skill/command registration
- Reference audit (Phase 0) before implementation
- Migration guide for existing users

### Out of Scope
- Changes to the triad governance model (sign-off requirements, review flow)
- Changes to underlying scripts (`.specify/scripts/bash/`)
- Changes to templates (`.specify/templates/`)
- Changes to agent definitions
- Adding new features or capabilities beyond what exists today
- Adding a "governance skip" flag to triad commands (future consideration)
- Modifying the `/triad.prd` or `/triad.close-feature` commands
- Modifying the `/execute` or `/continue` commands

---

## 6. Success Criteria

1. **Zero speckit commands remain**: No `speckit.*.md` files in `.claude/commands/`
2. **Zero speckit references**: Grep for `speckit.` across `.claude/`, `docs/`, `CLAUDE.md` returns empty (excluding historical/changelog)
3. **All 10 triad commands functional**: `prd`, `specify`, `plan`, `tasks`, `implement`, `close-feature`, `clarify`, `analyze`, `checklist`, `constitution`
4. **Behavioral parity**: Triad commands produce identical artifacts to the previous triad+speckit combination
5. **No broken cross-references**: All `/triad.*` references in documentation resolve to existing commands

---

## 7. Implementation Phases

### Phase 0: Reference Audit (NEW -- per Team-Lead review)
- Grep all markdown files for `/speckit.` pattern
- Create reference inventory: file path, line numbers, context
- Generate update checklist for Phase 3
- **Deliverable**: Reference audit checklist

### Phase 1: Inline Speckit Logic into 4 Triad Commands
- Merge `speckit.specify` logic into `triad.specify`
- Merge `speckit.plan` logic into `triad.plan`
- Merge `speckit.tasks` logic into `triad.tasks`
- Merge `speckit.implement` logic into `triad.implement`
- **Validation**: Logic preservation check for each merged command

### Phase 2: Create 4 New Triad Commands
- Create `triad.clarify` from `speckit.clarify`
- Create `triad.analyze` from `speckit.analyze`
- Create `triad.checklist` from `speckit.checklist`
- Create `triad.constitution` from `speckit.constitution`

### Phase 3: Delete, Update References, Validate
- Create archive branch/tag before deletion (per Architect review)
- Delete 8 speckit command files
- Update all documentation references
- Comprehensive grep validation
- Update CHANGELOG.md

---

## 8. Dependencies

- No external dependencies
- Requires no changes to `.specify/scripts/bash/` scripts
- Requires no changes to `.specify/templates/`
- Self-contained within `.claude/commands/`, `.claude/skills/`, `.claude/rules/`, and `docs/`

---

## 9. Risks & Mitigations

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| Content lost during transfer | High | Low | Logic preservation checklist; diff before/after |
| Triad commands become too long | Medium | Medium | Clear section headings; monitor 500-line threshold |
| Missed references to speckit | Medium | Medium | Phase 0 reference audit; comprehensive grep in Phase 3 |
| Users with muscle memory for speckit | Low | Medium | Migration guide; CHANGELOG entry |
| Active branches using speckit commands | Medium | Low | Confirm with user before starting; archive branch |

---

## 10. Reviewer Feedback Incorporated

### Architect Concerns (Addressed)
- **Archive branch**: Added to Phase 3 -- create archive branch/tag before deletion
- **Merge validation**: Added logic preservation checklist to Phase 1
- **File length monitoring**: Noted 500-line threshold in risks
- **Version bump**: Consider v3.0.0 for breaking change (implementation decision)

### Team-Lead Concerns (Addressed)
- **Phase 0 reference audit**: Added as new phase
- **Migration guide**: Added to scope and Phase 3 deliverables
- **Logic preservation validation**: Added to FR-1 acceptance criteria
- **Active branch check**: Added to risks with mitigation
