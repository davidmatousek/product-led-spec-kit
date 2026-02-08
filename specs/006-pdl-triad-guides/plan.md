---
triad:
  pm_signoff:
    agent: product-manager
    date: 2026-02-07
    status: APPROVED
    notes: "Full coverage of all spec requirements (FR-1 through FR-4, NFR-1 through NFR-4), complete user story traceability (US-001 through US-003), and zero scope creep. Two-wave sequential implementation order is appropriate for a documentation-only feature requiring cross-consistency. Both Architect concerns from PRD phase are explicitly resolved with concrete strategies."
  architect_signoff:
    agent: architect
    date: 2026-02-07
    status: APPROVED
    notes: "Technically sound and implementation-ready. Careful handling of merge strategy (Phase 3) and historical file preservation (Phase 4) fully resolves both PRD Architect concerns. Non-blocking suggestions: (1) monitor artifact example line counts during Phase 3 — 80-line estimate for 6 examples is achievable but tight; (2) consider adding link target verification to Phase 5 cross-validation."
  techlead_signoff: null  # Added by /triad.tasks
---

# Implementation Plan: PDL + Triad Guide Consolidation

**Feature**: 006-pdl-triad-guides
**Spec**: [spec.md](spec.md)
**PRD**: [006-pdl-triad-guides-2026-02-07.md](../../docs/product/02_PRD/006-pdl-triad-guides-2026-02-07.md)
**Research**: [research.md](research.md)
**Created**: 2026-02-07

---

## Technical Context

### Feature Type

**Documentation-only** — no code, no APIs, no data models, no database changes. All deliverables are markdown files in `docs/guides/`.

### Technology

- **Format**: Markdown with Unicode box-drawing characters (ASCII art)
- **Rendering**: Standard monospace fonts across Git platforms (GitHub, GitLab, Bitbucket) and terminals
- **Diagrams**: Unicode box-drawing (┌─┐│└├─┤┬┴┼), flow indicators (→, ↓, ═══▶, ▶), block fill (▓)

### Dependencies

| Dependency | Status | Notes |
|-----------|--------|-------|
| Existing `docs/guides/PDL_QUICKSTART.md` (152 lines) | Available | Content source for unified quickstart; to be deleted |
| Existing `docs/guides/PDL_TRIAD_LIFECYCLE.md` (205 lines) | Available | Base for enhancement; preserve existing content |
| CISO_Agent reference implementations | Available (read-only) | Proven templates for structure/format inspiration |
| PDL skill definitions (`.claude/skills/pdl-*/SKILL.md`) | Available | Verified command syntax source |
| `docs/SPEC_KIT_TRIAD.md` (357 lines) | Available | Triad deep reference; unchanged by this feature |

### Unknowns

None. All content sources, command syntax, and file structure are verified in research.md.

---

## Constitution Check

| Principle | Status | Notes |
|-----------|--------|-------|
| I. General-Purpose Architecture | PASS | Documentation is domain-agnostic, template-focused |
| III. Backward Compatibility | PASS | No system changes; markdown files only |
| VII. Definition of Done | PASS | Documentation-only; DoD exception applies (no deployment required) |
| IX. Git Workflow | PASS | Feature branch `006-pdl-triad-guides` in use |
| X. Product-Spec Alignment | PASS | PRD approved, spec approved with PM sign-off |

No constitution violations.

---

## Implementation Approach

### Strategy: Two-Wave Sequential Execution

This is a documentation-only feature with no code or infrastructure changes. The implementation is broken into two waves:

1. **Wave 1 — Write**: Create new files, enhance existing file
2. **Wave 2 — Cleanup**: Delete old file, verify references, cross-validate consistency

### Agent Assignment

Single agent execution (documentation writer). No parallel agent waves needed — the deliverables are interdependent (cross-references must be consistent).

---

## Phase 1: Create PDL_TRIAD_QUICKSTART.md (New File)

**Output**: `docs/guides/PDL_TRIAD_QUICKSTART.md` (~270 lines)
**Priority**: P0

### Content Structure

The unified quickstart combines PDL and Triad content into a single onboarding document. Structure based on CISO_Agent proven templates, adapted for this project's conventions.

