---
triad:
  pm_signoff:
    agent: product-manager
    date: 2026-02-07
    status: APPROVED
    notes: "All 7 functional requirements (FR-1 through FR-7) mapped to concrete implementation steps. All 5 user stories plus Scenario 6 traceable to specific plan phases. All 6 primary success criteria verifiable from deliverables. No scope creep detected. All 4 NFRs addressed with verification methods. Phase ordering logical with correct dependency accounting. All acceptance criteria from all 6 scenarios mapped to plan steps with validation checkpoints."
  architect_signoff:
    agent: architect
    date: 2026-02-07
    status: APPROVED
    notes: "Technically sound, well-structured, and implementation-ready. Correctly follows existing skill/command patterns. Complies with Anthropic Agent Skills standard. All skills well within 500-line limit. No security vulnerabilities. Passes all constitution checks. Scales adequately for 50-100 ideas. FR-5 integration is low-risk with proper backward compatibility. Two minor concerns addressed in plan: (1) error handling for missing story ID during status sync added to Phase 3.2B, (2) CLAUDE.md and commands.md registration added to Phase 4.5."
  techlead_signoff: null  # Added by /triad.tasks
---

# Implementation Plan: Product Discovery Lifecycle (PDL)

**Feature**: 005-product-discovery-lifecycle
**Spec Reference**: [spec.md](spec.md)
**PRD Reference**: [005-product-discovery-lifecycle-2026-02-07.md](../../docs/product/02_PRD/005-product-discovery-lifecycle-2026-02-07.md)
**Created**: 2026-02-07

---

## Technical Context

### Project Nature

This is a **methodology-only template** (no application code). All changes involve markdown skill files, command wrappers, documentation, and backlog table structures. No data models, API contracts, database schemas, or runtime code apply.

### Technology Stack

- **Files**: Markdown (`.md`) skill files, command wrappers, documentation, YAML frontmatter
- **Standards**: Anthropic Agent Skills open standard (SKILL.md frontmatter)
- **Tools**: Git (branching), product-manager agent (PM validation), AskUserQuestion (ICE scoring input)
- **No dependencies**: No package managers, build systems, or runtime code

### Architecture

Product-Led Spec Kit uses a skill/command architecture:

- **Skills** (`.claude/skills/*/SKILL.md`): Contain workflow logic, invoked by Claude agent
- **Commands** (`.claude/commands/*.md`): User-facing wrappers that orchestrate skills and agents
- **Pattern**: Skills define "how" (e.g., `prd-create`); commands define "when and with what governance" (e.g., `triad.prd`)

PDL follows the same pattern but with a lighter governance model:
- PDL commands invoke skill logic directly (no separate Triad wrapper needed)
- PM validation happens inside `/pdl.validate` and `/pdl.run` (not as a post-hoc review)
- No Architect or Team-Lead sign-off at the discovery stage

### Key Constraints

- **500-line threshold**: Each SKILL.md must stay under 500 lines (NFR-3)
- **Anthropic Agent Skills standard**: Only `name` and `description` in frontmatter; no `triggers`, `allowed-tools`, or non-standard fields
- **Single-user assumption**: No concurrent editing safeguards for markdown table ID generation (NFR-4)
- **PDL is optional**: Must not create a mandatory gate before `/triad.prd` (NFR-1)
- **Local-first**: All data in markdown files within the repository (NFR-2)
- **Existing backlog files preserved**: Individual backlog files are not deleted when consolidated tables are created (FR-7)

### Research Decisions

