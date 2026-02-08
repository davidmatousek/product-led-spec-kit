---
prd:
  number: 6
  topic: pdl-triad-guides
  created: 2026-02-07
  status: Approved
  type: feature
triad:
  pm_signoff:
    agent: product-manager
    date: 2026-02-07
    status: APPROVED
    notes: "Well-structured documentation quality initiative with clear user value, measurable deliverables, and tight scope. Three-file structure serves distinct user needs. Architect concerns appropriately deferred to spec phase."
  architect_signoff:
    agent: architect
    date: 2026-02-07
    status: APPROVED_WITH_CONCERNS
    notes: "Technically feasible and architecturally well-aligned. Two concerns for spec phase: (1) FR-4 reference update scope needs live-vs-historical distinction — historical specs/005-* should NOT be modified; (2) FR-3 lifecycle enhancement should define merge strategy for existing 206 lines to stay within ~400-line target."
  techlead_signoff:
    agent: team-lead
    date: 2026-02-07
    status: APPROVED
    notes: "Well-scoped documentation-only work, 3-5 hours realistic. Single agent can execute in two waves (write, then cleanup). Reference cleanup risk is negligible — zero active context files reference PDL_QUICKSTART.md. Lifecycle line target of ~400 may need flexibility."
source:
  idea_id: IDEA-001
  story_id: US-001
---

# PDL + Triad Guide Consolidation - Product Requirements Document

**Status**: Draft
**Created**: 2026-02-07
**Author**: product-manager
**Reviewers**: architect, team-lead
**Priority**: P1 (High)

---

## Executive Summary

### The One-Liner
Consolidate and enhance PDL + Triad documentation into three definitive guide files that cover the complete product discovery-to-delivery workflow.

### Problem Statement
Product-Led Spec Kit currently has two guide files in `docs/guides/` — `PDL_QUICKSTART.md` (PDL-only quickstart) and `PDL_TRIAD_LIFECYCLE.md` (lifecycle stages). These were created as initial documentation deliverables during PRD-005 (Product Discovery Lifecycle). However:

1. **No Triad quickstart**: There's no unified quickstart that covers both PDL discovery and Triad delivery in one document. Users must piece together the PDL quickstart and `docs/SPEC_KIT_TRIAD.md` (a reference doc, not a quickstart).
2. **No visual infographic**: The lifecycle guide contains inline ASCII diagrams but lacks a dedicated single-page visual reference that shows the complete flow at a glance.
3. **Fragmentation**: A separate PDL quickstart that doesn't cover Triad forces users to context-switch between documents to understand the end-to-end flow.

### Proposed Solution
Consolidate the existing two guides into three definitive files:

| # | File | Purpose |
|---|------|---------|
| 1 | `PDL_TRIAD_QUICKSTART.md` | Unified quickstart covering both PDL discovery and Triad delivery — the "start here" document |
| 2 | `PDL_TRIAD_LIFECYCLE.md` | Enhanced end-to-end lifecycle with stage-by-stage transformation details, traceability model, and status flows |
| 3 | `PDL_TRIAD_INFOGRAPHIC.md` | Single-page visual ASCII infographic — the "print this out" reference |

The existing `PDL_QUICKSTART.md` is replaced by the unified quickstart. The existing `PDL_TRIAD_LIFECYCLE.md` is enhanced in-place.

### Success Criteria
- Template adopters can understand the complete PDL → Triad flow from a single quickstart document
- The infographic provides a one-page visual reference of the entire workflow
- All three guides cross-reference each other with consistent terminology
- Existing `PDL_QUICKSTART.md` is removed (content absorbed into unified quickstart)

---

## Strategic Alignment

### Product Vision Alignment
Product-Led Spec Kit is a methodology template. Its value is directly proportional to the clarity of its documentation. Comprehensive, well-structured guides lower the barrier to adoption and reinforce the product-led development philosophy.

### Roadmap Fit
This is a documentation quality initiative that builds on PRD-005 (Product Discovery Lifecycle). PRD-005's FR-6 delivered initial guides; this PRD enhances them to production quality.

---

## Target Users & Personas

### Primary Persona: Template Adopter (Developer/Tech Lead)
- **Role**: Developer or tech lead evaluating or adopting Product-Led Spec Kit
- **Pain Points**: Must read multiple fragmented documents to understand the complete workflow; no visual quick-reference
- **Goals**: Quickly understand the end-to-end flow, have a printable reference, onboard team members efficiently
- **How This Helps**: Three focused documents serve distinct needs — getting started, deep understanding, and visual reference

---

## User Stories

