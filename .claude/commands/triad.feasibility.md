---
name: triad.feasibility
description: >
  Perform feasibility check on draft PRD to estimate effort, timeline, agent assignments, and capacity.
  This command invokes the team-lead agent to provide realistic timeline estimates before PM finalizes
  PRD. Prevents timeline errors like PM-001 where PRD-004 proposed 7 days for a 2-4 hour task.

usage: /triad.feasibility <feature-id>

examples:
  - /triad.feasibility 005-frontend-deployment
  - /triad.feasibility 006-user-authentication
  - /triad.feasibility 007-api-rate-limiting

expertise:
  - timeline-estimation
  - capacity-planning
  - agent-orchestration

model: claude-sonnet-4-5-20250929
---

You are executing the `/triad.feasibility` command to perform a feasibility check on a draft PRD.

## Constitutional Authority

Per Constitution v1.4.0, Principle XI (SDLC Triad Collaboration):
- **Tech-Lead** must estimate timeline and validate capacity before PM finalizes PRD
- **Purpose**: Prevent timeline errors (see PM-001: PRD-004 proposed 7 days for 2-4 hour task = 21x error)
- **Feasibility checks** provide realistic timelines based on current state and capacity
- **Phase 2** of SDLC Triad workflow (after PM draft, before finalization)

## Command Parameters

**Feature ID**: `{{feature-id}}`

If feature-id is missing, prompt the user:
```
❌ Error: Feature ID required

Usage: /triad.feasibility <feature-id>

Example: /triad.feasibility 006-phase-production-launch

The feature-id should match the PRD number format (NNN-feature-name).
This creates files in specs/NNN-feature-name/ to match the PRD numbering.

NOTE: Branch names may differ from spec folder names (branch names are auto-generated).
The spec folder should always match the PRD number for traceability.
```

## Feasibility Check Purpose

**Problem**: PMs estimate timelines without understanding:
- Current infrastructure completion state
- Agent capacity and availability
- Dependency constraints
- Parallel execution opportunities

**Result**: Timelines off by 21x (7 days vs 2-4 hours in PRD-004)

