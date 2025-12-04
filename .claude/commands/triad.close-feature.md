---
description: Close a completed feature with automatic documentation updates and cleanup (Triad-enhanced)
---

## Context

You are executing `/triad.close-feature`, which orchestrates the closure of a completed feature by:
1. Validating the feature is ready for closure (PR merged, tasks complete)
2. Launching specialized agents IN PARALLEL to update their respective documentation domains
3. Performing cleanup tasks (branch deletion, validation)
4. Creating a single commit with all changes
5. Auto-committing and pushing to main

**Agents Involved**:
- `head-honcho` (PM): Product documentation (Section 1 of checklist)
- `architect`: Architecture documentation (Section 2 of checklist)
- `devops`: DevOps/deployment documentation (Section 3 of checklist)
- Main orchestrator: Cleanup, validation, commit (Sections 4-10)

**Reference**: `docs/DOCS_TO_UPDATE_AFTER_NEW_FEATURE.md` - comprehensive checklist with agent assignments

## User Input

```text
$ARGUMENTS
```

The argument should be the feature number (e.g., `007` or `007-phase-brain-rag`).

If no argument provided, attempt to detect from recent PRs or prompt user.

## Step 1: Validate Feature Ready for Closure

Before proceeding, validate the feature is ready:

### 1.1 Locate Feature Specs

```bash
# Find feature directory
ls -la specs/*{FEATURE_NUMBER}* 2>/dev/null || ls -la specs/ | grep {FEATURE_NUMBER}
```

If feature not found, prompt user:
```markdown
Could not find feature specs for `{FEATURE_NUMBER}`.

Please provide:
1. Feature number (e.g., `007`)
2. Or full feature name (e.g., `007-phase-brain-rag`)

Available features in specs/:
{list of directories}
```

### 1.2 Verify PR Merged

```bash
# Check if on main branch and up to date
git fetch origin main
git log origin/main --oneline -10 | head -5

# Check for feature branch (should NOT exist if merged)
git branch -a | grep {FEATURE_NUMBER} || echo "Branch already deleted (expected)"
```

If feature branch still exists:
```markdown
Feature branch `{branch}` still exists.

**Options**:
1. The PR may not be merged yet - check GitHub
2. The branch may need manual deletion

Would you like me to:
- (A) Check PR status on GitHub
- (B) Delete the branch and proceed
- (C) Abort and wait for PR merge
```

### 1.3 Verify Tasks Complete

Read the tasks.md file and verify all tasks are marked `[X]`:

```bash
# Count incomplete tasks
grep -c "^\- \[ \]" specs/{FEATURE}/tasks.md || echo "0"
```

If incomplete tasks found:
```markdown
Found {count} incomplete tasks in `specs/{FEATURE}/tasks.md`.

**Incomplete Tasks**:
{list incomplete tasks}

**Options**:
- (A) Mark remaining tasks complete and proceed (if truly done)
- (B) Abort closure until tasks are completed
- (C) Proceed anyway (not recommended)

Which would you like?
```

### 1.4 Gather Feature Context

Read key files to understand what was delivered:

```python
# Read these files to gather context for agents
Read("specs/{FEATURE}/tasks.md")  # Task list and metrics
Read("specs/{FEATURE}/spec.md")   # Requirements
Read("docs/product/02_PRD/INDEX.md")  # PRD reference
```

Extract key metrics:
- Feature name and number
- Completion date
- PR number (from git log or tasks.md)
- Task count (total and completed)
- User stories delivered
- Key deliverables

## Step 2: Launch Documentation Update Agents (PARALLEL)

Launch all three agents IN PARALLEL using a single message with multiple Task tool calls:

### Agent 1: head-honcho (Product Documentation)

```python
Task(
    subagent_type="head-honcho",
    description="Update product docs for feature closure",
    prompt="""## Task: Update Product Documentation for Feature {NUMBER} Closure

Feature {NUMBER} ({NAME}) has been completed and merged. Update all product documentation per Section 1 of `docs/DOCS_TO_UPDATE_AFTER_NEW_FEATURE.md`.

### Feature Context
- **Feature**: {NUMBER} - {NAME}
- **Completion Date**: {DATE}
- **PR**: #{PR_NUMBER}
- **Tasks**: {TASK_COUNT} completed
- **User Stories**: {US_COUNT} delivered
- **Key Deliverables**: {DELIVERABLES}

### Required Updates (Section 1 of Checklist)

1. **docs/product/STATUS.md**
   - Update "Last Updated" date to {DATE}
   - Update "Current Phase" status
   - Add feature to "Latest Production Deployments" with full metrics
   - Update "Feature Completion Timeline" table
   - Update "Current Phase Status" section

2. **docs/product/completed-features.md**
   - Update summary table (increment completed count)
   - Add comprehensive feature entry with all metrics
   - Include triple sign-off confirmation
   - Link to PRD, spec, plan, tasks

3. **docs/product/03_Product_Roadmap/README.md**
   - Mark phase/feature as COMPLETE with date
   - Update "Current Status" section

4. **docs/product/03_Product_Roadmap/001-overall-roadmap.md**
   - Update phase diagram (mark complete)
   - Update milestone timeline
   - Update Key Dates table

5. **docs/product/03_Product_Roadmap/{PHASE_FILE}.md**
   - Update header: Status: COMPLETE, Date: {DATE}
   - Mark all success criteria as achieved

6. **docs/product/02_PRD/INDEX.md**
   - Update PRD status to DELIVERED
   - Update "Recent Deployments" section

### Conditional Updates
- docs/product/06_OKRs/*.md (if feature contributes to OKRs)
- docs/product/05_User_Stories/*.md (mark completed stories)

### Output
List all files updated with brief summary of changes.
Confirm all product docs accurately reflect feature completion.
"""
)
```

