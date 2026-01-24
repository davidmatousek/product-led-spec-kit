---
description: Generate a session continuation prompt with context for the next session
tags: [project, workflow, session-management]
---

# Continue Session Prompt Generator

Generate a comprehensive prompt for continuing work in a fresh session, with automatic file location detection and single-command handoff.

## Instructions

You are generating a **session continuation prompt** that will be used to resume work in a clean Claude Code session.

### Step 1: Detect File Location

**Determine where to save NEXT-SESSION.md**:

1. **Get current branch**:
   ```bash
   git branch --show-current
   ```

2. **Check for feature branch pattern** (e.g., `002-frontend-mvp`, `001-{{PROJECT_NAME}}`):
   - Extract feature number from branch name (e.g., `002` from `002-frontend-mvp`)
   - Look for matching spec folder: `specs/NNN-*` (e.g., `specs/002-frontend-mvp/`)

3. **Determine file path**:
   - **If feature branch detected AND `specs/NNN-*/` exists**: Use `specs/NNN-feature-name/NEXT-SESSION.md`
   - **Otherwise**: Use `docs/prompts/NEXT-SESSION.md`

4. **Check if file exists and modification time**:
   ```bash
   # Get file modification time
   stat -f "%m" [file_path]  # macOS
   # or
   stat -c "%Y" [file_path]  # Linux
   ```

5. **Overwrite logic**:
   - **If file doesn't exist**: Create new file
   - **If file modified <15 minutes ago**: Silently overwrite (same session, just updating)
   - **If file modified >15 minutes ago**: Ask confirmation:
     ```
     NEXT-SESSION.md was last modified [X hours/days] ago.
     Overwrite with new session prompt? (yes/no)
     ```

### Step 2: Accept User Input (Optional)

The user may provide natural language input describing what to work on next:
- If input provided: Use it as the primary objective
- If no input: Infer from project context (current spec, tasks, git status)

### Step 3: Detect Workflow Type

**Check for Spec Kit workflow**:
```bash
# Look for tasks.md in detected feature folder
specs/NNN-feature/tasks.md
```

**Determine handoff command**:
- **If `specs/NNN-feature/tasks.md` exists**: Use `/team-lead.implement specs/NNN-feature/NEXT-SESSION.md`
- **Otherwise**: Use `/execute read docs/prompts/NEXT-SESSION.md` (or appropriate path)

### Step 4: Gather Project Context

**Git Status**:
```bash
git branch --show-current
git status --short
git log --oneline -5
```

**Detect Current Feature/Phase**:
- Branch name analysis (feature number, descriptive name)
- Look for spec files in detected folder
- Read `specs/NNN-feature/spec.md` or `.specify/spec.md` if exists

**Detect Work Type**:
- **Spec Kit Feature**: `specs/NNN-feature/tasks.md` exists
- **Debugging**: Recent errors in conversation or git history
- **Research**: Web-researcher agent used recently
- **Infrastructure**: DevOps/deployment-related commits

**Key Files**:
- Spec Kit: `specs/NNN-feature/spec.md`, `specs/NNN-feature/tasks.md`, `specs/NNN-feature/plan.md`
- Documentation: `docs/`, `specs/`
- Configuration: `vercel.json`, `package.json`, etc.

### Step 5: Generate Session Continuation Prompt

**Format** (Markdown):

```markdown
# Continue Session: [Feature/Project Name] - [Phase/Topic]

**Feature**: [NNN-feature-name or N/A]
**Phase**: [Phase number/name or topic]
**Branch**: [current branch]
**Last Updated**: [current date and time]

---

## Context

**What Was Completed** (Current/Previous Session):
- ✅ [Key accomplishment 1]
- ✅ [Key accomplishment 2]
- ✅ [Key accomplishment 3]

**Git Status**:
- Branch: `[branch]` ([X commits ahead/behind])
- Last commit: `[hash]` - [commit message]
- Uncommitted changes: [count] files modified, [count] new files

---

## Current State

**Workflow**: [Spec Kit / General Development / Debugging / Research]
**Status**: [Brief 1-2 sentence summary of current state]

**Key Artifacts**:
- [Artifact 1]: [status]
- [Artifact 2]: [status]

---

## Next Action

**Immediate Goal**: [Clear 1-sentence objective]

**To Continue This Session**:

```
[HANDOFF COMMAND HERE - single line]
```

**What This Will Do**:
- [Step 1 brief description]
- [Step 2 brief description]
- [Step 3 brief description]

---
---

# 📋 Detailed Context & Execution Plan

The sections below contain all the detailed information for executing the deployment pipeline.

---

## Key Context

**Files Modified** (Uncommitted):
- [File 1]: [description]
- [File 2]: [description]

**Recent Commits**:
- `[hash]` - [commit message 1]
- `[hash]` - [commit message 2]

**Important Notes**:
- [Note 1]
- [Note 2]

---
---

## Commands Reference

**Verification**:
```bash
git status
git diff
[other verification commands]
```

**Testing** (if applicable):
```bash
npm test
[other test commands]
```

**Deployment** (if applicable):
```bash
[deployment commands]
```

---

**Session Type**: [Feature Development / Bug Fixing / Research / Infrastructure]
**Estimated Duration**: [time estimate for next steps]
**Prerequisites**: ✅ [All ready] / ⚠️ [Some blockers] / ❌ [Blocked]
```

### Step 6: Handoff Command Format

**CRITICAL**: The handoff must be a **single command** that the user can copy and paste.

**For Spec Kit workflows** (when `specs/NNN-feature/tasks.md` exists):
```
/triad.implement [Brief task description] per specs/NNN-feature/NEXT-SESSION.md
```

