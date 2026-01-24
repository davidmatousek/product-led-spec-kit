# Governance

<!-- Rule file for Product-Led Spec Kit -->
<!-- This file is referenced from CLAUDE.md using @-syntax -->

## Overview

This file defines mandatory governance workflows for Product-Led Spec Kit. All agents must follow these sign-off requirements when creating specs, plans, and tasks.

**CRITICAL**: After creating specs/plans/tasks, you MUST auto-trigger reviews. Do not wait for user request.

---

## Sign-off Requirements

| Artifact | Required Sign-offs | Agents to Invoke |
|----------|-------------------|------------------|
| spec.md | PM | product-manager |
| plan.md | PM + Architect | product-manager, architect |
| tasks.md | PM + Architect + Team-Lead | product-manager, architect, team-lead |

### After `/speckit.specify` Completes:
1. **Automatically** invoke product-manager agent for PM review using Task tool
2. Present review results (APPROVED or CHANGES REQUESTED)
3. If CHANGES REQUESTED: Address issues, re-submit for review
4. Do NOT declare "ready for planning" until PM sign-off: APPROVED

### After `/speckit.plan` Completes:
1. Invoke product-manager for PM review
2. Invoke architect for technical review
3. Require **both approvals** before declaring ready

**Parallel Review (Claude Code v2.1.16+)**: If context forking is available, PM and Architect reviews run simultaneously in isolated contexts. Use a single message with two Task calls for parallel execution.

### After `/speckit.tasks` Completes:
1. Invoke product-manager, architect, and team-lead
2. Team-lead generates `agent-assignments.md` with parallel execution waves
3. Require **all three approvals** before implementation

**Triple Parallel Review (v2.1.16+)**: All three reviews can run in parallel with context forking. Results merge automatically using severity ranking.

### Review Outcomes:
- **APPROVED**: Proceed to next phase, document sign-off
- **CHANGES REQUESTED**: Address issues, re-submit (repeat until approved)
- **BLOCKED**: Critical issues, escalate to user

---

## Triad Roles

The SDLC Triad ensures Product-Architecture-Engineering alignment:
- **product-manager (PM)**: Defines **What** & **Why** (user value, business goals)
- **architect**: Defines **How** (technical approach, infrastructure baseline)
- **team-lead**: Defines **When** & **Who** (timeline, agent assignments)

### Infrastructure PRD Workflow (sequential):
1. PM analyzes need → architect provides baseline → PM drafts PRD
2. Tech-lead feasibility → architect review → PM finalizes

### Feature PRD Workflow (parallel):
1. PM drafts PRD → architect + tech-lead review in parallel → PM finalizes
