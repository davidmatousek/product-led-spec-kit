---
prd_reference: docs/product/02_PRD/006-pdl-triad-guides-2026-02-07.md
triad:
  pm_signoff:
    agent: product-manager
    date: 2026-02-07
    status: APPROVED
    notes: "High-quality spec covering all PRD requirements (FR-1 through FR-4, NFR-1 through NFR-3, US-001 through US-003). Both Architect concerns resolved — FR-4 live-vs-historical distinction explicit, FR-3 merge strategy with P0/P1 prioritization defined. NFR-4 (Local-First) and Scenario 4 (Cleanup) add value without scope creep. Success criteria measurable and traceable. Ready for planning."
  architect_signoff: null  # Added by /triad.plan
  techlead_signoff: null   # Added by /triad.tasks
---

# Feature Specification: PDL + Triad Guide Consolidation

**Status**: Draft
**Feature Number**: 006
**PRD Reference**: [006-pdl-triad-guides-2026-02-07.md](../../docs/product/02_PRD/006-pdl-triad-guides-2026-02-07.md)
**Created**: 2026-02-07
**Author**: Specification generated from PRD

---

## 1. Feature Overview

### 1.1 Problem Statement

Product-Led Spec Kit currently has two guide files in `docs/guides/`:

1. **PDL_QUICKSTART.md** (152 lines) — A PDL-only quickstart covering `/pdl.run`, `/pdl.idea`, `/pdl.score`, and `/pdl.validate`. It does not cover the Triad delivery workflow, forcing users to find `docs/SPEC_KIT_TRIAD.md` (a reference doc, not a quickstart) separately.
2. **PDL_TRIAD_LIFECYCLE.md** (205 lines) — An end-to-end lifecycle guide with stage-by-stage descriptions. It lacks concrete artifact examples, Triad sign-off details per stage, and a visual flow diagram at the top.

There is no single onboarding document that covers both PDL discovery and Triad delivery. There is no dedicated visual reference (infographic) that shows the complete workflow at a glance. Users must context-switch between multiple documents to understand the end-to-end flow from raw idea to shipped feature.

### 1.2 Proposed Solution

Consolidate the existing two guides into three definitive files, each serving a distinct user need:

| # | File | Purpose | Target |
|---|------|---------|--------|
| 1 | `PDL_TRIAD_QUICKSTART.md` | Unified "start here" document covering both PDL and Triad | ~270 lines, ~5 min read |
| 2 | `PDL_TRIAD_LIFECYCLE.md` | Enhanced lifecycle with artifact examples and sign-off details | ~400 lines, ~8 min read |
| 3 | `PDL_TRIAD_INFOGRAPHIC.md` | Single-page ASCII visual reference for quick scanning | ~160 lines, <1 min scan |

The existing `PDL_QUICKSTART.md` is replaced by the unified quickstart and deleted. The existing `PDL_TRIAD_LIFECYCLE.md` is enhanced in-place with additional content.

### 1.3 Target Users

**Primary**: Template Adopter (Developer/Tech Lead)
- Evaluating or adopting Product-Led Spec Kit for their project
- Needs to quickly understand the complete workflow from idea capture through feature delivery
- Wants a visual reference to share with team members or post on a wall
- Currently must read multiple fragmented documents to understand the end-to-end flow

---

## 2. User Scenarios & Testing

### Scenario 1: New User Onboarding

**Actor**: Template Adopter
**Goal**: Understand the complete PDL + Triad workflow from a single starting document

**Given** a user is new to Product-Led Spec Kit
**When** they open `docs/guides/PDL_TRIAD_QUICKSTART.md`
**Then** they understand what PDL is (discovery phase) and what Triad is (delivery phase)
**And** they see the complete workflow from idea capture through feature implementation
**And** they can find all PDL commands (`/pdl.run`, `/pdl.idea`, `/pdl.score`, `/pdl.validate`) with examples
**And** they can find all Triad commands (`/triad.prd`, `/triad.specify`, `/triad.plan`, `/triad.tasks`, `/triad.implement`) with descriptions
**And** they understand the ICE scoring framework (dimensions, anchors, priority tiers)
**And** they see how PDL hands off to Triad (backlog item → PRD with source traceability)
**And** they are pointed to the lifecycle guide and infographic for deeper understanding

