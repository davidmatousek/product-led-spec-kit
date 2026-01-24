# Data Model: Claude Code Memory Features Enhancement

**Feature ID**: 001
**Date**: 2025-12-15
**Status**: Draft

---

## Entity Overview

This feature involves markdown file entities only. No database, API, or complex data structures are required.

---

## Entity 1: Rule File

**Description**: A focused markdown file containing governance rules for a single topic.

### Attributes

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| filename | string | Yes | Kebab-case name (e.g., `git-workflow.md`) |
| location | path | Yes | Always `.claude/rules/` |
| content | markdown | Yes | Topic-specific governance content |
| topic | enum | Yes | One of: governance, git-workflow, deployment, scope, commands, context-loading |

### File Structure

```
.claude/rules/
├── governance.md      # SDLC Triad, sign-off requirements, PM/Architect authority
├── git-workflow.md    # Branch naming, commit standards, PR policies
├── deployment.md      # DevOps agent policy, verification requirements
├── scope.md           # Project boundaries, what this is/isn't
├── commands.md        # Triad vs Vanilla command reference
└── context-loading.md # Context loading guide by domain
```

### Validation Rules

1. Filename must be kebab-case with `.md` extension
2. File must exist in `.claude/rules/` directory
3. Content must be valid CommonMark markdown
4. Each file covers exactly one topic (single responsibility)
5. No circular @-references within rule files

### State Transitions

Rule files are static content. No state machine.

| State | Description |
|-------|-------------|
| Active | File exists and is referenced by CLAUDE.md |
| Unreferenced | File exists but not imported (still works with modular rules auto-loading) |

---

## Entity 2: @-reference

**Description**: A syntax pattern that instructs Claude Code to load a file inline.

### Attributes

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| syntax | string | Yes | Format: `@path/to/file.md` |
| path | relative path | Yes | Path from repository root |
| target | Rule File | Yes | The file to load inline |

### Syntax Variants

| Variant | Example | Use Case |
|---------|---------|----------|
| Relative | `@.claude/rules/governance.md` | Standard rule file reference |
| Absolute | `@/path/to/file.md` | Absolute path reference |
| Home | `@~/.claude/custom.md` | User-specific rules |

### Validation Rules

1. Path must point to existing file
2. File must be markdown (`.md` extension)
3. Nesting depth ≤ 5 hops (Claude Code limit)
4. No circular references (A→B→A)
5. Not inside code blocks (excluded from evaluation)

### Error States

| Error | Cause | Recovery |
|-------|-------|----------|
| File Not Found | Referenced file doesn't exist | Create file or fix path |
| Circular Reference | A→B→A pattern detected | Remove circular import |
| Max Depth Exceeded | Nesting > 5 levels | Flatten import structure |

---

## Entity 3: CLAUDE.md

**Description**: The main agent context file at repository root.

### Attributes

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| location | path | Yes | Repository root (`./CLAUDE.md`) |
| format | markdown | Yes | CommonMark with @-references |
| line_count | integer | Target | ≤80 lines (reduced from 192) |
| sections | array | Yes | Core Constraints, Commands, Governance, etc. |

### Section Structure (Target ~80 lines)

| Section | Lines | @-reference |
|---------|-------|-------------|
| Header + Core Constraints | 10 | `@.claude/rules/governance.md` |
| Project Structure | 15 | None (inline for quick reference) |
| Scope Boundaries | 5 | `@.claude/rules/scope.md` |
| Commands | 10 | `@.claude/rules/commands.md` |
| SDLC Triad Workflow | 5 | (covered by governance.md) |
| Context Loading | 5 | `@.claude/rules/context-loading.md` |
| Governance Workflow | 5 | (covered by governance.md) |
| Deployment Policy | 5 | `@.claude/rules/deployment.md` |
| Git Workflow | 5 | `@.claude/rules/git-workflow.md` |
| Key Principles | 5 | None (inline for quick reference) |
| Tips + Tech Stack + Recent Changes | 10 | None (project-specific) |
| **Total** | **~80** | |

### Validation Rules

