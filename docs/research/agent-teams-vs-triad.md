# Research: Claude Code Agent Teams vs. SDLC Triad

**Date**: 2026-02-06
**Source**: https://code.claude.com/docs/en/agent-teams
**Status**: Agent Teams is experimental (disabled by default)
**Compared Against**: [SPEC_KIT_TRIAD.md](../SPEC_KIT_TRIAD.md)

---

## Summary

Claude Code Agent Teams is an experimental feature for coordinating multiple Claude Code instances as a team with shared tasks, inter-agent messaging, and centralized management. This research compares it against our SDLC Triad multi-agent orchestration process.

**Finding**: Our Triad process is a more sophisticated orchestration system. Agent Teams offers two capabilities we lack (persistent teammate context and inter-agent messaging), but everything else — agent specialization, task assignment, parallel strategy, quality gates, governance separation — we already handle more thoroughly.

---

## Agent Teams Overview

### Architecture

| Component | Role |
|-----------|------|
| Team Lead | Main session that creates the team, spawns teammates, coordinates work |
| Teammates | Separate Claude Code instances working on assigned tasks |
| Task List | Shared list of work items that teammates claim and complete |
| Mailbox | Messaging system for communication between agents |

### Key Features

- **Persistent teammates**: Each teammate is a full Claude Code session that stays alive across tasks
- **Inter-agent messaging**: Teammates can message each other directly (not just report to lead)
- **Self-claiming tasks**: Teammates pick up next unassigned, unblocked task autonomously
- **Delegate mode**: Restricts lead to coordination-only (no implementation)
- **Plan approval**: Lead can require teammates to plan before implementing
- **Display modes**: In-process (single terminal) or split panes (tmux/iTerm2)
- **Shared task list**: Three states (pending, in progress, completed) with dependency tracking and file locking

### Subagents vs. Agent Teams (from official docs)

|                   | Subagents                                        | Agent Teams                                         |
|:------------------|:-------------------------------------------------|:----------------------------------------------------|
| **Context**       | Own context window; results return to the caller | Own context window; fully independent               |
| **Communication** | Report results back to the main agent only       | Teammates message each other directly               |
| **Coordination**  | Main agent manages all work                      | Shared task list with self-coordination             |
| **Best for**      | Focused tasks where only the result matters      | Complex work requiring discussion and collaboration |
| **Token cost**    | Lower: results summarized back to main context   | Higher: each teammate is a separate Claude instance |

### Best Use Cases (per official docs)

- Research and review (parallel investigation)
- New modules or features (independent ownership)
- Debugging with competing hypotheses (adversarial investigation)
- Cross-layer coordination (frontend, backend, tests)

### Known Limitations

- No session resumption with in-process teammates
- Task status can lag (teammates fail to mark tasks complete)
- Shutdown can be slow
- One team per session, no nested teams
- Lead is fixed (no promotion/transfer)
- Permissions set at spawn (inherited from lead)
- Split panes require tmux or iTerm2
- Significantly higher token costs

---

## Comparison: Orchestration Models

| Capability | Claude Code Agent Teams | SDLC Triad |
|-----------|------------------------|----------------|
| **Agent specialization** | Ad-hoc roles (described by prompt) | **13 pre-defined agents** with 210-291 line role definitions |
| **Task assignment** | Lead assigns or teammates self-claim | **Team-lead creates `agent-assignments.md`** with task-to-agent mapping, rationale, workload % |
| **Parallel execution** | Teammates work independently | **Execution waves** (Wave 3A / 3B) with `[P]` markers and dependency tracking |
| **Workload balancing** | None built-in | **No agent >80% loaded**, backup agent assignments |
| **Coordination split** | Lead does everything (unless delegate mode) | **Team-lead** (governance) + **Orchestrator** (execution) |
| **Task dispatch** | Lead spawns teammates with prompts | `Task(subagent_type=...)` in single message for true parallelism |
| **Quality gates** | Optional plan approval | **P0/P1/P2 checkpoints** with architect review after each wave group |
| **Final validation** | None built-in | Parallel architect + code-reviewer + security-analyst reviews |
| **Progress tracking** | Shared task list with 3 states | TodoWrite + `[X]` marking + checkpoint status |
| **Time savings** | Not measured | **38-58% reduction** documented (Feature 002: 45 to 28 hrs) |

---

## Where Agent Teams Adds Something We Lack

| Capability | Agent Teams | Our Current Approach | Impact |
|------------|-------------|---------------------|--------|
| **Inter-agent messaging** | Teammates message each other directly via mailbox | Agents report back to lead only (subagent model) | **Medium** - would let architect challenge backend-engineer mid-wave instead of waiting for checkpoint |
| **Persistent teammates** | Stay alive across multiple tasks | Re-spawned per Task call (fresh context each time) | **High** - PM/Architect/Team-Lead could retain context from PRD through implementation |
| **Self-claiming tasks** | Teammates claim next unblocked task with file locking | Orchestrator dispatches explicitly per wave | **Medium** - more dynamic than wave-based batching |
| **Direct user interaction** | User can message any teammate (Shift+Up/Down) | User only interacts with lead session | **Low** - useful for debugging but checkpoints handle most needs |
| **Delegate mode** | Forces lead to coordinate-only | Already separated: team-lead (governance) vs orchestrator (execution) | **None** - solved architecturally |