| Decision | Rationale | Alternatives Considered |
|----------|-----------|------------------------|
| Additive ICE scoring (I+C+E, max 30) | Simpler for lightweight discovery filter; consistent with source material; defensible simplification of standard multiplicative approach | Multiplicative (I×C×E) — standard but produces larger range (1-1000); overkill for a pre-filter |
| Auto-defer threshold at 12 | Catches unanimously weak ideas (Low/Low/Low=9); permissive by design — only filters ideas where all 3 dimensions score poorly | Higher threshold (15) — too aggressive, filters Medium combos; Lower (9) — only catches absolute minimum |
| Quick-assessment H(9)/M(6)/L(3) | Equal spacing (3-point intervals); clean tier boundaries; reduces friction vs full 1-10 scale | H(8)/M(5)/L(2) — unequal spacing; H(10)/M(5)/L(1) — extreme range |
| Command + Skill pattern (not command-only) | Follows existing `prd-create` → `triad.prd` pattern; separates reusable logic from user invocation | Command-only (no separate skill) — simpler but inconsistent with codebase patterns |
| User story format "As a... I want... so that..." | Industry-standard format; consistent with existing PRD user stories | Feature description format — simpler but less structured; Job Stories "When... I want... so that..." — less widely adopted |
| `02_USER_STORIES.md` (not `02_PRODUCT_BACKLOG.md`) | Better describes content (user stories, not generic backlog); distinguishes from existing individual backlog files | Source naming (`02_PRODUCT_BACKLOG.md`) — creates confusion with existing `_backlog/` directory purpose |

---

## Constitution Check

### Applicable Principles

| Principle | Status | Notes |
|-----------|--------|-------|
| I. General-Purpose Architecture | PASS | PDL is domain-agnostic; works for any project type with ICE scoring |
| III. Backward Compatibility | PASS | PDL is optional (NFR-1); existing workflows unaffected; no forced migration |
| VI. Testing Excellence | PASS | Manual end-to-end test of each command; success criteria defined in spec |
| VII. Definition of Done | PASS | 6 primary success metrics + 4 secondary metrics defined |
| IX. Git Workflow | PASS | Feature branch `005-product-discovery-lifecycle`; PR before merge |
| X. Product-Spec Alignment | PASS | PRD approved, spec approved with PM sign-off |
| XI. SDLC Triad Collaboration | PASS | Triad sign-off chain in progress; PDL is pre-Triad (PM-only governance) |

### Gates

- **No constitution violations detected**. PDL adds a new optional workflow without modifying existing governance.

---

## Phase 0: File Inventory & Dependency Map

**Goal**: Establish the complete list of deliverables and their dependencies.

### 0.1 New Files to Create

| # | File | Path | Depends On | Est. Lines |
|---|------|------|------------|------------|
| 1 | pdl-idea SKILL.md | `.claude/skills/pdl-idea/SKILL.md` | None | ~150 |
| 2 | pdl-score SKILL.md | `.claude/skills/pdl-score/SKILL.md` | None | ~100 |
| 3 | pdl-validate SKILL.md | `.claude/skills/pdl-validate/SKILL.md` | #1 (idea format) | ~200 |
| 4 | pdl-run SKILL.md | `.claude/skills/pdl-run/SKILL.md` | #1, #2, #3 | ~150 |
| 5 | pdl.idea.md command | `.claude/commands/pdl.idea.md` | #1 | ~40 |
| 6 | pdl.score.md command | `.claude/commands/pdl.score.md` | #2 | ~35 |
| 7 | pdl.validate.md command | `.claude/commands/pdl.validate.md` | #3 | ~40 |
| 8 | pdl.run.md command | `.claude/commands/pdl.run.md` | #4 | ~40 |
| 9 | 01_IDEAS.md | `docs/product/_backlog/01_IDEAS.md` | None | ~20 |
| 10 | 02_USER_STORIES.md | `docs/product/_backlog/02_USER_STORIES.md` | None | ~20 |
| 11 | PDL Quickstart | `docs/guides/PDL_QUICKSTART.md` | #1-#8 | ~120 |
| 12 | PDL+Triad Lifecycle | `docs/guides/PDL_TRIAD_LIFECYCLE.md` | #11 | ~150 |

### 0.2 Existing Files to Update