1. File must exist at repository root
2. Line count ≤ 80 after refactoring
3. All @-references resolve to existing files
4. 100% content preservation (no information loss)
5. All high-level sections preserved

---

## Entity 4: MIGRATION.md

**Description**: Documentation guide for users migrating from monolithic to modular structure.

### Attributes

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| location | path | Yes | Repository root (`./MIGRATION.md`) |
| format | markdown | Yes | Step-by-step guide |
| sections | array | Yes | Overview, Steps, Validation, Rollback, FAQ |

### Content Structure

| Section | Purpose |
|---------|---------|
| Overview | Explain benefits of migration |
| Prerequisites | What's needed before migrating |
| Migration Steps | Step-by-step instructions |
| Validation | How to verify migration succeeded |
| Rollback | How to revert if needed |
| Troubleshooting | Common issues and solutions |
| FAQ | Frequently asked questions |

---

## Relationships

```
┌─────────────────┐
│   CLAUDE.md     │
│  (80 lines)     │
└────────┬────────┘
         │ @-references
         ▼
┌─────────────────────────────────────────────────────┐
│              .claude/rules/                          │
├───────────────┬───────────────┬─────────────────────┤
│ governance.md │ git-workflow  │ deployment.md       │
│               │ .md           │                     │
├───────────────┼───────────────┼─────────────────────┤
│ scope.md      │ commands.md   │ context-loading.md  │
└───────────────┴───────────────┴─────────────────────┘
         │
         │ imports (optional nested)
         ▼
┌─────────────────┐
│ Other .md files │
│ (max 5 hops)    │
└─────────────────┘
```

---

## Content Mapping

### From CLAUDE.md → Rule Files

| Original Section | Target Rule File | Lines Moved |
|------------------|------------------|-------------|
| Governance Workflow (MANDATORY) | governance.md | ~30 lines |
| SDLC Triad Workflow | governance.md | ~20 lines |
| Git Workflow | git-workflow.md | ~10 lines (from Core Constraints) |
| Deployment Policy | deployment.md | ~15 lines |
| Scope Boundaries | scope.md | ~12 lines |
| Commands (Triad + Vanilla) | commands.md | ~30 lines |
| Context Loading | context-loading.md | ~25 lines |
| **Total Moved** | | **~142 lines** |

### Preserved in CLAUDE.md

| Section | Reason | Lines |
|---------|--------|-------|
| Core Constraints (summary) | Quick reference | 10 |
| Project Structure | Essential orientation | 15 |
| Key Principles | Quick reference | 5 |
| Tips | Project-specific | 5 |
| Tech Stack | Project-specific | 5 |
| Recent Changes | Project-specific | 5 |
| Active Technologies | Project-specific | 5 |
| **Total Preserved** | | **~50 lines** |

---

## Schema Validation

No database schema required. Validation is file-based:

```bash
# Validate rule files exist
ls .claude/rules/{governance,git-workflow,deployment,scope,commands,context-loading}.md

# Validate @-references resolve
grep -o '@\.claude/rules/[a-z-]*\.md' CLAUDE.md | while read ref; do
  file="${ref#@}"
  [ -f "$file" ] || echo "Missing: $file"
done

# Validate line count
wc -l CLAUDE.md  # Should be ≤ 80
```

---

## Migration Data Flow

```
┌────────────────────┐
│ CLAUDE.md (192)    │
│ (monolithic)       │
└─────────┬──────────┘
          │ Extract by section
          ▼
┌────────────────────────────────────────────┐
│ Temporary: Section content extracted       │
├────────────────────────────────────────────┤
│ • Governance → governance.md               │
│ • Git → git-workflow.md                    │
│ • Deploy → deployment.md                   │
│ • Scope → scope.md                         │
│ • Commands → commands.md                   │
│ • Context → context-loading.md             │
└─────────┬──────────────────────────────────┘
          │ Write to rule files
          ▼
┌────────────────────┐     ┌────────────────────┐
│ .claude/rules/*.md │     │ CLAUDE.md (80)     │
│ (6 files)          │◄────│ (with @-references)│
└────────────────────┘     └────────────────────┘
```

---

**End of Data Model**
