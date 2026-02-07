# Research Summary: Remove SpecKit Commands & Transfer Content to Triad

## Knowledge Base Findings

- **No existing KB patterns** for command consolidation or skill removal found
- **PRD 004** (approved with all Triad sign-offs) provides comprehensive requirements
- **Architect review** (2026-02-07): Technically sound; recommends archive branch, merge validation checklist, 500-line threshold monitoring, v3.0.0 version bump
- **Team-Lead review** (2026-02-07): Feasible in 1.5 days; recommends Phase 0 reference audit, migration guide, logic preservation validation
- **Constitution** (Principle X, XI): References `/speckit.analyze` and `/speckit.prd` - must be updated

## Codebase Analysis

### Command Inventory

**8 Speckit Commands** (to be removed/merged):
| File | Lines | Type |
|------|-------|------|
| `speckit.specify.md` | 227 | Core (merge into triad.specify) |
| `speckit.plan.md` | 80 | Core (merge into triad.plan) |
| `speckit.tasks.md` | 128 | Core (merge into triad.tasks) |
| `speckit.implement.md` | 122 | Core (merge into triad.implement) |
| `speckit.clarify.md` | 176 | Support (create triad.clarify) |
| `speckit.analyze.md` | 184 | Support (create triad.analyze) |
| `speckit.checklist.md` | 287 | Support (create triad.checklist) |
| `speckit.constitution.md` | 77 | Support (create triad.constitution) |

**6 Existing Triad Commands** (to be modified):
| File | Lines | Type |
|------|-------|------|
| `triad.specify.md` | 179 | Core (will grow to ~400 lines) |
| `triad.plan.md` | 117 | Core (will grow to ~190 lines) |
| `triad.tasks.md` | 147 | Core (will grow to ~260 lines) |
| `triad.implement.md` | 112 | Core (will grow to ~220 lines) |
| `triad.prd.md` | 179 | No changes needed |
| `triad.close-feature.md` | 127 | No changes needed |

### Coupling Points (Skill Tool Invocations)
1. `triad.specify.md` line 91: `Invoke /speckit.specify using the Skill tool`
2. `triad.plan.md` line 30: `Invoke /speckit.plan using the Skill tool`
3. `triad.tasks.md` line 30: `Invoke /speckit.tasks using the Skill tool`

### Reference Scope
- **142 references** to `/speckit.` across **39 files**
- **9 command files** with `compatible_with_speckit` frontmatter markers
- **3 skill files** with speckit references (speckit-validator, prd-create, architecture-validator)

### Key Files to Update
- `CLAUDE.md` - Remove "Vanilla" section, add new triad commands
- `.claude/rules/commands.md` - Remove "Vanilla Commands" section
- `.claude/rules/governance.md` - Remove `/speckit.*` references
- `.claude/README.md` - 24 speckit references
- `.specify/memory/constitution.md` - 8 speckit references
- `docs/SPEC_KIT_TRIAD.md` - 5 speckit references
- `docs/standards/PRODUCT_SPEC_ALIGNMENT.md` - 13 speckit references
- `Makefile` - 7 speckit references
- `README.md` - 5 speckit references

## Architecture Constraints

- **Wrapper Pattern**: Triad commands currently wrap speckit via Skill tool invocations
- **Research Phase**: Only triad.specify includes mandatory research; speckit.specify does not
- **Frontmatter Metadata**: Triad commands inject sign-off tracking; speckit commands do not
- **Auto-invocation**: Triad commands auto-trigger agent reviews; speckit commands leave this manual
- **Template Dependencies**: Both command sets share `.specify/scripts/bash/` and `.specify/templates/`
- **500-line threshold**: Architect concern - merged files should stay under 500 lines

## Industry Research

- **Meshery CLI consolidation** (GitHub): Recommends shared reusable libraries over duplicated implementations for UX consistency
- **CLI best practices**: Consolidating duplicate command sets with flag standardization ensures consistent user experience
- **Duplicate command detection**: Best practice is to check for duplicates and exit with clear messaging

Sources:
- [Meshery CLI consolidation](https://github.com/meshery/meshery/issues/17079)
- [urfave/cli duplicate commands](https://github.com/urfave/cli/issues/785)

## Recommendations for Spec

1. **Phase the work carefully**: Phase 0 (audit) → Phase 1 (inline core) → Phase 2 (create new) → Phase 3 (delete + cleanup)
2. **Archive before deletion**: Create git tag/branch before removing speckit files
3. **Logic preservation validation**: Diff before/after for each merged command
4. **Monitor file sizes**: Keep merged triad commands under 500 lines each
5. **Update all 39 reference files** systematically using Phase 0 audit checklist
6. **Remove `compatible_with_speckit` frontmatter** from 9 command files
7. **Update constitution.md** to reference only triad commands
8. **Create migration guide** for users with muscle memory for speckit commands
9. **Consider v3.0.0 version bump** for this breaking change
