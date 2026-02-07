---
triad:
  pm_signoff:
    agent: product-manager
    date: 2026-02-07
    status: APPROVED
    notes: "All 6 functional requirements (FR-1 through FR-6) addressed with concrete implementation steps. All 10 user scenarios mapped to specific plan phases. All 5 success criteria have explicit verification steps in Phase 3.7. Scope boundaries respected with no creep detected. Phase ordering is logical with proper dependency accounting."
  architect_signoff:
    agent: architect
    date: 2026-02-07
    status: APPROVED_WITH_CONCERNS
    notes: "Architecturally sound with correct merge strategy and coupling point identification. Size estimates verified accurate. Two concerns addressed in plan: (1) .claude/INFRASTRUCTURE_SETUP_SUMMARY.md added to Phase 3.4 update list, (2) Size mitigation strategy added for triad.specify.md (~400 lines). Historical spec files added to validation exception list."
  techlead_signoff: null  # Added by /triad.tasks
---

# Implementation Plan: Remove SpecKit Commands & Transfer Content to Triad

**Feature**: 004-remove-speckit-commands
**Spec Reference**: [spec.md](spec.md)
**PRD Reference**: [004-remove-speckit-commands-2026-02-07.md](../../docs/product/02_PRD/004-remove-speckit-commands-2026-02-07.md)
**Created**: 2026-02-07

---

## Technical Context

### Project Nature

This is a **methodology-only template** (no application code). All changes involve markdown command files, documentation, and configuration. No data models, API contracts, database schemas, or quickstart guides apply.

### Technology Stack

- **Files**: Markdown (`.md`) command files, documentation, YAML frontmatter
- **Tools**: Git (branching, tagging), shell scripts (`.specify/scripts/bash/`), grep (validation)
- **No dependencies**: No package managers, build systems, or runtime code

### Architecture

Product-Led Spec Kit uses a command-based architecture where `.claude/commands/*.md` files define agent workflows:

- **Speckit commands** (8 files): Standalone workflow logic invoked directly or via Skill tool
- **Triad commands** (6 files): Governance wrappers that invoke speckit commands via `Skill tool` then add sign-off reviews
- **Coupling mechanism**: Triad commands contain `Invoke /speckit.{cmd} using the Skill tool` directives (3 coupling points in specify, plan, tasks)

### Key Constraints

- **500-line threshold**: Merged triad command files must stay under 500 lines each (Architect requirement)
- **Behavioral parity**: Merged commands must produce identical artifacts as before
- **No script changes**: `.specify/scripts/bash/` files remain untouched (out of scope)
- **No template changes**: `.specify/templates/` files remain untouched (out of scope)
- **No agent definition changes**: `.claude/agents/` content unchanged (only reference updates)

---

## Constitution Check

### Applicable Principles

| Principle | Status | Notes |
|-----------|--------|-------|
| I. General-Purpose Architecture | PASS | Changes maintain domain-agnostic command structure |
| III. Backward Compatibility | N/A | No local `.specify/` file workflow changes |
| VI. Testing Excellence | PASS | Validation via grep audits and line count checks |
| VII. Definition of Done | PASS | Three-step validation: grep returns zero, all 10 commands functional, documentation consistent |
| IX. Git Workflow | PASS | Feature branch `004-remove-speckit-commands`, archive tag before deletion |
| X. Product-Spec Alignment | PASS | PRD approved, spec approved with PM sign-off |
| XI. SDLC Triad Collaboration | PASS | Full Triad sign-off chain in progress |

### Gates

- **No constitution violations detected**. All changes serve consolidation without introducing new architectural patterns.

---

## Phase 0: Reference Audit

**Goal**: Create a complete inventory of every speckit reference to drive Phase 3 cleanup.

### 0.1 Reference Inventory

Scan all markdown files for the following patterns and document findings:

| Pattern | Scope | Purpose |
|---------|-------|---------|
| `/speckit.` | All `.md` files | Command invocation references |
| `speckit.` (without slash) | All `.md` files | Prose and filename references |
| `compatible_with_speckit` | `.claude/commands/` | Frontmatter metadata markers |
| `last_tested_with_speckit` | `.claude/commands/` | Frontmatter metadata markers |
| `"Vanilla"` / `"vanilla"` | All `.md` files | Dual-workflow terminology |