```
1. Header + Version + Related links (cross-references)
2. Workflow Overview Diagram (unified PDL + Triad ASCII flow)
3. What is PDL? (2-3 sentences)
4. What is Triad? (2-3 sentences with roles)
5. Quick Start (fastest path: /pdl.run → /triad.prd → ... → /triad.implement)
6. PDL Command Reference Table (4 commands: /pdl.run, /pdl.idea, /pdl.score, /pdl.validate)
7. Triad Command Reference Table (6 commands: /triad.prd, /triad.specify, /triad.plan, /triad.tasks, /triad.implement, /triad.close-feature)
8. ICE Scoring Quick Reference (dimensions, anchors, priority tiers, auto-defer gate)
9. PDL → Triad Handoff (how backlog item becomes PRD with source traceability)
10. Triad Roles Summary (PM: What & Why, Architect: How, Team-Lead: When & Who)
11. Sign-off Requirements by Phase (table: phase → required sign-offs)
12. File Locations Reference (PDL and Triad artifact paths)
13. Troubleshooting (common issues and solutions)
14. Cross-references (lifecycle guide, infographic, SPEC_KIT_TRIAD.md)
```

### Content Sources

| Section | Primary Source | Adaptation Needed |
|---------|---------------|-------------------|
| Workflow diagram | CISO_Agent PDL_QUICKSTART.md + TRIAD_QUICKSTART.md | Merge PDL and Triad into single diagram |
| PDL commands | Existing `PDL_QUICKSTART.md` + skill definitions | Verify syntax, consolidate |
| Triad commands | `docs/SPEC_KIT_TRIAD.md` + CISO_Agent TRIAD_QUICKSTART.md | Adapt to this project's command format |
| ICE scoring | Existing `PDL_QUICKSTART.md` lines 46-69 | Reuse directly |
| Triad roles | Constitution Principle XI | Summarize concisely |
| Sign-off table | Spec Scenario 1 acceptance criteria | Format as table |
| Troubleshooting | CISO_Agent TRIAD_QUICKSTART.md | Adapt for this project |

### Acceptance Criteria Mapping

- [ ] All 13 content sections present (FR-1)
- [ ] Command syntax matches `.claude/skills/pdl-*/SKILL.md` (NFR-1)
- [ ] ICE scoring consistent with PDL skill definitions (NFR-1)
- [ ] Under ~270 lines (NFR-2)
- [ ] Cross-references use relative paths from `docs/guides/` (NFR-3)
- [ ] Version number and Related links at top (FR-1 metadata)

---

## Phase 2: Create PDL_TRIAD_INFOGRAPHIC.md (New File)

**Output**: `docs/guides/PDL_TRIAD_INFOGRAPHIC.md` (~160 lines)
**Priority**: P0

### Content Structure

Single continuous ASCII visual. Template: CISO_Agent `PDL_TRIAD_LIFECYCLE_INFOGRAPHIC.md` (154 lines).

```
1. Title + Version + Related links
2. Triad Roles Legend (PM, Architect, Team-Lead with authorities)
3. PDL Section
   - Idea → Score → Validate → Backlog flow boxes
   - ICE dimensions detail
   - Auto-defer gate visualization
4. Handoff Visual (═══ HANDOFF ═══ separator)
5. Triad Section
   - Phase 1: PRD (with triple sign-off gate)
   - Phase 2: Specify (with PM sign-off gate)
   - Phase 3: Plan (with dual sign-off gate)
   - Phase 4: Tasks (with triple sign-off gate)
   - Phase 5: Implement (with wave visualization)
   - Phase 6: Review & Deploy (with parallel validation)
6. Artifact Trail Summary (one-line chain)
```

### Adaptation from CISO_Agent Template

The CISO_Agent infographic is 154 lines — well within the 160-line target. Key adaptations:

| CISO_Agent Element | Adaptation |
|-------------------|------------|
| Role names (e.g., "head-honcho") | Use generic "PM" (no project-specific names) |
| Agent names (e.g., "backend-eng", "code-monkey") | Use generic agent role descriptions |
| Output paths (e.g., `docs/product/05_PRDs/`) | Use this project's paths (`docs/product/02_PRD/`) |
| Image reference (PNG link) | Remove — local-first, ASCII only (NFR-4) |

### Acceptance Criteria Mapping