**For non-Spec Kit workflows** (general development):
```
/execute [Brief task description] per docs/prompts/NEXT-SESSION.md
```

**The "Next Action" section MUST include agent assignments**:

```markdown
## Next Action

**Immediate Goal**: [Clear objective]

**To Continue This Session**:

```
/triad.implement [Brief task description] per specs/NNN-feature/NEXT-SESSION.md
```

**What This Will Do**:
1. Auto-assign agents to tasks based on patterns
2. Execute in parallel waves with architect checkpoints
3. [Specific step 1]
4. [Specific step 2]

**Agent Assignments**:
| Task | Agent |
|------|-------|
| [Task category 1] | `[agent-name]` |
| [Task category 2] | `[agent-name]` |
| [Task category 3] | `[agent-name]` |
| Final sign-off | `product-manager` |
| Architecture checkpoint | `architect` |
```

**Available Agents for Assignment**:
- `tester` - E2E tests, validation, test infrastructure
- `debugger` - Bug investigation, root cause analysis
- `senior-backend-engineer` - API, database, services, backend code
- `frontend-developer` - Frontend UI, React components, client-side code
- `devops` - Infrastructure, deployment, CI/CD
- `architect` - Technical reviews, architecture decisions
- `product-manager` - Product sign-off, requirements validation
- `security-analyst` - Security analysis, vulnerability assessment
- `web-researcher` - External research, best practices
- `code-reviewer` - Code quality review

### Step 7: Special Cases

**Mid-Implementation Pause**:
- Capture partial progress on current task
- Note files modified but not committed
- Include TODO comments or blockers
- Highlight what's "in flight" vs "ready to start"

**Debugging Session**:
- Capture error state (error messages, stack traces)
- Note debugging steps already tried
- Include hypothesis about root cause
- List next debugging steps to try

**Research/Exploration**:
- Summarize key findings discovered
- List resources/documentation consulted
- Note decisions made or patterns discovered
- Highlight open questions remaining

**Multi-Day Break** (>24 hours since last commit):
- Add "Session Recap" section at top
- Summarize project status in 3-5 bullet points
- Highlight any blockers or decisions needed
- Include links to relevant documentation

**Deployment/Testing Phase**:
- Include test results summary
- List deployment steps completed
- Note any validation remaining
- Include relevant URLs (staging, production)

### Step 8: Validation

Before writing the file, verify:
- [ ] File path is correct (specs/NNN-* or docs/prompts/)
- [ ] Handoff command uses correct path
- [ ] Handoff command is appropriate for workflow type (/triad.implement vs /execute)
- [ ] All context is accurate (git status matches reality)
- [ ] Next steps are clear and actionable
- [ ] File paths referenced exist
- [ ] Commands are valid and tested
- [ ] No sensitive information exposed (credentials, API keys)

### Step 9: Present to User

1. **Check file status and confirm if needed**:
   ```
   [If file >15 min old]
   NEXT-SESSION.md was last modified 2 hours ago.
   Overwrite with new session prompt? (yes/no)
   ```

2. **Show brief summary** in chat:
   ```markdown
   ## ✅ Session Continuation Prompt Generated

   **Saved to**: `specs/002-frontend-mvp/NEXT-SESSION.md`

   **Quick Summary**:
   - Current Status: [brief status]
   - Next Action: [1-line goal]
   - Handoff Command: `/triad.implement [description] per specs/002-frontend-mvp/NEXT-SESSION.md`

   The full detailed context is in the file above.
   Use the handoff command in your next session to continue! 🚀
   ```

3. **Do NOT display the full prompt in chat** - it's already in the file
   - Only show: file location, brief summary, handoff command
   - User can open the file if they want to review details

## Example Usage

**User provides specific next step**:
```
/continue Fix the remaining 2 flaky tests and deploy to staging
```

**No user input (infer from context)**:
```
/continue
```

**Result**:
- Detects feature branch `002-frontend-mvp`
- Saves to `specs/002-frontend-mvp/NEXT-SESSION.md`
- Generates handoff: `/triad.implement [description] per specs/002-frontend-mvp/NEXT-SESSION.md`
- Shows brief summary in chat

## Implementation Notes

**File Location Priority**:
1. Extract feature number from current branch name
2. Check if `specs/NNN-*/` directory exists
3. If yes: use `specs/NNN-*/NEXT-SESSION.md`
4. If no: use `docs/prompts/NEXT-SESSION.md`
5. Create parent directory if doesn't exist

**Modification Time Check**:
- Use file system stat to get modification timestamp
- Compare with current time
- <60 minutes: Silent overwrite
- >60 minutes: Ask confirmation
- No file: Create new

**Handoff Command Selection**:
- Check if `specs/NNN-feature/tasks.md` exists
- If yes: Use `/triad.implement [task description] per [path]`
- If no: Use `/execute [task description] per [path]`

**Agent Assignment Logic**:
Based on the tasks/milestones in NEXT-SESSION.md, assign agents using these patterns:
- Testing tasks → `tester`
- Bug investigation → `debugger`
- Backend code changes → `senior-backend-engineer`
- Frontend code changes → `frontend-developer`
- Deployment/infra → `devops`
- Always include `product-manager` for sign-off
- Always include `architect` for checkpoints

**Keep It Simple**:
- File has ALL the context (can be long, detailed)
- Chat shows ONLY: location, summary, handoff command
- Single command to continue = great UX

## Notes

- Always overwrite to same filename: `NEXT-SESSION.md` (no versioning)
- Use feature branch detection to find correct spec folder
- Single-command handoff is critical for smooth workflow
- Keep chat output minimal - details are in the file
- Handoff command includes full context, user just runs one command