### Agent 2: architect (Architecture Documentation)

```python
Task(
    subagent_type="architect",
    description="Update architecture docs for feature closure",
    prompt="""## Task: Update Architecture Documentation for Feature {NUMBER} Closure

Feature {NUMBER} ({NAME}) has been completed and merged. Update all architecture documentation per Section 2 of `docs/DOCS_TO_UPDATE_AFTER_NEW_FEATURE.md`.

### Feature Context
- **Feature**: {NUMBER} - {NAME}
- **Completion Date**: {DATE}
- **New Technologies**: {TECH_LIST}
- **New API Endpoints**: {ENDPOINT_COUNT}
- **Database Changes**: {DB_CHANGES}
- **Key Deliverables**: {DELIVERABLES}

### Required Updates (Section 2 of Checklist)

1. **docs/architecture/README.md**
   - Update "Last Updated" date to {DATE}
   - Update "Current Status" section
   - Add feature to deployed features list
   - Update tech stack overview if new technologies

2. **docs/architecture/00_Tech_Stack/tech-stack.md**
   - Add new dependencies with versions
   - Update technology stack table
   - Document rationale for new tech choices

3. **docs/architecture/01_system_design/README.md**
   - Update system diagrams if architecture changed
   - Update component descriptions

4. **CLAUDE.md**
   - Update "Active Technologies" section
   - Update "Recent Changes" with feature summary
   - Verify all links still work

### Conditional Updates
- Create ADR if significant architectural decisions made
- Update deployment environment docs if env vars changed
- Update patterns docs if new patterns introduced

### Output
List all files updated with brief summary of changes.
If ADR created, include its filename.
Confirm architecture docs accurately reflect the new system.
"""
)
```

### Agent 3: devops (DevOps Documentation)

```python
Task(
    subagent_type="devops",
    description="Update devops docs for feature closure",
    prompt="""## Task: Update DevOps Documentation for Feature {NUMBER} Closure

Feature {NUMBER} ({NAME}) has been completed and merged. Update all DevOps documentation per Section 3 of `docs/DOCS_TO_UPDATE_AFTER_NEW_FEATURE.md`.

### Feature Context
- **Feature**: {NUMBER} - {NAME}
- **Completion Date**: {DATE}
- **New Environment Variables**: {ENV_VARS}
- **Infrastructure Changes**: {INFRA_CHANGES}
- **Key Deliverables**: {DELIVERABLES}

### Required Updates (Section 3 of Checklist)

1. **docs/devops/README.md**
   - Update "Last Updated" date to {DATE}
   - Update version number
   - Update deployment status

2. **docs/devops/01_Local/README.md**
   - Update local setup if changed

3. **docs/devops/01_Local/environment-variables.md**
   - Add new environment variables
   - Document purpose and example values

4. **docs/devops/02_Staging/README.md**
   - Update staging configuration

5. **docs/devops/03_Production/README.md**
   - Update production configuration

### Conditional Updates
- docs/devops/03_Production/pre-deployment-checklist.md (new checks)
- deployment/environment-variables.md (master registry)
- Verify all 3 environments are documented

### Output
List all files updated with brief summary of changes.
Confirm all environments properly configured.
Provide environment variable summary if new vars added.
"""
)
```

## Step 3: Wait for All Agents to Complete

All three agents run in parallel. Wait for all to return results.

### Handle Partial Failures

If any agent fails:

```markdown
## Agent Execution Results

| Agent | Status | Summary |
|-------|--------|---------|
| head-honcho | {SUCCESS/FAILED} | {summary} |
| architect | {SUCCESS/FAILED} | {summary} |
| devops | {SUCCESS/FAILED} | {summary} |

{if any FAILED:}

**Partial Failure Detected**

The following agents encountered issues:
- {agent}: {error summary}

**Options**:
1. (A) Retry failed agents only
2. (B) Proceed with successful updates (manual fix later)
3. (C) Abort entire closure (rollback changes)

Which would you like?
```

## Step 4: Perform Cleanup Tasks (Main Orchestrator)

After agents complete, perform remaining tasks:

### 4.1 Delete Feature Branch (if exists)