- [ ] Complete PDL + Triad flow in one continuous visual (FR-2)
- [ ] All Triad sign-off gates shown at correct phases (FR-2)
- [ ] Auto-defer gate shown in PDL section (FR-2)
- [ ] Artifact trail visible (FR-2)
- [ ] Under ~160 lines (NFR-2)
- [ ] No narrative text — purely visual with labels (FR-2)
- [ ] Cross-reference links at top (NFR-3)

---

## Phase 3: Enhance PDL_TRIAD_LIFECYCLE.md (Existing File)

**Output**: Enhanced `docs/guides/PDL_TRIAD_LIFECYCLE.md` (~400 lines)
**Priority**: P1

### Merge Strategy

Preserve all existing 205 lines. Add enhancements within a ~195-line budget.

| Priority | Enhancement | Estimated Lines | Placement |
|----------|------------|----------------|-----------|
| P0 | Visual flow diagram at top | ~25 | After title, before "Complete Lifecycle Overview" |
| P0 | Cross-references (Related: links) | ~3 | At top, below title |
| P0 | Summary table (Stage → Artifact → Purpose → Owner) | ~20 | New section after "End-to-End Example" |
| P0 | Triad sign-off details per stage | ~30 | Inline additions to Stages 6-10 table and text |
| P1 | Concrete artifact examples (6 examples) | ~80 | Inline at each stage section |
| P1 | Commands-by-stage reference table | ~25 | New section before summary table |
| — | **Total estimated additions** | **~183** | Within 195-line budget |

### Preservation Rules

- **DO NOT** rewrite existing stage descriptions (Stages 1-10)
- **DO NOT** change the existing traceability model section
- **DO NOT** change the existing status flow diagrams
- **DO NOT** change the existing end-to-end example
- **ADD** new content inline or as new sections
- **ENHANCE** the Stages 6-10 table with sign-off column detail

### Acceptance Criteria Mapping

- [ ] Existing content preserved (FR-3)
- [ ] Visual flow diagram added at top (FR-3 enhancement 1)
- [ ] Triad sign-off details for applicable stages (FR-3 enhancement 2)
- [ ] At least 4 of 6 concrete artifact examples (FR-3 enhancement 3)
- [ ] Commands-by-stage reference table (FR-3 enhancement 4)
- [ ] Summary table present (FR-3 enhancement 5)
- [ ] Cross-references present (FR-3 enhancement 6)
- [ ] Under ~400 lines (NFR-2)

---

## Phase 4: File Cleanup

**Priority**: P0

### Actions

1. **Delete** `docs/guides/PDL_QUICKSTART.md`
2. **Search** for `PDL_QUICKSTART.md` references in active codebase files
3. **Update** active references to point to `PDL_TRIAD_QUICKSTART.md`
4. **DO NOT** modify historical files in `specs/005-*/` (per Architect concern)
5. **Evaluate** whether `CLAUDE.md` context discovery section should reference `PDL_TRIAD_QUICKSTART.md`

### Reference Analysis (from research.md)

| File | Type | Action |
|------|------|--------|
| `specs/005-*/spec.md` | Historical | DO NOT MODIFY |
| `specs/005-*/plan.md` | Historical | DO NOT MODIFY |
| `specs/005-*/tasks.md` | Historical | DO NOT MODIFY |
| `specs/005-*/research.md` | Historical | DO NOT MODIFY |
| `specs/005-*/agent-assignments.md` | Historical | DO NOT MODIFY |
| `docs/product/02_PRD/005-*.md` | Historical (PRD) | DO NOT MODIFY |
| `docs/product/_backlog/01_IDEAS.md` | Active, but self-describing | DO NOT MODIFY (describes the feature, not a link) |
| `specs/006-*/spec.md` | Current feature | Self-referencing, no update needed |
| `specs/006-*/research.md` | Current feature | Self-referencing, no update needed |
| `docs/product/02_PRD/006-*.md` | Current feature | Self-referencing, no update needed |

**Result**: Zero active references require updating. Cleanup risk is negligible.

### CLAUDE.md Evaluation

Current `CLAUDE.md` context discovery section does not reference `PDL_QUICKSTART.md`. No update needed. The guides are discoverable via `docs/guides/` directory.

---

