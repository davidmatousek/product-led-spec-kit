# Commands

<!-- Rule file for Product-Led Spec Kit -->
<!-- This file is referenced from CLAUDE.md using @-syntax -->

## Overview

Product-Led Spec Kit provides the **Triad Commands** with automatic governance, PM/Architect/Team-Lead sign-offs, and full SDLC workflow support.

---

## Triad Commands

Use Triad commands for governance, quality gates, and multi-agent collaboration.

### SDLC Workflow Commands

```bash
/triad.prd <topic>         # Create PRD with Triad validation (includes optional vision workshop)
/triad.specify             # Create spec.md with auto PM sign-off
/triad.plan                # Create plan.md with auto PM + Architect sign-off
/triad.tasks               # Create tasks.md with auto triple sign-off
/triad.implement           # Execute with auto architect checkpoints
/triad.close-feature {NNN} # Close feature with parallel doc updates
```

### Utility Commands

```bash
/triad.clarify             # Ask clarification questions about current feature
/triad.analyze             # Verify spec/plan/task consistency
/triad.checklist           # Run Definition of Done checklist
/triad.constitution        # View or update governance constitution
```

**When to Use**:
- Production features requiring quality gates
- Multi-stakeholder projects needing sign-offs
- Complex features with architecture review requirements
- When you need documented governance trail
- Clarifying requirements or verifying consistency at any phase