| File | Change | Depends On |
|------|--------|------------|
| `docs/product/_backlog/README.md` | Add PDL structure, migration guidance, preserve existing content | #9, #10 |
| `.claude/skills/prd-create/skill.md` | Add optional `source` frontmatter traceability fields (FR-5) | None |
| `.claude/commands/triad.prd.md` | Add PDL source detection + status update logic (FR-5) | prd-create update |
| `docs/product/02_PRD/INDEX.md` | Add spec link for feature 005 | None |
| `CLAUDE.md` | Register PDL commands in Commands section | None |
| `.claude/rules/commands.md` | Add PDL Commands section | None |

### 0.3 Dependency Graph

```
Phase 1: Foundation (parallelizable)
  ├── 01_IDEAS.md (backlog table template)
  ├── 02_USER_STORIES.md (backlog table template)
  └── ICE scoring logic (shared across skills)

Phase 2: Core Skills (sequential, each builds on previous)
  ├── pdl-idea SKILL.md (standalone)
  ├── pdl-score SKILL.md (shares ICE logic with pdl-idea)
  ├── pdl-validate SKILL.md (references idea format from pdl-idea)
  └── pdl-run SKILL.md (orchestrates idea + score + validate)

Phase 3: Commands & Integration (parallelizable after Phase 2)
  ├── pdl.idea.md command wrapper
  ├── pdl.score.md command wrapper
  ├── pdl.validate.md command wrapper
  ├── pdl.run.md command wrapper
  ├── prd-create skill update (source traceability)
  └── triad.prd command update (PDL handoff)

Phase 4: Documentation (parallelizable after Phase 3)
  ├── PDL_QUICKSTART.md
  ├── PDL_TRIAD_LIFECYCLE.md
  ├── _backlog/README.md update
  └── PRD INDEX update
```

---

## Phase 1: Foundation — Backlog Table Templates

**Goal**: Create the two backlog table files that all PDL commands will write to.

### 1.1 Create 01_IDEAS.md

**Path**: `docs/product/_backlog/01_IDEAS.md`

**Content**:
```markdown
# Ideas Backlog

| ID | Idea | Source | Date | Status | ICE Score |
|----|------|--------|------|--------|-----------|
```

**Notes**: Table starts empty. PDL commands append rows. Auto-created by any PDL command if missing (FR-7).

### 1.2 Create 02_USER_STORIES.md

**Path**: `docs/product/_backlog/02_USER_STORIES.md`

**Content**:
```markdown
# Product Backlog - User Stories

| Priority | Story ID | Story | ICE Score | Source | Status |
|----------|----------|-------|-----------|--------|--------|
```

**Notes**: Table starts empty. Only PM-validated ideas appear here. Auto-created by any PDL command if missing (FR-7).

### 1.3 Validation

- Both files exist at correct paths
- Table headers match spec FR-1 and FR-2 field definitions
- Existing individual backlog files are preserved (not deleted)

---

## Phase 2: Core Skills

**Goal**: Create the four PDL skill files with complete workflow logic.

### 2.1 pdl-idea SKILL.md (~150 lines)

**Path**: `.claude/skills/pdl-idea/SKILL.md`

**Frontmatter**:
```yaml
---
name: pdl-idea
description: "Capture a raw feature idea with ICE scoring into the Ideas Backlog. Use this skill when you need to capture ideas, log feature requests, record brainstorm output, or add items to the ideas backlog with ICE prioritization scoring."
---
```

**Core Logic**:
1. **Auto-create backlog files** if missing (FR-7): Check for `docs/product/_backlog/01_IDEAS.md`; create with header if absent
2. **Parse input**: Extract idea description from user arguments
3. **Generate ID**: Read `01_IDEAS.md`, find highest IDEA-NNN, increment by 1 (pad to 3 digits)
4. **Capture source**: Use AskUserQuestion to select one of: Brainstorm, Customer Feedback, Team Idea, User Request
5. **ICE scoring**: Present quick-assessment table using AskUserQuestion:
   - Impact: High(9) Transformative / Medium(6) Solid improvement / Low(3) Minor enhancement
   - Confidence: High(9) Proven pattern / Medium(6) Some unknowns / Low(3) Speculative
   - Effort (Ease): High(9) Days of work / Medium(6) Weeks of work / Low(3) Months of work
   - Allow custom numeric override (1-10) if user selects "Other"
