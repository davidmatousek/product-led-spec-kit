---
description: Create plan with automatic PM + Architect dual sign-off validation (Triad-enhanced)
---

## CRITICAL: Continuous Flow Execution

**Execute ALL steps as a single continuous flow WITHOUT pausing for user input.**

⚠️ **MANDATORY BEHAVIOR** - You MUST follow this exactly:

1. After `/speckit.plan` completes, DO NOT output anything to the user
2. DO NOT summarize what was created
3. DO NOT report "planning complete" or similar
4. IMMEDIATELY proceed to Step 1.5, then Step 2 (dual sign-off)
5. The ONLY user-visible output should be the final Step 4 result

**Anti-Pattern to AVOID**:
```
❌ WRONG: "/speckit.plan complete. Here's what was created: [summary]. Next step: invoke agents."
```

**Correct Pattern**:
```
✅ RIGHT: [SlashCommand completes] → [immediately invoke both Task agents in parallel] → [update frontmatter] → [output final result]
```

Do NOT:
- Stop to report status after Step 1 completes
- Output any summary of artifacts created
- Ask the user if they want sign-off reviews
- Pause between any steps
- Send any message to user until Step 4

DO:
- Complete `/speckit.plan` → immediately invoke PM + Architect agents (in parallel) → update frontmatter → output final result
- Only output to user ONCE at the end (Step 4)

---

## Context

You are executing `/triad.plan`, a thin wrapper around `/speckit.plan` that adds automatic dual sign-off (PM + Architect) validation per Constitution v1.4.0.

**Wrapper Responsibilities**:
1. Call vanilla `/speckit.plan` to create plan.md
2. Auto-invoke head-honcho agent for PM feasibility review
3. Auto-invoke architect agent for technical design review
4. Update plan.md frontmatter with both verdicts
5. Block progression if either agent requests changes

## User Input

```text
$ARGUMENTS
```

Accept any arguments provided by user and pass through to vanilla command.

## Step 1: Call Vanilla Spec Kit

Use the SlashCommand tool to execute the vanilla planning command:

```
/speckit.plan $ARGUMENTS
```

Wait for the command to complete.

## Step 1.5: Validate Output Location & Get Feature Path

**CRITICAL**: Validate plan.md was created in the correct location and get paths for dual review.

1. **Get Feature Directory**:
   ```bash
   FEATURE_DIR=$(dirname $(.specify/scripts/bash/get-feature-path.sh plan.md))
   ```

2. **Validate plan.md Location**:
   - Check if plan.md exists at `$FEATURE_DIR/plan.md` (CORRECT location)
   - Check if plan.md exists at `.specify/plan.md` (WRONG location)

3. **Auto-Fix Wrong Location** (Defense-in-Depth):
   ```bash
   if [[ -f ".specify/plan.md" ]] && [[ ! -f "$FEATURE_DIR/plan.md" ]]; then
       # Wrong location detected - move to correct location
       mv .specify/plan.md "$FEATURE_DIR/plan.md"
       echo "⚠️ plan.md was created in wrong location and has been moved to $FEATURE_DIR/plan.md"
   fi
   ```

4. **Store Paths for Steps 2-3**:
   - `PLAN_PATH=$FEATURE_DIR/plan.md`
   - `SPEC_PATH=$FEATURE_DIR/spec.md`

## Step 2: Dual Sign-Off (Parallel)

**CRITICAL**: Automatically invoke BOTH agents in parallel (single message, two Task calls). Do NOT wait for user to request this. Do NOT run sequentially.

### Task 1: PM Feasibility Review

```python
Task(
    subagent_type="head-honcho",
    description="PM sign-off for plan feasibility",
    prompt="""Review the technical plan for product and feasibility alignment per Constitution v1.4.0.

**Context**:
- Feature Directory: $FEATURE_DIR (from get-feature-path.sh)
- Plan created: $FEATURE_DIR/plan.md
- Specification: $FEATURE_DIR/spec.md
- Workflow: Triad wrapper auto-review (parallel with Architect)
- Required: PM sign-off before task breakdown

**Review Responsibilities**:

1. **Product-Plan Alignment**:
   - Does plan deliver spec requirements?
   - Does plan maintain product vision?
   - Are trade-offs acceptable from product perspective?
   - Is scope creep avoided?

2. **Feasibility Assessment**:
   - Is timeline realistic?
   - Are resource requirements reasonable?
   - Are dependencies identified?
   - Are risks acknowledged?

3. **User Value Validation**:
   - Does plan prioritize user needs?
   - Are MVP vs future features clear?
   - Is technical complexity justified by user value?

**Provide Structured Review**:

**Status**: [APPROVED | CHANGES_REQUESTED]

**Product-Plan Alignment**:
- ✅ | ⚠️ | ❌ Delivers spec requirements
- ✅ | ⚠️ | ❌ Maintains product vision
- ✅ | ⚠️ | ❌ Acceptable trade-offs
- ✅ | ⚠️ | ❌ No scope creep

**Feasibility**:
- ✅ | ⚠️ | ❌ Realistic timeline
- ✅ | ⚠️ | ❌ Reasonable resources
- ✅ | ⚠️ | ❌ Dependencies identified

**Critical Issues** (if any): [List blocking issues]
**Concerns** (if any): [List non-blocking concerns]
**Recommendations** (if any): [List improvements]

**Approval**: [APPROVED | CHANGES_REQUESTED]

**Justification**: [1-2 sentences explaining decision]

---

**IMPORTANT**: If status is CHANGES_REQUESTED, user must address issues before proceeding to /triad.tasks.
"""
)
```

