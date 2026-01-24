# Technical Plan: Anthropic Claude Code Updates Integration

## Metadata

- **Feature ID**: 002
- **Feature Name**: Anthropic Claude Code Updates Integration
- **Status**: Draft
- **Created**: 2026-01-24
- **Author**: architect
- **Spec Reference**: specs/002-anthropic-updates-integration/spec.md
- **PRD Reference**: docs/product/02_PRD/002-anthropic-updates-integration-2026-01-24.md
- **Priority**: P0
- **pm_signoff**: APPROVED
- **pm_signoff_date**: 2026-01-24
- **pm_signoff_notes**: Strong plan with clear product alignment. Correctly incorporates Tech-Lead feasibility recommendations (2-3 week P0 scope, Week 1 go/no-go gate). All FR-1 through FR-5 functional requirements mapped to phases. Minor recommendations for rollback docs and technical debt tracking. Ready for task breakdown.
- **architect_signoff**: APPROVED
- **architect_signoff_date**: 2026-01-24
- **architect_signoff_notes**: Well-structured plan with sound architectural judgment. Properly leverages Claude Code v2.1.16 native capabilities. All spec requirements covered. Recommend ADR-001 for custom dependency wrapper decision before Phase 4. Pattern documentation should be included in Phase 5.

---

## Technical Context

### Current State Analysis

**Spec Kit Today** (v1.x):
- Sequential agent invocation (PM → Architect → Tech-Lead)
- Shared context between parallel agent workflows
- Manual dependency tracking in command logic
- No Claude Code version detection
- Potential memory issues in long-running parallel workflows

**Pain Points**:
1. Sequential Triad reviews take 5-7 minutes (could be 3-4 minutes parallel)
2. Context pollution between agents causes unreliable review results
3. Manual coordination overhead for task dependencies
4. No graceful degradation for older Claude Code versions

### Target State

**Spec Kit After** (v2.x):
- Parallel agent invocation with context isolation
- Native context forking for PM/Architect reviews
- Custom dependency wrapper using TodoWrite for visibility
- Runtime version detection with feature flags
- Graceful degradation for v2.1.15 users

### Technology Choices

| Component | Technology | Rationale |
|-----------|------------|-----------|
| Context Isolation | `context: fork` frontmatter | Native Claude Code v2.1.0+ support |
| Review Agent | `agent: Explore` | Read-only, Haiku model, fast |
| Write Agent | `agent: general-purpose` | Full tools, inherit model |
| Version Detection | `CLAUDECODE` env var | Official method (v0.2.47+) |
| Dependency Tracking | Custom wrapper + TodoWrite | Native API insufficient |

---

## Constitution Check

### Applicable Principles

| Principle | Status | Notes |
|-----------|--------|-------|
| III. Backward Compatibility | ✅ Compliant | v2.1.15 graceful degradation |
| VI. Testing Excellence | ✅ Planned | Test cases defined |
| VII. Definition of Done | ✅ Compliant | Validation steps defined |
| IX. Git Workflow | ✅ Compliant | Feature branch workflow |
| X. Product-Spec Alignment | ✅ Compliant | Aligns with spec.md |
| XI. SDLC Triad | ✅ Compliant | Triad workflow enhanced |

### Validation Gates

- [ ] Backward compatibility verified (v2.1.15 workflows unchanged)
- [ ] Context forking tested and working
- [ ] Version detection accurate
- [ ] Parallel execution stable (no memory leaks)
- [ ] Graceful degradation functional

---

## Architecture Overview