6. **Compute total**: ICE Total = Impact + Confidence + Effort
7. **Apply auto-defer gate**: If total < 12, set status to "Deferred"; otherwise "Scoring"
8. **Append row** to `01_IDEAS.md` table with all fields
9. **Report**: Show idea ID, ICE breakdown, priority tier, and status

**ICE Scoring Reference** (shared section — duplicated in pdl-score):
```
Priority Tiers:
  25-30: P0 (Critical) — Fast-track to development
  18-24: P1 (High) — Queue for next sprint
  12-17: P2 (Medium) — Consider when capacity allows
  < 12:  Deferred — Auto-defer; requires PM override via /pdl.validate
```

### 2.2 pdl-score SKILL.md (~100 lines)

**Path**: `.claude/skills/pdl-score/SKILL.md`

**Frontmatter**:
```yaml
---
name: pdl-score
description: "Re-score an existing idea's ICE rating when circumstances change. Use this skill when you need to re-evaluate ideas, update ICE scores, change idea priority, or re-assess deferred ideas."
---
```

**Core Logic**:
1. **Parse input**: Extract IDEA-NNN identifier from user arguments
2. **Read 01_IDEAS.md**: Find the row matching the given ID
3. **Error if not found**: "IDEA-{NNN} not found in 01_IDEAS.md"
4. **Display current scores**: Show existing ICE breakdown and status
5. **New ICE scoring**: Present same quick-assessment table as pdl-idea (AskUserQuestion)
6. **Compute new total**: ICE Total = Impact + Confidence + Effort
7. **Update status**: If score crosses auto-defer threshold, update status accordingly:
   - Was "Deferred" + new score >= 12 → set to "Scoring"
   - Was "Scoring" + new score < 12 → set to "Deferred"
   - Preserve "Validated" status (already PM-approved)
8. **Update row in place**: Replace the existing table row (not append a new one)
9. **Update date**: Set date to current date
10. **Report**: Show old vs new ICE scores, tier change if any

### 2.3 pdl-validate SKILL.md (~200 lines)

**Path**: `.claude/skills/pdl-validate/SKILL.md`

**Frontmatter**:
```yaml
---
name: pdl-validate
description: "PM validation gate for ideas — approves or rejects ideas for the product backlog with user story generation. Use this skill when you need to validate ideas, promote to backlog, run PM review on ideas, generate user stories, or override auto-deferred ideas."
---
```

**Core Logic**:
1. **Auto-create backlog files** if missing (FR-7)
2. **Parse input**: Extract IDEA-NNN identifier from user arguments
3. **Read 01_IDEAS.md**: Find the row matching the given ID
4. **Error if not found** or if status is "Rejected" or "Validated"
5. **Launch PM validation**: Use Task tool with `product-manager` subagent_type:
   ```
   Review idea for product backlog inclusion:

   Idea: {idea_description}
   ICE Score: {total} (I:{impact} C:{confidence} E:{effort})
   Priority Tier: {tier}
   Status: {current_status}
   Auto-Deferred: {yes/no}

   Evaluate:
   1. Does this idea align with the product vision?
   2. Is the ICE scoring reasonable?
   3. Should this idea enter the product backlog?

   Provide:
   STATUS: [APPROVED | REJECTED]
   RATIONALE: [Your reasoning]
   ```
