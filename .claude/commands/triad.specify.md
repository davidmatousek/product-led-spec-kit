---
description: Create feature specification with automatic PM sign-off - Streamlined v2
compatible_with_speckit: ">=1.0.0"
last_tested_with_speckit: "2.0.0"
---

## User Input

```text
$ARGUMENTS
```

Consider user input before proceeding (if not empty).

## Overview

Wraps `/speckit.specify` with automatic PM sign-off (Constitution Principle VIII: Product-Spec Alignment).

**Flow**: Validate PRD → **Research** → Generate spec → PM review → Handle blockers → Inject frontmatter

## Step 1: Validate Prerequisites

1. Get branch: `git branch --show-current` → must match `NNN-*` pattern
2. Find PRD: `docs/product/02_PRD/{NNN}-*.md` → must exist
3. Parse frontmatter: Verify all Triad sign-offs are APPROVED (or APPROVED_WITH_CONCERNS/BLOCKED_OVERRIDDEN)
4. If validation fails: Show error with required workflow order and exit

## Step 2: Research Phase

Before generating the specification, conduct research to ground the spec in reality. Run these **in parallel** using Task agents:

| Research Area | Agent/Tool | What to Find | Output |
|---------------|------------|--------------|--------|
| Knowledge Base | kb-query skill | Similar patterns, lessons learned, past bug fixes | Relevant KB entries |
| Codebase | Explore agent | Existing implementations, naming conventions, utilities | Similar features, patterns |
| Architecture | Read tool | Relevant architecture docs, constraints, dependencies | Technical constraints |
| Web Research | WebSearch tool | Industry best practices, existing solutions, common patterns | External references |

**Parallel Execution**: Launch all four research tasks simultaneously to minimize time.

**Research Prompt Template** (for Explore agent):
```
Research the codebase for the feature: {prd_title}

Find:
1. Similar features already implemented (patterns to follow)
2. Relevant utilities, helpers, or shared components
3. Naming conventions used for similar functionality
4. Any existing code that this feature might extend or integrate with

PRD context: {prd_path}
```

**Web Research Queries** (derive from PRD):
- "{feature_type} best practices {year}"
- "{feature_type} implementation patterns"
- "common {feature_type} user experience patterns"

**Output**: Create `specs/{NNN}-*/research.md` with findings:

```markdown
# Research Summary: {feature_name}

## Knowledge Base Findings
- [List relevant KB entries with links]
- Key lessons: ...

## Codebase Analysis
- Similar features: [list with file paths]
- Patterns to follow: ...
- Utilities to reuse: ...

## Architecture Constraints
- Relevant docs: [list with links]
- Key constraints: ...
- Dependencies: ...

## Industry Research
- Best practices: ...
- Common patterns: ...
- References: [links]

## Recommendations for Spec
- [Bullet points of what to include/avoid based on research]
```

**Pass research.md to Step 3** so `/speckit.specify` can use it as context.

## Step 3: Generate Specification

1. Invoke `/speckit.specify` using the Skill tool, passing `research.md` as context
2. Verify `spec.md` was created at `specs/{NNN}-*/spec.md`
3. If not created: Error and exit

## Step 4: PM Sign-off

Launch **one Task agent** for PM review:

| Agent | subagent_type | Focus | Key Criteria |
|-------|---------------|-------|--------------|
| PM | product-manager | Product alignment | PRD requirements covered, user stories, success criteria, no scope creep |

**Prompt template**:
```
Review spec.md at {spec_path} against PRD at {prd_path}.

Evaluate:
- Alignment with PRD requirements and scope
- Completeness (all PRD requirements addressed)
- User story coverage
- Success criteria clarity

Provide sign-off:
STATUS: [APPROVED | APPROVED_WITH_CONCERNS | CHANGES_REQUESTED | BLOCKED]
NOTES: [Your detailed feedback]
```

**Parse response**: Extract STATUS and NOTES from agent output.

## Step 5: Handle Review Results

**APPROVED/APPROVED_WITH_CONCERNS**: → Proceed to Step 5

**CHANGES_REQUESTED**:
1. Display PM feedback
2. Notify: "Update spec.md and re-run /triad.specify"
3. Still inject frontmatter with CHANGES_REQUESTED status

**BLOCKED**:
1. Display blocker with veto domain (PM=product scope)
2. Use AskUserQuestion with options:
   - **Resolve**: Address issues and re-run /triad.specify
   - **Override**: Provide justification (min 20 chars), mark as BLOCKED_OVERRIDDEN
   - **Abort**: Exit workflow

## Step 6: Inject Frontmatter

Add YAML frontmatter to spec.md (prepend to existing content):

```yaml
---
prd_reference: {prd_path}
triad:
  pm_signoff:
    agent: product-manager
    date: {YYYY-MM-DD}
    status: {pm_status}
    notes: "{pm_notes}"
  architect_signoff: null  # Added by /triad.plan
  techlead_signoff: null   # Added by /triad.tasks
---
```

## Step 7: Report Completion

Display summary:
```
✅ SPECIFICATION CREATION COMPLETE

Feature: {feature_number}
PRD: {prd_path}
Spec: {spec_path}

PM Sign-off: {pm_status}

Next: /triad.plan
```

## Quality Checklist

- [ ] Branch matches NNN-* pattern
- [ ] PRD exists with approved Triad sign-offs
- [ ] Research phase completed (KB, codebase, architecture, web)
- [ ] research.md created with findings
- [ ] spec.md created by /speckit.specify (informed by research)
- [ ] PM review completed
- [ ] Blockers handled (resolved, overridden, or aborted)
- [ ] Frontmatter injected with PM sign-off
- [ ] Completion summary displayed