**Acceptance Criteria**:
- Document covers both PDL and Triad commands in a single file
- ICE scoring reference includes quick-assessment anchors and priority tiers
- PDL → Triad handoff is explained with a clear example
- Cross-references to lifecycle guide and infographic are present
- Document is under ~270 lines

### Scenario 2: Quick Visual Reference

**Actor**: Template Adopter
**Goal**: See the complete workflow at a glance without reading narrative documentation

**Given** a user wants a quick visual overview of the PDL → Triad flow
**When** they open `docs/guides/PDL_TRIAD_INFOGRAPHIC.md`
**Then** they see a single continuous ASCII diagram showing all stages from idea capture through feature delivery
**And** they see Triad roles (PM, Architect, Team-Lead) with their authorities
**And** they see sign-off gates at each Triad phase
**And** they see the auto-defer gate in the PDL section
**And** the entire flow fits in one visual scan without scrolling through narrative text
**And** the artifact trail (IDEAS → User Stories → PRD → spec → plan → tasks → code) is visible

**Acceptance Criteria**:
- Complete PDL + Triad flow shown in ASCII art with box-drawing characters
- Triad roles legend included
- Sign-off gates visible at each applicable phase
- Auto-defer gate shown in PDL section
- Document is under ~160 lines
- No narrative text — purely visual with minimal labels

### Scenario 3: Deep Lifecycle Understanding

**Actor**: Template Adopter
**Goal**: Understand how an idea transforms through each stage with concrete examples

**Given** a user wants to deeply understand the stage-by-stage transformation
**When** they open `docs/guides/PDL_TRIAD_LIFECYCLE.md`
**Then** they see a visual flow diagram at the top showing the complete lifecycle
**And** each stage includes which Triad roles sign off
**And** each stage includes a concrete artifact example (what the output looks like)
**And** they can see a commands-by-stage reference table (PDL and Triad side by side)
**And** they can see a summary table mapping each stage to its artifact, purpose, and owner
**And** they are cross-referenced to the quickstart for onboarding and infographic for visual reference

**Acceptance Criteria**:
- Visual flow diagram present at top of document
- Triad sign-off details included for each relevant stage
- Concrete artifact examples provided (IDEAS.md row, user story, PRD frontmatter, spec section, plan section, task entry)
- Commands-by-stage reference table present
- Summary table (Stage → Artifact → Purpose → Owner) present
- Cross-references to quickstart and infographic present
- Document is under ~400 lines
- Existing lifecycle content preserved and enhanced, not replaced

### Scenario 4: Old Quickstart Removal

**Actor**: Template Adopter
**Goal**: Not encounter the outdated PDL-only quickstart

**Given** the unified quickstart `PDL_TRIAD_QUICKSTART.md` has been created
**When** a user searches the `docs/guides/` directory
**Then** `PDL_QUICKSTART.md` no longer exists (content consolidated into unified quickstart)
**And** any active codebase references to `PDL_QUICKSTART.md` point to the new unified quickstart
**And** historical references in completed feature specs (e.g., `specs/005-*/`) remain unchanged

**Acceptance Criteria**:
- `docs/guides/PDL_QUICKSTART.md` is deleted
- Active codebase references updated to point to `PDL_TRIAD_QUICKSTART.md`
- Historical/archived references in `specs/005-*/` are NOT modified (per Architect concern)

---

## 3. Functional Requirements

### FR-1: PDL_TRIAD_QUICKSTART.md (Unified Quickstart)

**Description**: A single onboarding document covering both PDL discovery and Triad delivery workflows.

**Replaces**: `docs/guides/PDL_QUICKSTART.md` (152 lines)

**Required Content Sections**:
1. Workflow overview diagram — PDL + Triad shown in one visual (ASCII art)
2. "What is PDL?" brief description — 2-3 sentences explaining the discovery phase
3. "What is Triad?" brief description — 2-3 sentences explaining the delivery phase with roles
4. Quick start — fastest path from idea to implementation (`/pdl.run` → `/triad.prd` → through `/triad.implement`)
5. PDL command reference table — all 4 commands with purpose, input, and output columns
6. Triad command reference table — all 5+1 commands (`/triad.prd`, `/triad.specify`, `/triad.plan`, `/triad.tasks`, `/triad.implement`, `/triad.close-feature`) with descriptions
7. ICE scoring quick reference — dimension anchors (High/Medium/Low), priority tiers, auto-defer gate
8. PDL → Triad handoff explanation — how a backlog item becomes a PRD with source traceability
9. Triad roles summary — PM (What & Why), Architect (How), Team-Lead (When & Who)
10. Sign-off requirements by phase table — which roles sign off at each Triad phase
11. File locations reference — where PDL and Triad artifacts are stored
12. Troubleshooting section — common issues and solutions
13. Cross-references — links to lifecycle guide, infographic, and `docs/SPEC_KIT_TRIAD.md`

