# Fork Setup Instructions

**Purpose**: This document explains how to set up product-led-spec-kit as a fork of the upstream github/spec-kit repository and maintain synchronization.

---

## Overview

**product-led-spec-kit** is a specialized template that extends the base spec-kit repository with:
- Product-led governance principles
- SDLC Triad collaboration framework
- Templatized constitution for easy customization
- Product management workflows and documentation structure

**Relationship**:
- **Upstream**: `github/spec-kit` (base Spec Kit files and templates)
- **Fork**: `product-led-spec-kit` (this repository - adds product-led governance)

---

## Initial Fork Setup (One-Time)

### Step 1: Fork on GitHub

1. Navigate to: `https://github.com/spec-kit-ops/spec-kit`
2. Click "Fork" button (top-right)
3. Choose your GitHub account or organization
4. Rename fork to: `product-led-spec-kit`
5. Optional: Update description to "Product-led template with SDLC Triad governance"
6. Click "Create fork"

### Step 2: Clone Your Fork Locally

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/product-led-spec-kit.git
cd product-led-spec-kit

# Verify remote
git remote -v
# Should show:
# origin  https://github.com/YOUR_USERNAME/product-led-spec-kit.git (fetch)
# origin  https://github.com/YOUR_USERNAME/product-led-spec-kit.git (push)
```

### Step 3: Add Upstream Remote

```bash
# Add upstream spec-kit repository
git remote add upstream https://github.com/spec-kit-ops/spec-kit.git

# Verify remotes
git remote -v
# Should show:
# origin    https://github.com/YOUR_USERNAME/product-led-spec-kit.git (fetch)
# origin    https://github.com/YOUR_USERNAME/product-led-spec-kit.git (push)
# upstream  https://github.com/spec-kit-ops/spec-kit.git (fetch)
# upstream  https://github.com/spec-kit-ops/spec-kit.git (push)

# Fetch upstream branches
git fetch upstream
```

### Step 4: Set Up Main Branch Tracking

```bash
# Ensure main branch tracks upstream
git checkout main
git branch --set-upstream-to=upstream/main

# Verify tracking
git branch -vv
# Should show: main -> upstream/main
```

---

## Syncing with Upstream

### When to Sync

Sync with upstream when:
- Upstream spec-kit releases new templates or commands
- Upstream fixes bugs in core Triad functionality
- You want to pull in new features from base spec-kit
- Monthly maintenance (recommended schedule)

### How to Sync

```bash
# Step 1: Fetch latest upstream changes
git fetch upstream

# Step 2: Checkout main branch
git checkout main

# Step 3: Merge upstream changes
git merge upstream/main

# Step 4: Resolve conflicts (if any)
# - Keep product-led-spec-kit customizations
# - Accept upstream changes for core spec-kit files
# - See "File Ownership" section below

# Step 5: Push to your fork
git push origin main
```

### Handling Merge Conflicts

**Conflict Resolution Strategy**:

1. **Keep our version** (product-led-spec-kit customizations):
   - `.specify/memory/constitution.md` (templatized)
   - `docs/planning/FORK_SETUP.md` (this file)
   - `docs/product/` (product-led additions)
   - `.gitignore` (may have product-led additions)

2. **Accept upstream version** (core spec-kit files):
   - `.claude/` (agents, skills, commands from upstream)
   - `.specify/templates/` (spec-kit templates)
   - `docs/core_principles/` (core methodology)
   - README.md (base spec-kit README)

3. **Manual merge** (case-by-case):
   - CLAUDE.md (may have both upstream + product-led additions)
   - Makefile (may have product-led targets)

**Conflict Resolution Commands**:

```bash
# Keep our version
git checkout --ours path/to/file
git add path/to/file

# Accept upstream version
git checkout --theirs path/to/file
git add path/to/file

