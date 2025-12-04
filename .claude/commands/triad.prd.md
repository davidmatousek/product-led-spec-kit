---
name: triad.prd
description: >
  Create a Product Requirements Document (PRD) using the head-honcho Product Manager
  agent and prd-create skill. PRDs are stored in docs/product/02_PRD/ with sequential
  numbering and date stamps for chronological tracking.

usage: /triad.prd <topic>

examples:
  - /triad.prd task-locking-api
  - /triad.prd rag-search-implementation
  - /triad.prd user-authentication

expertise:
  - product-management
  - prd-creation
  - requirements-gathering

model: claude-sonnet-4-5-20250929
---

You are executing the `/triad.prd` command to create a Product Requirements Document (PRD) with automatic SDLC Triad validation.

## Constitutional Authority

Per Constitution v1.4.0:
- **Principle X**: Product-Spec Alignment - ALWAYS create PRD before spec.md (NON-NEGOTIABLE)
- **Principle XI**: SDLC Triad Collaboration - PRD must have Triad validation (Architect + Tech-Lead + PM)
- PRD creation is the responsibility of the Product Manager (head-honcho)
- PRDs must use industry-standard format via prd-create skill
- **NEW**: Auto-invoke Triad workflow for all PRDs starting PRD-005 (effective 2025-11-22)

## Command Parameters

**Topic**: `{{topic}}`

If topic is missing, prompt the user:
```
❌ Error: PRD topic required

Usage: /triad.prd <topic>

Example: /triad.prdtask-locking-api

The topic should be a short, descriptive kebab-case name for the feature.
```

## PRD Naming Convention

PRDs are stored with sequential numbering for chronological tracking:

**Format**: `NNN-topic-YYYY-MM-DD.md`

**Example**: `001-task-locking-api-2025-11-19.md`

**Location**: `docs/product/02_PRD/`

## Workflow

### Step 1: Determine PRD Number

1. List existing PRDs to find the next sequential number:
```bash
ls docs/product/02_PRD/*.md | grep -E "^[0-9]" | sort | tail -1
```

2. Extract the number from the last PRD (e.g., `003-...md` → next is `004`)

3. If no PRDs exist yet, start with `001`

### Step 2: Create PRD Filename

**Pattern**: `{NNN}-{topic}-{YYYY-MM-DD}.md`

**Components**:
- `NNN`: Zero-padded sequential number (001, 002, 003, ...)
- `topic`: User-provided topic from command parameter
- `YYYY-MM-DD`: Today's date (from system)

**Example**:
- Next number: 004
- Topic: task-locking-api
- Date: 2025-11-19
- Filename: `004-task-locking-api-2025-11-19.md`

### Step 3: Invoke head-honcho Agent

You must now spawn the head-honcho agent to create the PRD. The agent will:

1. Use the `prd-create` skill to generate an industry-standard PRD
2. Follow the comprehensive PRD structure from `.claude/skills/prd-create/skill.md`
3. Gather context from existing product artifacts:
   - Product vision: `docs/product/01_Product_Vision/`
   - OKRs: `docs/product/06_OKRs/`
   - Roadmap: `docs/product/03_Product_Roadmap/`
   - User Stories: `docs/product/05_User_Stories/`
   - Customer Journeys: `docs/product/04_Customer_Journey_Maps/`

**Agent Invocation**:

```
Invoking head-honcho agent to create PRD for: {{topic}}

Agent Task:
1. Use prd-create skill to generate comprehensive PRD
2. Research existing product context (vision, OKRs, roadmap)
3. Create PRD following industry-standard template
4. Save to: docs/product/02_PRD/{NNN}-{topic}-{YYYY-MM-DD}.md
5. Update PRD index: docs/product/02_PRD/INDEX.md

Context:
- Feature/Topic: {{topic}}
- PRD Filename: {calculated filename}
- Creation Date: {today's date}
```

### Step 3.5: Auto-Detect Infrastructure Work (NEW - SDLC Triad)

**Check if PRD is infrastructure/deployment work**:

Scan topic and PRD content for keywords:
- "deploy", "deployment", "infrastructure", "production", "staging"
- "vercel", "database provisioning", "environment setup"

**If infrastructure detected** → Use **Infrastructure PRD workflow** (Sequential Triad)
**If not detected** → Use **Feature PRD workflow** (Parallel Triad)

### Step 4: SDLC Triad Workflow (NEW - Constitution v1.4.0)

**IMPORTANT**: This step is MANDATORY for all PRDs starting PRD-005 (per Constitution Principle XI)

#### Infrastructure PRD Workflow (Sequential - ~2-4 hours)

**When**: Infrastructure keywords detected in topic or PRD content

**Process**:

1. **Architect Baseline (Phase 0)** - FIRST
   ```
   Invoke architect agent:
   - Read: docs/architecture/04_deployment_environments/production.md
   - Read: docs/architecture/04_deployment_environments/staging.md
   - Read: docs/product/STATUS.md
   - Read: git log --oneline -20
   - Create: specs/{feature-id}/architect-baseline.md
   - Hand baseline to PM
   ```

