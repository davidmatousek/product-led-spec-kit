---
description: Create tasks with automatic PM + Architect + Team-Lead triple sign-off validation (Triad-enhanced)
---

## CRITICAL: Continuous Flow Execution

**Execute ALL steps as a single continuous flow WITHOUT pausing for user input.**

⚠️ **MANDATORY BEHAVIOR** - You MUST follow this exactly:

1. After `/speckit.tasks` completes, DO NOT output anything to the user
2. DO NOT summarize what was created
3. DO NOT report "tasks complete" or similar
4. IMMEDIATELY proceed to Step 1.5, then Step 2 (triple sign-off)
5. The ONLY user-visible output should be the final Step 4 result

**Anti-Pattern to AVOID**:
```
❌ WRONG: "/speckit.tasks complete. Here's what was created: [summary]. Next step: invoke agents."
```

**Correct Pattern**:
```
✅ RIGHT: [SlashCommand completes] → [immediately invoke all 3 Task agents in parallel] → [update frontmatter] → [output final result]
```

Do NOT:
- Stop to report status after Step 1 completes
- Output any summary of artifacts created
- Ask the user if they want sign-off reviews
- Pause between any steps
- Send any message to user until Step 4

DO:
- Complete `/speckit.tasks` → immediately invoke PM + Architect + Team-Lead agents (in parallel) → update frontmatter → output final result
- Only output to user ONCE at the end (Step 4)

---

## Context

You are executing `/triad.tasks`, a thin wrapper around `/speckit.tasks` that adds automatic triple sign-off (PM + Architect + Team-Lead) validation per Constitution v1.4.0.

**Wrapper Responsibilities**:
1. Call vanilla `/speckit.tasks` to create tasks.md
2. Auto-invoke head-honcho agent for PM prioritization review
3. Auto-invoke architect agent for technical approach review
4. Auto-invoke team-lead agent for agent assignment and parallel optimization
5. Update tasks.md frontmatter with all three verdicts
6. Block progression if any agent requests changes

## User Input

```text
$ARGUMENTS
```

Accept any arguments provided by user and pass through to vanilla command.

## Step 1: Call Vanilla Spec Kit

Use the SlashCommand tool to execute the vanilla task breakdown command:

```
/speckit.tasks $ARGUMENTS
```

Wait for the command to complete.

## Step 1.5: Validate Output Location & Get Feature Path

**CRITICAL**: Validate tasks.md was created in the correct location and get paths for agent reviews.

1. **Get Feature Directory**:
   ```bash
   FEATURE_DIR=$(.specify/scripts/bash/get-feature-path.sh "")
   # Remove trailing slash and filename to get directory
   FEATURE_DIR=$(dirname $(.specify/scripts/bash/get-feature-path.sh tasks.md))
   ```

2. **Validate tasks.md Location**:
   - Check if tasks.md exists at `$FEATURE_DIR/tasks.md` (CORRECT location)
   - Check if tasks.md exists at `.specify/tasks.md` (WRONG location)

3. **Auto-Fix Wrong Location** (Defense-in-Depth):
   ```bash
   if [[ -f ".specify/tasks.md" ]] && [[ ! -f "$FEATURE_DIR/tasks.md" ]]; then
       # Wrong location detected - move to correct location
       mv .specify/tasks.md "$FEATURE_DIR/tasks.md"
       echo "⚠️ tasks.md was created in wrong location and has been moved to $FEATURE_DIR/tasks.md"
   fi
   ```

4. **Store Paths for Steps 2-4**:
   - `TASKS_PATH=$FEATURE_DIR/tasks.md`
   - `PLAN_PATH=$FEATURE_DIR/plan.md`
   - `SPEC_PATH=$FEATURE_DIR/spec.md`

## Step 2: Triple Sign-Off (Parallel)

**CRITICAL**: Automatically invoke ALL THREE agents in parallel (single message, three Task calls). Do NOT wait for user to request this. Do NOT run sequentially.

### Task 1: PM Prioritization Review

```python
Task(
    subagent_type="head-honcho",
    description="PM sign-off for task prioritization",
    prompt="""Review the task breakdown for prioritization and product alignment per Constitution v1.4.0.

**Context**:
- Feature Directory: $FEATURE_DIR (from get-feature-path.sh)
- Tasks created: $FEATURE_DIR/tasks.md
- Plan: $FEATURE_DIR/plan.md
- Specification: $FEATURE_DIR/spec.md
- Workflow: Triad wrapper auto-review (parallel with Architect + Team-Lead)
- Required: PM sign-off before implementation

**Review Responsibilities**:

1. **Prioritization Validation**:
   - Are tasks ordered by user value?
   - Are MVP tasks clearly identified?
   - Are nice-to-haves separated from must-haves?
   - Are dependencies logical?

2. **Scope Control**:
   - Do tasks deliver spec requirements (no more, no less)?
   - Is scope creep avoided?
   - Are tasks appropriately sized?
   - Are estimations realistic?

3. **Product Alignment**:
   - Do tasks maintain product vision?
   - Are user stories traceable to tasks?
   - Are acceptance criteria clear?

**Provide Structured Review**:

**Status**: [APPROVED | CHANGES_REQUESTED]

**Prioritization**:
- ✅ | ⚠️ | ❌ Ordered by user value
- ✅ | ⚠️ | ❌ MVP tasks identified
- ✅ | ⚠️ | ❌ Dependencies logical

**Scope Control**:
- ✅ | ⚠️ | ❌ Delivers spec (no scope creep)
- ✅ | ⚠️ | ❌ Tasks appropriately sized
- ✅ | ⚠️ | ❌ Realistic estimates

**Critical Issues** (if any): [List blocking issues]
**Concerns** (if any): [List non-blocking concerns]
**Recommendations** (if any): [List improvements]

**Approval**: [APPROVED | CHANGES_REQUESTED]

**Justification**: [1-2 sentences explaining decision]

---

**IMPORTANT**: If status is CHANGES_REQUESTED, user must address issues before proceeding to /triad.implement.
"""
)
```