**Metadata Requirements**:
- Version number (e.g., "Version: 1.0.0")
- Related links at top to other two guides

**Acceptance Criteria**:
- All 13 content sections present
- Command syntax matches actual skill definitions in `.claude/skills/pdl-*/SKILL.md`
- ICE scoring reference consistent with PDL skill definitions
- Document is under ~270 lines
- Cross-references use relative paths from `docs/guides/`

### FR-2: PDL_TRIAD_INFOGRAPHIC.md (Visual Reference)

**Description**: A single-page ASCII infographic showing the complete PDL → Triad flow — optimized for quick visual scanning.

**Required Content Sections**:
1. Title banner — clear heading identifying this as a visual reference
2. Triad roles legend — PM, Architect, Team-Lead with brief authority descriptions
3. PDL section — Idea → Score → Validate → Backlog flow with auto-defer gate visualization
4. Handoff visual — clear visual separator showing transition from PDL to Triad
5. Triad section — PRD → Specify → Plan → Tasks → Implement with sign-off gates at each phase
6. Review & Deploy phase — parallel validation indicators
7. Artifact trail summary — one-line showing the complete artifact chain in order

**Differentiation from Lifecycle Guide**: The lifecycle guide contains contextual diagrams within narrative text. The infographic is a standalone, continuous visual with no narrative text — optimized for quick reference, wall-posting, or screen-sharing.

**Visual Format Requirements**:
- Use Unicode box-drawing characters (┌─┐│└├─┤┬┴┼) for diagrams
- Use flow indicators (→, ↓, ═══▶) for direction
- Minimal text labels — just enough to identify each stage and gate
- No narrative paragraphs

**Acceptance Criteria**:
- Complete PDL + Triad flow visible in one continuous visual
- All Triad sign-off gates shown at correct phases
- Auto-defer gate shown in PDL section
- Artifact trail visible
- Document is under ~160 lines
- No narrative text — purely visual with labels
- Cross-reference links to quickstart and lifecycle at top

### FR-3: PDL_TRIAD_LIFECYCLE.md (Enhancement)

**Description**: Enhancement of the existing lifecycle guide (205 lines) with additional content while preserving current material.

**Current State**: 205 lines covering stages 1-10, traceability model, status flow diagrams, and an end-to-end example.

**Required Enhancements**:
1. **Visual flow diagram at top** — matching the quickstart overview style, showing complete PDL + Triad flow
2. **Triad sign-off details per stage** — which roles sign off at each stage (none for PDL stages, escalating for Triad stages)
3. **Concrete artifact examples** at each stage:
   - Stage 1 (Idea Capture): Example `01_IDEAS.md` table row
   - Stage 3 (PM Validation): Example user story in "As a... I want... so that..." format
   - Stage 5 (Triad Handoff): Example PRD frontmatter with `source` traceability fields
   - Stage 6 (Specify): Example spec.md section header structure
   - Stage 7 (Plan): Example plan.md architecture decision
   - Stage 8 (Tasks): Example task entry with wave assignment
4. **Commands-by-stage reference table** — PDL commands and Triad commands shown side by side mapped to each stage
5. **Summary table** — Stage → Artifact → Purpose → Owner mapping
6. **Cross-references** — links to quickstart and infographic at top

**Merge Strategy** (per Architect concern): Preserve existing 205 lines of valuable content. Add enhancements within a ~195-line budget to stay within the ~400-line target. Prioritize:
- P0: Visual flow diagram, sign-off details, cross-references, summary table
- P1: Artifact examples, commands-by-stage table (may use compact format if line budget is tight)

**Acceptance Criteria**:
- Existing content preserved (stage descriptions, traceability model, status flows, end-to-end example)
- Visual flow diagram added at top
- Triad sign-off details included for applicable stages
- At least 4 of 6 concrete artifact examples included
- Commands-by-stage reference table present
- Summary table present
- Cross-references present
- Document is under ~400 lines
- Content enhancements are accurate and consistent with quickstart and infographic