2. **PM Incorporates Baseline into PRD**
   - PM updates draft PRD with "Current State" section
   - PM uses baseline data to correct infrastructure claims
   - Mark timeline as "TBD - pending Tech-Lead feasibility"

3. **Tech-Lead Feasibility Check (Phase 2)** - SECOND
   ```
   Invoke team-lead agent:
   - Read: Draft PRD at docs/product/02_PRD/{NNN}-{topic}-{date}.md
   - Read: Architect baseline at specs/{feature-id}/architect-baseline.md
   - Estimate: Effort, timeline, agent assignments, capacity
   - Create: specs/{feature-id}/feasibility-check.md
   - Provide: Optimistic/Realistic/Pessimistic timeline
   ```

4. **PM Incorporates Timeline into PRD**
   - PM updates PRD timeline with Tech-Lead's realistic estimate
   - PM validates product requirements still achievable

5. **Architect Technical Review (Phase 3)** - THIRD
   ```
   Invoke architect agent:
   - Read: Draft PRD at docs/product/02_PRD/{NNN}-{topic}-{date}.md
   - Cross-check: Infrastructure claims vs baseline
   - Validate: Technical feasibility, dependency accuracy
   - Create: docs/agents/architect/{date}_{feature}_prd-review_ARCH.md
   - Verdict: APPROVED or CHANGES REQUESTED
   ```

6. **PM Finalizes PRD**
   - If APPROVED → Finalize PRD, mark Status: Approved
   - If CHANGES REQUESTED → Address corrections, re-submit for review
   - Only finalize when Architect verdict is APPROVED

#### Feature PRD Workflow (Parallel - ~1-2 hours)

**When**: No infrastructure keywords detected

**Process**:

1. **PM Drafts PRD** (already done in Step 3)

2. **Parallel Reviews** - Run simultaneously:
   ```
   Invoke architect agent (Technical Review):
   - Read: Draft PRD
   - Validate: Technical feasibility, technology stack alignment
   - Create: docs/agents/architect/{date}_{feature}_prd-review_ARCH.md
   - Verdict: APPROVED or CHANGES REQUESTED

   Invoke team-lead agent (Feasibility Check):
   - Read: Draft PRD
   - Estimate: Timeline, agents, capacity
   - Create: specs/{feature-id}/feasibility-check.md
   - Provide: Realistic timeline estimate
   ```

3. **PM Incorporates Feedback**
   - Update PRD with Tech-Lead timeline
   - Address Architect corrections (if any)
   - Re-submit if Architect requested changes

4. **PM Finalizes PRD**
   - Only finalize when both reviews complete
   - Only finalize when Architect verdict is APPROVED

#### Triad Success Criteria

All PRDs (starting PRD-005) MUST have:
- ✅ Architect baseline report (if infrastructure work)
- ✅ Tech-Lead feasibility check with timeline estimate
- ✅ Architect technical review with APPROVED verdict
- ✅ PRD timeline based on Tech-Lead estimate (not PM guess)
- ✅ PRD infrastructure claims validated by Architect against baseline

**Validation Gates**:
- PRD cannot be marked "Approved" until Architect verdict is APPROVED
- PRD timeline must use Tech-Lead's estimate, not PM's guess
- Infrastructure PRDs must incorporate Architect baseline into "Current State"

### Step 5: Update PRD Index

After PRD creation, update `docs/product/02_PRD/INDEX.md` with:

```markdown
| PRD # | Topic | Created | Status | Phase | Related Spec |
|-------|-------|---------|--------|-------|--------------|
| {NNN} | [{topic}]({filename}) | {date} | Draft | TBD | - |
```

**Status Values**:
- `Draft` - PRD created, not yet reviewed
- `Approved` - PM approved, ready for spec creation
- `In Progress` - Spec/plan/tasks being created
- `Implemented` - Feature delivered
- `Archived` - Obsolete or replaced

### Step 6: Provide Output Summary

After successful PRD creation and Triad validation, output:

```
✅ PRD Created Successfully with SDLC Triad Validation!

PRD: {NNN}-{topic}-{date}
File: docs/product/02_PRD/{NNN}-{topic}-{date}.md
Status: {Draft | Approved}
Created: {date}
Workflow: {Infrastructure (Sequential) | Feature (Parallel)}

Triad Validation Results:
- ✅ Architect Baseline: {specs/{feature-id}/architect-baseline.md} (if infrastructure)
- ✅ Tech-Lead Feasibility: {specs/{feature-id}/feasibility-check.md}
- ✅ Architect Review: {docs/agents/architect/{date}_{feature}_prd-review_ARCH.md}
- ✅ Verdict: {APPROVED | CHANGES REQUESTED}

Timeline Estimate (from Tech-Lead):
- Optimistic: {X hours/days}
- Realistic: {Y hours/days} (RECOMMENDED)
- Pessimistic: {Z hours/days}

Technical Inaccuracies Found: {count} (target: <3)

Next Steps:
1. {If APPROVED}: Create spec from PRD: /speckit.specify
2. {If CHANGES REQUESTED}: Review architect corrections and revise PRD
3. View all PRDs: cat docs/product/02_PRD/INDEX.md
4. View Triad artifacts in specs/{feature-id}/

Constitutional Requirements (v1.4.0):
- Principle X: This PRD must be approved before creating spec.md
- Principle XI: SDLC Triad validation complete (Architect + Tech-Lead + PM)
- Use /speckit.specify only after PRD status is "Approved"

Success Metrics (vs PM-001 baseline):
- Technical inaccuracies: {count} (target: <3, baseline: 18 in PRD-004)
- Triad cycle time: {duration} (target: <4 hours for infrastructure, <2 hours for feature)
- Architect review time: {duration} (target: <30 min, baseline: 2-3 hours for PRD-004)
```