# Manual merge (open in editor)
git mergetool path/to/file
```

---

## File Ownership Matrix

| File/Directory | Owner | Sync Strategy | Rationale |
|----------------|-------|---------------|-----------|
| `.specify/memory/constitution.md` | product-led-spec-kit | KEEP OURS | Templatized constitution with product-led governance |
| `.claude/` | upstream | ACCEPT THEIRS | Core Triad agents, skills, commands |
| `.specify/templates/` | upstream | ACCEPT THEIRS | Base Triad templates |
| `docs/core_principles/` | upstream | ACCEPT THEIRS | Core methodology (Five Whys, DoD, etc.) |
| `docs/planning/FORK_SETUP.md` | product-led-spec-kit | KEEP OURS | Fork-specific documentation |
| `docs/product/` | product-led-spec-kit | KEEP OURS | Product-led additions |
| `docs/architecture/` | mixed | MANUAL MERGE | Upstream structure + product-led customizations |
| `README.md` | upstream | ACCEPT THEIRS | Base spec-kit README |
| `CLAUDE.md` | mixed | MANUAL MERGE | Upstream instructions + product-led additions |
| `.gitignore` | product-led-spec-kit | MANUAL MERGE | May have product-led additions |
| `Makefile` | mixed | MANUAL MERGE | Upstream targets + product-led targets |

---

## What We Add (product-led-spec-kit)

**Files We Own**:
1. `.specify/memory/constitution.md` - Templatized with `{{PLACEHOLDERS}}`
2. `docs/planning/FORK_SETUP.md` - This file
3. `docs/product/` - Product-led documentation structure
4. Template customization instructions in constitution

**Files We Customize** (but accept upstream updates):
1. `CLAUDE.md` - Add product-led workflow instructions
2. `.gitignore` - Add product-led ignores (if needed)
3. `Makefile` - Add product-led targets (if needed)

**What We Don't Touch** (pure upstream):
1. `.claude/agents/` - Upstream agents
2. `.claude/skills/` - Upstream skills
3. `.claude/commands/` - Upstream commands
4. `.specify/templates/` - Upstream templates
5. `docs/core_principles/` - Core methodology

---

## Testing Sync

After syncing, validate that:

```bash
# 1. Constitution is still templatized
grep "{{PROJECT_NAME}}" .specify/memory/constitution.md
# Should return matches (template variables intact)

# 2. Core principles are up-to-date
ls docs/core_principles/
# Should show latest upstream methodology files

# 3. Triad commands work
ls .claude/commands/
# Should show latest upstream commands

# 4. Product-led additions intact
ls docs/product/
# Should show product-led documentation structure

# 5. No unintended conflicts
git status
# Should show clean working tree
```

---

## Troubleshooting

### Problem: "Divergent branches" error

**Cause**: Local main has diverged from upstream

**Solution**:
```bash
# Option A: Rebase (clean history)
git rebase upstream/main

# Option B: Merge (preserve history)
git merge upstream/main
```

### Problem: Constitution lost template variables

**Cause**: Accidentally accepted upstream constitution

**Solution**:
```bash
# Restore our templatized version
git checkout origin/main -- .specify/memory/constitution.md
git add .specify/memory/constitution.md
git commit -m "fix: restore templatized constitution"
```

### Problem: Lost product-led customizations

**Cause**: Accepted upstream version for product-led files

**Solution**:
```bash
# Check what changed
git diff origin/main -- docs/product/

# Restore if needed
git checkout origin/main -- docs/product/
git add docs/product/
git commit -m "fix: restore product-led documentation"
```

---

## Maintenance Schedule

**Monthly Sync** (Recommended):
1. First week of each month
2. Fetch upstream changes
3. Review changelog/release notes
4. Merge and resolve conflicts
5. Test that template still works
6. Update version if needed

**On-Demand Sync**:
- When upstream releases critical bug fixes
- When upstream adds features we want
- Before creating new template instances

---

## Contributing Back to Upstream

If you discover improvements that benefit **all** Triad users (not just product-led):

1. Fork upstream spec-kit (separate from this fork)
2. Create feature branch
3. Make changes
4. Submit PR to upstream spec-kit
5. After upstream accepts, sync to product-led-spec-kit

**Examples of upstream contributions**:
- Bug fixes in core Triad templates
- Performance improvements in agents/skills
- New slash commands useful for all workflows

**NOT for upstream** (product-led specific):
- SDLC Triad governance framework
- Templatized constitution
- Product-led documentation structure

---

## References

- **Upstream Repository**: https://github.com/spec-kit-ops/spec-kit
- **GitHub Fork Documentation**: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks
- **Git Remote Documentation**: https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes

---

**Last Updated**: 2025-12-04
**Maintainer**: Architect Agent
**Version**: 1.0.0
