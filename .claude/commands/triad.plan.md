---
description: Create implementation plan with dual sign-off (PM + Architect) - Streamlined v2
compatible_with_speckit: ">=1.0.0"
last_tested_with_speckit: "2.0.0"
---

## User Input

```text
$ARGUMENTS
```

Consider user input before proceeding (if not empty).

## Overview

Wraps `/speckit.plan` with automatic PM + Architect dual sign-off.

**Flow**: Validate spec → Generate plan → Dual review (parallel) → Handle blockers → Inject frontmatter

## Step 1: Validate Prerequisites

1. Get branch: `git branch --show-current` → must match `NNN-*` pattern
2. Find spec: `specs/{NNN}-*/spec.md` → must exist
3. Parse frontmatter: Verify `triad.pm_signoff.status` is APPROVED (or APPROVED_WITH_CONCERNS/BLOCKED_OVERRIDDEN)
4. If validation fails: Show error with required workflow order and exit

## Step 2: Generate Plan

1. Invoke `/speckit.plan` using the Skill tool
2. Verify `plan.md` was created at `specs/{NNN}-*/plan.md`
3. If not created: Error and exit

## Step 3: Dual Sign-off (Parallel)

Launch **two Task agents in parallel** (single message, two Task tool calls):

| Agent | subagent_type | Focus | Key Criteria |
|-------|---------------|-------|--------------|
| PM | product-manager | Product alignment | Spec requirements covered, user stories, acceptance criteria, no scope creep |
| Architect | architect | Technical | Architecture sound, technology appropriate, security addressed, scalable |

**Prompt template for each** (customize focus area):
```
Review plan.md at {plan_path} for {FOCUS AREA}.

Read the file, then provide sign-off:

STATUS: [APPROVED | APPROVED_WITH_CONCERNS | CHANGES_REQUESTED | BLOCKED]
NOTES: [Your detailed feedback]
```

**Parse responses**: Extract STATUS and NOTES from each agent's output.

## Step 4: Handle Review Results

**All APPROVED/APPROVED_WITH_CONCERNS**: → Proceed to Step 5

**Any CHANGES_REQUESTED**:
1. Display feedback from reviewers who requested changes
2. Use architect agent to update plan addressing the feedback
3. Re-run reviews only for reviewers who requested changes
4. Loop until all approved or user aborts

**Any BLOCKED**:
1. Display blocker with veto domain (PM=product scope, Architect=technical)
2. Use AskUserQuestion with options:
   - **Resolve**: Address issues and re-submit to blocked reviewer
   - **Override**: Provide justification (min 20 chars), mark as BLOCKED_OVERRIDDEN
   - **Abort**: Cancel plan creation

## Step 5: Inject Frontmatter

Add YAML frontmatter to plan.md (prepend to existing content):

```yaml
---
triad:
  pm_signoff:
    agent: product-manager
    date: {YYYY-MM-DD}
    status: {pm_status}
    notes: "{pm_notes}"
  architect_signoff:
    agent: architect
    date: {YYYY-MM-DD}
    status: {architect_status}
    notes: "{architect_notes}"
  techlead_signoff: null  # Added by /triad.tasks
---
```

## Step 6: Report Completion

Display summary:
```
✅ IMPLEMENTATION PLAN COMPLETE

Feature: {feature_number}
Spec: {spec_path}
Plan: {plan_path}

Dual Sign-offs:
- PM: {pm_status}
- Architect: {architect_status}

Next: /triad.tasks
```

## Quality Checklist

- [ ] Spec has approved PM sign-off
- [ ] plan.md created by /speckit.plan
- [ ] Dual review executed in parallel
- [ ] Blockers handled (resolved, overridden, or aborted)
- [ ] Frontmatter injected with PM + Architect sign-offs
- [ ] Completion summary displayed