### Task 2: Architect Technical Approach Review

```python
Task(
    subagent_type="architect",
    description="Architect sign-off for technical approach",
    prompt="""Review the task breakdown for technical soundness and consistency per Constitution v1.4.0.

**Context**:
- Feature Directory: $FEATURE_DIR (from get-feature-path.sh)
- Tasks created: $FEATURE_DIR/tasks.md
- Plan: $FEATURE_DIR/plan.md
- Specification: $FEATURE_DIR/spec.md
- Workflow: Triad wrapper auto-review (parallel with PM + Team-Lead)
- Required: Architect sign-off before implementation

**Review Responsibilities**:

1. **Technical Approach Validation**:
   - Are tasks technically sound?
   - Are architectural decisions consistent with plan?
   - Are patterns and best practices followed?
   - Are refactoring needs identified?

2. **Quality Assurance**:
   - Are testing tasks included?
   - Are code review tasks included?
   - Are documentation tasks included?
   - Are security considerations addressed?

3. **Architecture Consistency**:
   - Do tasks align with tech stack?
   - Do tasks follow architecture principles?
   - Are dependencies on architecture decisions clear?

**Provide Structured Review**:

**Status**: [APPROVED | APPROVED_WITH_CONCERNS | CHANGES_REQUESTED]

**Technical Approach**:
- ✅ | ⚠️ | ❌ Tasks technically sound
- ✅ | ⚠️ | ❌ Consistent with plan
- ✅ | ⚠️ | ❌ Best practices followed

**Quality Assurance**:
- ✅ | ⚠️ | ❌ Testing tasks included
- ✅ | ⚠️ | ❌ Code review tasks included
- ✅ | ⚠️ | ❌ Documentation tasks included
- ✅ | ⚠️ | ❌ Security addressed

**Critical Issues** (if any): [List blocking issues]
**Concerns** (if any): [List non-blocking concerns]
**Recommendations** (if any): [List improvements]

**Approval**: [APPROVED | APPROVED_WITH_CONCERNS | CHANGES_REQUESTED]

**Justification**: [1-2 sentences explaining decision]

---

**IMPORTANT**: If status is CHANGES_REQUESTED, user must address issues before proceeding to /triad.implement.
"""
)
```

### Task 3: Team-Lead Agent Assignment and Parallel Optimization

```python
Task(
    subagent_type="team-lead",
    description="Team-Lead optimization of agent assignments",
    prompt="""Review the task breakdown and optimize agent assignments and parallel execution per Constitution v1.4.0.

**Context**:
- Feature Directory: $FEATURE_DIR (from get-feature-path.sh)
- Tasks created: $FEATURE_DIR/tasks.md
- Plan: $FEATURE_DIR/plan.md
- Specification: $FEATURE_DIR/spec.md
- Workflow: Triad wrapper auto-review (parallel with PM + Architect)
- Required: Team-Lead optimization before implementation

**Review Responsibilities**:

1. **Agent Assignment Optimization**:
   - Which specialized agent should handle each task?
   - Are agent skills matched to task requirements?
   - Is workload balanced across agents?
   - Are agent dependencies minimized?

2. **Parallel Execution Identification**:
   - Which tasks can run in parallel (mark [P])?
   - Which tasks must run sequentially (dependencies)?
   - How should tasks be grouped into waves?
   - What's the optimal wave structure?

3. **Timeline and Sprint Planning**:
   - What's the realistic timeline?
   - How should tasks be grouped into sprints?
   - What's the critical path?
   - Are estimations reasonable?

4. **Create Optimization Report** (Optional but Recommended):
   - Create `$FEATURE_DIR/agent-assignments.md` with:
     * Agent assignment matrix
     * Parallel execution waves
     * Weekly sprint plan
     * Critical path analysis
     * Workload distribution
     * Optimization recommendations

**Provide Structured Review**:

**Status**: [APPROVED | CHANGES_REQUESTED]

**Agent Assignments**:
- Total tasks: {count}
- Agents required: {list of specialized agents}
- Workload distribution: {balanced | needs rebalancing}

**Parallel Execution**:
- Wave count: {N}
- Parallelization: {percentage of tasks that can run in parallel}
- Critical path: {identify longest dependency chain}

**Timeline Estimation**:
- Sequential execution: {hours/days}
- Parallel execution: {hours/days}
- Time savings: {percentage}

**Optimization Recommendations**:
- [List 2-5 recommendations for maximizing efficiency]

**Agent Assignment Matrix**:
{Optional: Include summary of which agents handle which tasks}

**Critical Issues** (if any): [List blocking issues]
**Concerns** (if any): [List non-blocking concerns]

**Approval**: [APPROVED | CHANGES_REQUESTED]

**Justification**: [1-2 sentences explaining decision]

**agent-assignments.md created**: [YES | NO | NOT_NEEDED]

---

**IMPORTANT**: If status is CHANGES_REQUESTED, user must address issues before proceeding to /triad.implement.
"""
)
```

