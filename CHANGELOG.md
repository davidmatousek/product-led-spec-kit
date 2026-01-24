# Changelog

All notable changes to Product-Led Spec Kit will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [2.0.0] - 2026-01-24

### Added - Anthropic Claude Code v2.1.16 Integration

**Parallel Triad Reviews**
- PM + Architect reviews now run simultaneously with context forking
- Triple sign-off (PM + Architect + Team-Lead) executes in parallel for tasks.md
- Review results merge automatically using severity ranking (Critical > Warning > Suggestion)

**Version Detection & Feature Flags**
- Automatic Claude Code version detection at session start
- Feature flags system (`.claude/config/feature-flags.json`) for capability management
- Graceful degradation for older Claude Code versions (sequential fallback)

**New Libraries**
- `.claude/lib/version/detect.sh` - Version detection utilities
- `.claude/lib/version/feature-gate.sh` - Feature gating logic
- `.claude/lib/version/degradation.sh` - Graceful fallback handling
- `.claude/lib/triad/merge-results.sh` - Parallel review result merging
- `.claude/lib/triad/timing-metrics.sh` - Performance measurement
- `.claude/lib/dependencies/` - Task dependency resolution system

**New Skills**
- `.claude/skills/triad/pm-review.md` - PM review skill for parallel execution
- `.claude/skills/triad/architect-review.md` - Architect review skill
- `.claude/skills/triad/teamlead-review.md` - Team-Lead review skill

**Documentation**
- `docs/devops/FEATURE_MATRIX.md` - Feature compatibility by Claude Code version
- `docs/devops/MIGRATION.md` - DevOps migration guide
- PRD-002: Anthropic Updates Integration specification

**Test Fixtures**
- `specs/002-anthropic-updates-integration/test-fixtures/` - Comprehensive test suite
  - Version detection tests
  - Parallel execution tests
  - Context forking tests
  - Degradation tests
  - Dependency resolution tests

### Changed
- Triad commands now auto-detect version and use parallel execution when available
- `_triad-init.md` command initializes version detection at session start
- Review workflows use isolated contexts to prevent cross-contamination

### Migration
See [MIGRATION.md](MIGRATION.md) for detailed upgrade instructions from v1.x to v2.0.0.

---

## [1.1.0] - 2025-12-15

### Added - Modular Rules System

**Modular Governance Rules**
- `.claude/rules/governance.md` - Sign-off requirements, Triad workflow
- `.claude/rules/git-workflow.md` - Branch naming, PR policies
- `.claude/rules/deployment.md` - DevOps agent policy
- `.claude/rules/scope.md` - Project boundaries
- `.claude/rules/commands.md` - Triad + Vanilla command reference
- `.claude/rules/context-loading.md` - Context loading guide

**Documentation**
- `MIGRATION.md` - Guide for customizing modular rules

### Changed
- Refactored CLAUDE.md from 192 to 70 lines using @-references
- Instant context loading (<1 second vs 5-10 seconds with manual `cat` commands)
- Topic-specific editing without merge conflicts

---

## [1.0.0] - 2025-12-04

### Added - Initial Release

**Core Governance**
- Product-led governance template
- SDLC Triad collaboration framework (PM + Architect + Tech-Lead)
- Templatized constitution with `{{PLACEHOLDERS}}` for easy customization

**Agents**
- 13 specialized agents for different roles
- Product Manager, Architect, Team-Lead, and implementation agents

**Skills**
- 8 automation capabilities
- PRD creation, specification, planning, task generation, implementation

**Commands**
- Triad commands with governance (sign-offs required)
- Vanilla commands for fast prototyping (no governance)

**Documentation**
- Constitution template (`.specify/memory/constitution.md`)
- Product documentation structure (`docs/product/`)
- Architecture documentation (`docs/architecture/`)
- Core principles (`docs/core_principles/`)

---

## Version Comparison

| Feature | v1.0.0 | v1.1.0 | v2.0.0 |
|---------|--------|--------|--------|
| Triad Governance | Sequential | Sequential | Parallel |
| CLAUDE.md Size | 192 lines | 70 lines | 70 lines |
| Context Loading | Manual | @-references | @-references |
| Version Detection | - | - | Automatic |
| Feature Flags | - | - | Supported |
| Degradation | - | - | Graceful |

---

[2.0.0]: https://github.com/davidmatousek/product-led-spec-kit/compare/v1.1.0...v2.0.0
[1.1.0]: https://github.com/davidmatousek/product-led-spec-kit/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/davidmatousek/product-led-spec-kit/releases/tag/v1.0.0
