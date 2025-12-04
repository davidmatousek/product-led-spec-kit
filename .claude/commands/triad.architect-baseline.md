---
name: triad.architect-baseline
description: >
  Create an infrastructure baseline report documenting current system state before PRD creation.
  This command invokes the architect agent to analyze production/staging environments and document
  what infrastructure exists, what's operational, and what remains to be done. Prevents PRD errors
  like PM-001 where PRD-004 claimed infrastructure "doesn't exist" when it was 100% operational.

usage: /triad.architect-baseline <feature-id>

examples:
  - /triad.architect-baseline 005-frontend-deployment
  - /triad.architect-baseline 006-database-migration
  - /triad.architect-baseline 007-production-monitoring

expertise:
  - infrastructure-documentation
  - architecture-analysis
  - deployment-validation

model: claude-sonnet-4-5-20250929
---

You are executing the `/triad.architect-baseline` command to create an infrastructure baseline report.

## Constitutional Authority

Per Constitution v1.4.0, Principle XI (SDLC Triad Collaboration):
- **Architect** must document current infrastructure state before PM creates deployment PRDs
- **Purpose**: Prevent infrastructure status errors (see PM-001: PRD-004 had 18 inaccuracies)
- **Baseline reports** establish ground truth for infrastructure/deployment work
- **Phase 0** of SDLC Triad workflow for infrastructure PRDs

## Command Parameters

**Feature ID**: `{{feature-id}}`

If feature-id is missing, prompt the user:
```
❌ Error: Feature ID required

Usage: /triad.architect-baseline <feature-id>

Example: /triad.architect-baseline 006-phase-production-launch

The feature-id should match the PRD number format (NNN-feature-name).
This creates specs/NNN-feature-name/ to match the PRD numbering.

NOTE: Branch names may differ from spec folder names (branch names are auto-generated).
The spec folder should always match the PRD number for traceability.
```

## Baseline Report Purpose

**Problem**: PMs creating infrastructure PRDs often claim infrastructure "doesn't exist" when it's actually operational, leading to:
- Incorrect scope estimates (7 days vs 2-4 hours in PRD-004)
- Wasted architect review time (2-3 hours vs target <30 min)
- 18 technical inaccuracies requiring corrections

**Solution**: Architect creates baseline report before PM drafts PRD, documenting:
- What infrastructure exists (backend, frontend, database, domains)
- What's operational (deployed, configured, monitored)
- What's remaining (actual work needed vs already done)
- Completion percentage (X% infrastructure vs Y% code)

**Result**: PM uses baseline to create accurate PRD with correct scope and timeline

## Workflow

### Step 1: Create specs/ Directory

Create directory for baseline and related artifacts:

```bash
mkdir -p specs/{{feature-id}}
```

Example: `specs/005-frontend-deployment/`

### Step 2: Invoke Architect Agent

Spawn the architect agent to create the baseline report:

**Agent Task**:
```
Invoking architect agent to create infrastructure baseline for: {{feature-id}}

Agent Responsibilities:
1. Read current architecture documentation:
   - docs/architecture/README.md (overall status)
   - docs/architecture/04_deployment_environments/production.md
   - docs/architecture/04_deployment_environments/staging.md
   - docs/product/STATUS.md (recently completed features)
   - git log --oneline -20 (recent deployments)

2. Document infrastructure inventory:
   - Backend: URL, status, deployment date
   - Frontend: URL, status, deployment date
   - Database: Name, region, status
   - Environment Variables: Count, scope (backend/frontend/both)
   - Custom Domains: SSL status, DNS configuration
   - Monitoring: Analytics, logging, alerts

3. Calculate completion percentage:
   - Infrastructure setup: X%
   - Code development: Y%
   - Testing/validation: Z%

4. Identify remaining work:
   - Infrastructure tasks (what truly needs infrastructure setup?)
   - Code tasks (what needs implementation?)
   - Validation tasks (what needs testing?)

5. Create baseline report:
   - File: specs/{{feature-id}}/architect-baseline.md
   - Format: Follow template in .claude/agents/architect.md
   - Timeline impact: How does current state affect timeline?

Context:
- Feature ID: {{feature-id}}
- Report Location: specs/{{feature-id}}/architect-baseline.md
- Creation Date: {today's date}
```

### Step 3: Validate Baseline Report

After architect creates baseline, validate it contains:

