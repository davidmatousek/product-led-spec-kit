# Research Summary: PDL + Triad Guide Consolidation (006)

**Date**: 2026-02-07
**PRD**: [006-pdl-triad-guides-2026-02-07.md](../../docs/product/02_PRD/006-pdl-triad-guides-2026-02-07.md)

---

## Knowledge Base Findings

- No existing KB entries on documentation consolidation patterns (KB has 0/20 entries filled)
- Institutional Knowledge template (`docs/INSTITUTIONAL_KNOWLEDGE.md`) uses structured format: Date, Context, Problem, Solution, Why It Matters, Tags
- Project uses table-based documentation, cross-referencing patterns, and frontmatter sign-offs consistently
- ASCII box-drawing characters (┌─┐│└├─) used in `SPEC_KIT_TRIAD.md` and `PDL_TRIAD_LIFECYCLE.md` for workflow diagrams

## Codebase Analysis

### Existing Guide Files
- `docs/guides/PDL_QUICKSTART.md` (152 lines) — PDL-only quickstart; to be replaced
- `docs/guides/PDL_TRIAD_LIFECYCLE.md` (205 lines) — End-to-end lifecycle; to be enhanced
- `docs/SPEC_KIT_TRIAD.md` (357 lines) — Deep Triad reference; stays unchanged

### CISO_Agent Reference Implementations (proven templates)
- `PDL_QUICKSTART.md` (~270 lines) — Includes workflow diagram, PDL vs Triad comparison
- `TRIAD_QUICKSTART.md` (~271 lines) — Sign-off legend, command reference, troubleshooting
- `PDL_TRIAD_LIFECYCLE.md` (~394 lines) — Stage-by-stage with concrete artifact examples
- `PDL_TRIAD_LIFECYCLE_INFOGRAPHIC.md` (~154 lines) — ASCII infographic with box-drawing, roles legend, artifact trail

### PDL Skill Definitions (verified command syntax)
- `/pdl.run "<idea>"` — Full flow: capture → score → validate → backlog
- `/pdl.idea "<idea>"` — Capture + ICE score
- `/pdl.score IDEA-NNN` — Re-score existing idea
- `/pdl.validate IDEA-NNN` — PM validation gate + user story generation

### References to PDL_QUICKSTART.md
- 21 total references across codebase
- **Zero in active context files** — all in specs/005 (completed feature) and PRD/backlog tracking
- No CLAUDE.md reference to PDL_QUICKSTART.md
- Cleanup risk: negligible

## Architecture Constraints

- **Constitution Principle I**: Documentation must be domain-agnostic, template-focused
- **Constitution Principle VII (DoD)**: Documentation updates must be complete before marking done
- **Constitution Principle IX**: Feature branch workflow required (`006-pdl-triad-guides`)
- **Constitution Principle X**: Product-spec alignment with bi-directional traceability
- **Local-first**: Markdown/ASCII only, no external dependencies or images
- **Architect concern 1**: Historical specs/005-* should NOT be modified during reference cleanup
- **Architect concern 2**: Lifecycle enhancement needs merge strategy for ~400-line target (206 current + ~194 new)

### File Size Targets (NFR-2)
| Document | Target Lines | Read Time |
|----------|-------------|-----------|
| PDL_TRIAD_QUICKSTART.md | ~270 | ~5 min |
| PDL_TRIAD_LIFECYCLE.md | ~400 | ~8 min |
| PDL_TRIAD_INFOGRAPHIC.md | ~160 | <1 min scan |

## Industry Research

- ASCII art in markdown is well-supported across all Git platforms and terminals
- Box-drawing characters (Unicode) render consistently in monospace fonts
- Documentation best practices recommend no more than 3 heading levels
- Frontmatter metadata (title, version, date) is standard practice
- Git-based markdown documentation benefits from plain-text version control

## Recommendations for Spec

1. **Three distinct deliverables** — each serves a different user need (onboarding, deep understanding, visual reference)
2. **Enhance lifecycle in-place** — preserve existing 206 lines, add enhancements within ~194-line budget
3. **Use CISO_Agent infographic as template** — proven 154-line ASCII format with box-drawing characters
4. **Cross-reference all three guides** at top of each with `Related:` links
5. **Verify command syntax** against actual skill definitions before writing guides
6. **Only update active references** when deleting PDL_QUICKSTART.md — leave specs/005 historical files unchanged
7. **Include version numbers** in each guide for staleness tracking (Risk 1 mitigation)
8. **Differentiate clearly** between infographic (standalone visual, no narrative) and lifecycle diagrams (contextual within narrative)