---

## Where Our Process Is Ahead

### 1. Specialized Agent Registry (13 agents)

Agent Teams spawns generic "teammates" described by prompt. We have pre-defined, deeply-specified agents:

| Agent | Lines | Specialization |
|-------|-------|---------------|
| senior-backend-engineer | 278 | API development, server-side logic, database operations |
| frontend-developer | 243 | UI implementation, component development, client-side code |
| architect | 269 | Technical design, architecture decisions, technology selection |
| devops | 291 | Deployment, CI/CD, environment management |
| tester | 187 | Test strategy, test cases, BDD scenarios |
| code-reviewer | 269 | Pull request reviews, code quality |
| debugger | 239 | Bug investigation, 5 Whys analysis |
| security-analyst | 277 | Security reviews, vulnerability assessment |
| ux-ui-designer | 245 | UI/UX design, user experience |
| web-researcher | 265 | Web research, documentation lookup |
| product-manager | 259 | PRD creation, requirements, scope |
| team-lead | 210 | Governance, sign-offs, feasibility |
| orchestrator | 255 | Multi-agent coordination, parallel waves |

### 2. Wave Strategy with Dependency Analysis

- `[P]` markers identify parallelizable tasks at generation time
- Waves group tasks by dependency chains AND agent availability
- Cross-wave parallelism (Wave 3A / 3B with different agents on different files)
- Team-lead optimizes wave strategy (documented 38% time reduction on Feature 002)

### 3. Governance/Execution Separation

- **Team-lead**: assigns agents, creates wave strategy, signs off - never executes
- **Orchestrator**: dispatches agents, monitors progress, reports - never governs
- Agent Teams conflates the lead role unless delegate mode is manually enabled

### 4. Checkpoint Architecture

| Checkpoint | After | Description | Blocking |
|------------|-------|-------------|----------|
| P0 | Setup waves | Go/No-Go decision | Yes |
| P1 | Core waves | Production cutover readiness | Yes |
| P2 | All waves | Pre-final review | No |

Each triggers architect review with severity outcomes: APPROVED / APPROVED_WITH_CONCERNS / CHANGES_REQUESTED / BLOCKED.

### 5. Research Phase

`/triad.specify` runs parallel research across KB, codebase, architecture docs, and web before spec creation. Agent Teams has no equivalent.

---

## Recommendations

### Do NOT adopt Agent Teams today

It's experimental with known limitations (no session resumption, task status lag, one team per session). Our subagent-based approach is more reliable.

### Monitor the feature

When Agent Teams stabilizes, it could serve as a runtime for our Triad orchestration. The persistent teammate model (PM stays alive from PRD through implementation) would be valuable.

### Design for compatibility

Our governance rules (sign-off matrices, artifact handoffs, research phases) should remain independent of whether the underlying mechanism is subagents or Agent Teams.

### Hybrid adoption path

| Phase | Approach |
|-------|----------|
| Phase 1 (now) | Keep subagents for reviews (focused, isolated) |
| Phase 2 (when stable) | Pilot Agent Teams for `/triad.implement` waves (persistent context + messaging) |
| Phase 3 (mature) | Map agent registry to persistent teammate profiles that carry role definitions |

### Role mapping for future adoption

| Triad Role | Agent Teams Mapping |
|------------|-------------------|
| Team-lead | Team Lead (coordinator) |
| Orchestrator | Team Lead in delegate mode |
| PM, Architect | Persistent teammates across phases |
| Backend, Frontend, Tester, etc. | Teammates spawned per wave |

---

## References

- **Agent Teams docs**: https://code.claude.com/docs/en/agent-teams
- **Subagents docs**: https://code.claude.com/docs/en/sub-agents
- **Agent Teams token costs**: https://code.claude.com/docs/en/costs#agent-team-token-costs
- **SDLC Triad guide**: [docs/SPEC_KIT_TRIAD.md](../SPEC_KIT_TRIAD.md)
- **Triad Collaboration standard**: [docs/standards/TRIAD_COLLABORATION.md](../standards/TRIAD_COLLABORATION.md)
- **Agent registry**: [.claude/agents/_README.md](../../.claude/agents/_README.md)
- **Orchestrator agent**: [.claude/agents/orchestrator.md](../../.claude/agents/orchestrator.md)
- **Team-lead agent**: [.claude/agents/team-lead.md](../../.claude/agents/team-lead.md)

---

**Last Updated**: 2026-02-06
**Next Review**: When Agent Teams exits experimental status