6. **If PM REJECTS**: Update idea status to "Rejected" in `01_IDEAS.md`, display rationale, exit
7. **If PM APPROVES**:
   a. **Generate user story**: Transform idea description into "As a [persona], I want [action], so that [benefit]" format
      - Default persona: "Template Adopter" if not evident from idea
      - Extract action from the idea description
      - Infer benefit from the context
   b. **Present for confirmation**: Show generated user story to user, allow editing
   c. **Generate US-NNN ID**: Read `02_USER_STORIES.md`, find highest US-NNN, increment by 1
   d. **Determine priority**: Map ICE score to priority rank (lower rank = higher priority)
   e. **Append to 02_USER_STORIES.md**: Add row with Priority, Story ID, Story, ICE Score, Source (IDEA-NNN), Status ("Ready for PRD")
   f. **Update 01_IDEAS.md**: Set idea status to "Validated"
   g. **If auto-deferred idea was approved**: Document PM override rationale in a note below the user stories table
8. **Report**: Show validation result, user story (if approved), and next step (`/triad.prd`)

### 2.4 pdl-run SKILL.md (~150 lines)

**Path**: `.claude/skills/pdl-run/SKILL.md`

**Frontmatter**:
```yaml
---
name: pdl-run
description: "Full product discovery flow in one command — captures idea, scores with ICE, validates with PM, and adds to product backlog. Use this skill when you need to run complete discovery, evaluate a new idea end-to-end, or go from raw idea to backlog-ready in one step."
---
```

**Core Logic**:
1. **Auto-create backlog files** if missing (FR-7)
2. **Run pdl-idea logic**: Capture idea, generate ID, get ICE score (inline — not via Skill tool invocation)
3. **Check auto-defer gate**:
   - If score < 12: Display auto-defer result with guidance: "Idea auto-deferred. Use `/pdl.validate IDEA-{NNN}` to request PM override."  **STOP flow here.**
   - If score >= 12: Continue to validation
4. **Run pdl-validate logic**: Launch PM validation, generate user story on approval (inline)
5. **Report**: Display complete flow summary:
   - Idea captured: IDEA-NNN
   - ICE Score: Total (I:n C:n E:n)
   - PM Validation: Approved/Rejected
   - User Story: US-NNN (if approved)
   - Next step: `/triad.prd {topic}` (if approved)

**Note**: pdl-run inlines the logic from pdl-idea and pdl-validate rather than invoking them via Skill tool. This avoids nested skill invocation complexity and keeps the flow seamless.

### 2.5 Validation After Phase 2

For each skill:
1. **Line count**: Verify < 500 lines
2. **Frontmatter**: Only `name` and `description` fields (Anthropic standard)
3. **No Skill tool calls within skills**: Skills contain logic, not skill invocations
4. **ICE scoring consistency**: Same thresholds, same tier definitions, same quick-assessment anchors across all 4 skills
5. **ID generation**: Same sequential IDEA-NNN and US-NNN logic

---

## Phase 3: Command Wrappers & Integration

**Goal**: Create command wrappers and add PDL → Triad handoff integration.

### 3.1 Command Wrappers (4 files)

Each command follows the existing pattern from `triad.prd.md`:

**Format** (shared across all 4):
```yaml
---
description: "{What the command does}"
---

## User Input

\```text
$ARGUMENTS
\```

Consider user input before proceeding (if not empty).

## Overview
{One-line description of the command flow}

## Step 1: {First major step}
...

## Quality Checklist
- [ ] ...
```

#### A. pdl.idea.md (~40 lines)

**Path**: `.claude/commands/pdl.idea.md`
**Description**: `Capture a new feature idea with ICE scoring into the Ideas Backlog`
**Flow**: Parse input → Invoke pdl-idea skill logic → Report result
**Key**: Command validates input is not empty, then delegates to skill

#### B. pdl.score.md (~35 lines)

**Path**: `.claude/commands/pdl.score.md`
**Description**: `Re-score an existing idea's ICE rating when circumstances change`
**Flow**: Parse IDEA-NNN → Invoke pdl-score skill logic → Report result
**Key**: Command validates IDEA-NNN format, then delegates to skill

#### C. pdl.validate.md (~40 lines)

