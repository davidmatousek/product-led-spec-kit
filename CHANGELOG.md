# Changelog

All notable changes to Product-Led Spec Kit will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [3.0.0] - 2026-02-07

### BREAKING CHANGES

#### SpecKit Commands Removed — Unified Triad Workflow

All `/speckit.*` commands have been removed and consolidated into the `/triad.*` command set. The dual command architecture (Triad + Vanilla) has been replaced with a single, unified workflow.

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

### Added
- 4 new triad commands: `/triad.clarify`, `/triad.analyze`, `/triad.checklist`, `/triad.constitution`
- Archive tag `v2.0.0-pre-speckit-removal` preserves historical state

### Removed
- All 8 `/speckit.*` command files
- "Vanilla Commands" sections from all documentation
- `compatible_with_speckit` and `last_tested_with_speckit` frontmatter from all command files

### Changed
- 4 core triad commands now self-contained (no Skill tool coupling to speckit commands)
- All documentation, rules, skills, and agents reference only `/triad.*` commands
- CLAUDE.md updated with unified command set (10 triad commands)
- Renamed `speckit-validator` skill to `spec-validator` (removes speckit branding)

---

## [2.1.0] - 2026-01-31

### Added - Agent Refactoring (Feature 003)

**Agent Best Practices Documentation**
- Created `_AGENT_BEST_PRACTICES.md` with 8 core principles for agent design
- Created `_README.md` agent directory overview and quick reference

**Agent Refactoring**
- Refactored all 12 agents to consistent 8-section structure (58% line reduction)
- Split team-lead into team-lead + orchestrator (13 agents total)
- Standardized YAML frontmatter across all agents (version, changelog, boundaries, triad-governance)

**New Skill**
- Added thinking-lens skill for structured analysis methodologies

**Key Metrics**
- Tasks completed: 140
- Total agent line reduction: 58% (7,885 → ~3,300 lines)
- All 12 agents now follow standardized 8-section structure
- 100% YAML frontmatter standardization

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

| Feature | v1.0.0 | v1.1.0 | v2.0.0 | v2.1.0 | v3.0.0 |
|---------|--------|--------|--------|--------|--------|
| Command Set | Triad + Vanilla | Triad + Vanilla | Triad + Vanilla | Triad + Vanilla | Triad only (10 commands) |
| Triad Governance | Sequential | Sequential | Parallel | Parallel | Parallel |
| CLAUDE.md Size | 192 lines | 70 lines | 70 lines | 70 lines | ~80 lines |
| Context Loading | Manual | @-references | @-references | @-references | @-references |
| Version Detection | - | - | Automatic | Automatic | Automatic |
| Feature Flags | - | - | Supported | Supported | Supported |
| Degradation | - | - | Graceful | Graceful | Graceful |
| Agent Count | 13 | 13 | 13 | 13 (refactored) | 13 |
| Agent Line Reduction | - | - | - | 58% | 58% |
| Skill Tool Coupling | - | - | 3 cross-calls | 3 cross-calls | 0 (self-contained) |

---

[3.0.0]: https://github.com/davidmatousek/product-led-spec-kit/compare/v2.1.0...v3.0.0
[2.1.0]: https://github.com/davidmatousek/product-led-spec-kit/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/davidmatousek/product-led-spec-kit/compare/v1.1.0...v2.0.0
[1.1.0]: https://github.com/davidmatousek/product-led-spec-kit/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/davidmatousek/product-led-spec-kit/releases/tag/v1.0.0
