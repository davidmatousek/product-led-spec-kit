---
description: Execute implementation with automatic architect checkpoints (Triad-enhanced)
---

## Context

You are executing `/triad.implement`, a thin wrapper around `/speckit.implement` that adds automatic architect checkpoints during execution per Constitution v1.4.0.

**Wrapper Responsibilities**:
1. Call vanilla `/speckit.implement` to execute tasks
2. Monitor implementation progress for checkpoint opportunities
3. Auto-invoke architect for review at strategic checkpoints
4. Create checkpoint reports in `docs/agents/architect/`
5. Block continuation if architect identifies critical issues

**What is a Checkpoint?**
A checkpoint is a strategic pause during implementation where the architect reviews progress, validates technical decisions, and ensures alignment with architecture principles. Checkpoints prevent technical debt accumulation and catch issues early.

## User Input

```text
$ARGUMENTS
```

Accept any arguments provided by user and pass through to vanilla command.

## Step 1: Call Advanced Team-Lead Implementation

Use the SlashCommand tool to execute the team-lead parallel orchestration command:

```
/team-lead.implement $ARGUMENTS
```

This will begin execution of tasks defined in `.specify/tasks.md` with:
- Parallel agent orchestration (maximizes concurrency)
- Wave-based execution planning
- Agent assignment matrix (optimal workload distribution)
- Checklist validation and auto-completion
- Progress tracking and error handling

## Step 2: Monitor for Checkpoint Opportunities

During implementation, watch for these checkpoint triggers:

**Automatic Checkpoint Triggers**:
1. **Wave Completion**: After each parallel execution wave completes
2. **Architectural Decision**: When new patterns, frameworks, or technologies are introduced
3. **Major Code Changes**: When >500 lines changed, new services created, or database schema modified
4. **Phase Boundaries**: When transitioning between major implementation phases
5. **User Request**: User explicitly requests checkpoint with "checkpoint" or "pause for review"

**Checkpoint Timing**:
- Checkpoints should occur AFTER significant work completes, not during
- Aim for 1-3 checkpoints per implementation (balance oversight vs overhead)
- For small implementations (<10 tasks): 1 checkpoint at end
- For medium implementations (10-30 tasks): 2-3 checkpoints at wave boundaries
- For large implementations (>30 tasks): 3-5 checkpoints at phase boundaries

## Step 3: Auto-Invoke Architect at Checkpoints

When a checkpoint is detected, invoke the architect agent:

```python
Task(
    subagent_type="architect",
    description="Architect checkpoint review during implementation",
    prompt="""Review implementation progress at checkpoint per Constitution v1.4.0.

**Context**:
- Implementation: {feature name}
- Tasks completed: {list of completed tasks}
- Tasks remaining: {list of pending tasks}
- Files modified: {list of changed files}
- Checkpoint trigger: {wave completion | architectural decision | major code change | phase boundary}

**Review Responsibilities**:

1. **Technical Quality Validation**:
   - Are implemented changes consistent with plan?
   - Are patterns and best practices followed?
   - Is technical debt being introduced?
   - Are security considerations addressed?
   - Are performance implications acceptable?

2. **Architecture Consistency Check**:
   - Do changes align with tech stack?
   - Do changes follow architecture principles?
   - Are new technologies properly integrated?
   - Are APIs and contracts consistent?

3. **Documentation Requirements**:
   - What architecture docs need updating?
     * docs/architecture/00_Tech_Stack/tech-stack.md (new tech)
     * docs/architecture/03_patterns/ (new patterns)
     * docs/architecture/02_ADRs/ (major decisions)
   - Are code comments sufficient?
   - Are design decisions documented?

4. **Risk Assessment**:
   - What risks are introduced by current changes?
   - What technical debt needs tracking?
   - What refactoring may be needed later?

**Provide Structured Review**:

**Status**: [APPROVED | APPROVED_WITH_CONCERNS | BLOCKED]

**Technical Quality**:
- ✅ | ⚠️ | ❌ Consistent with plan
- ✅ | ⚠️ | ❌ Best practices followed
- ✅ | ⚠️ | ❌ No technical debt introduced
- ✅ | ⚠️ | ❌ Security addressed
- ✅ | ⚠️ | ❌ Performance acceptable

**Architecture Consistency**:
- ✅ | ⚠️ | ❌ Aligns with tech stack
- ✅ | ⚠️ | ❌ Follows principles
- ✅ | ⚠️ | ❌ APIs consistent

**Documentation Needs**:
- [ ] Update tech-stack.md: {yes/no - why}
- [ ] Update patterns/: {yes/no - why}
- [ ] Create ADR: {yes/no - why}
- [ ] Update deployment docs: {yes/no - why}

**Risks Identified**:
- [List any risks introduced]

**Technical Debt**:
- [List any technical debt to track]

**Critical Issues** (if any): [List blocking issues]
**Concerns** (if any): [List non-blocking concerns]
**Recommendations** (if any): [List improvements for remaining work]

**Approval**: [APPROVED | APPROVED_WITH_CONCERNS | BLOCKED]

**Justification**: [1-2 sentences explaining decision]

---

**IMPORTANT**:
- If status is BLOCKED, implementation must halt until issues resolved
- If status is APPROVED_WITH_CONCERNS, implementation may continue but concerns should be tracked
"""
)
```

## Step 4: Create Checkpoint Report

After architect completes review, create a checkpoint report:

**File**: `docs/agents/architect/{YYYY-MM-DD}_checkpoint_{N}_ARCH.md`

