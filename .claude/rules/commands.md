# Commands

<!-- Rule file for Product-Led Spec Kit -->
<!-- This file is referenced from CLAUDE.md using @-syntax -->

## Overview

Product-Led Spec Kit provides two command sets:
- **Triad Commands**: Automatic governance with PM/Architect/Team-Lead sign-offs (RECOMMENDED)
- **Vanilla Commands**: Fast prototyping without governance workflows

---

## Triad Commands (Automatic Governance - RECOMMENDED)

Use Triad commands when you need governance, quality gates, and multi-agent collaboration.

```bash
/triad.vision              # Interactive product vision workshop (START HERE)
/triad.prd <topic>         # Create PRD with Triad validation
/triad.specify             # Create spec.md with auto PM sign-off
/triad.plan                # Create plan.md with auto PM + Architect sign-off
/triad.tasks               # Create tasks.md with auto triple sign-off
/triad.implement           # Execute with auto architect checkpoints
/triad.close-feature {NNN} # Close feature with parallel doc updates
```

**When to Use**:
- Production features requiring quality gates
- Multi-stakeholder projects needing sign-offs
- Complex features with architecture review requirements
- When you need documented governance trail

---

## Vanilla Commands (No Governance - Fast Prototyping)

Use Vanilla commands when you need speed and can skip governance workflows.

```bash
/speckit.specify           # Create spec.md
/speckit.plan              # Create plan.md
/speckit.tasks             # Create tasks.md
/speckit.implement         # Execute tasks
/speckit.clarify           # Ask clarification questions
/speckit.analyze           # Verify consistency
/team-lead.implement       # Execute with parallel agent orchestration
```

**When to Use**:
- Quick prototypes or experiments
- Solo developer projects
- Internal tools with lower quality bar
- When you trust agent output without review