## Phase 5: Cross-Validation

**Priority**: P0

### Consistency Checks

After all files are created/modified, verify:

1. **Command syntax**: All PDL commands (`/pdl.run`, `/pdl.idea`, `/pdl.score`, `/pdl.validate`) match across all three guides
2. **Triad commands**: All Triad commands match across all three guides
3. **File paths**: Artifact paths consistent across all three guides
4. **Terminology**: Same terms used (e.g., "Product Backlog" vs "Backlog" — pick one and use consistently)
5. **Cross-references**: Each guide links to the other two + `docs/SPEC_KIT_TRIAD.md`
6. **Line counts**: Verify each file is within target range
7. **Historical files**: Confirm `specs/005-*/` files are unchanged

### Verification Commands

```bash
# Line counts
wc -l docs/guides/PDL_TRIAD_QUICKSTART.md
wc -l docs/guides/PDL_TRIAD_LIFECYCLE.md
wc -l docs/guides/PDL_TRIAD_INFOGRAPHIC.md

# Old file deleted
ls docs/guides/PDL_QUICKSTART.md  # Should not exist

# Historical files unchanged
git diff specs/005-*/  # Should show no changes

# Cross-reference check
grep -l "PDL_TRIAD_QUICKSTART" docs/guides/PDL_TRIAD_LIFECYCLE.md docs/guides/PDL_TRIAD_INFOGRAPHIC.md
grep -l "PDL_TRIAD_LIFECYCLE" docs/guides/PDL_TRIAD_QUICKSTART.md docs/guides/PDL_TRIAD_INFOGRAPHIC.md
grep -l "PDL_TRIAD_INFOGRAPHIC" docs/guides/PDL_TRIAD_QUICKSTART.md docs/guides/PDL_TRIAD_LIFECYCLE.md
```

---

## Implementation Order

```
Wave 1 — Write (sequential, same agent)
├── Phase 1: Create PDL_TRIAD_QUICKSTART.md
├── Phase 2: Create PDL_TRIAD_INFOGRAPHIC.md
└── Phase 3: Enhance PDL_TRIAD_LIFECYCLE.md

Wave 2 — Cleanup & Validate (sequential, same agent)
├── Phase 4: Delete PDL_QUICKSTART.md + reference check
└── Phase 5: Cross-validate consistency across all three guides
```

### Rationale for Sequential Execution

All three guides must be cross-consistent (same commands, same paths, same terminology). Writing them sequentially ensures consistency without a reconciliation pass. The infographic structure also informs the quickstart overview diagram.

---

## Risk Mitigations

| Risk | Mitigation in Plan |
|------|-------------------|
| Guides become stale | Version numbers in each guide; command references link to skill definitions |
| Infographic exceeds size | CISO_Agent template is 154 lines; strict ~160 line cap |
| Lifecycle exceeds ~400 lines | P0/P1 prioritization; compact artifact examples; line budget tracked |
| Historical files modified | Explicit DO NOT MODIFY list; `git diff specs/005-*/` verification step |

---

## Deliverable Checklist

| # | Deliverable | Action | Target Lines | Phase |
|---|-------------|--------|-------------|-------|
| 1 | `docs/guides/PDL_TRIAD_QUICKSTART.md` | Create | ~270 | Phase 1 |
| 2 | `docs/guides/PDL_TRIAD_INFOGRAPHIC.md` | Create | ~160 | Phase 2 |
| 3 | `docs/guides/PDL_TRIAD_LIFECYCLE.md` | Enhance | ~400 | Phase 3 |
| 4 | `docs/guides/PDL_QUICKSTART.md` | Delete | N/A | Phase 4 |
| 5 | Cross-validation report | Verify | N/A | Phase 5 |

---

## Design Artifacts

### Not Applicable

This is a documentation-only feature. The following standard plan artifacts are **not applicable**:

- **data-model.md**: No data entities or database changes
- **contracts/**: No API contracts or endpoints
- **quickstart.md** (developer onboarding): No code to run — the deliverables *are* the quickstart guides

### Research

Research was completed during the spec phase. See [research.md](research.md) for findings on:
- Existing guide analysis
- CISO_Agent reference implementations
- ASCII art rendering compatibility
- Codebase reference analysis
- Architecture constraints