### FR-4: File Cleanup

**Description**: Remove the old PDL-only quickstart and update references.

**Actions**:
1. Delete `docs/guides/PDL_QUICKSTART.md`
2. Search for references to `PDL_QUICKSTART.md` in active codebase files
3. Update active references to point to `PDL_TRIAD_QUICKSTART.md`
4. **Do NOT modify historical/archived files** in `specs/005-*/` — these document completed work and must remain unchanged (per Architect concern)
5. Evaluate whether `CLAUDE.md` context discovery section should reference `PDL_TRIAD_QUICKSTART.md`

**Reference Scope**:
- Active references: 0 (per Tech-Lead assessment: "zero active context files reference PDL_QUICKSTART.md")
- Historical references: 21 (all in `specs/005-*/` and PRD/backlog tracking — NOT to be modified)

**Acceptance Criteria**:
- `docs/guides/PDL_QUICKSTART.md` no longer exists
- No active codebase references to the deleted file remain
- Historical references in `specs/005-*/` are preserved unchanged
- Reference update scope documented for verification

---

## 4. Non-Functional Requirements

### NFR-1: Consistency Across Guides

**Requirement**: All three guides must use identical terminology, command syntax, and file paths
**Measure**: Command references in all guides match actual skill definitions in `.claude/skills/pdl-*/SKILL.md`; file paths match actual project structure
**Verification**: Cross-compare command tables and file references across all three documents

### NFR-2: Readability Targets

**Requirement**: Each guide meets its line count and read time target
**Measure**:

| Document | Max Lines | Max Read Time |
|----------|----------|---------------|
| PDL_TRIAD_QUICKSTART.md | ~270 | ~5 minutes |
| PDL_TRIAD_LIFECYCLE.md | ~400 | ~8 minutes |
| PDL_TRIAD_INFOGRAPHIC.md | ~160 | <1 minute scan |

**Verification**: `wc -l` on each file; manual read-through timing

### NFR-3: Cross-Referencing

**Requirement**: Each guide links to the other two at the top, plus links to `docs/SPEC_KIT_TRIAD.md` for deep dives
**Measure**: "Related:" section present at top of each guide with correct relative paths
**Verification**: Check for presence of cross-reference links in each guide header

### NFR-4: Local-First

**Requirement**: All content is pure markdown with ASCII art — no external images, videos, or dependencies
**Measure**: Zero non-markdown content; ASCII diagrams use Unicode box-drawing characters that render in any monospace font
**Verification**: Files contain only markdown syntax and Unicode text characters

---

## 5. Success Criteria

### Primary Metrics

| Metric | Target | How to Measure |
|--------|--------|----------------|
| Unified quickstart created | `PDL_TRIAD_QUICKSTART.md` exists with all 13 required sections | File exists; sections verified |
| Infographic created | `PDL_TRIAD_INFOGRAPHIC.md` exists with complete visual flow | File exists; visual covers PDL + Triad |
| Lifecycle enhanced | `PDL_TRIAD_LIFECYCLE.md` updated with enhancements | Diff shows additions; existing content preserved |
| Old quickstart removed | `PDL_QUICKSTART.md` no longer exists | File absent from `docs/guides/` |
| Cross-references work | All three guides link to each other and to `SPEC_KIT_TRIAD.md` | Check "Related:" sections in each guide |
| Command syntax accurate | All commands match actual skill definitions | Compare command tables with `.claude/skills/pdl-*/SKILL.md` |

### Secondary Metrics

| Metric | Target | How to Measure |
|--------|--------|----------------|
| Line count compliance | Each guide within target range | `wc -l` on each file |
| Terminology consistency | Same terms used across all three guides | Manual cross-comparison |
| Historical files preserved | `specs/005-*/` files unchanged | `git diff` shows no changes in `specs/005-*/` |

### User Experience Outcomes

- A new user can understand the complete PDL → Triad flow by reading the quickstart alone (~5 minutes)
- The infographic provides a printable, wall-postable reference of the entire workflow
- The lifecycle guide serves as the definitive deep reference for stage-by-stage transformation
- Users no longer need to context-switch between a PDL-only quickstart and a separate Triad reference

---

## 6. Scope & Boundaries