### Task 2: Architect Technical Review

```python
Task(
    subagent_type="architect",
    description="Architect sign-off for technical design",
    prompt="""Review the technical plan for architecture quality and consistency per Constitution v1.4.0.

**Context**:
- Feature Directory: $FEATURE_DIR (from get-feature-path.sh)
- Plan created: $FEATURE_DIR/plan.md
- Specification: $FEATURE_DIR/spec.md
- Workflow: Triad wrapper auto-review (parallel with PM)
- Required: Architect sign-off before task breakdown

**Review Responsibilities**:

1. **Technical Validation**:
   - Consistency with existing tech stack (docs/architecture/00_Tech_Stack/tech-stack.md)
   - Adherence to architecture principles
   - No anti-patterns or technical debt introduced
   - Security and performance considerations
   - Database schema consistency (if applicable)
   - API contract consistency (if applicable)

2. **Design Quality**:
   - Are design decisions justified?
   - Are alternatives considered?
   - Are patterns appropriate?
   - Is complexity minimized?

3. **Architecture Documentation**:
   - Are new technologies documented?
   - Are design patterns explained?
   - Are trade-offs recorded?
   - Should an ADR be created?

**Provide Structured Review**:

**Status**: [APPROVED | APPROVED_WITH_CONCERNS | CHANGES_REQUESTED]

**Technical Validation**:
- ✅ | ⚠️ | ❌ Consistent with tech stack
- ✅ | ⚠️ | ❌ Follows architecture principles
- ✅ | ⚠️ | ❌ No anti-patterns introduced
- ✅ | ⚠️ | ❌ Security/performance OK

**Design Quality**:
- ✅ | ⚠️ | ❌ Design decisions justified
- ✅ | ⚠️ | ❌ Alternatives considered
- ✅ | ⚠️ | ❌ Appropriate patterns
- ✅ | ⚠️ | ❌ Complexity minimized

**Documentation Needs**:
- [ ] Update tech-stack.md (new technology)
- [ ] Update patterns/ (new pattern)
- [ ] Create ADR (major decision)
- [ ] Update deployment docs (infrastructure change)

**Critical Issues** (if any): [List blocking issues]
**Concerns** (if any): [List non-blocking concerns]
**Recommendations** (if any): [List improvements]

**Approval**: [APPROVED | APPROVED_WITH_CONCERNS | CHANGES_REQUESTED]

**Justification**: [1-2 sentences explaining decision]

---

**IMPORTANT**: If status is CHANGES_REQUESTED, user must address issues before proceeding to /triad.tasks.
"""
)
```

**Execute both Task calls in a SINGLE message** to maximize parallelism.

## Step 3: Update Frontmatter

Read both agent review responses and extract:
- PM Status: APPROVED or CHANGES_REQUESTED
- Architect Status: APPROVED, APPROVED_WITH_CONCERNS, or CHANGES_REQUESTED
- Date: Today's date (2025-11-23)
- PM Notes: Brief summary (1-2 sentences)
- Architect Notes: Brief summary (1-2 sentences)

Use the Edit tool to update `$FEATURE_DIR/plan.md` frontmatter (use the PLAN_PATH from Step 1.5):

**Add or update these fields**:
```yaml
pm_signoff: [APPROVED | CHANGES_REQUESTED]
pm_signoff_date: 2025-11-23
pm_signoff_notes: [Brief summary from PM review]
architect_signoff: [APPROVED | APPROVED_WITH_CONCERNS | CHANGES_REQUESTED]
architect_signoff_date: 2025-11-23
architect_signoff_notes: [Brief summary from Architect review]
```

**Location**: Add immediately after existing frontmatter fields, before the first `---` closing delimiter.

## Step 4: Validate & Output

**If BOTH PM + Architect = APPROVED (or APPROVED_WITH_CONCERNS)**:
```markdown
✅ **Plan Approved**

**PM Sign-Off**: APPROVED (2025-11-23)
- [PM notes]

**Architect Sign-Off**: [APPROVED | APPROVED_WITH_CONCERNS] (2025-11-23)
- [Architect notes]

**Architect Concerns** (if any):
- [List concerns if APPROVED_WITH_CONCERNS]

**Next Step**:
/triad.tasks

The plan has passed dual review and is ready for task breakdown.
```

**If EITHER PM or Architect = CHANGES_REQUESTED**:
```markdown
⚠️ **Plan Requires Changes**

**PM Sign-Off**: [status] (2025-11-23)
{if CHANGES_REQUESTED:}
**PM Critical Issues**:
- [List issues]

**Architect Sign-Off**: [status] (2025-11-23)
{if CHANGES_REQUESTED:}
**Architect Critical Issues**:
- [List issues]

**Recommendations**:
{from PM if any}
{from Architect if any}

**Action Required**:
1. Address all issues listed above
2. Re-run `/triad.plan` to update plan and get fresh dual review

**Blocked**: Cannot proceed to /triad.tasks until BOTH PM and Architect approve.
```

## Design Principles

**Keep This Wrapper Thin**:
- ✅ Call vanilla command
- ✅ Invoke dual sign-off (parallel)
- ✅ Update frontmatter
- ❌ Do NOT add: automatic architecture doc updates (Architect does this separately)
- ❌ Do NOT add: git operations, linting, formatting
- ❌ Do NOT add: automatic remediation

**One Governance Concern**: Dual sign-off validation only.

**Parallelism**: Launch both agents simultaneously to save time.

**Upgrade-Safe**: This wrapper calls `/speckit.plan` by name, so upstream updates are automatically inherited.