### US-001: Unified Quickstart
**When** I'm getting started with Product-Led Spec Kit or onboarding a team member,
**I want to** read a single quickstart guide that covers both PDL discovery and Triad delivery,
**So I can** understand the complete workflow and start using the commands without switching between documents.

**Acceptance Criteria**:
- Given a user reads `PDL_TRIAD_QUICKSTART.md`, when they finish, then they understand both PDL commands (`/pdl.run`, `/pdl.idea`, `/pdl.score`, `/pdl.validate`) and Triad commands (`/triad.prd`, `/triad.specify`, `/triad.plan`, `/triad.tasks`, `/triad.implement`)
- Given the quickstart exists, when a user looks for `PDL_QUICKSTART.md`, then it no longer exists (content consolidated)
- Given the quickstart document, when reviewed, then it is under ~270 lines (concise, not a reference manual)

**Priority**: P0
**Effort**: S

### US-002: Visual Infographic Reference
**When** I want a quick visual overview of the complete workflow,
**I want to** see a single-page ASCII infographic showing all stages, sign-offs, and artifact flow,
**So I can** quickly reference the process without reading narrative documentation.

**Acceptance Criteria**:
- Given `PDL_TRIAD_INFOGRAPHIC.md` exists, when viewed, then it shows the complete PDL → Triad flow in ASCII art with Triad roles, sign-off gates, and artifact trail
- Given the infographic, when compared to existing ASCII diagrams in `PDL_TRIAD_LIFECYCLE.md`, then it is clearly differentiated as a single-page visual reference (not narrative)
- Given the infographic, when printed or viewed, then the complete flow fits in one visual scan

**Priority**: P0
**Effort**: S

### US-003: Enhanced Lifecycle Guide
**When** I want to deeply understand how an idea transforms through each stage,
**I want to** read a comprehensive lifecycle guide with stage-by-stage details,
**So I can** understand the complete traceability chain and how artifacts evolve.

**Acceptance Criteria**:
- Given `PDL_TRIAD_LIFECYCLE.md` exists, when reviewed, then it covers all stages from Idea Capture through Feature Delivery with concrete examples
- Given the lifecycle guide, when compared to the quickstart, then it provides significantly more detail (stage-by-stage transformation, example artifacts, status flow diagrams, traceability model)
- Given the lifecycle guide, when it references commands, then command syntax matches the actual skill definitions

**Priority**: P1
**Effort**: M

---

## Functional Requirements

### FR-1: PDL_TRIAD_QUICKSTART.md

**Description**: Unified quickstart covering both PDL discovery and Triad delivery.

**Content Requirements**:
- Workflow overview diagram (PDL + Triad in one visual)
- "What is PDL?" and "What is Triad?" brief descriptions
- Quick start with fastest path (`/pdl.run` → `/triad.prd` → through to `/triad.implement`)
- PDL command reference table with examples
- Triad command reference table with examples
- ICE scoring quick reference (anchors + tiers)
- PDL → Triad handoff explanation
- Triad roles summary (PM, Architect, Team-Lead)
- Sign-off requirements by phase
- File locations reference
- Troubleshooting section
- Cross-references to lifecycle and infographic guides

**Replaces**: `docs/guides/PDL_QUICKSTART.md`

### FR-2: PDL_TRIAD_INFOGRAPHIC.md

**Description**: Single-page visual ASCII infographic of the complete flow.

**Content Requirements**:
- Title banner
- Triad roles legend
- PDL section: Idea → Score → Validate → Backlog with auto-defer gate
- Handoff visual
- Triad section: PRD → Specify → Plan → Tasks → Implement with sign-off gates at each phase
- Review & Deploy phase with parallel validation
- Artifact trail summary (one-line showing all artifacts in order)
- Must be clearly differentiated from inline diagrams in the lifecycle guide — this is a standalone visual reference, not narrative

**Differentiation from lifecycle guide diagrams**: The lifecycle guide contains contextual diagrams within narrative sections. The infographic is a single continuous visual that shows the entire flow without narrative text — optimized for quick reference and wall-posting.

### FR-3: PDL_TRIAD_LIFECYCLE.md (Enhancement)

**Description**: Enhanced end-to-end lifecycle guide with stage-by-stage transformation.

**Current State**: Existing file has 206 lines covering stages, traceability, status flow, and end-to-end example.

**Enhancements**:
- Add visual flow diagram at top (matching quickstart overview style)
- Add Triad sign-off details per stage (which roles sign off at each stage)
- Add concrete artifact examples at each stage (example IDEAS.md row, example user story, example PRD frontmatter, example spec section, example plan section, example task)
- Add quick reference table: Commands by Stage (PDL commands and Triad commands side by side)
- Add summary table: Stage → Artifact → Purpose → Owner
- Ensure cross-references to quickstart and infographic