**Path**: `.claude/commands/pdl.validate.md`
**Description**: `PM validation gate for ideas with user story generation`
**Flow**: Parse IDEA-NNN → Invoke pdl-validate skill logic → Report result
**Key**: Command validates IDEA-NNN format, then delegates to skill

#### D. pdl.run.md (~40 lines)

**Path**: `.claude/commands/pdl.run.md`
**Description**: `Full product discovery flow: capture, score, validate, and add to backlog in one step`
**Flow**: Parse idea description → Invoke pdl-run skill logic → Report result
**Key**: Command validates input is not empty, then delegates to skill

### 3.2 PDL → Triad Handoff (FR-5)

#### A. Update prd-create skill

**File**: `.claude/skills/prd-create/skill.md`

**Change**: Add optional source traceability section to PRD template structure:

In the PRD frontmatter template, after the existing fields, add:
```yaml
source:           # Optional — populated when PRD originates from PDL
  idea_id: null   # IDEA-NNN reference
  story_id: null  # US-NNN reference
```

Add a step in the PRD creation flow:
1. Check if `docs/product/_backlog/02_USER_STORIES.md` exists
2. If it exists and contains entries with status "Ready for PRD", present them to the user
3. If user selects a backlog item, populate `source.idea_id` and `source.story_id` in frontmatter
4. If user starts fresh (no backlog item), leave source fields as null

#### B. Update triad.prd command

**File**: `.claude/commands/triad.prd.md`

**Change**: After PRD is written (Step 6), add a substep:
1. If PRD frontmatter contains `source.story_id`, update the corresponding entry in `02_USER_STORIES.md`:
   - Change status from "Ready for PRD" to "In PRD"
   - If the story ID is not found in `02_USER_STORIES.md` (e.g., file was manually edited), skip gracefully with a warning message: "Warning: {story_id} not found in 02_USER_STORIES.md — status not updated"

### 3.3 Validation After Phase 3

1. All 4 command files exist in `.claude/commands/`
2. Each command has valid YAML frontmatter with `description`
3. prd-create skill includes optional source traceability
4. triad.prd updates user story status on PRD creation

---

## Phase 4: Documentation

**Goal**: Create guide documentation and update existing docs.

### 4.1 PDL Quickstart Guide (~120 lines)

**Path**: `docs/guides/PDL_QUICKSTART.md`

**Sections**:
1. **What is PDL?** — One-paragraph overview of Product Discovery Lifecycle
2. **Quick Start** — Run `/pdl.run "your idea"` example with expected output
3. **Commands Reference** — Table of all 4 commands with usage examples
4. **ICE Scoring Reference** — Quick-assessment table, tier definitions, auto-defer explanation
5. **File Structure** — Where PDL data lives (`01_IDEAS.md`, `02_USER_STORIES.md`)
6. **Common Workflows**:
   - Capture a quick idea: `/pdl.idea`
   - Full evaluation: `/pdl.run`
   - Promote a deferred idea: `/pdl.validate`
   - Re-evaluate when context changes: `/pdl.score`