**Execute all three Task calls in a SINGLE message** to maximize parallelism.

## Step 3: Update Frontmatter

Read all three agent review responses and extract:
- PM Status: APPROVED or CHANGES_REQUESTED
- Architect Status: APPROVED, APPROVED_WITH_CONCERNS, or CHANGES_REQUESTED
- Team-Lead Status: APPROVED or CHANGES_REQUESTED
- Date: Today's date (2025-11-23)
- PM Notes: Brief summary (1-2 sentences)
- Architect Notes: Brief summary (1-2 sentences)
- Team-Lead Notes: Brief summary (1-2 sentences)

Use the Edit tool to update `$FEATURE_DIR/tasks.md` frontmatter (use the TASKS_PATH from Step 1.5):

**Add or update these fields**:
```yaml
pm_signoff: [APPROVED | CHANGES_REQUESTED]
pm_signoff_date: 2025-11-23
pm_signoff_notes: [Brief summary from PM review]
architect_signoff: [APPROVED | APPROVED_WITH_CONCERNS | CHANGES_REQUESTED]
architect_signoff_date: 2025-11-23
architect_signoff_notes: [Brief summary from Architect review]
teamlead_signoff: [APPROVED | CHANGES_REQUESTED]
teamlead_signoff_date: 2025-11-23
teamlead_signoff_notes: [Brief summary from Team-Lead review]
```

**Location**: Add immediately after existing frontmatter fields, before the first `---` closing delimiter.

## Step 4: Validate & Output

**If ALL THREE (PM + Architect + Team-Lead) = APPROVED (or APPROVED_WITH_CONCERNS)**:
```markdown
✅ **Tasks Approved**

**PM Sign-Off**: APPROVED (2025-11-23)
- [PM notes]

**Architect Sign-Off**: [APPROVED | APPROVED_WITH_CONCERNS] (2025-11-23)
- [Architect notes]

**Team-Lead Sign-Off**: APPROVED (2025-11-23)
- [Team-Lead notes]
- Parallel optimization: {wave count} waves, {percentage}% time savings

**Architect Concerns** (if any):
- [List concerns if APPROVED_WITH_CONCERNS]

**Agent Assignments**:
{if agent-assignments.md created:}
- Full agent assignment matrix: $FEATURE_DIR/agent-assignments.md
- Wave structure: {wave count} waves
- Timeline: {parallel execution estimate}

**Next Step**:
/triad.implement

The tasks have passed triple review and are ready for implementation.
```

**If ANY agent = CHANGES_REQUESTED**:
```markdown
⚠️ **Tasks Require Changes**

**PM Sign-Off**: [status] (2025-11-23)
{if CHANGES_REQUESTED:}
**PM Critical Issues**:
- [List issues]

**Architect Sign-Off**: [status] (2025-11-23)
{if CHANGES_REQUESTED:}
**Architect Critical Issues**:
- [List issues]

**Team-Lead Sign-Off**: [status] (2025-11-23)
{if CHANGES_REQUESTED:}
**Team-Lead Critical Issues**:
- [List issues]

**Recommendations**:
{from PM if any}
{from Architect if any}
{from Team-Lead if any}

**Action Required**:
1. Address all issues listed above
2. Re-run `/triad.tasks` to update tasks and get fresh triple review

**Blocked**: Cannot proceed to /triad.implement until ALL THREE agents approve.
```

## Design Principles

**Keep This Wrapper Thin**:
- ✅ Call vanilla command
- ✅ Invoke triple sign-off (parallel)
- ✅ Update frontmatter
- ❌ Do NOT add: automatic task modifications
- ❌ Do NOT add: git operations, linting, formatting
- ❌ Do NOT add: automatic wave restructuring

**One Governance Concern**: Triple sign-off validation only.

**Parallelism**: Launch all three agents simultaneously to maximize time savings.

**Optional Optimization**: Team-Lead MAY create agent-assignments.md but it's not required by wrapper.

**Upgrade-Safe**: This wrapper calls `/speckit.tasks` by name, so upstream updates are automatically inherited.