**Required Sections**:
- ✅ Infrastructure Inventory (what exists?)
- ✅ Operational Status (what's working?)
- ✅ Completion Percentage (X% complete)
- ✅ Remaining Work (what's truly needed?)
- ✅ Baseline Summary (impact on timeline)

**Quality Checks**:
- [ ] All infrastructure components documented (backend, frontend, database, domains, monitoring)
- [ ] Operational status is clear (deployed, configured, operational percentages)
- [ ] Remaining work is specific (not vague "needs setup")
- [ ] Timeline impact is realistic (based on what's actually remaining)

### Step 4: Provide Output Summary

After successful baseline creation, output:

```
✅ Architect Baseline Report Created!

Feature: {{feature-id}}
Report: specs/{{feature-id}}/architect-baseline.md
Created: {date}

Infrastructure Inventory:
- Backend: {status}
- Frontend: {status}
- Database: {status}
- Domains: {status}
- Monitoring: {status}

Completion Summary:
- Infrastructure: {X}% complete
- Code: {Y}% complete
- Testing: {Z}% complete

Remaining Work: {count} tasks identified

Baseline Highlights:
- {Key finding 1}
- {Key finding 2}
- {Key finding 3}

Next Steps:
1. PM uses this baseline to draft accurate PRD
2. PM incorporates baseline into PRD "Current State" section
3. PM avoids claiming infrastructure "doesn't exist" when it's operational
4. Tech-Lead uses baseline for accurate timeline estimates

SDLC Triad Workflow:
- ✅ Phase 0 Complete: Architect Baseline
- ⏳ Phase 1 Next: PM drafts PRD with baseline
- ⏳ Phase 2 Next: Tech-Lead feasibility check
- ⏳ Phase 3 Next: Architect technical review

Baseline Purpose:
This report establishes ground truth for infrastructure state. PM must use this
data when creating PRD to ensure accurate infrastructure claims and realistic scope.

Success Metrics (vs PM-001 baseline):
- Target: <3 technical inaccuracies in PRD (baseline: 18 in PRD-004)
- Target: Baseline creation <30 minutes
- Target: 100% infrastructure status accuracy (baseline: 0% in PRD-004)
```

## Error Handling

### Missing Feature ID

```
❌ Error: Feature ID required

Usage: /triad.architect-baseline <feature-id>

Example: /triad.architect-baseline 005-frontend-deployment
```

### Invalid Feature ID Format

If feature-id doesn't match NNN-feature-name format:

```
❌ Error: Invalid feature ID format

Feature ID must be: NNN-feature-name (e.g., 005-frontend-deployment)

Invalid: "frontend deployment"
Valid:   "005-frontend-deployment"
```

### Infrastructure Documentation Missing

If architecture docs don't exist or are incomplete:

```
⚠️ Warning: Architecture documentation incomplete

Missing or incomplete:
- docs/architecture/04_deployment_environments/production.md
- docs/architecture/04_deployment_environments/staging.md

Baseline will document current gaps. Consider updating architecture docs first.

Continue anyway? (y/n)
```

## Baseline Report Template

The architect agent should follow this template from `.claude/agents/architect.md`:

```markdown
# Architect Baseline Report: {Feature Name}

**Feature**: {NNN-feature-name}
**Date**: {YYYY-MM-DD}
**Architect**: Claude (architect agent)

---

## Infrastructure Inventory

**What Exists**:
- Backend: [status, URL if deployed]
- Frontend: [status, URL if deployed]
- Database: [name, status, region]
- Environment Variables: [count configured, scope]
- Custom Domains: [status, SSL certificates]
- Monitoring: [analytics, logging, alerts]

**Operational Status**:
- Production deployment: [% complete]
- Staging environment: [status]
- Infrastructure configuration: [% complete]

**Completion Percentage**:
- Infrastructure setup: [X%]
- Code development: [Y%]
- Testing/validation: [Z%]

---

## Remaining Work

**Infrastructure**:
- [ ] [Task 1]: [description]
- [ ] [Task 2]: [description]

**Code**:
- [ ] [Task 1]: [description]

**Validation**:
- [ ] [Task 1]: [description]

---

## Baseline Summary

**Already Done**: [X% complete]
**Remaining**: [Y% effort needed]
**Timeline Impact**: [How current state affects timeline]
```

## Integration with SDLC Triad Workflow

This command is **Phase 0** of the Infrastructure PRD workflow:

```
Infrastructure PRD Workflow (Sequential):

0. /triad.architect-baseline <feature-id>   ← YOU ARE HERE
   └─ Architect creates baseline report

0.5. PM reads baseline
   └─ PM understands current state

1. /speckit.prd <topic>
   └─ PM drafts PRD incorporating baseline

2. Tech-Lead feasibility check
   └─ Tech-Lead uses baseline for timeline estimate

3. Architect technical review
   └─ Architect validates PRD claims vs baseline

4. PM finalizes PRD
   └─ PRD has accurate infrastructure status
```

## Files Created by This Command

**Created**:
- `specs/{feature-id}/architect-baseline.md` - Infrastructure baseline report

**Directory Created**:
- `specs/{feature-id}/` - Feature artifact directory

## Related Commands

- `/speckit.prd` - Create PRD (uses baseline if available)
- `/speckit.feasibility` - Tech-Lead feasibility check (uses baseline for timeline)
- `/speckit.analyze` - Validate PRD accuracy vs baseline

## Related Agents

- `architect` - Creates baseline report and technical reviews
- `head-honcho` - Uses baseline to draft accurate PRD
- `team-lead` - Uses baseline for timeline estimates

## Success Criteria

You have successfully completed this command when:

1. ✅ Baseline report created at `specs/{feature-id}/architect-baseline.md`
2. ✅ All infrastructure components documented (backend, frontend, database, domains, monitoring)
3. ✅ Operational status clearly stated (% complete for infrastructure, code, testing)
4. ✅ Remaining work identified (specific tasks, not vague claims)
5. ✅ Timeline impact assessed (how current state affects estimates)
6. ✅ PM can use baseline to create accurate PRD with correct infrastructure claims

## Success Metrics

**Target Performance** (vs PM-001 baseline):
- Baseline creation time: <30 minutes
- Infrastructure status accuracy: 100% (vs 0% in PRD-004)
- Enables PRD with <3 technical inaccuracies (vs 18 in PRD-004)
- Reduces architect review time to <30 min (vs 2-3 hours for PRD-004)

**Baseline Quality**:
- All infrastructure components documented
- Operational percentages are realistic
- Remaining work is specific and actionable
- Timeline impact is based on actual gaps, not assumptions

## Remember

**Purpose**: This baseline prevents PM from creating PRDs that claim infrastructure "doesn't exist" when it's actually operational. Ground truth matters.

**Usage**: Always run this command BEFORE creating infrastructure/deployment PRDs to establish accurate baseline.

**SDLC Triad**: This is Phase 0 of the Triad workflow - Architect provides baseline, then PM drafts PRD, then Tech-Lead estimates timeline, then Architect reviews technical accuracy.

---

**Now execute the workflow above to create the baseline report for: {{feature-id}}**