### 0.2 Known Reference Map (from research)

| Category | Files | Reference Count | Action |
|----------|-------|-----------------|--------|
| Speckit command files | 8 | Self-contained | DELETE in Phase 3 |
| Triad command files (Skill calls) | 3 | 3 coupling points | INLINE in Phase 1 |
| Triad command files (frontmatter) | 6 | 12 markers | REMOVE in Phase 3 |
| Other command files (frontmatter) | 3 | 6 markers | REMOVE in Phase 3 |
| Rules files | 2 | ~10 refs | UPDATE in Phase 3 |
| Skill files | 3 | ~5 refs | UPDATE in Phase 3 |
| Agent files | 1 | ~2 refs | UPDATE in Phase 3 |
| Core docs (CLAUDE.md, README, Makefile) | 3 | ~14 refs | UPDATE in Phase 3 |
| Architecture/standards docs | 5 | ~19 refs | UPDATE in Phase 3 |
| Constitution | 1 | ~8 refs | UPDATE in Phase 3 |
| Historical (preserve as-is) | 7+ | ~60+ refs | NO CHANGE |

**Deliverable**: `specs/004-remove-speckit-commands/reference-audit.md` with file-by-file checklist.

---

## Phase 1: Inline Core Commands

**Goal**: Make 4 triad commands self-contained by inlining speckit logic, removing Skill tool coupling.

### 1.1 Merge Strategy

For each of the 4 core command pairs, the merge follows this pattern:

1. **Read** both speckit and triad command files side by side
2. **Identify** the Skill tool invocation point in the triad command
3. **Replace** the `Invoke /speckit.{cmd} using the Skill tool` directive with the actual execution logic from the speckit command
4. **Deduplicate** any overlapping content (e.g., both files may describe user input handling)
5. **Preserve** all triad governance logic (prerequisite validation, research phase, sign-off reviews, frontmatter injection)
6. **Update** internal references from `/speckit.*` to `/triad.*`
7. **Remove** `compatible_with_speckit` and `last_tested_with_speckit` from frontmatter
8. **Verify** line count stays under 500 lines

### 1.2 Command Merge Details

#### A. `triad.specify.md` (179 → ~400 lines)

**Current coupling** (line 91): `Invoke /speckit.specify using the Skill tool, passing research.md as context`

**Logic to inline from `speckit.specify.md`** (227 lines):
- PRD traceability check (search `docs/product/02_PRD/`, use `--number N` flag)
- Script invocation: `.specify/scripts/bash/create-new-feature.sh --json [--number N] "$ARGUMENTS"`
- Template loading: `.specify/templates/spec-template.md`
- Execution flow: parse description → extract concepts → handle clarifications → fill sections → quality validation
- Checklist generation at `FEATURE_DIR/checklists/requirements.md`
- NEEDS CLARIFICATION handling (max 3 markers, table-formatted questions)
- Section requirements and AI generation guidelines

**What to preserve from `triad.specify.md`**:
- Step 1: Prerequisite validation (branch, PRD, Triad sign-offs)
- Step 2: Research phase (4 parallel research agents → research.md)
- Step 4: PM sign-off (product-manager agent review)
- Step 5: Review result handling (APPROVED/CHANGES_REQUESTED/BLOCKED)
- Step 6: Frontmatter injection
- Step 7: Completion reporting

**Merge approach**: Replace Step 3 ("Generate Specification") with the full inline logic from speckit.specify. The triad command's Step 3 currently says "Invoke /speckit.specify" — replace with the actual 6-step outline from speckit.specify (adjusted to reference research.md from Step 2). Update the overview line to remove "Wraps /speckit.specify" phrasing. Update quality checklist to remove speckit references.

**Size mitigation**: The "General Guidelines" and "For AI Generation" sections (lines 166-227 of speckit.specify.md, ~62 lines) overlap with `.specify/templates/spec-template.md` content and can be condensed during merge to maintain headroom. Target: keep merged file under 420 lines.

**Estimated merged size**: ~400 lines (within 500-line limit)

#### B. `triad.plan.md` (117 → ~190 lines)