### In Scope

**Must Have (P0)**:
- `PDL_TRIAD_QUICKSTART.md` — unified quickstart with all 13 sections
- `PDL_TRIAD_INFOGRAPHIC.md` — single-page ASCII visual reference
- Deletion of `PDL_QUICKSTART.md`
- Reference updates in active codebase files

**Should Have (P1)**:
- Enhanced `PDL_TRIAD_LIFECYCLE.md` with all 6 enhancement areas
- Cross-reference links between all three guides
- `CLAUDE.md` context discovery update (if appropriate)

### Out of Scope

- Image/PNG versions of the infographic (ASCII only, per local-first principle)
- Video or interactive tutorials
- Changes to the underlying PDL or Triad command functionality or skill definitions
- New commands or skills
- Changes to `docs/SPEC_KIT_TRIAD.md` (the deep reference, not a guide)
- Modification of historical files in `specs/005-*/`

### Assumptions

- The CISO_Agent reference implementations in `/Users/david/Projects/CISO_Agent/docs/guides/` provide proven templates to adapt
- ASCII art infographics using Unicode box-drawing characters render consistently in standard monospace fonts and terminals
- Three files is the right number — each serves a distinct user need (onboarding, deep understanding, visual reference)
- The existing lifecycle content (205 lines) is valuable and should be preserved during enhancement

### Dependencies

**Internal**:
- Existing guide files: `docs/guides/PDL_QUICKSTART.md`, `docs/guides/PDL_TRIAD_LIFECYCLE.md`
- PDL skill definitions: `.claude/skills/pdl-run/`, `pdl-idea/`, `pdl-score/`, `pdl-validate/`
- Triad reference: `docs/SPEC_KIT_TRIAD.md`
- CISO_Agent reference implementations (read-only, for structure inspiration)
- PRD-005 (Product Discovery Lifecycle) — delivered, provides PDL foundation

**External**: None

---

## 7. Key Entities

### Deliverable Inventory

| Deliverable | Action | Location | Line Target |
|-------------|--------|----------|-------------|
| `PDL_TRIAD_QUICKSTART.md` | Create (new) | `docs/guides/` | ~270 |
| `PDL_TRIAD_INFOGRAPHIC.md` | Create (new) | `docs/guides/` | ~160 |
| `PDL_TRIAD_LIFECYCLE.md` | Enhance (existing) | `docs/guides/` | ~400 |
| `PDL_QUICKSTART.md` | Delete | `docs/guides/` | N/A |

### Architect Concern Resolution

| Concern | Resolution |
|---------|------------|
| FR-4 reference update scope needs live-vs-historical distinction | FR-4 explicitly states: do NOT modify `specs/005-*/`. Only update active context files. Reference scope documented (0 active, 21 historical). |
| FR-3 lifecycle enhancement should define merge strategy for ~400-line target | FR-3 includes merge strategy with P0/P1 prioritization. P0 enhancements (diagram, sign-offs, cross-refs, summary table) fit within budget. P1 enhancements (artifact examples) may use compact format if needed. |

---

## 8. Risks & Mitigations

### Risk 1: Guides Become Stale as Commands Evolve

**Likelihood**: Medium | **Impact**: Medium
**Description**: Command syntax or workflow changes could make guide content inaccurate
**Mitigation**: Include version numbers in each guide for staleness tracking. Reference skill definitions by link rather than duplicating full command logic. Add "Last Updated" dates.

### Risk 2: Infographic Exceeds Readable Size

**Likelihood**: Low | **Impact**: Low
**Description**: The ASCII infographic may become too large to scan in under 1 minute
**Mitigation**: Cap at ~160 lines. Use the CISO_Agent infographic (~154 lines) as a proven template for size. Keep labels minimal — no narrative text.

### Risk 3: Lifecycle Enhancement Exceeds Line Target

**Likelihood**: Medium | **Impact**: Low
**Description**: Adding all 6 enhancement areas to the existing 205 lines may push beyond ~400 lines
**Mitigation**: Merge strategy defined in FR-3 with P0/P1 prioritization. Compact format for artifact examples (code block per example, not full-file reproductions). Team-Lead noted: "~400 may need flexibility."

---

## 9. Open Questions

- Should `docs/SPEC_KIT_TRIAD.md` add a "See Also" reference to the new guides? (Owner: PM, address during implementation)
