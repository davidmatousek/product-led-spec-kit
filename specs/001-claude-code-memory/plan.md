# Technical Plan: Claude Code Memory Features Enhancement

## Metadata

- **Feature ID**: 001
- **Feature Name**: Claude Code Memory Features Enhancement
- **Status**: Draft
- **Created**: 2025-12-15
- **Author**: architect
- **Spec Reference**: specs/001-claude-code-memory/spec.md
- **PRD Reference**: docs/product/02_PRD/001-claude-code-memory-features-2025-12-15.md
- **Priority**: P1
- **pm_signoff**: APPROVED
- **pm_signoff_date**: 2025-12-15
- **pm_signoff_notes**: Excellent plan with 100% spec fidelity. Clear phases, realistic timeline, measurable outcomes. User value well-articulated. Ready for task breakdown.
- **architect_signoff**: APPROVED
- **architect_signoff_date**: 2025-12-15
- **architect_signoff_notes**: Strong technical foundation leveraging Claude Code native @-syntax, constitutional compliance (Principles III, VI, VII, IX, X), clear design rationale, comprehensive validation strategy. No blocking issues.

---

## Technical Context

### Current State Analysis

**CLAUDE.md Today** (192 lines):
- Monolithic file at repository root
- All governance content inline
- Manual `cat` commands for context loading (5-10 seconds)
- Difficult to customize individual topics
- Merge conflicts when team edits different sections

**Pain Points**:
1. Large file hard to navigate
2. Manual context loading slow
3. Editing one topic risks breaking others
4. No clear separation of concerns

### Target State

**CLAUDE.md After** (~80 lines):
- High-level overview with @-references
- Modular rule files in `.claude/rules/`
- Instant context loading via @-syntax (<1 second)
- Topic-specific editing without merge conflicts
- Clean separation of concerns

### Technology Choices

| Component | Technology | Rationale |
|-----------|------------|-----------|
| File Format | Markdown (CommonMark) | Standard, supported by Claude Code |
| Reference Syntax | @-syntax | Native Claude Code support, instant loading |
| Directory | `.claude/rules/` | Follows Claude Code conventions |
| Nesting Depth | ≤3 (max 5 supported) | Maintainability, well under limit |

---

## Constitution Check

### Applicable Principles

| Principle | Status | Notes |
|-----------|--------|-------|
| III. Backward Compatibility | ✅ Compliant | Old CLAUDE.md pattern works unchanged |
| VII. Definition of Done | ✅ Compliant | Validation steps defined |
| IX. Git Workflow | ✅ Compliant | Feature branch workflow followed |
| X. Product-Spec Alignment | ✅ Compliant | Plan aligns with spec.md requirements |

### Validation Gates

- [ ] Backward compatibility verified (old pattern works)
- [ ] @-syntax tested and working
- [ ] Content 100% preserved
- [ ] Line count ≤80

---

## Architecture Overview

### Component Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                     Repository Root                          │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────────┐                                           │
│  │  CLAUDE.md   │ ─────────────────────────────────────┐    │
│  │  (~80 lines) │                                      │    │
│  └──────────────┘                                      │    │
│         │                                              │    │
│         │ @-references                                 │    │
│         ▼                                              │    │
│  ┌─────────────────────────────────────────────┐      │    │
│  │           .claude/rules/                     │      │    │
│  ├─────────────────────────────────────────────┤      │    │
│  │  ┌─────────────────┐  ┌─────────────────┐   │      │    │
│  │  │ governance.md   │  │ git-workflow.md │   │      │    │
│  │  │ (~50 lines)     │  │ (~20 lines)     │   │      │    │
│  │  └─────────────────┘  └─────────────────┘   │      │    │
│  │  ┌─────────────────┐  ┌─────────────────┐   │      │    │
│  │  │ deployment.md   │  │ scope.md        │   │      │    │
│  │  │ (~20 lines)     │  │ (~15 lines)     │   │      │    │
│  │  └─────────────────┘  └─────────────────┘   │      │    │
│  │  ┌─────────────────┐  ┌─────────────────┐   │      │    │
│  │  │ commands.md     │  │ context-loading │   │      │    │
│  │  │ (~35 lines)     │  │ .md (~30 lines) │   │      │    │
│  │  └─────────────────┘  └─────────────────┘   │      │    │
│  └─────────────────────────────────────────────┘      │    │
│                                                       │    │
│  ┌──────────────┐                                     │    │
│  │ MIGRATION.md │ ◄───────────────────────────────────┘    │
│  │ (guide)      │                                          │
│  └──────────────┘                                          │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Data Flow