**Current coupling** (line 30): `Invoke /speckit.plan using the Skill tool`

**Logic to inline from `speckit.plan.md`** (80 lines):
- Script invocation: `.specify/scripts/bash/setup-plan.sh --json`
- Context loading: FEATURE_SPEC, constitution, IMPL_PLAN template
- Plan workflow: Technical Context → Constitution Check → gates
- Phase 0: Research.md generation (resolve NEEDS CLARIFICATION)
- Phase 1: Design artifacts (data-model.md, contracts/, quickstart.md)
- Agent context update: `.specify/scripts/bash/update-agent-context.sh claude`
- Key rules: absolute paths, ERROR on gate failures

**What to preserve from `triad.plan.md`**:
- Step 1: Prerequisite validation (branch, spec, PM sign-off status)
- Step 3: Dual sign-off (PM + Architect in parallel)
- Step 4: Review result handling
- Step 5: Frontmatter injection
- Step 6: Completion reporting

**Merge approach**: Replace Step 2 ("Generate Plan") with the full speckit.plan outline (setup → load → execute → report). Update overview and quality checklist.

**Estimated merged size**: ~190 lines (well within limit)

#### C. `triad.tasks.md` (147 → ~260 lines)

**Current coupling** (line 30): `Invoke /speckit.tasks using the Skill tool`

**Logic to inline from `speckit.tasks.md`** (128 lines):
- Script invocation: `.specify/scripts/bash/check-prerequisites.sh --json`
- Document loading: plan.md (required), spec.md (required), data-model.md, contracts/, research.md, quickstart.md (optional)
- Task generation workflow: extract stories → map entities → map endpoints → generate → validate
- Tasks.md generation: template structure, phase organization
- Task Generation Rules: checklist format (T001, [P], [US1]), organization by user story, phase structure
- Completion report: task count, parallel opportunities, MVP scope, format validation

**What to preserve from `triad.tasks.md`**:
- Step 1: Prerequisite validation (branch, plan, dual sign-off status)
- Step 3: Triple sign-off (PM + Architect + Team-Lead in parallel)
- Step 4: Review result handling (including cross-domain conflict resolution)
- Step 5: Frontmatter injection
- Step 6: Agent assignments generation
- Step 7: Completion reporting

**Merge approach**: Replace Step 2 ("Generate Tasks") with the full speckit.tasks outline and Task Generation Rules. Update overview and quality checklist.

**Estimated merged size**: ~260 lines (within limit)

#### D. `triad.implement.md` (112 → ~220 lines)

**Current state**: Unlike the other 3, `triad.implement.md` does NOT invoke `speckit.implement` via Skill tool. It has its own implementation flow with Architect checkpoints. However, it lacks some detailed logic from `speckit.implement.md`.

**Logic to inline from `speckit.implement.md`** (122 lines):
- Script invocation: `.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks`
- Checklist status checking (scan checklists/, create pass/fail status table)
- Incomplete checklist user prompt (STOP and ask before proceeding)
- Implementation context loading (tasks.md, plan.md, data-model.md, contracts/, research.md, quickstart.md)
- Project setup verification (detect and create ignore files: .gitignore, .dockerignore, etc.)
- Task parsing: phases, dependencies, parallel markers
- Phase-by-phase execution with TDD approach
- Progress tracking and error handling
- Completion validation

**What to preserve from `triad.implement.md`**:
- Step 1: Prerequisite validation (branch, tasks, triple sign-off, agent-assignments)
- Step 2: Load context and define checkpoints (P0, P1, P2)
- Step 3: Wave execution with Architect checkpoint reviews
- Step 4: Final validation (Architect + Code Review + Security)
- Step 5: Completion reporting