**Format**:
```markdown
# Architect Checkpoint Report #{N} - {Feature Name}

**Date**: 2025-11-23
**Checkpoint Trigger**: {wave completion | architectural decision | major code change | phase boundary}
**Implementation Phase**: {beginning | middle | end}

## Review Summary

**Status**: [APPROVED | APPROVED_WITH_CONCERNS | BLOCKED]

**Tasks Reviewed**:
- [List of completed tasks at this checkpoint]

**Files Modified** ({count} files):
- [List of changed files]

## Technical Quality Assessment

{Copy relevant sections from architect review}

## Architecture Consistency

{Copy relevant sections from architect review}

## Documentation Updates Required

{List documentation needs from architect review}

## Risks and Technical Debt

**Risks Identified**:
- [List risks]

**Technical Debt**:
- [List technical debt]

## Critical Issues

{if BLOCKED:}
**Critical Issues** (BLOCKING):
- [List blocking issues]

**Action Required**:
1. [Steps to resolve]
2. [Steps to resolve]

**Implementation Status**: BLOCKED - cannot proceed until resolved

## Recommendations for Remaining Work

{List architect recommendations}

## Architect Sign-Off

**Architect**: architect agent
**Status**: [APPROVED | APPROVED_WITH_CONCERNS | BLOCKED]
**Date**: 2025-11-23

---

**Next Checkpoint**: {After wave N+1 | After phase completion | At end of implementation}
```

## Step 5: Continue or Block Implementation

**Based on architect checkpoint status**:

### If APPROVED or APPROVED_WITH_CONCERNS:

```markdown
✅ **Checkpoint #{N} Passed**

**Architect Review**: [APPROVED | APPROVED_WITH_CONCERNS]
**Checkpoint Report**: docs/agents/architect/{date}_checkpoint_{N}_ARCH.md

{if APPROVED_WITH_CONCERNS:}
**Concerns to Track**:
- [List concerns from architect]

**Status**: Implementation continuing with architect approval

**Next Checkpoint**: {After wave N+1 | After phase completion | At end of implementation}
```

**Action**: Continue executing remaining tasks from `/speckit.implement`

### If BLOCKED:

```markdown
🛑 **Checkpoint #{N} BLOCKED**

**Architect Review**: BLOCKED
**Checkpoint Report**: docs/agents/architect/{date}_checkpoint_{N}_ARCH.md

**Critical Issues Identified**:
- [List blocking issues]

**Action Required**:
1. Halt implementation immediately
2. Address critical issues listed above
3. Request fresh architect review
4. Resume implementation only after issues resolved

**Implementation Status**: PAUSED - awaiting issue resolution

**User Decision Required**:
- How would you like to proceed?
  * Option A: Fix issues and resume (recommended)
  * Option B: Modify approach and restart affected tasks
  * Option C: Abort implementation and replan
```

**Action**: HALT implementation, await user input, do NOT continue executing tasks

## Step 6: Final Validation

After `/speckit.implement` completes all tasks:

1. **Create final checkpoint** (if not already done):
   - Invoke architect for final review
   - Create final checkpoint report
   - Validate all documentation updated

2. **Verify Constitution compliance**:
   - All sign-offs present in frontmatter
   - All checkpoint reports created
   - All architecture docs updated
   - All technical debt tracked

3. **Generate completion summary**:

```markdown
✅ **Implementation Complete**

**Feature**: {feature name}
**Tasks Completed**: {count}
**Checkpoints**: {count}

**Architect Checkpoints**:
1. Checkpoint #1: [APPROVED | APPROVED_WITH_CONCERNS] - {date}
2. Checkpoint #2: [APPROVED | APPROVED_WITH_CONCERNS] - {date}
3. Final Checkpoint: [APPROVED | APPROVED_WITH_CONCERNS] - {date}

**Checkpoint Reports**:
{list all checkpoint report files}

**Architecture Updates**:
{list docs updated by architect during checkpoints}

**Technical Debt Tracked**:
{list technical debt items if any}

**Status**: ✅ Ready for testing and code review

**Next Steps**:
1. Review changes: git diff
2. Run tests: {test command}
3. Create PR: gh pr create
4. Mark feature complete in `.specify/tasks.md`
```

## Design Principles

**Keep This Wrapper Thin**:
- ✅ Call vanilla implement command
- ✅ Monitor for checkpoints
- ✅ Invoke architect at checkpoints
- ✅ Create checkpoint reports
- ✅ Block on BLOCKED status
- ❌ Do NOT add: automatic code modifications
- ❌ Do NOT add: automatic documentation updates (architect does this)
- ❌ Do NOT add: automatic testing or deployment
- ❌ Do NOT add: git operations or commits

**One Governance Concern**: Architect checkpoint validation only.

**Strategic Checkpoints**: Balance oversight (catch issues early) vs overhead (too many pauses).

**Blocking Behavior**: BLOCKED = immediate halt, user decision required.

**Best-of-Both-Worlds**: Combines team-lead's parallel orchestration with architect's checkpoint governance.

**Upgrade-Safe**: If `/team-lead.implement` is updated, this wrapper automatically inherits improvements.

## Checkpoint Best Practices

**When to Checkpoint** (GOOD):
- ✅ After 5-10 tasks completed (wave boundary)
- ✅ After introducing new technology or pattern
- ✅ After major database schema change
- ✅ After creating new service or API
- ✅ At natural phase boundaries (backend → frontend → docs)

**When NOT to Checkpoint** (BAD):
- ❌ After every single task (too granular)
- ❌ In the middle of a multi-step task
- ❌ Before any work completed (nothing to review)
- ❌ More than 5 checkpoints per implementation (overhead)

**Checkpoint Size** (Optimal):
- Small implementation (<10 tasks): 1 checkpoint at end
- Medium implementation (10-30 tasks): 2-3 checkpoints at waves
- Large implementation (>30 tasks): 3-5 checkpoints at phases

**Balance**: Enough checkpoints to catch issues early, not so many that implementation grinds to a halt.