```
┌─────────────────────────────────────────────────────────────┐
│                   Context Loading Flow                       │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Agent reads CLAUDE.md                                       │
│         │                                                    │
│         ▼                                                    │
│  Claude Code parses @-references                            │
│         │                                                    │
│         ├──► @.claude/rules/governance.md (inline)          │
│         ├──► @.claude/rules/git-workflow.md (inline)        │
│         ├──► @.claude/rules/deployment.md (inline)          │
│         ├──► @.claude/rules/scope.md (inline)               │
│         ├──► @.claude/rules/commands.md (inline)            │
│         └──► @.claude/rules/context-loading.md (inline)     │
│                                                              │
│  Total load time: <1 second                                 │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Implementation Phases

### Phase 1: Directory Setup (30 min)

**Objective**: Create modular rules directory structure

**Tasks**:
1. Create `.claude/rules/` directory
2. Create 6 empty rule files with headers

**Files Created**:
- `.claude/rules/governance.md`
- `.claude/rules/git-workflow.md`
- `.claude/rules/deployment.md`
- `.claude/rules/scope.md`
- `.claude/rules/commands.md`
- `.claude/rules/context-loading.md`

**Validation**:
```bash
ls .claude/rules/*.md | wc -l  # Should be 6
```

### Phase 2: Content Migration (4-6 hours)

**Objective**: Extract content from CLAUDE.md to rule files

**Content Mapping**:

| Source Section | Target File | Lines |
|----------------|-------------|-------|
| Governance Workflow (MANDATORY) | governance.md | ~30 |
| SDLC Triad Workflow | governance.md | ~20 |
| Git Workflow | git-workflow.md | ~10 |
| Deployment Policy (MANDATORY) | deployment.md | ~15 |
| Scope Boundaries | scope.md | ~12 |
| Commands (Triad + Vanilla) | commands.md | ~30 |
| Context Loading (READ AS NEEDED) | context-loading.md | ~25 |

**Validation**:
- Each rule file has focused, single-topic content
- Content is valid CommonMark markdown
- No content duplication across files

### Phase 3: CLAUDE.md Refactoring (2-3 hours)

**Objective**: Reduce CLAUDE.md to ~80 lines with @-references

**Transformation Pattern**:

Before:
```markdown
## Governance Workflow (MANDATORY)

**CRITICAL**: After creating specs/plans/tasks, you MUST auto-trigger reviews...
[30+ lines of detailed content]
```

After:
```markdown
## Governance Workflow (MANDATORY)
Specs require PM sign-off. Plans require PM + Architect. Tasks require triple sign-off.
@.claude/rules/governance.md
```

**Sections to Keep Inline**:
- Project Structure (essential orientation)
- Key Principles (quick reference)
- Tips (project-specific)
- Tech Stack (project-specific)
- Recent Changes (project-specific)
- Active Technologies (project-specific)

**Validation**:
```bash
wc -l CLAUDE.md  # Should be ≤80
```

### Phase 4: Migration Documentation (3-4 hours)

**Objective**: Create MIGRATION.md for template users

**Content**:
1. Overview and benefits
2. Prerequisites
3. Step-by-step migration guide
4. Before/after examples
5. Validation steps
6. Rollback instructions
7. FAQ

**Validation**:
- MIGRATION.md exists at repository root
- All steps are actionable
- Examples are clear and accurate

### Phase 5: Validation & Testing (2-3 hours)

**Objective**: Verify all requirements met

**Test Cases**:

| Test | Expected | Validation |
|------|----------|------------|
| Rule files exist | 6 files in .claude/rules/ | `ls .claude/rules/*.md \| wc -l` = 6 |
| CLAUDE.md line count | ≤80 lines | `wc -l CLAUDE.md` ≤ 80 |
| @-references resolve | All files exist | grep + file check |
| Content preserved | 100% fidelity | Manual comparison |
| @-syntax loads | Context appears | `/memory` command |

---

## Technical Decisions

### Decision 1: Rule File Organization

**Decision**: 6 files by topic domain

**Rationale**:
- Matches logical topic separation in current CLAUDE.md
- Each file has single responsibility
- Enables parallel editing without conflicts
- Scales well (can add more topics as needed)

**Alternatives Considered**:
1. Single rules.md file - defeats modularity purpose
2. Many granular files - over-engineering for current scope
3. Nested subdirectories - unnecessary complexity

### Decision 2: @-reference Placement

**Decision**: Place @-references after section summary

**Rationale**:
- Summary provides quick context
- @-reference provides full details
- Reader can choose depth

**Example**:
```markdown
## Governance Workflow (MANDATORY)
Specs require PM sign-off. Plans require PM + Architect. Tasks require triple sign-off.
@.claude/rules/governance.md
```

### Decision 3: Content Distribution

**Decision**: Keep project-specific content inline, move governance content to rules

**Rationale**:
- Project-specific content (Tech Stack, Recent Changes) varies per project
- Governance content is stable and reusable
- Inline content = quick reference
- Rule files = detailed reference

---

## Risk Mitigation

### Risk 1: @-syntax Issues

**Risk**: @-references don't load as expected

**Mitigation**:
- Research confirmed @-syntax is supported (research.md)
- Test with `/memory` command before deployment
- Fallback: Add cat command instructions if needed

### Risk 2: Content Loss

**Risk**: Some content lost during migration

**Mitigation**:
- Manual comparison of original vs new structure
- Validation script checks for completeness
- Git history preserves original for recovery

### Risk 3: User Confusion

**Risk**: Users don't understand new structure

**Mitigation**:
- Comprehensive MIGRATION.md guide
- Before/after examples
- FAQ section for common questions

---

## Success Criteria

| Criteria | Target | Measurement |
|----------|--------|-------------|
| CLAUDE.md line count | ≤80 lines | `wc -l CLAUDE.md` |
| Context load time | <1 second | Manual timing |
| Content preservation | 100% | Manual comparison |
| Rule files created | 6 files | `ls .claude/rules/*.md` |
| User task time | <30 seconds | Manual testing |
| Error handling | Clear messages | Test missing file scenario |

---

## Dependencies

### Internal Dependencies

| Dependency | Status | Notes |
|------------|--------|-------|
| spec.md | ✅ Complete | Feature requirements defined |
| research.md | ✅ Complete | @-syntax support confirmed |
| data-model.md | ✅ Complete | Entity structures defined |

### External Dependencies

| Dependency | Status | Notes |
|------------|--------|-------|
| Claude Code @-syntax | ✅ Supported | Confirmed in research |
| CommonMark markdown | ✅ Supported | Standard format |

---

## Implementation Order

1. **Phase 1**: Directory Setup (prerequisite for all)
2. **Phase 2**: Content Migration (depends on Phase 1)
3. **Phase 3**: CLAUDE.md Refactoring (depends on Phase 2)
4. **Phase 4**: Migration Documentation (parallel with Phase 2-3)
5. **Phase 5**: Validation & Testing (depends on Phase 2-3)

**Critical Path**: Phase 1 → Phase 2 → Phase 3 → Phase 5

**Parallel Opportunity**: Phase 4 can run alongside Phases 2-3

---

## Appendix: File Templates

### Rule File Template

```markdown
# {Topic Title}

## Overview
{1-2 sentence description of what this file covers}

## {Main Section}
{Detailed content from CLAUDE.md}

## {Additional Section}
{Additional content as needed}

---
{Optional references to other docs}
```

### Refactored CLAUDE.md Structure

```markdown
# CLAUDE.md - {{PROJECT_NAME}}

<!-- Generated by Product-Led-Spec-Kit -->

## Core Constraints
{4 bullet points - keep inline}

## Git Workflow
{Branch policy summary}
@.claude/rules/git-workflow.md

## Project Structure
{Directory tree - keep inline}

## Scope Boundaries
{Brief summary}
@.claude/rules/scope.md

## Commands
{Brief intro}
@.claude/rules/commands.md

## SDLC Triad Workflow
{Brief summary - detailed in governance.md}

## Context Loading
@.claude/rules/context-loading.md

## Governance Workflow (MANDATORY)
{Brief summary}
@.claude/rules/governance.md

## Deployment Policy (MANDATORY)
{Brief summary}
@.claude/rules/deployment.md

## Key Principles
{6 bullet points - keep inline}

## Tips
{Project-specific - keep inline}

## Tech Stack
{Project-specific - keep inline}

## Recent Changes
{Project-specific - keep inline}

## Active Technologies
{Project-specific - keep inline}
```

---

**End of Technical Plan**
