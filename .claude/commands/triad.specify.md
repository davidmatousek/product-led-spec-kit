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

**Flow**: Validate PRD → Generate spec → PM review → Handle blockers → Inject frontmatter

## Step 1: Validate Prerequisites

1. Get branch: `git branch --show-current` → must match `NNN-*` pattern
2. Find PRD: `docs/product/02_PRD/{NNN}-*.md` → must exist
3. Parse frontmatter: Verify all Triad sign-offs are APPROVED (or APPROVED_WITH_CONCERNS/BLOCKED_OVERRIDDEN)
4. If validation fails: Show error with required workflow order and exit

## Step 2: Generate Specification

1. Invoke `/speckit.specify` using the Skill tool
2. Verify `spec.md` was created at `specs/{NNN}-*/spec.md`
3. If not created: Error and exit

## Step 3: PM Sign-off

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

## Step 4: Handle Review Results

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

## Step 5: Inject Frontmatter

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

## Step 6: Report Completion

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
- [ ] spec.md created by /speckit.specify
- [ ] PM review completed
- [ ] Blockers handled (resolved, overridden, or aborted)
- [ ] Frontmatter injected with PM sign-off
- [ ] Completion summary displayed