**Merge approach**: Enhance Step 2 with the detailed context loading and checklist checking from speckit.implement. Enhance Step 3 with the project setup verification and detailed execution rules. The wave-based execution model from triad.implement supersedes the phase-by-phase model from speckit.implement (triad's is more sophisticated). Update overview and quality checklist.

**Estimated merged size**: ~220 lines (within limit)

### 1.3 Validation After Phase 1

For each merged command:
1. **Line count**: Verify < 500 lines
2. **No Skill calls**: Grep for `Skill tool` or `/speckit.` within merged file → zero results
3. **Logic preservation**: Side-by-side comparison of key sections (script invocations, template loading, error handling)
4. **Internal consistency**: All cross-references use `/triad.*` naming

---

## Phase 2: Create New Triad Commands

**Goal**: Create 4 new triad commands from speckit-only commands that have no triad counterpart.

### 2.1 Creation Strategy

For each of the 4 support commands:
1. **Copy** the speckit command content
2. **Update** all internal cross-references from `/speckit.*` to `/triad.*`
3. **Update** the description in frontmatter to reflect triad namespace
4. **Preserve** all functional logic unchanged

### 2.2 Command Creation Details

#### A. `triad.clarify.md` (from `speckit.clarify.md`, 176 lines)

**References to update**:
- Line 17: `BEFORE invoking /speckit.plan` → `BEFORE invoking /triad.plan`
- Line 164: `proceed to /speckit.plan or run /speckit.clarify again` → `proceed to /triad.plan or run /triad.clarify again`
- Line 169: `instruct user to run /speckit.specify first` → `instruct user to run /triad.specify first`

**Description update**: `Identify underspecified areas in the current feature spec by asking up to 5 highly targeted clarification questions and encoding answers back into the spec (Triad-enhanced).`

#### B. `triad.analyze.md` (from `speckit.analyze.md`, 184 lines)

**References to update**:
- Line 15: `This command MUST run only after /tasks has successfully produced` → preserve but verify context
- Line 159: Command suggestions referencing `/specify`, `/plan` → ensure `/triad.specify`, `/triad.plan`

**Description update**: `Perform a non-destructive cross-artifact consistency and quality analysis across spec.md, plan.md, and tasks.md after task generation (Triad-enhanced).`

#### C. `triad.checklist.md` (from `speckit.checklist.md`, 287 lines)

**References to update**:
- Line 94: `Each /speckit.checklist run` → `Each /triad.checklist run`
- Line 108: `Items marked incomplete require spec updates before /speckit.clarify or /speckit.plan` → `before /triad.clarify or /triad.plan`
- Line 212: `Each /speckit.checklist command invocation` → `Each /triad.checklist command invocation`

**Description update**: `Generate a custom checklist for the current feature based on user requirements (Triad-enhanced).`

**Note**: At 287 lines, this is the largest speckit command. Verify it stays under 500 lines as a standalone triad command (it will, since no additional governance wrapper is needed).

#### D. `triad.constitution.md` (from `speckit.constitution.md`, 77 lines)

**References to update**: Scan for any `/speckit.*` references (minimal expected in this file).

**Description update**: `Create or update the project constitution from interactive or provided principle inputs, ensuring all dependent templates stay in sync (Triad-enhanced).`

### 2.3 Validation After Phase 2

1. All 4 new files exist in `.claude/commands/`
2. Zero `/speckit.` references within the new files
3. Functional logic is unchanged (diff only shows reference updates)
4. All files under 500 lines

---

## Phase 3: Delete, Update References, Validate

**Goal**: Remove all speckit files, clean up every reference across the codebase, create migration guide, and validate zero speckit references remain.

### 3.1 Archive Before Deletion

1. Create archive git tag: `git tag v2.0.0-pre-speckit-removal` (preserves all speckit files in git history)
2. Verify tag was created: `git tag -l "v2.0.0-pre-speckit-removal"`

### 3.2 Delete Speckit Command Files

Delete all 8 files from `.claude/commands/`:
- `speckit.specify.md`
- `speckit.plan.md`
- `speckit.tasks.md`
- `speckit.implement.md`
- `speckit.clarify.md`
- `speckit.analyze.md`
- `speckit.checklist.md`
- `speckit.constitution.md`

### 3.3 Remove Frontmatter Metadata

Remove `compatible_with_speckit` and `last_tested_with_speckit` lines from these command files:
- `triad.prd.md`
- `triad.close-feature.md`
- `continue.md`
- `execute.md`

(The 4 core triad commands already had frontmatter cleaned in Phase 1.)

### 3.4 Update Documentation and Configuration

#### Core Files

| File | Changes |
|------|---------|
| `CLAUDE.md` | Remove "Vanilla (fast, no governance)" section; update validation reference from `/speckit.analyze` to `/triad.analyze`; list all 10 triad commands |
| `README.md` | Remove "Vanilla Commands" section; update to triad-only workflow |
| `Makefile` | Replace all speckit command shortcuts with triad equivalents |

#### Rules Files

| File | Changes |
|------|---------|
| `.claude/rules/commands.md` | Remove entire "Vanilla Commands" section; add clarify, analyze, checklist, constitution to triad section |
| `.claude/rules/governance.md` | Replace `/speckit.specify`, `/speckit.plan`, `/speckit.tasks` references with `/triad.*` equivalents |

#### Skill and Agent Files

| File | Changes |
|------|---------|
| `.claude/skills/speckit-validator/SKILL.md` | Replace `/speckit.plan` → `/triad.plan`, `/speckit.clarify` → `/triad.clarify` |
| `.claude/skills/architecture-validator/SKILL.md` | Replace `/speckit.tasks` → `/triad.tasks` |
| `.claude/skills/prd-create/skill.md` | Replace any speckit command references with triad equivalents |
| `.claude/agents/product-manager.md` | Replace speckit references with triad equivalents |

#### Documentation

| File | Changes |
|------|---------|
| `.specify/memory/constitution.md` | Replace `/speckit.analyze` → `/triad.analyze`; replace all `/speckit.*` tool references with `/triad.*` equivalents |
| `docs/SPEC_KIT_TRIAD.md` | Remove speckit command comparisons; update to triad-only workflow |
| `docs/standards/PRODUCT_SPEC_ALIGNMENT.md` | Replace all `/speckit.*` references (13 instances) |
| `docs/standards/TRIAD_COLLABORATION.md` | Replace `/speckit.specify` → `/triad.specify`, `/speckit.prd` → `/triad.prd` |
| `docs/product/02_PRD/INDEX.md` | Replace `/speckit.prd` → `/triad.prd` |
| `docs/product/01_Product_Vision/README.md` | Replace `/speckit.specify` → `/triad.specify` |
| `.claude/README.md` | Remove Vanilla Commands sections (~24 speckit references); update to triad-only |
| `docs/devops/MIGRATION.md` | Update `/speckit.analyze` → `/triad.analyze` |
| `.claude/INFRASTRUCTURE_SETUP_SUMMARY.md` | Replace ~10 speckit references with triad equivalents |

#### Scope Files

| File | Changes |
|------|---------|
| `.claude/rules/scope.md` | Update "Vanilla (fast)" workflow references to describe unified triad workflow |

### 3.5 Migration Guide

Add a migration section to `CHANGELOG.md`:

```markdown
## [3.0.0] - 2026-02-XX

### BREAKING CHANGES

#### SpecKit Commands Removed - Unified Triad Workflow

All `/speckit.*` commands have been removed and consolidated into the `/triad.*` command set.

**Command Mapping:**

| Former Command | New Command | Notes |
|----------------|-------------|-------|
| `/speckit.specify` | `/triad.specify` | Logic inlined with research + PM sign-off |
| `/speckit.plan` | `/triad.plan` | Logic inlined with PM + Architect sign-off |
| `/speckit.tasks` | `/triad.tasks` | Logic inlined with triple sign-off |
| `/speckit.implement` | `/triad.implement` | Logic inlined with Architect checkpoints |
| `/speckit.clarify` | `/triad.clarify` | Direct transfer with reference updates |
| `/speckit.analyze` | `/triad.analyze` | Direct transfer with reference updates |
| `/speckit.checklist` | `/triad.checklist` | Direct transfer with reference updates |
| `/speckit.constitution` | `/triad.constitution` | Direct transfer with reference updates |

**Migration**: Replace all `/speckit.*` commands with their `/triad.*` equivalents. No other changes needed.
```

### 3.6 Update PRD INDEX

Add spec.md link to PRD INDEX for feature 004:

```markdown
| 004 | Remove SpecKit Commands | [PRD](004-remove-speckit-commands-2026-02-07.md) | [Spec](../../specs/004-remove-speckit-commands/spec.md) | Approved |
```

### 3.7 Final Validation

Execute comprehensive validation:

1. **File deletion check**: Verify zero `speckit.*.md` files in `.claude/commands/`
2. **Reference grep**: Search for `/speckit.` across entire codebase
   - Expected: Zero matches in active files
   - Acceptable exceptions: `CHANGELOG.md`, `specs/004-*/` (historical), PRD 004 (historical), architect review, historical spec files (`specs/001-*/`, `specs/002-*/`, `specs/003-*/`)
3. **Triad command count**: Verify 10 `triad.*.md` files in `.claude/commands/`
4. **Line count audit**: Verify all merged triad commands are under 500 lines
5. **Frontmatter check**: Verify zero `compatible_with_speckit` or `last_tested_with_speckit` references
6. **Vanilla terminology check**: Verify no "vanilla commands" terminology in active documentation

---

## Size Estimates Summary

| Triad Command | Current | After Merge | Within 500-line Limit |
|---------------|---------|-------------|----------------------|
| `triad.specify.md` | 179 | ~400 | Yes |
| `triad.plan.md` | 117 | ~190 | Yes |
| `triad.tasks.md` | 147 | ~260 | Yes |
| `triad.implement.md` | 112 | ~220 | Yes |
| `triad.clarify.md` | NEW | ~176 | Yes |
| `triad.analyze.md` | NEW | ~184 | Yes |
| `triad.checklist.md` | NEW | ~287 | Yes |
| `triad.constitution.md` | NEW | ~77 | Yes |

---

## Risk Mitigations

| Risk | Mitigation | Verification |
|------|------------|-------------|
| Content lost during transfer | Side-by-side diff of speckit vs merged triad per command | Logic preservation checklist per Phase 1 command |
| Merged files exceed 500 lines | Real-time line count during merge; deduplicate overlapping sections | `wc -l` on each merged file |
| Missed speckit references | Phase 0 audit + Phase 3 final grep | `grep -r "/speckit\." --include="*.md"` |
| Users confused by removal | Migration guide in CHANGELOG.md | Command mapping table with clear equivalents |
| Archive tag not created | Create tag as first action in Phase 3 | `git tag -l` verification |

---

## Implementation Order

```
Phase 0: Reference Audit
  └── Create reference-audit.md with file-by-file checklist

Phase 1: Inline Core Commands (sequential - each depends on previous for pattern consistency)
  ├── 1A: Merge speckit.specify → triad.specify
  ├── 1B: Merge speckit.plan → triad.plan
  ├── 1C: Merge speckit.tasks → triad.tasks
  └── 1D: Merge speckit.implement → triad.implement

Phase 2: Create New Commands (parallelizable)
  ├── 2A: Create triad.clarify from speckit.clarify
  ├── 2B: Create triad.analyze from speckit.analyze
  ├── 2C: Create triad.checklist from speckit.checklist
  └── 2D: Create triad.constitution from speckit.constitution

Phase 3: Delete, Update, Validate (sequential)
  ├── 3A: Archive tag creation
  ├── 3B: Delete 8 speckit files
  ├── 3C: Remove frontmatter metadata
  ├── 3D: Update all documentation references
  ├── 3E: Create migration guide (CHANGELOG.md)
  ├── 3F: Update PRD INDEX
  └── 3G: Final validation (grep, line count, command count)
```

---

## Deliverables

| Phase | Artifact | Path |
|-------|----------|------|
| 0 | Reference audit | `specs/004-remove-speckit-commands/reference-audit.md` |
| 1 | Merged triad.specify | `.claude/commands/triad.specify.md` |
| 1 | Merged triad.plan | `.claude/commands/triad.plan.md` |
| 1 | Merged triad.tasks | `.claude/commands/triad.tasks.md` |
| 1 | Merged triad.implement | `.claude/commands/triad.implement.md` |
| 2 | New triad.clarify | `.claude/commands/triad.clarify.md` |
| 2 | New triad.analyze | `.claude/commands/triad.analyze.md` |
| 2 | New triad.checklist | `.claude/commands/triad.checklist.md` |
| 2 | New triad.constitution | `.claude/commands/triad.constitution.md` |
| 3 | Archive tag | `v2.0.0-pre-speckit-removal` |
| 3 | Migration guide | `CHANGELOG.md` update |
| 3 | Updated docs | ~25 files across codebase |