```bash
# Delete local branch
git branch -d {FEATURE_BRANCH} 2>/dev/null || echo "Local branch already deleted"

# Delete remote branch
git push origin --delete {FEATURE_BRANCH} 2>/dev/null || echo "Remote branch already deleted"

# Prune stale references
git fetch --prune
```

### 4.2 Update INSTITUTIONAL_KNOWLEDGE.md (Section 4)

Check if there are learnings to add (prompt user if unclear):

```markdown
**Institutional Knowledge Update**

Did the implementation of Feature {NUMBER} produce any learnings worth documenting?

Examples:
- Debugging solutions discovered
- Patterns that worked well
- "Gotchas" to avoid in the future
- Performance insights
- Integration tips

If yes, please provide 1-3 key learnings to add to `docs/INSTITUTIONAL_KNOWLEDGE.md`.
If no, type "skip" to continue.
```

### 4.3 Verify Specification Artifacts (Section 5)

```bash
# Verify tasks.md all complete
grep -c "^\- \[X\]" specs/{FEATURE}/tasks.md
grep -c "^\- \[ \]" specs/{FEATURE}/tasks.md  # Should be 0
```

## Step 5: Run Validation (Section 9)

### 5.1 Check for Uncommitted Changes

```bash
git status
```

### 5.2 Verify No Placeholder Text

```bash
# Search for TBD, TODO in updated docs
grep -r "TBD\|TODO" docs/ --include="*.md" | head -20
```

### 5.3 Verify Links (optional - can be slow)

If time permits, spot-check a few key links.

## Step 6: Create Single Commit

Stage all documentation changes and create a single commit:

```bash
# Stage all doc changes
git add docs/ deployment/ CLAUDE.md

# Check what's staged
git status

# Create commit with comprehensive message
git commit -m "$(cat <<'EOF'
docs: close Feature {NUMBER} - update all documentation

Close Feature {NUMBER} ({NAME}) and update all tracking documentation
across product, architecture, and devops domains.

Product Documentation (PM):
- STATUS.md: Mark {PHASE} complete
- completed-features.md: Add Feature {NUMBER} with metrics
- Roadmap: Update all roadmap files
- PRD INDEX: Status changed to DELIVERED

Architecture Documentation (Architect):
- README.md: Update current status and tech stack
- tech-stack.md: Add new dependencies
{- ADR-NNN: Created (if applicable)}

DevOps Documentation (DevOps):
- All environments: Updated configuration
{- New env vars: {LIST} (if applicable)}

Cleanup:
- Feature branch deleted
- All tasks verified complete

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

## Step 7: Push to Main

```bash
git push origin main
```

## Step 8: Generate Closure Report

```markdown
## ✅ Feature {NUMBER} Closure Complete

**Feature**: {NUMBER} - {NAME}
**Closed**: {DATE}
**Commit**: {COMMIT_HASH}

### Documentation Updates

| Domain | Agent | Files Updated | Status |
|--------|-------|---------------|--------|
| Product | head-honcho | {count} | ✅ |
| Architecture | architect | {count} | ✅ |
| DevOps | devops | {count} | ✅ |
| System | orchestrator | {count} | ✅ |

### Files Changed
{list of all changed files}

### Cleanup Completed
- [x] Feature branch deleted (local and remote)
- [x] All tasks marked complete
- [x] PR merged to main
- [x] Documentation committed and pushed

### Validation
- [x] No incomplete tasks
- [x] No placeholder text (TBD, TODO)
- [x] All environments documented

### Next Steps
1. Monitor production for any issues
2. Consider Phase {NEXT_PHASE} planning
3. Run `/speckit.analyze` to verify consistency

**Feature {NUMBER} is now officially CLOSED.**
```

## Error Handling

### If PR Not Merged
```markdown
**Cannot close feature - PR not merged**

The feature branch `{branch}` still exists, indicating the PR may not be merged.

**Please**:
1. Verify PR is merged on GitHub
2. Delete the feature branch manually if needed
3. Re-run `/triad.close-feature {NUMBER}`
```

### If Tasks Incomplete
```markdown
**Cannot close feature - incomplete tasks**

Found {count} incomplete tasks in `specs/{FEATURE}/tasks.md`.

**Please**:
1. Complete remaining tasks, OR
2. Mark tasks as complete if already done
3. Re-run `/triad.close-feature {NUMBER}`
```

### If Agent Fails
See Step 3 for partial failure handling - let user decide whether to retry, proceed, or abort.

## Design Principles

**Parallel Execution**: All 3 documentation agents run in parallel for speed.

**Automated Commit**: Changes are automatically committed and pushed (user confirmed this preference).

**Graceful Failure**: Partial failures prompt user for decision rather than aborting entirely.

**Comprehensive Cleanup**: Branch deletion, validation, and verification all handled.

**Single Commit**: All documentation updates in one atomic commit for clean history.

**Checklist-Driven**: Uses `docs/DOCS_TO_UPDATE_AFTER_NEW_FEATURE.md` as source of truth for what to update.

**Agent Ownership**: Each agent handles their assigned sections from the checklist.
