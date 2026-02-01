---
description: Execute implementation with Architect checkpoints at critical phases - Streamlined v2
compatible_with_speckit: ">=1.0.0"
last_tested_with_speckit: "2.0.0"
---

## User Input

```text
$ARGUMENTS
```

Consider user input before proceeding (if not empty).

## Overview

Executes feature implementation with Architect checkpoint reviews at priority boundaries.

**Flow**: Validate tasks → Load waves → Execute with parallel agents → Checkpoint reviews → Final validation

**Key Feature**: Architect reviews at P0→P1→P2 boundaries for governed quality gates.

## Step 1: Validate Prerequisites

1. Get branch: `git branch --show-current` → must match `NNN-*` pattern
2. Find tasks: `specs/{NNN}-*/tasks.md` → must exist
3. Parse frontmatter: Verify all three sign-offs (PM, Architect, Team-Lead) are APPROVED
4. Find assignments: `specs/{NNN}-*/agent-assignments.md` → must exist
5. If validation fails: Show error with required workflow order and exit

## Step 2: Load Context and Checkpoints

1. Read `tasks.md`, `plan.md`, `spec.md` for implementation context
2. Parse `agent-assignments.md` for task→agent mapping and wave definitions
3. Define checkpoints:

| Checkpoint | After Waves | Description | Blocking |
|------------|-------------|-------------|----------|
| P0 | 1, 2 | POC validation - Go/No-Go decision | Yes |
| P1 | 3, 4, 5 | Core functionality - Production cutover | Yes |
| P2 | 6, 7 | All features - Pre-final review | No |

## Step 3: Wave Execution with Checkpoints

For each wave:

1. **Skip if complete**: Check if all wave tasks marked `[X]` in tasks.md
2. **Group by agent**: Map tasks to specialized agents from agent-assignments.md
3. **Launch parallel**: Send **SINGLE message with multiple Task calls** for true parallelism
   - Use [Agent Registry](.claude/agents/) for task→agent mapping
   - Agent assignments from `agent-assignments.md` take precedence

4. **Verify completion**: Check all wave tasks marked `[X]`
5. **Checkpoint review** (if wave triggers checkpoint):
   - Launch architect agent for review
   - Parse STATUS: APPROVED / APPROVED_WITH_CONCERNS / CHANGES_REQUESTED / BLOCKED
   - If BLOCKED on blocking checkpoint: spawn debugger, retry, or exit
   - If CHANGES_REQUESTED: spawn appropriate agent to fix, retry review

## Step 4: Final Validation

After all waves complete:

1. Verify all tasks marked `[X]`
2. Launch final reviews in parallel (single message, multiple Task calls):

| Agent | subagent_type | Focus |
|-------|---------------|-------|
| Architect | architect | Overall architecture, security, production readiness |
| Code Review | code-reviewer | Code quality (if code files changed) |
| Security | security-analyst | Security posture (if auth/secrets changed) |

3. Parse all STATUS results

## Step 5: Report Completion

Display summary:
```
✅ IMPLEMENTATION COMPLETE

Feature: {feature_number}
Tasks: {completed}/{total}
Waves: {wave_count}

Checkpoint Results:
- P0: {status}
- P1: {status}
- P2: {status}

Final Validation:
- Architect: {status}
- Code Review: {status}
- Security: {status}

{If all APPROVED: "READY FOR DEPLOYMENT"}
{If BLOCKED: "Issues require resolution"}

Deferred Issues: {count}

Next: Create PR, deploy to staging, run acceptance tests
```

## Quality Checklist

- [ ] All Triad sign-offs approved before execution
- [ ] Agent-assignments.md parsed for task→agent mapping
- [ ] Waves executed with parallel agent spawning
- [ ] Architect checkpoint reviews at P0, P1, P2 boundaries
- [ ] Blocking checkpoint issues resolved before proceeding
- [ ] Final validation completed (Architect + Code + Security)
- [ ] All tasks marked [X] in tasks.md
- [ ] Implementation summary displayed