**Solution**: Tech-Lead provides realistic timeline estimates based on:
- Architect baseline (what's done vs remaining)
- Current team velocity (hours/day realistic completion)
- Agent workload distribution (backend, frontend, devops, tester)
- Critical path analysis (what blocks parallel work?)

**Outcome**: PRD has realistic timeline, PM makes informed scope/timeline trade-offs

## Workflow

### Step 1: Locate Draft PRD

Find the draft PRD file:

```bash
ls docs/product/02_PRD/{{feature-id}}-*.md
```

Example: `docs/product/02_PRD/005-frontend-deployment-2025-11-23.md`

If PRD doesn't exist, error:
```
❌ Error: Draft PRD not found

Expected: docs/product/02_PRD/{{feature-id}}-*.md

Create PRD first using: /speckit.prd <topic>
```

### Step 2: Check for Architect Baseline (if infrastructure work)

Check if architect baseline exists:

```bash
ls specs/{{feature-id}}/architect-baseline.md
```

**If exists**: Use baseline for timeline estimation
**If missing**: For infrastructure PRDs, warn:
```
⚠️ Warning: Architect baseline not found

For infrastructure PRDs, baseline should exist at:
specs/{{feature-id}}/architect-baseline.md

Create baseline first using: /speckit.architect-baseline {{feature-id}}

Continue without baseline? (y/n)
```

### Step 3: Invoke Team-Lead Agent

Spawn the team-lead agent to perform feasibility check:

**Agent Task**:
```
Invoking team-lead agent to perform feasibility check for: {{feature-id}}

Agent Responsibilities:
1. Read draft PRD:
   - File: docs/product/02_PRD/{{feature-id}}-{date}.md
   - Understand: Scope, requirements, dependencies

2. Read architect baseline (if exists):
   - File: specs/{{feature-id}}/architect-baseline.md
   - Understand: What's done vs remaining

3. Estimate effort by work stream:
   - Backend: X hours
   - Frontend: Y hours
   - Testing: Z hours
   - Deployment: W hours
   - Documentation: V hours

4. Identify agent assignments:
   - Which specialized agents needed? (backend, frontend, devops, tester)
   - Workload distribution (hours per agent)
   - Flag overloaded agents (>80% capacity)
   - Suggest parallel execution opportunities

5. Provide timeline estimate:
   - Optimistic: All parallel, no blockers, high velocity
   - Realistic: Some serial, normal blockers, typical velocity
   - Pessimistic: Dependencies delay, capacity constraints, low velocity
   - Confidence level: High (90%+), Medium (70-90%), Low (<70%)

6. Assess risks:
   - Timeline risks (what could delay?)
   - Capacity risks (bottlenecks, overloaded agents)
   - Dependency risks (external blockers)

7. Create feasibility report:
   - File: specs/{{feature-id}}/feasibility-check.md
   - Format: Follow template in .claude/agents/team-lead.md
   - Verdict: FEASIBLE / FEASIBLE WITH MODIFICATIONS / NOT FEASIBLE

Context:
- Feature ID: {{feature-id}}
- Draft PRD: docs/product/02_PRD/{{feature-id}}-{date}.md
- Architect Baseline: specs/{{feature-id}}/architect-baseline.md (if exists)
- Report Location: specs/{{feature-id}}/feasibility-check.md
- Check Date: {today's date}
```

### Step 4: Validate Feasibility Report

After team-lead creates feasibility check, validate it contains:

**Required Sections**:
- ✅ Effort Estimation (work streams with hours/days)
- ✅ Agent Assignment Preview (which agents, how many hours)
- ✅ Timeline Estimate (optimistic/realistic/pessimistic)
- ✅ Risk Assessment (timeline, capacity, dependency risks)
- ✅ Feasibility Verdict (feasible, modifications, not feasible)

**Quality Checks**:
- [ ] Timeline estimates are realistic (not guesses)
- [ ] Agent assignments are specific (not vague "team")
- [ ] Workload distribution is balanced (no single agent >80% utilized)
- [ ] Risks are identified with mitigations
- [ ] Verdict is clear with recommendations for PM

### Step 5: Provide Output Summary

After successful feasibility check, output:

```
✅ Feasibility Check Complete!

Feature: {{feature-id}}
Report: specs/{{feature-id}}/feasibility-check.md
Check Date: {date}

Effort Estimation:
- Backend: {X hours}
- Frontend: {Y hours}
- Testing: {Z hours}
- Deployment: {W hours}
- Documentation: {V hours}
- **Total**: {Total hours/days}

Agent Assignment Preview:
- {Agent 1}: {X hours} - {tasks}
- {Agent 2}: {Y hours} - {tasks}
- {Agent 3}: {Z hours} - {tasks}
- Workload: {Balanced / {Agent} overloaded}

Timeline Estimate:
- Optimistic: {X hours/days} (all parallel, no blockers)
- **Realistic: {Y hours/days} ← RECOMMENDED**
- Pessimistic: {Z hours/days} (dependencies, capacity issues)
- Confidence: {High/Medium/Low}

Risk Assessment:
- Timeline Risks: {count} identified
- Capacity Risks: {count} identified
- Dependency Risks: {count} identified

Feasibility Verdict: {FEASIBLE / FEASIBLE WITH MODIFICATIONS / NOT FEASIBLE}

Recommendations for PM:
1. {Recommendation 1}
2. {Recommendation 2}
3. {Recommendation 3}

Next Steps:
1. PM incorporates timeline estimate into PRD
2. PM uses realistic timeline (not optimistic or pessimistic)
3. PM validates product requirements still achievable with this timeline
4. If timeline unacceptable: PM reduces scope OR extends deadline OR adds resources
5. Continue to Architect technical review: Architect validates PRD technical accuracy

SDLC Triad Workflow:
- ✅ Phase 0 Complete: Architect Baseline (if infrastructure)
- ✅ Phase 1 Complete: PM drafted PRD
- ✅ Phase 2 Complete: Tech-Lead Feasibility Check ← YOU ARE HERE
- ⏳ Phase 3 Next: Architect technical review
- ⏳ Phase 4 Next: PM finalizes PRD with all Triad input

Success Metrics (vs PM-001 baseline):
- Timeline accuracy target: Within 20% of actual (baseline: 21x error in PRD-004)
- Feasibility check time: {duration} (target: <30 minutes)
- Capacity constraints identified: {count} (prevents bottlenecks)
```

## Error Handling

### Missing Feature ID

```
❌ Error: Feature ID required

Usage: /triad.feasibility <feature-id>

Example: /triad.feasibility 005-frontend-deployment
```

### Draft PRD Not Found

```
❌ Error: Draft PRD not found for {{feature-id}}

Expected location: docs/product/02_PRD/{{feature-id}}-*.md

Create PRD first using: /speckit.prd <topic>

Available PRDs:
{list existing PRDs}
```

### Baseline Missing (Infrastructure PRD)

```
⚠️ Warning: Architect baseline not found

For infrastructure PRDs, baseline should exist at:
specs/{{feature-id}}/architect-baseline.md

Without baseline, timeline estimates may be inaccurate (cannot determine what's
already done vs what remains).

Create baseline first using: /speckit.architect-baseline {{feature-id}}

Continue without baseline? (y/n)
```

## Feasibility Report Template

The team-lead agent should follow this template from `.claude/agents/team-lead.md`:

```markdown
# Feasibility Check: {Feature Name}

**Feature**: {NNN-feature-name}
**Date**: {YYYY-MM-DD}
**Tech-Lead**: Claude (team-lead agent)

---

## Effort Estimation

**Work Streams**:
1. {Stream 1 (e.g., Backend API)}: [X hours/days]
2. {Stream 2 (e.g., Frontend UI)}: [Y hours/days]
3. {Stream 3 (e.g., Testing)}: [Z hours/days]
4. {Stream 4 (e.g., Deployment)}: [W hours/days]
5. {Stream 5 (e.g., Documentation)}: [V hours/days]

**Total Effort**: [X hours/days]
**Confidence Level**: [High/Medium/Low]
**Confidence Rationale**: [Why this confidence level?]

---

## Agent Assignment Preview

**Agents Required**:
- **{Agent 1 (e.g., devops)}**: [X hours] - {specific tasks}
- **{Agent 2 (e.g., senior-backend-engineer)}**: [Y hours] - {specific tasks}
- **{Agent 3 (e.g., code-monkey)}**: [Z hours] - {specific tasks}
- **{Agent 4 (e.g., tester)}**: [W hours] - {specific tasks}

**Workload Distribution**: [Balanced / {Agent} overloaded at {%} capacity]
**Workload Notes**: [Any capacity concerns or optimization opportunities]

---

## Timeline Estimate

**Critical Path**: {Description of longest dependency chain}
**Dependencies**: {Blocking dependencies that must be resolved}
**Parallel Opportunities**: {Tasks that can run concurrently}

**Realistic Timeline**:
- **Optimistic**: [X hours/days] (all parallel, no blockers, high velocity)
- **Realistic**: [Y hours/days] (some serial, normal blockers, typical velocity)
- **Pessimistic**: [Z hours/days] (dependencies delay, capacity constraints, low velocity)

**Confidence Level**: [High/Medium/Low]

**Recommendation**: [Timeline range with confidence level]
- Example: "2-4 hours (High confidence)" or "3-5 days (Medium confidence)"

---

## Risk Assessment

**Timeline Risks**:
- **{Risk 1}**: [Likelihood: High/Med/Low] [Impact: High/Med/Low]
  - Description: {What could delay timeline?}
  - Mitigation: {How to reduce risk?}

**Capacity Risks**:
- **{Risk 1}**: [Likelihood/Impact]
  - Description: {Capacity constraints or bottlenecks}
  - Mitigation: {How to address capacity issues?}

**Dependency Risks**:
- **{Risk 1}**: [Likelihood/Impact]
  - Description: {External or blocking dependencies}
  - Mitigation: {How to unblock or work around?}

---

## Feasibility Verdict

**Overall Assessment**: [FEASIBLE / FEASIBLE WITH MODIFICATIONS / NOT FEASIBLE]

**Reasoning**: {1-2 sentence explanation}

**Recommendations for PM**:
1. {Recommendation 1 - e.g., "Use realistic timeline: 2-4 hours (not 7 days)"}
2. {Recommendation 2 - e.g., "Scope down feature if timeline is firm"}
3. {Recommendation 3 - e.g., "Add resource: second backend engineer for parallel work"}

**Next Steps**: [What PM should do with this feasibility check]
```

## Integration with SDLC Triad Workflow

This command is **Phase 2** of both Infrastructure and Feature PRD workflows:

```
Infrastructure PRD Workflow (Sequential):
0. /speckit.architect-baseline
1. PM drafts PRD
2. /triad.feasibility ← YOU ARE HERE
3. Architect technical review
4. PM finalizes PRD

Feature PRD Workflow (Parallel):
1. PM drafts PRD
2a. /triad.feasibility ← YOU ARE HERE (parallel with 2b)
2b. Architect technical review (parallel with 2a)
3. PM finalizes PRD
```

## Files Created by This Command

**Created**:
- `specs/{feature-id}/feasibility-check.md` - Feasibility report with timeline estimates

## Related Commands

- `/speckit.prd` - Create PRD (auto-invokes feasibility check)
- `/speckit.architect-baseline` - Create infrastructure baseline (used by feasibility check)
- `/speckit.analyze` - Validate timeline accuracy post-implementation

## Related Agents

- `team-lead` - Performs feasibility checks and timeline estimates
- `head-honcho` - Uses feasibility check to finalize PRD timeline
- `architect` - Provides baseline data for accurate estimates

## Success Criteria

You have successfully completed this command when:

1. ✅ Feasibility report created at `specs/{feature-id}/feasibility-check.md`
2. ✅ Effort estimated by work stream (backend, frontend, testing, deployment, docs)
3. ✅ Agent assignments identified (which agents, how many hours)
4. ✅ Timeline estimate provided (optimistic/realistic/pessimistic with confidence)
5. ✅ Risks assessed (timeline, capacity, dependency)
6. ✅ Verdict clear (feasible, modifications, not feasible)
7. ✅ PM can use realistic timeline to finalize PRD

## Success Metrics

**Target Performance** (vs PM-001 baseline):
- Timeline accuracy: Within 20% of actual (baseline: 21x error in PRD-004)
- Feasibility check time: <30 minutes
- Capacity constraints identified before development starts
- Agent assignments optimized for parallel execution

**Feasibility Quality**:
- Timeline estimates are realistic (not guesses or wishes)
- Agent workload is balanced (<80% capacity for any single agent)
- Risks are identified with specific mitigations
- Recommendations are actionable for PM

## Remember

**Purpose**: This feasibility check prevents PM from guessing timelines. Tech-Lead provides realistic estimates based on current state, capacity, and velocity.

**Usage**: Always run AFTER PM drafts PRD, BEFORE PM finalizes. PM must use Tech-Lead's realistic timeline, not their own guess.

**SDLC Triad**: This is Phase 2 of Triad workflow - Tech-Lead estimates timeline, PM incorporates estimate, Architect validates technical accuracy, PM finalizes.

**Timeline Authority**: Per Constitution Principle XI, Tech-Lead has veto authority over timeline estimates. PM cannot override Tech-Lead's capacity-based estimate.

---

**Now execute the workflow above to perform feasibility check for: {{feature-id}}**