### FR-4: File Cleanup

**Description**: Remove the old `PDL_QUICKSTART.md` after consolidation.

**Actions**:
- Delete `docs/guides/PDL_QUICKSTART.md`
- Update any references to `PDL_QUICKSTART.md` in other files (search codebase)
- Ensure `PDL_TRIAD_QUICKSTART.md` is referenced in `CLAUDE.md` context discovery if appropriate

---

## Non-Functional Requirements

### NFR-1: Consistency
- All three guides must use consistent terminology for commands, artifact names, and file paths
- Command syntax must match actual skill definitions in `.claude/skills/`
- File paths must match actual project structure

### NFR-2: Readability
- Quickstart: Under ~270 lines, ~5 minute read
- Lifecycle: Under ~400 lines, ~8 minute read
- Infographic: Under ~160 lines, visual scan in under 1 minute

### NFR-3: Cross-Referencing
- Each guide must link to the other two at the top (Related: links)
- Each guide must link to the Triad reference (`docs/SPEC_KIT_TRIAD.md`) for deep dives

---

## Scope & Boundaries

### In Scope (This PRD)

**Must Have (P0)**:
- `PDL_TRIAD_QUICKSTART.md` — unified quickstart
- `PDL_TRIAD_INFOGRAPHIC.md` — visual ASCII infographic
- Removal of `PDL_QUICKSTART.md`
- Reference updates across codebase

**Should Have (P1)**:
- Enhanced `PDL_TRIAD_LIFECYCLE.md` with additional content
- Cross-reference links between all three guides

### Out of Scope

**Won't Have** - Explicitly excluded:
- Image/PNG versions of the infographic (ASCII only, per local-first principle)
- Video or interactive tutorials
- Changes to the underlying PDL or Triad command functionality
- New commands or skills
- Changes to `docs/SPEC_KIT_TRIAD.md` (that's the deep reference, not a guide)

### Assumptions
- The CISO_Agent reference implementations provide a proven structure to adapt
- ASCII art infographics are sufficient for the target audience (developers)
- Three files is the right number (not two, not four)

### Constraints
- **Local-first**: Markdown files only, no external dependencies
- **Template-only**: These are methodology guides, not application documentation
- **Existing content**: Must preserve the value of existing lifecycle content while enhancing it

---

## Risks & Dependencies

### Risks

**Risk 1**: Guides become stale as commands evolve
- **Likelihood**: Medium
- **Impact**: Medium
- **Mitigation**: Include command syntax references that link to skill definitions; add version number to each guide

**Risk 2**: Infographic is too large for ASCII rendering
- **Likelihood**: Low
- **Impact**: Low
- **Mitigation**: Cap at ~160 lines; use the CISO_Agent infographic as a proven template

### Dependencies

**Internal Dependencies**:
- PRD-005 (Product Discovery Lifecycle) — delivered, provides the PDL foundation
- Existing guide files in `docs/guides/`
- CISO_Agent reference implementations (read-only, for structure inspiration)

**External Dependencies**: None

---

## Open Questions

- [x] Should we have 2 or 3 files? → **3 files** (quickstart, lifecycle, infographic — each serves a distinct purpose)
- [x] Should we keep a separate TRIAD_QUICKSTART.md? → **No** — unified PDL_TRIAD_QUICKSTART.md covers both
- [ ] Should `docs/SPEC_KIT_TRIAD.md` reference the new guides? → Owner: PM, address during implementation

---

## References

### Source Material
- CISO_Agent PDL+Triad Lifecycle: `/Users/david/Projects/CISO_Agent/docs/guides/PDL_TRIAD_LIFECYCLE.md`
- CISO_Agent Infographic: `/Users/david/Projects/CISO_Agent/docs/guides/PDL_TRIAD_LIFECYCLE_INFOGRAPHIC.md`
- CISO_Agent PDL Quickstart: `/Users/david/Projects/CISO_Agent/docs/guides/PDL_QUICKSTART.md`
- CISO_Agent Triad Quickstart: `/Users/david/Projects/CISO_Agent/docs/guides/TRIAD_QUICKSTART.md`

### Product Documentation
- PRD-005: `docs/product/02_PRD/005-product-discovery-lifecycle-2026-02-07.md`
- Triad Reference: `docs/SPEC_KIT_TRIAD.md`
- Existing Guides: `docs/guides/PDL_QUICKSTART.md`, `docs/guides/PDL_TRIAD_LIFECYCLE.md`

### Backlog Traceability
- Idea: IDEA-001 (ICE: 24, P1)
- User Story: US-001 ("As a Template Adopter, I want a unified set of PDL + Triad guide documents...")

---

## Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-02-07 | product-manager | Initial PRD |