## Error Handling

### Missing Topic

```
❌ Error: PRD topic required

Usage: /triad.prd <topic>

Example: /triad.prdtask-locking-api
```

### Invalid Topic Format

If topic contains invalid characters (spaces, special chars except hyphens):

```
❌ Error: Invalid topic format

Topic must be kebab-case (lowercase, hyphens only).

Invalid: "Task Locking API"
Valid:   "task-locking-api"
```

### Duplicate PRD Topic

If a PRD with similar topic already exists:

```
⚠️ Warning: Similar PRD may exist

Found existing PRD: 002-task-locking-2025-11-10.md

Do you want to:
1. Create new PRD anyway (continue)
2. View existing PRD
3. Cancel

Your choice:
```

## PRD Quality Standards

The head-honcho agent must ensure the PRD includes:

**Minimum Required Sections**:
- ✅ Executive Summary (problem, solution, success criteria)
- ✅ Strategic Alignment (vision, OKRs, roadmap fit)
- ✅ Target Users & Personas (who benefits?)
- ✅ User Stories (job stories with acceptance criteria)
- ✅ Functional Requirements (what does it do?)
- ✅ Non-Functional Requirements (performance, security, etc.)
- ✅ Success Metrics (measurable outcomes)
- ✅ Scope & Boundaries (in scope vs out of scope)
- ✅ Timeline & Milestones (delivery plan)
- ✅ Risks & Dependencies (what could go wrong?)

**Quality Checklist**:
- [ ] Problem statement is clear and user-focused
- [ ] User stories have testable acceptance criteria
- [ ] Success metrics are specific and measurable
- [ ] Scope is realistic for timeline
- [ ] Dependencies are identified
- [ ] Aligns with product vision and OKRs

## Integration with Spec Kit Workflow

**PRD → Spec Flow**:

```
1. /speckit.prd <topic>           → Create PRD (this command)
2. PM reviews & approves PRD      → Manual review
3. /speckit.specify               → Create spec.md from PRD
4. PM signs off on spec.md        → Validates alignment
5. /speckit.plan                  → Create plan.md from spec
6. PM signs off on plan.md        → Validates feasibility
7. /speckit.tasks                 → Create tasks.md from plan
8. PM signs off on tasks.md       → Validates prioritization
9. /speckit.implement             → Execute implementation
```

**Traceability**:

Every spec.md MUST reference its source PRD:

```markdown
---
source_prd: docs/product/02_PRD/004-task-locking-api-2025-11-19.md
---
```

## Files Modified by This Command

**Created**:
- `docs/product/02_PRD/{NNN}-{topic}-{YYYY-MM-DD}.md` - The PRD document

**Updated**:
- `docs/product/02_PRD/INDEX.md` - PRD registry with metadata

## Related Commands

- `/speckit.specify` - Create spec.md from PRD (requires PRD approval first)
- `/speckit.analyze` - Validate PRD-spec alignment
- `/speckit.clarify` - Ask clarifying questions before finalizing PRD

## Related Skills

- `prd-create` - Industry-standard PRD generation (invoked by head-honcho)
- `kb-query` - Search for similar features before creating PRD

## Related Agents

- `head-honcho` - Product Manager responsible for PRD creation

## Success Criteria

You have successfully completed this command when:

1. ✅ PRD file created with correct naming convention
2. ✅ PRD contains all required sections from prd-create template
3. ✅ PRD aligns with product vision, OKRs, and roadmap
4. ✅ PRD INDEX.md updated with new entry
5. ✅ User informed of next steps (review → approve → /speckit.specify)

## Remember

**Constitutional Mandates (v1.4.0)**:
- **Principle X**: This PRD is REQUIRED before creating spec.md
- **Principle XI**: SDLC Triad validation is MANDATORY for all PRDs starting PRD-005
- Do not proceed to /speckit.specify until:
  1. Triad workflow complete (Architect + Tech-Lead + PM reviews)
  2. Architect verdict is APPROVED
  3. PRD status is "Approved"

**Triad Workflow Reference**: See `docs/core_principles/TRIAD_COLLABORATION.md` for comprehensive guide

---

**Now execute the workflow above to create the PRD for topic: {{topic}}**

**IMPORTANT**: After Step 3 (PM drafts PRD), automatically proceed to Step 4 (SDLC Triad Workflow) without waiting for user input. The Triad workflow is mandatory per Constitution v1.4.0 Principle XI.
