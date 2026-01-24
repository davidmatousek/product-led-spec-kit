# Quickstart: Claude Code Memory Features Enhancement

**Feature ID**: 001
**Date**: 2025-12-15

---

## Overview

This quickstart guide provides implementation instructions for the Claude Code Memory Features Enhancement.

---

## Prerequisites

- [ ] Product-Led Spec Kit repository cloned
- [ ] Current CLAUDE.md (192 lines) at repository root
- [ ] Claude Code installed and working
- [ ] Read spec.md, research.md, and data-model.md

---

## Phase 1: Create Rule Files Directory

### Step 1.1: Create Directory Structure

```bash
mkdir -p .claude/rules
```

### Step 1.2: Create Rule Files

Create 6 empty rule files:

```bash
touch .claude/rules/governance.md
touch .claude/rules/git-workflow.md
touch .claude/rules/deployment.md
touch .claude/rules/scope.md
touch .claude/rules/commands.md
touch .claude/rules/context-loading.md
```

### Step 1.3: Verify Structure

```bash
ls -la .claude/rules/
# Expected: 6 .md files
```

---

## Phase 2: Migrate Content to Rule Files

### Step 2.1: Extract Governance Content

**Source**: CLAUDE.md sections:
- "Governance Workflow (MANDATORY)"
- "SDLC Triad Workflow"

**Target**: `.claude/rules/governance.md`

**Content to include**:
- Sign-off requirements (PM, Architect, Team-Lead)
- Review outcomes (APPROVED, CHANGES_REQUESTED, BLOCKED)
- Triad collaboration workflow
- Validation gates

### Step 2.2: Extract Git Workflow Content

**Source**: CLAUDE.md section:
- "Git Workflow" (from Core Constraints or related)

**Target**: `.claude/rules/git-workflow.md`

**Content to include**:
- Feature branch policy
- Branch naming convention
- Commit standards
- PR requirements

### Step 2.3: Extract Deployment Content

**Source**: CLAUDE.md section:
- "Deployment Policy (MANDATORY)"

**Target**: `.claude/rules/deployment.md`

**Content to include**:
- DevOps agent policy
- Deployment verification requirements
- Environment-specific procedures

### Step 2.4: Extract Scope Content

**Source**: CLAUDE.md section:
- "Scope Boundaries"

**Target**: `.claude/rules/scope.md`

**Content to include**:
- What this project IS
- What this project IS NOT
- Project boundaries

### Step 2.5: Extract Commands Content

**Source**: CLAUDE.md section:
- "Commands" (Triad + Vanilla)

**Target**: `.claude/rules/commands.md`

**Content to include**:
- Triad commands list
- Vanilla commands list
- Command usage examples

### Step 2.6: Extract Context Loading Content

**Source**: CLAUDE.md section:
- "Context Loading (READ AS NEEDED)"

**Target**: `.claude/rules/context-loading.md`

**Content to include**:
- Session start reads
- Domain-specific context table
- Current feature context

---

## Phase 3: Refactor CLAUDE.md

### Step 3.1: Reduce CLAUDE.md

Transform each detailed section into:
1. Brief summary (1-2 lines)
2. @-reference to detailed rule file

**Example transformation**:

Before (30+ lines):
```markdown
## Governance Workflow (MANDATORY)

**CRITICAL**: After creating specs/plans/tasks, you MUST auto-trigger reviews...

| Artifact | Required Sign-offs | Agents to Invoke |
|----------|-------------------|------------------|
| spec.md | PM | product-manager |
...
```

After (3 lines):
```markdown
## Governance Workflow (MANDATORY)
Specs require PM sign-off. Plans require PM + Architect. Tasks require triple sign-off.
@.claude/rules/governance.md
```

### Step 3.2: Keep Inline Sections

**Sections to keep inline** (not moved to rule files):
- Project Structure (essential orientation)
- Key Principles (quick reference)
- Tips (project-specific)
- Tech Stack (project-specific)
- Recent Changes (project-specific)
- Active Technologies (project-specific)

### Step 3.3: Add @-references

Insert @-references after each section summary:

```markdown
## Core Constraints
@.claude/rules/governance.md

## Git Workflow
@.claude/rules/git-workflow.md

## Scope Boundaries
@.claude/rules/scope.md

## Commands
@.claude/rules/commands.md

## Context Loading
@.claude/rules/context-loading.md

## Deployment Policy
@.claude/rules/deployment.md
```

### Step 3.4: Verify Line Count

```bash
wc -l CLAUDE.md
# Target: ≤80 lines
```

---

## Phase 4: Create Migration Documentation

### Step 4.1: Create MIGRATION.md

Create `MIGRATION.md` at repository root with:
- Overview of modular structure
- Step-by-step migration instructions
- Before/after diff examples
- Validation steps
- Rollback instructions
- FAQ

---

## Phase 5: Validation

### Step 5.1: Verify All Files Exist

```bash
# Rule files
ls .claude/rules/{governance,git-workflow,deployment,scope,commands,context-loading}.md

# Main files
ls CLAUDE.md MIGRATION.md
```

### Step 5.2: Verify @-references Resolve

```bash
grep -o '@\.claude/rules/[a-z-]*\.md' CLAUDE.md | while read ref; do
  file="${ref#@}"
  if [ -f "$file" ]; then
    echo "OK: $file exists"
  else
    echo "FAIL: $file missing"
  fi
done
```

### Step 5.3: Verify Line Count

```bash
lines=$(wc -l < CLAUDE.md)
if [ "$lines" -le 80 ]; then
  echo "OK: CLAUDE.md is $lines lines (≤80)"
else
  echo "FAIL: CLAUDE.md is $lines lines (>80)"
fi
```

### Step 5.4: Verify Content Preservation

Manual check:
1. Open original CLAUDE.md (git show HEAD:CLAUDE.md)
2. Compare each section exists in either CLAUDE.md or rule files
3. Verify no information lost

### Step 5.5: Test @-reference Loading

1. Start new Claude Code session
2. Run `/memory` slash command
3. Verify rule files appear in loaded memory

---

## Implementation Checklist

### Phase 1: Directory Setup
- [ ] Create `.claude/rules/` directory
- [ ] Create 6 empty rule files
- [ ] Verify structure

### Phase 2: Content Migration
- [ ] Migrate governance content
- [ ] Migrate git-workflow content
- [ ] Migrate deployment content
- [ ] Migrate scope content
- [ ] Migrate commands content
- [ ] Migrate context-loading content
- [ ] Verify 100% content preservation

### Phase 3: CLAUDE.md Refactoring
- [ ] Add @-references
- [ ] Reduce sections to summaries
- [ ] Keep inline sections as-is
- [ ] Verify ≤80 lines

### Phase 4: Documentation
- [ ] Create MIGRATION.md
- [ ] Include examples
- [ ] Include rollback instructions

### Phase 5: Validation
- [ ] All files exist
- [ ] All @-references resolve
- [ ] Line count ≤80
- [ ] Content 100% preserved
- [ ] @-references load in Claude Code

---

## Common Issues

### Issue: @-reference Not Loading

**Symptom**: File content not appearing in context

**Cause**: @-reference inside code block or inline code

**Fix**: Move @-reference outside code blocks

### Issue: Line Count > 80

**Symptom**: CLAUDE.md exceeds target line count

**Cause**: Section summaries too long

**Fix**: Reduce summaries to 1-2 lines each

### Issue: Missing Content

**Symptom**: Some governance rules missing after migration

**Cause**: Content not copied to rule file

**Fix**: Compare original CLAUDE.md with rule files, add missing content

---

**End of Quickstart Guide**
