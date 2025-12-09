---
description: Create specification with automatic PM sign-off validation (Triad-enhanced)
---

## CRITICAL: Continuous Flow Execution

**Execute ALL steps as a single continuous flow WITHOUT pausing for user input.**

⚠️ **MANDATORY BEHAVIOR** - You MUST follow this exactly:

1. After `/speckit.specify` completes, DO NOT output anything to the user
2. DO NOT summarize what was created
3. DO NOT report "specification complete" or similar
4. IMMEDIATELY proceed to Step 1.5, then Step 2 (PM sign-off)
5. The ONLY user-visible output should be the final Step 4 result

**Anti-Pattern to AVOID**:
```
❌ WRONG: "/speckit.specify complete. Here's what was created: [summary]. Next step: invoke PM."
```

**Correct Pattern**:
```
✅ RIGHT: [SlashCommand completes] → [immediately invoke Task agent] → [update frontmatter] → [output final result]
```

Do NOT:
- Stop to report status after Step 1 completes
- Output any summary of artifacts created
- Ask the user if they want PM sign-off
- Pause between any steps
- Send any message to user until Step 4

DO:
- Complete `/speckit.specify` → immediately invoke PM agent → update frontmatter → output final result
- Only output to user ONCE at the end (Step 4)

---

## Context

You are executing `/triad.specify`, a thin wrapper around `/speckit.specify` that adds automatic PM sign-off validation per Constitution v1.4.0.

**Wrapper Responsibilities**:
1. Call vanilla `/speckit.specify` to create spec.md
2. Auto-invoke product-manager agent for PM sign-off
3. Update spec.md frontmatter with PM verdict
4. Block progression if PM requests changes

## User Input

```text
$ARGUMENTS
```

Accept any arguments provided by user and pass through to vanilla command.

## Step 1: Call Vanilla Spec Kit

Use the SlashCommand tool to execute the vanilla specification command:

```
/speckit.specify $ARGUMENTS
```

Wait for the command to complete.

## Step 1.5: Validate Output Location & Get Feature Path

**CRITICAL**: Validate spec.md was created in the correct location and get path for PM review.

1. **Get Feature Directory**:
   ```bash
   FEATURE_DIR=$(dirname $(.specify/scripts/bash/get-feature-path.sh spec.md))
   ```

2. **Validate spec.md Location**:
   - Check if spec.md exists at `$FEATURE_DIR/spec.md` (CORRECT location)
   - Check if spec.md exists at `.specify/spec.md` (WRONG location)

3. **Auto-Fix Wrong Location** (Defense-in-Depth):
   ```bash
   if [[ -f ".specify/spec.md" ]] && [[ ! -f "$FEATURE_DIR/spec.md" ]]; then
       # Wrong location detected - move to correct location
       mv .specify/spec.md "$FEATURE_DIR/spec.md"
       echo "⚠️ spec.md was created in wrong location and has been moved to $FEATURE_DIR/spec.md"
   fi
   ```

4. **Store Path for Steps 2-3**:
   - `SPEC_PATH=$FEATURE_DIR/spec.md`

## Step 2: Auto-Invoke PM Sign-Off

**CRITICAL**: Automatically invoke the product-manager agent for PM review. Do NOT wait for user to request this.

Use the Task tool with the following parameters:

```python
Task(
    subagent_type="product-manager",
    description="PM sign-off for specification",
    prompt="""Review the specification for product alignment per Constitution v1.4.0.

**Context**:
- Feature Directory: $FEATURE_DIR (from get-feature-path.sh)
- Specification created: $FEATURE_DIR/spec.md
- Workflow: Triad wrapper auto-review
- Required: PM sign-off before planning phase

**Review Responsibilities**:

1. **Product Alignment Validation**:
   - Does spec align with product vision?
   - Does spec serve user needs?
   - Are acceptance criteria clear and measurable?
   - Is scope appropriate (not over-engineered, not under-defined)?

2. **Requirements Quality**:
   - Are user stories well-defined?
   - Are edge cases identified?
   - Are success metrics defined?
   - Are constraints documented?

3. **Governance Compliance**:
   - Does spec follow Constitution principles?
   - Is documentation complete?
   - Are stakeholders identified?

**Provide Structured Review**:

**Status**: [APPROVED | CHANGES_REQUESTED]

**Product Alignment**:
- ✅ | ⚠️ | ❌ Aligns with product vision
- ✅ | ⚠️ | ❌ Serves user needs
- ✅ | ⚠️ | ❌ Clear acceptance criteria
- ✅ | ⚠️ | ❌ Appropriate scope

**Requirements Quality**:
- ✅ | ⚠️ | ❌ Well-defined user stories
- ✅ | ⚠️ | ❌ Edge cases identified
- ✅ | ⚠️ | ❌ Success metrics defined

**Critical Issues** (if any): [List blocking issues]
**Concerns** (if any): [List non-blocking concerns]
**Recommendations** (if any): [List improvements]

**Approval**: [APPROVED | CHANGES_REQUESTED]

**Justification**: [1-2 sentences explaining decision]

---

**IMPORTANT**: If status is CHANGES_REQUESTED, user must address issues before proceeding to /triad.plan.
"""
)
```

## Step 3: Update Frontmatter

Read the PM agent's review response and extract:
- Status: APPROVED or CHANGES_REQUESTED
- Date: Today's date (2025-11-23)
- Notes: Brief summary of PM feedback (1-2 sentences)

Use the Edit tool to update `$FEATURE_DIR/spec.md` frontmatter (use the SPEC_PATH from Step 1.5):

**Add or update these fields**:
```yaml
pm_signoff: [APPROVED | CHANGES_REQUESTED]
pm_signoff_date: 2025-11-23
pm_signoff_notes: [Brief summary from PM review]
```

**Location**: Add immediately after existing frontmatter fields, before the first `---` closing delimiter.

## Step 4: Validate & Output

**If PM status = APPROVED**:
```markdown
✅ **Specification Approved**

**PM Sign-Off**: APPROVED (2025-11-23)
**Notes**: [PM notes]

**Next Step**:
/triad.plan

The specification has passed PM review and is ready for technical planning.
```

**If PM status = CHANGES_REQUESTED**:
```markdown
⚠️ **Specification Requires Changes**

**PM Sign-Off**: CHANGES_REQUESTED (2025-11-23)

**Critical Issues**:
- [List issues from PM review]

**Recommendations**:
- [List recommendations from PM review]

**Action Required**:
1. Address the issues listed above
2. Re-run `/triad.specify` to update spec and get fresh PM review

**Blocked**: Cannot proceed to /triad.plan until PM approves.
```

## Design Principles

**Keep This Wrapper Thin**:
- ✅ Call vanilla command
- ✅ Invoke PM sign-off
- ✅ Update frontmatter
- ❌ Do NOT add: git validation, linting, formatting, commits, notifications
- ❌ Do NOT add: multiple review rounds in single run
- ❌ Do NOT add: automatic fixes or modifications

**One Governance Concern**: PM sign-off validation only.

**Upgrade-Safe**: This wrapper calls `/speckit.specify` by name, so upstream updates to the vanilla command are automatically inherited.
