# Reference Audit: SpecKit Command References

**Feature**: 004-remove-speckit-commands
**Generated**: 2026-02-07
**Purpose**: Comprehensive inventory of all speckit references to drive cleanup phases

---

## Summary

| Category | File Count | Reference Count | Action |
|----------|------------|-----------------|--------|
| **Active - Command Files (speckit)** | 8 | Self-contained | DELETE after merge |
| **Active - Command Files (triad, Skill coupling)** | 3 | 3 coupling points | INLINE in Phase 3 |
| **Active - Command Files (frontmatter)** | 8 | 16 markers | REMOVE |
| **Active - Core Docs** | 3 | ~14 refs | UPDATE |
| **Active - Rules Files** | 3 | ~16 refs | UPDATE |
| **Active - Skill/Agent Files** | 4 | ~12 refs | UPDATE |
| **Active - Documentation** | 8 | ~30 refs | UPDATE |
| **Active - .claude/README.md** | 1 | ~12 refs | UPDATE |
| **Active - INFRASTRUCTURE_SETUP_SUMMARY** | 1 | ~3 refs | UPDATE |
| **Historical - specs/004-*** | 6 | ~170+ refs | PRESERVE (this feature's artifacts) |
| **Historical - PRD 004** | 1 | ~20 refs | PRESERVE |
| **Historical - specs/001-003** | 5 | ~8 refs | PRESERVE |
| **Historical - CHANGELOG.md** | 1 | ~2 refs (vanilla) | PRESERVE |
| **Historical - Architect reviews** | 2 | ~5 refs | PRESERVE |

---

## Active References (MUST UPDATE)

### Speckit Command Files (DELETE)

| File | Action |
|------|--------|
| `.claude/commands/speckit.specify.md` | DELETE after merge to triad.specify |
| `.claude/commands/speckit.plan.md` | DELETE after merge to triad.plan |
| `.claude/commands/speckit.tasks.md` | DELETE after merge to triad.tasks |
| `.claude/commands/speckit.implement.md` | DELETE after merge to triad.implement |
| `.claude/commands/speckit.clarify.md` | DELETE after copy to triad.clarify |
| `.claude/commands/speckit.analyze.md` | DELETE after copy to triad.analyze |
| `.claude/commands/speckit.checklist.md` | DELETE after copy to triad.checklist |
| `.claude/commands/speckit.constitution.md` | DELETE after copy to triad.constitution |

### Triad Command Files - Skill Tool Coupling (INLINE)

| File | Line | Reference | Action |
|------|------|-----------|--------|
| `.claude/commands/triad.specify.md` | 17 | `Wraps /speckit.specify` | UPDATE description |
| `.claude/commands/triad.specify.md` | 87 | `Pass research.md to Step 3 so /speckit.specify can use it` | INLINE logic |
| `.claude/commands/triad.specify.md` | 91 | `Invoke /speckit.specify using the Skill tool` | INLINE logic |
| `.claude/commands/triad.specify.md` | 175 | `spec.md created by /speckit.specify` | UPDATE reference |
| `.claude/commands/triad.plan.md` | 17 | `Wraps /speckit.plan` | UPDATE description |
| `.claude/commands/triad.plan.md` | 30 | `Invoke /speckit.plan using the Skill tool` | INLINE logic |
| `.claude/commands/triad.plan.md` | 113 | `plan.md created by /speckit.plan` | UPDATE reference |
| `.claude/commands/triad.tasks.md` | 17 | `Wraps /speckit.tasks` | UPDATE description |
| `.claude/commands/triad.tasks.md` | 30 | `Invoke /speckit.tasks using the Skill tool` | INLINE logic |
| `.claude/commands/triad.tasks.md` | 142 | `tasks.md created by /speckit.tasks` | UPDATE reference |

### Frontmatter Markers (REMOVE)

| File | Markers |
|------|---------|
| `.claude/commands/triad.specify.md` | `compatible_with_speckit`, `last_tested_with_speckit` |
| `.claude/commands/triad.plan.md` | `compatible_with_speckit`, `last_tested_with_speckit` |
| `.claude/commands/triad.tasks.md` | `compatible_with_speckit`, `last_tested_with_speckit` |
| `.claude/commands/triad.implement.md` | `compatible_with_speckit`, `last_tested_with_speckit` |
| `.claude/commands/triad.prd.md` | `compatible_with_speckit`, `last_tested_with_speckit` |
| `.claude/commands/triad.close-feature.md` | `compatible_with_speckit`, `last_tested_with_speckit` |
| `.claude/commands/continue.md` | `compatible_with_speckit`, `last_tested_with_speckit` |
| `.claude/commands/execute.md` | `compatible_with_speckit`, `last_tested_with_speckit` |

### Core Documentation (UPDATE)

| File | References | Details |
|------|------------|---------|
| `CLAUDE.md` | 2 | Line 8: `/speckit.analyze`; Line 42: Vanilla command list |
| `README.md` | 5 | Lines 161-165: Vanilla command table |
| `Makefile` | TBD | Check for speckit shortcuts |

### Rules Files (UPDATE)

| File | References | Details |
|------|------------|---------|
| `.claude/rules/commands.md` | 8 | Lines 10, 35-45: Vanilla section + 6 speckit commands |
| `.claude/rules/governance.md` | 4 | Lines 22, 35, 41, 48: `/speckit.specify`, `/speckit.plan`, `/speckit.tasks` |
| `.claude/rules/scope.md` | 2 | Lines 19, 34: Vanilla workflow references |

### Skill/Agent Files (UPDATE)

| File | References | Details |
|------|------------|---------|
| `.claude/skills/speckit-validator/SKILL.md` | 4 | Lines 116, 145, 148, 166: `/speckit.plan`, `/speckit.clarify` |
| `.claude/skills/architecture-validator/SKILL.md` | 1 | Line 132: `/speckit.tasks` |
| `.claude/skills/prd-create/skill.md` | 5 | Lines 37, 726, 887, 902, 905: `/speckit.specify`, `/speckit.analyze` |
| `.claude/agents/product-manager.md` | 5 | Lines 65, 120, 223-225: `/speckit.specify`, `/speckit.analyze`, `/speckit.clarify` |

### Documentation Files (UPDATE)

| File | References | Details |
|------|------------|---------|
| `.specify/memory/constitution.md` | 7 | Lines 415, 424-428, 632: speckit command references |
| `docs/SPEC_KIT_TRIAD.md` | 5 | Lines 242-245, 257-259, 276: Vanilla section + speckit commands |
| `docs/standards/PRODUCT_SPEC_ALIGNMENT.md` | 14 | Lines 40-92, 224, 394-397, 421, 436-439: speckit workflow refs |
| `docs/standards/TRIAD_COLLABORATION.md` | 2 | Lines 129, 405: `/speckit.specify`, `/speckit.prd` |
| `docs/product/02_PRD/INDEX.md` | 1 | Line 62: `/speckit.prd` |
| `docs/product/01_Product_Vision/README.md` | 1 | Line 119: `/speckit.specify` |
| `docs/devops/MIGRATION.md` | 1 | Line 372: `/speckit.analyze` |
| `.claude/README.md` | 12 | Lines 126-133, 174-177, 315: Vanilla section + speckit refs |
| `.claude/INFRASTRUCTURE_SETUP_SUMMARY.md` | 3 | Lines 314, 367: speckit command references |

### Vanilla Terminology (UPDATE)

| File | Lines | Action |
|------|-------|--------|
| `CLAUDE.md` | 41 | Remove "Vanilla" section |
| `README.md` | 155, 228 | Remove "Vanilla Commands" section |
| `.claude/rules/commands.md` | 10, 35, 37 | Remove Vanilla section |
| `.claude/rules/scope.md` | 19, 34 | Update to unified workflow |
| `.claude/README.md` | 120, 170, 315 | Remove Vanilla sections |
| `.claude/INFRASTRUCTURE_SETUP_SUMMARY.md` | 16, 181, 221, 226, 238, 405 | Update Vanilla references |
| `docs/SPEC_KIT_TRIAD.md` | 238 | Remove Vanilla section |
| `MIGRATION.md` | 99, 198, 210, 212, 729 | Historical - PRESERVE |

---

## Historical References (PRESERVE)

These files contain historical references that should NOT be modified:

| File | Reason |
|------|--------|
| `CHANGELOG.md` | Historical release notes |
| `MIGRATION.md` | Historical migration docs (lines 99, 198, 210, 212, 372, 729) |
| `specs/004-remove-speckit-commands/*` | This feature's own artifacts |
| `docs/product/02_PRD/004-remove-speckit-commands-*.md` | PRD for this feature |
| `specs/001-claude-code-memory/*` | Historical feature spec |
| `specs/002-anthropic-updates-integration/*` | Historical feature spec |
| `specs/003-agent-refactoring/*` | Historical feature spec |
| `docs/agents/architect/2026-02-07_*_ARCH.md` | Historical architect review |
| `docs/agents/architect/2025-12-15_*_ARCH.md` | Historical architect review |
| `docs/planning/STREAM_1_COMPLETION.md` | Historical planning doc |
| `docs/product/02_PRD/001-claude-code-memory-*.md` | Historical PRD |

---

## Checklist

- [X] T001: `/speckit.` references scanned (250+ matches across all files)
- [X] T002: Frontmatter markers inventoried (8 files, 16 markers)
- [X] T003: "Vanilla" terminology inventoried (30+ active references across ~8 files)
- [X] T004: All references categorized into historical/active/command