7. **PDL → Triad Handoff** — How to move from backlog to `/triad.prd`
8. **Known Limitations** — Single-user assumption (NFR-4), no concurrent editing
9. **FAQ** — Is PDL mandatory? (No.) Can I skip ICE scoring? (No, it's part of the capture flow.)

### 4.2 PDL + Triad Lifecycle Guide (~150 lines)

**Path**: `docs/guides/PDL_TRIAD_LIFECYCLE.md`

**Sections**:
1. **Complete Lifecycle Overview** — ASCII flow diagram from idea to shipped feature
2. **Stage 1: Idea Capture** — What happens, what's stored, example
3. **Stage 2: ICE Scoring** — How scoring works, tiers, auto-defer
4. **Stage 3: PM Validation** — What PM reviews, approval/rejection
5. **Stage 4: Product Backlog** — User story format, priority, status
6. **Stage 5: Triad Handoff** — How backlog items become PRDs
7. **Stages 6-10: Triad Workflow** — Brief summary of PRD → spec → plan → tasks → implement
8. **Traceability Model** — How IDEA-NNN → US-NNN → PRD → spec → plan → tasks links work
9. **Status Flow Diagram** — Status transitions across all artifacts
10. **Example: End-to-End** — Trace a single idea from capture to delivery

### 4.3 Backlog README Update

**File**: `docs/product/_backlog/README.md`

**Changes**:
1. **Add PDL section** at the top explaining the new table-based backlog structure
2. **Preserve existing content** about individual backlog files
3. **Add migration guidance**: "Existing individual backlog files are preserved. New ideas should use `/pdl.idea` to add entries to `01_IDEAS.md`. You may optionally migrate existing individual files by running `/pdl.idea` for each and then archiving the original files."
4. **Update review cadence** to include PDL-specific guidance
5. **Document single-user assumption** (NFR-4)

### 4.4 PRD INDEX Update

**File**: `docs/product/02_PRD/INDEX.md`

**Change**: Add spec link for feature 005:
```markdown
| 005 | Product Discovery Lifecycle | [PRD](005-product-discovery-lifecycle-2026-02-07.md) | [Spec](../../specs/005-product-discovery-lifecycle/spec.md) | Approved |
```

### 4.5 Register PDL Commands

#### A. Update CLAUDE.md

**File**: `CLAUDE.md`

**Change**: Add PDL commands to the Commands section:
```markdown
**PDL workflow** (optional, before Triad):
- `/pdl.run` → `/pdl.idea` → `/pdl.score` → `/pdl.validate`
```

#### B. Update commands.md rule

**File**: `.claude/rules/commands.md`

**Change**: Add a new "PDL Commands" section after the Triad Commands section:
```markdown
### PDL Commands (Optional Discovery)

\```bash
/pdl.run <idea>            # Full discovery flow: capture → score → validate → backlog
/pdl.idea <idea>           # Capture idea + ICE scoring
/pdl.score IDEA-NNN        # Re-score an existing idea
/pdl.validate IDEA-NNN     # PM validation gate + user story generation
\```
```

### 4.7 Validation After Phase 4

1. All documentation files exist at correct paths
2. PDL Quickstart covers all 4 commands with examples
3. Lifecycle guide shows complete traceability chain
4. Backlog README preserves existing content and adds PDL structure
5. PRD INDEX updated with feature 005 entry
6. CLAUDE.md lists PDL commands in Commands section
7. `.claude/rules/commands.md` includes PDL Commands section

---

## Implementation Order

```
Phase 1: Foundation (parallelizable — 2 files)
  ├── 01_IDEAS.md table template
  └── 02_USER_STORIES.md table template

Phase 2: Core Skills (sequential — each builds on previous)
  ├── 2.1: pdl-idea SKILL.md (standalone)
  ├── 2.2: pdl-score SKILL.md (shares ICE pattern with pdl-idea)
  ├── 2.3: pdl-validate SKILL.md (references idea format, user story generation)
  └── 2.4: pdl-run SKILL.md (orchestrates all three)

Phase 3: Commands & Integration (parallelizable after Phase 2)
  ├── 3.1A: pdl.idea.md command
  ├── 3.1B: pdl.score.md command
  ├── 3.1C: pdl.validate.md command
  ├── 3.1D: pdl.run.md command
  ├── 3.2A: prd-create skill update (source traceability)
  └── 3.2B: triad.prd command update (status sync)

Phase 4: Documentation & Registration (parallelizable after Phase 3)
  ├── 4.1: PDL_QUICKSTART.md
  ├── 4.2: PDL_TRIAD_LIFECYCLE.md
  ├── 4.3: _backlog/README.md update
  ├── 4.4: PRD INDEX update
  ├── 4.5A: CLAUDE.md update (register PDL commands)
  └── 4.5B: commands.md update (register PDL commands)
```

---

## Size Estimates Summary

| Deliverable | Path | Est. Lines | Within 500-line Limit |
|-------------|------|------------|----------------------|
| pdl-idea SKILL.md | `.claude/skills/pdl-idea/SKILL.md` | ~150 | Yes |
| pdl-score SKILL.md | `.claude/skills/pdl-score/SKILL.md` | ~100 | Yes |
| pdl-validate SKILL.md | `.claude/skills/pdl-validate/SKILL.md` | ~200 | Yes |
| pdl-run SKILL.md | `.claude/skills/pdl-run/SKILL.md` | ~150 | Yes |
| pdl.idea.md | `.claude/commands/pdl.idea.md` | ~40 | N/A (commands) |
| pdl.score.md | `.claude/commands/pdl.score.md` | ~35 | N/A (commands) |
| pdl.validate.md | `.claude/commands/pdl.validate.md` | ~40 | N/A (commands) |
| pdl.run.md | `.claude/commands/pdl.run.md` | ~40 | N/A (commands) |
| 01_IDEAS.md | `docs/product/_backlog/01_IDEAS.md` | ~10 | N/A |
| 02_USER_STORIES.md | `docs/product/_backlog/02_USER_STORIES.md` | ~10 | N/A |
| PDL_QUICKSTART.md | `docs/guides/PDL_QUICKSTART.md` | ~120 | N/A |
| PDL_TRIAD_LIFECYCLE.md | `docs/guides/PDL_TRIAD_LIFECYCLE.md` | ~150 | N/A |

---

## Risk Mitigations

| Risk | Mitigation | Verification |
|------|------------|-------------|
| ICE scoring inconsistency across skills | Define ICE reference section once; duplicate identically in pdl-idea and pdl-score | Side-by-side comparison of ICE sections |
| User story generation produces awkward output | Present generated story for user confirmation before writing | Acceptance flow in pdl-validate step 7b |
| ID generation collision (single-user assumption) | Document limitation in Quickstart and README | NFR-4 verification in docs |
| PDL accidentally blocks /triad.prd | Source traceability is optional; null fields when no PDL origin | Test /triad.prd with no backlog files present |
| Merged backlog files confuse adopters with existing individual files | Migration guidance in README; preserve existing files | README update verification |
| Skill files exceed 500 lines | Size estimates with margin; monitor during implementation | `wc -l` on each SKILL.md |

---

## Deliverables

| Phase | Artifact | Path |
|-------|----------|------|
| 1 | Ideas table template | `docs/product/_backlog/01_IDEAS.md` |
| 1 | User stories table template | `docs/product/_backlog/02_USER_STORIES.md` |
| 2 | pdl-idea skill | `.claude/skills/pdl-idea/SKILL.md` |
| 2 | pdl-score skill | `.claude/skills/pdl-score/SKILL.md` |
| 2 | pdl-validate skill | `.claude/skills/pdl-validate/SKILL.md` |
| 2 | pdl-run skill | `.claude/skills/pdl-run/SKILL.md` |
| 3 | pdl.idea command | `.claude/commands/pdl.idea.md` |
| 3 | pdl.score command | `.claude/commands/pdl.score.md` |
| 3 | pdl.validate command | `.claude/commands/pdl.validate.md` |
| 3 | pdl.run command | `.claude/commands/pdl.run.md` |
| 3 | prd-create update | `.claude/skills/prd-create/skill.md` (modified) |
| 3 | triad.prd update | `.claude/commands/triad.prd.md` (modified) |
| 4 | PDL Quickstart | `docs/guides/PDL_QUICKSTART.md` |
| 4 | PDL+Triad Lifecycle | `docs/guides/PDL_TRIAD_LIFECYCLE.md` |
| 4 | Backlog README update | `docs/product/_backlog/README.md` (modified) |
| 4 | PRD INDEX update | `docs/product/02_PRD/INDEX.md` (modified) |
| 4 | CLAUDE.md update | `CLAUDE.md` (modified) |
| 4 | commands.md update | `.claude/rules/commands.md` (modified) |