### Component Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                    Spec Kit v2.x Architecture                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │                    Triad Commands                           │ │
│  │  ┌─────────────┐ ┌─────────────┐ ┌─────────────────────┐   │ │
│  │  │ /triad.spec │ │ /triad.plan │ │ /triad.tasks        │   │ │
│  │  └──────┬──────┘ └──────┬──────┘ └──────────┬──────────┘   │ │
│  └─────────┼───────────────┼───────────────────┼──────────────┘ │
│            │               │                   │                 │
│            ▼               ▼                   ▼                 │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │              Version Detection Layer                         ││
│  │  ┌─────────────────┐  ┌─────────────────────────────────┐   ││
│  │  │ FeatureDetector │──│ FeatureFlags                    │   ││
│  │  │ - detectVersion │  │ - context_forking: boolean      │   ││
│  │  │ - hasFeature    │  │ - parallel_fixes: boolean       │   ││
│  │  └─────────────────┘  │ - dependency_tracking: boolean  │   ││
│  │                       └─────────────────────────────────┘   ││
│  └──────────────────────────────────────┬──────────────────────┘│
│                                         │                        │
│            ┌────────────────────────────┼───────────────────┐   │
│            │                            │                    │   │
│            ▼                            ▼                    ▼   │
│  ┌─────────────────┐     ┌─────────────────┐     ┌───────────┐ │
│  │  Context Fork   │     │  Parallel        │     │ Graceful  │ │
│  │    Manager      │     │  Executor        │     │ Degrader  │ │
│  │                 │     │                  │     │           │ │
│  │ ┌─────────────┐ │     │ ┌──────────────┐ │     │ Sequential│ │
│  │ │ PM Fork     │ │     │ │ PM Task      │ │     │ Fallback  │ │
│  │ │ agent:      │ │     │ └──────────────┘ │     │           │ │
│  │ │ Explore     │ │     │ ┌──────────────┐ │     └───────────┘ │
│  │ └─────────────┘ │     │ │ Arch Task    │ │                   │
│  │ ┌─────────────┐ │     │ └──────────────┘ │                   │
│  │ │ Arch Fork   │ │     │        ↓         │                   │
│  │ │ agent:      │ │     │ ┌──────────────┐ │                   │
│  │ │ Explore     │ │     │ │ Result Merger│ │                   │
│  │ └─────────────┘ │     │ └──────────────┘ │                   │
│  └─────────────────┘     └─────────────────┘                    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Data Flow: Parallel Triad Review

