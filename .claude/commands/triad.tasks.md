---
description: Generate tasks with triple sign-off (PM + Architect + Team-Lead) - Streamlined v2
compatible_with_speckit: ">=1.0.0"
last_tested_with_speckit: "2.0.0"
---

## User Input

```text
$ARGUMENTS
```

Consider user input before proceeding (if not empty).

## Overview

Wraps `/speckit.tasks` with automatic Triad triple sign-off.

**Flow**: Validate plan → Generate tasks → Triple review (parallel) → Handle blockers → Inject frontmatter → Generate assignments

## Step 1: Validate Prerequisites

1. Get branch: `git branch --show-current` → must match `NNN-*` pattern
2. Find plan: `specs/{NNN}-*/plan.md` → must exist
3. Parse frontmatter: Verify `triad.pm_signoff.status` and `triad.architect_signoff.status` are APPROVED (or APPROVED_WITH_CONCERNS/BLOCKED_OVERRIDDEN)
4. If validation fails: Show error with required workflow order and exit

## Step 2: Generate Tasks

1. Invoke `/speckit.tasks` using the Skill tool
2. Verify `tasks.md` was created at `specs/{NNN}-*/tasks.md`
3. If not created: Error and exit

## Step 3: Triple Sign-off (Parallel)

Launch **three Task agents in parallel** (single message, three Task tool calls):

| Agent | subagent_type | Focus | Key Criteria |
|-------|---------------|-------|--------------|
| PM | product-manager | Product scope | User stories covered, no scope creep, FRs addressed |
| Architect | architect | Technical | Dependencies ordered, parallel opportunities, patterns maintained |
| Team-Lead | team-lead | Timeline | Granularity appropriate, critical path identified, parallelization maximized |

**Prompt template for each** (customize focus area):
```
Review tasks.md at {tasks_path} for {FOCUS AREA}.

Read the file, then provide sign-off:

STATUS: [APPROVED | APPROVED_WITH_CONCERNS | CHANGES_REQUESTED | BLOCKED]
NOTES: [Your detailed feedback]
```

**Parse responses**: Extract STATUS and NOTES from each agent's output.

## Step 4: Handle Review Results

**All APPROVED/APPROVED_WITH_CONCERNS**: → Proceed to Step 5

**Any CHANGES_REQUESTED**:
1. Display feedback from reviewers who requested changes
2. Use architect agent to update tasks addressing the feedback
3. Re-run reviews only for reviewers who requested changes
4. Loop until all approved or user aborts

**Any BLOCKED**:
1. Display blocker with veto domain (PM=scope, Architect=technical, Team-Lead=timeline)
2. Use AskUserQuestion with options:
   - **Resolve**: Address issues and re-submit to blocked reviewer
   - **Override**: Provide justification, mark as BLOCKED_OVERRIDDEN
   - **Abort**: Cancel task generation

**Multiple BLOCKED (cross-domain conflict)**:
1. Display all blockers with their domains
2. Use AskUserQuestion for executive decision:
   - **Product priority**: Override non-PM blocks
   - **Technical priority**: Override non-Architect blocks
   - **Schedule priority**: Override non-Team-Lead blocks
   - **Revise all**: Return to planning phase
   - **Abort**: Cancel

## Step 5: Inject Frontmatter

Add YAML frontmatter to tasks.md (prepend to existing content):

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
  techlead_signoff:
    agent: team-lead
    date: {YYYY-MM-DD}
    status: {techlead_status}
    notes: "{techlead_notes}"
---
```

## Step 6: Generate Agent Assignments

Invoke team-lead agent to create `agent-assignments.md`.

**Reference**: Use [Agent Registry](.claude/agents/) for task-to-agent mapping.

**Output includes**:
- Agent Assignment Matrix (task → agent mapping based on Agent Registry)
- Parallel Execution Waves (grouped by dependencies)
- Quality Gates between waves
- Time estimates per wave

Save to `specs/{NNN}-*/agent-assignments.md`

## Step 7: Report Completion

Display summary:
```
✅ TASK BREAKDOWN COMPLETE

Feature: {feature_number}
Tasks: {tasks_path}
Assignments: {assignments_path}

Triple Sign-offs:
- PM: {pm_status}
- Architect: {architect_status}
- Team-Lead: {techlead_status}

Next: /triad.implement
```

## Quality Checklist

- [ ] Plan has dual sign-offs (PM + Architect)
- [ ] tasks.md created by /speckit.tasks
- [ ] Triple review executed in parallel
- [ ] Blockers handled (resolved, overridden, or aborted)
- [ ] Frontmatter injected with all three sign-offs
- [ ] agent-assignments.md generated
- [ ] Completion summary displayed