```
┌─────────────────────────────────────────────────────────────────┐
│              Parallel Review Data Flow (/triad.plan)             │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. /speckit.plan completes                                      │
│         │                                                        │
│         ▼                                                        │
│  2. Version Detection                                            │
│     ├─► v2.1.16+: Enable parallel + forking                     │
│     └─► < v2.1.16: Fallback to sequential                       │
│                                                                  │
│  3. Launch Parallel Forks (single message, two Task calls)      │
│         │                                                        │
│         ├───────────────────────┬─────────────────────────┐     │
│         │                       │                          │     │
│         ▼                       ▼                          │     │
│  ┌─────────────────┐   ┌─────────────────┐                │     │
│  │   PM Fork       │   │  Architect Fork │                │     │
│  │  context: fork  │   │  context: fork  │                │     │
│  │  agent: Explore │   │  agent: Explore │                │     │
│  │                 │   │                 │                │     │
│  │  Read spec.md   │   │  Read plan.md   │                │     │
│  │  Read plan.md   │   │  Read tech-stack│                │     │
│  │  Product review │   │  Arch review    │                │     │
│  │                 │   │                 │                │     │
│  │  Output:        │   │  Output:        │                │     │
│  │  - Verdict      │   │  - Verdict      │                │     │
│  │  - Findings     │   │  - Findings     │                │     │
│  └────────┬────────┘   └────────┬────────┘                │     │
│           │                     │                          │     │
│           └─────────┬───────────┘                          │     │
│                     │                                      │     │
│                     ▼                                      │     │
│  4. Result Merger                                          │     │
│     ├─► Both APPROVED: Proceed                            │     │
│     └─► Any CHANGES_REQUESTED: Block                       │     │
│                                                                  │
│  5. Update plan.md frontmatter with sign-offs                   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Implementation Phases

### Phase 0: Research Spike (Complete)

**Objective**: Validate Claude Code v2.1.16 capabilities

**Deliverables**:
- ✅ [research.md](./research.md) - Capability analysis
- ✅ [data-model.md](./data-model.md) - Entity definitions
- ✅ [contracts/integration-contracts.md](./contracts/integration-contracts.md) - API specs
- ✅ [quickstart.md](./quickstart.md) - Quick start guide

**Key Findings**:
1. Context forking is production-ready (`context: fork` frontmatter)
2. Parallel execution fixes are automatic (no code changes)
3. Task dependency tracking requires custom wrapper
4. Version detection via `CLAUDECODE` env var

---

### Phase 1: Version Detection & Feature Flags

**Objective**: Implement runtime feature detection

**Tasks**:
1. Create version detection utility
2. Implement feature flag system
3. Add graceful degradation logic

**Technical Approach**:
```bash
# Version detection
if [ -n "$CLAUDECODE" ]; then
  CLAUDE_VERSION=$(claude --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
  # Parse and set feature flags
fi
```

**Validation**:
- Version correctly detected on v2.1.16+
- Features correctly disabled on v2.1.15
- Clear user messaging for unavailable features

---

### Phase 2: Context Forking Integration

**Objective**: Enable isolated context for Triad reviews

**Tasks**:
1. Create PM review skill with `context: fork`
2. Create Architect review skill with `context: fork`
3. Update Triad commands to use forked skills
4. Implement result merging logic

**Skill Templates**:

PM Review Skill:
```yaml
---
name: pm-triad-review
description: PM review in isolated context
context: fork
agent: Explore
---

Review the specification and plan for product alignment...
```

Architect Review Skill:
```yaml
---
name: architect-triad-review
description: Architect review in isolated context
context: fork
agent: Explore
---

Review the plan for technical soundness and architecture alignment...
```

**Validation**:
- Reviews complete in isolated contexts
- No context pollution between PM and Architect
- Results correctly merged to parent context

---

### Phase 3: Parallel Execution

**Objective**: Run PM and Architect reviews simultaneously

**Tasks**:
1. Modify Triad commands to launch parallel Task calls
2. Implement wait-for-both completion logic
3. Add timing metrics for before/after comparison

**Implementation Pattern**:
```python
# Single message, two Task calls
Task(subagent_type="product-manager", context="fork", ...)
Task(subagent_type="architect", context="fork", ...)
# Both execute in parallel
```

**Validation**:
- Both agents execute simultaneously
- Total time < max(PM time, Architect time) + overhead
- Results correctly merged regardless of completion order

---

### Phase 4: Task Dependency Wrapper

**Objective**: Implement dependency tracking for tasks.md

**Tasks**:
1. Create dependency parsing logic for tasks.md
2. Implement circular dependency detection
3. Add blocking/ready status computation
4. Integrate with TodoWrite for visibility

**Dependency Format**:
```markdown
### T002: Implement context forking
- **Depends on**: T001
```

**Validation**:
- Dependencies correctly parsed from tasks.md
- Circular dependencies detected and rejected
- Tasks blocked until dependencies complete

---

### Phase 5: Documentation & Migration

**Objective**: Enable users to adopt new features

**Tasks**:
1. Update MIGRATION.md with v2.1.16 upgrade steps
2. Document feature availability matrix
3. Add troubleshooting guide
4. Update CLAUDE.md with new capabilities

**Validation**:
- Users can upgrade following MIGRATION.md
- Feature matrix accurately reflects availability
- Troubleshooting covers common issues

---

## Technical Decisions

### Decision 1: Agent Type for Reviews

**Decision**: Use `agent: Explore` for PM and Architect reviews

**Rationale**:
- Reviews are read-only operations
- Explore uses Haiku model (faster, cheaper)
- Sufficient tools: Read, Glob, Grep
- Full isolation without write capabilities

**Alternatives Considered**:
| Alternative | Pros | Cons | Decision |
|-------------|------|------|----------|
| `general-purpose` | Full tools | Slower, overkill for reads | Rejected |
| `Plan` | Planning focused | Less appropriate for reviews | Rejected |
| `Explore` | Fast, read-only, isolated | Limited tools | **Accepted** |

---

### Decision 2: Dependency Tracking Approach

**Decision**: Custom wrapper with TodoWrite visibility

**Rationale**:
- Native TodoWrite lacks declarative dependency API
- Custom wrapper provides enforcement
- TodoWrite provides user visibility
- Minimal external dependencies

**Alternatives Considered**:
| Alternative | Pros | Cons | Decision |
|-------------|------|------|----------|
| Wait for native API | Less code | Unknown timeline | Rejected |
| External orchestrator | Full DAG support | External dependency | Rejected |
| Custom + TodoWrite | Control + visibility | More code to maintain | **Accepted** |

---

### Decision 3: Version Detection Method

**Decision**: `CLAUDECODE` env var + CLI fallback

**Rationale**:
- `CLAUDECODE` is official detection method
- CLI fallback for version parsing
- Works across all supported versions

**Detection Flow**:
```
1. Check CLAUDECODE env var (presence = in Claude Code)
2. Parse version from `claude --version`
3. Set feature flags based on version
4. Fallback: Assume v2.1.15 (conservative)
```

---

## Risk Mitigation

### Risk 1: Context Forking Instability

**Risk**: Forked contexts may behave unexpectedly

**Mitigation**:
- Thorough testing in isolation
- Graceful fallback to sequential on fork failures
- Monitor for context pollution indicators

### Risk 2: Version Detection Failures

**Risk**: Version may not be detectable

**Mitigation**:
- Conservative fallback (assume v2.1.15)
- Clear user messaging when detection fails
- Manual override via environment variable

### Risk 3: Parallel Execution Issues

**Risk**: Memory leaks or orphaned results in parallel mode

**Mitigation**:
- Require v2.1.16 for parallel features
- Monitor memory in long workflows
- Automatic throttling on memory pressure

---

## Success Criteria

| Criteria | Target | Measurement |
|----------|--------|-------------|
| Parallel Review Time | <4 minutes | Timing metrics |
| Context Isolation | Zero pollution | Test verification |
| Version Detection | 100% accurate | Manual + automated tests |
| Backward Compatibility | 100% | v2.1.15 workflow tests |
| User Upgrade Time | <15 minutes | MIGRATION.md feedback |

---

## Dependencies

### Internal Dependencies

| Dependency | Status | Notes |
|------------|--------|-------|
| spec.md | ✅ Complete | Requirements defined |
| research.md | ✅ Complete | Capabilities researched |
| data-model.md | ✅ Complete | Entities defined |
| contracts | ✅ Complete | Interfaces specified |

### External Dependencies

| Dependency | Status | Notes |
|------------|--------|-------|
| Claude Code v2.1.16 | ✅ Available | Required for full features |
| `context: fork` | ✅ Supported | v2.1.0+ |
| `CLAUDECODE` env var | ✅ Supported | v0.2.47+ |

---

## Implementation Order

1. **Phase 1**: Version Detection (prerequisite for all)
2. **Phase 2**: Context Forking (depends on Phase 1)
3. **Phase 3**: Parallel Execution (depends on Phase 2)
4. **Phase 4**: Task Dependencies (parallel with Phase 2-3)
5. **Phase 5**: Documentation (depends on Phase 1-4)

**Critical Path**: Phase 1 → Phase 2 → Phase 3 → Phase 5

**Parallel Opportunity**: Phase 4 can run alongside Phases 2-3

---

## Appendix: Skill Templates

### PM Review Skill

```yaml
---
name: pm-triad-review
description: PM product alignment review in isolated context
context: fork
agent: Explore
---

You are the Product Manager reviewing a specification or plan.

**Your Responsibilities**:
1. Validate product vision alignment
2. Verify user value is clear
3. Check success criteria are measurable
4. Ensure scope is well-defined

**Review Structure**:
- Read the spec/plan at the provided path
- Evaluate against product criteria
- Provide structured verdict: APPROVED or CHANGES_REQUESTED
- List findings with severity (critical/warning/info)

**Output Format**:
Status: [APPROVED | CHANGES_REQUESTED]
Findings: [list]
Recommendations: [list]
```

### Architect Review Skill

```yaml
---
name: architect-triad-review
description: Architect technical review in isolated context
context: fork
agent: Explore
---

You are the Architect reviewing a technical plan.

**Your Responsibilities**:
1. Validate tech stack consistency
2. Check architecture alignment
3. Identify anti-patterns
4. Assess complexity and technical debt

**Review Structure**:
- Read the plan at the provided path
- Read tech-stack.md for consistency check
- Evaluate against architecture criteria
- Provide verdict: APPROVED, APPROVED_WITH_CONCERNS, or CHANGES_REQUESTED

**Output Format**:
Status: [APPROVED | APPROVED_WITH_CONCERNS | CHANGES_REQUESTED]
Findings: [list]
Technical Notes: [list]
```

---

**End of Technical Plan**
