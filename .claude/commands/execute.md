---
description: Execute any task with optimal parallel agent orchestration, automatic quality gates, and architectural oversight
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Goal

Execute any user-requested task by intelligently breaking it down into subtasks, assigning specialized agents, orchestrating parallel execution, and enforcing quality gates with mandatory architect reviews and documentation updates.

## Core Principles

**Flexibility**: Works with any task description - no predefined tasks.md required
**Intelligence**: Analyzes task and automatically determines optimal agent assignments
**Parallelism**: Maximizes concurrent execution wherever dependencies allow
**Quality**: Architect reviews all technical decisions; debugger documents bugs in KB
**Compliance**: Head-honcho must approve changes to plans; architect updates architecture docs

## Execution Flow

### 1. Parse User Intent

**Extract task requirements from natural language input**:

```python
# Example inputs:
"Add logging to backend and update DevOps docs"
"Fix the authentication bug and add tests"
"Create a new dashboard component with real-time updates"
"Deploy the backend to staging and run smoke tests"
```

**Identify task components**:
- Primary objective (what needs to be done)
- Scope (which parts of system: backend, frontend, docs, infra)
- Implied subtasks (e.g., "add feature" implies tests, docs)
- Quality requirements (e.g., "fix bug" implies KB documentation)

**Task complexity assessment**:
- **Simple** (1 agent, 1-3 files): "Update README with new API endpoint"
- **Moderate** (2-3 agents, 4-10 files): "Add logging to backend and update docs"
- **Complex** (4+ agents, 10+ files): "Build new dashboard with real-time updates and tests"

### 2. Analyze Context

**Read relevant project context**:

a. **Current project state**:
   - Git status: `git status --short` (understand current work)
   - Git branch: `git branch --show-current` (verify not on main)
   - Recent commits: `git log --oneline -5` (understand recent changes)

b. **Project structure** (if exists):
   - `.specify/spec.md` - Feature requirements (if feature work)
   - `.specify/plan.md` - Technical architecture (if feature work)
   - `.specify/memory/constitution.md` - Governance principles
   - `docs/architecture/` - Architecture documentation
   - `docs/INSTITUTIONAL_KNOWLEDGE.md` - Past learnings

c. **Affected systems** (based on task scope):
   - Backend: `backend/src/**` structure
   - Frontend: `frontend/src/**` structure
   - Docs: `docs/**` structure
   - Infrastructure: `deployment/**, .github/workflows/**`

**Identify dependencies**:
- Which files/components are affected
- What existing code/docs need modification
- What tests are required
- What documentation needs updating

### 3. Break Down Into Subtasks

**Decompose user request into atomic subtasks**:

**Task Breakdown Pattern**:
```
Primary Task: "Add logging to backend and update DevOps docs"

Subtasks:
1. Add logging framework to backend (backend-engineer)
   - Install logging library
   - Create logger configuration
   - Add logging to API endpoints
   - Add log rotation setup

2. Update DevOps documentation (devops)
   - Document log locations
   - Add log access instructions
   - Update troubleshooting guide

3. Add tests for logging (tester)
   - Unit tests for logger configuration
   - Integration tests for log output

4. Architecture review (architect)
   - Review logging implementation
   - Update architecture docs with logging decisions
```

**Subtask criteria**:
- Each subtask is independently executable
- Clear owner (one agent type)
- Clear deliverable (files created/modified)
- Clear acceptance criteria

### 4. Assign Agents

**Available Agents** (13 total):

| Agent | Responsibilities | Typical Tasks |
|-------|-----------------|---------------|
| **senior-backend-engineer** | API, database, models, services, business logic | Backend features, bug fixes, API endpoints |
| **code-monkey** | Frontend UI, React/Next.js components, client code | UI components, forms, dashboards |
| **tester** | Tests, validation, quality assurance | Unit tests, integration tests, E2E tests |
| **devops** | Infrastructure, deployment, CI/CD, Docker | Deployment, configuration, infrastructure |
| **architect** | Technical architecture, design decisions, documentation | Architecture reviews, tech decisions, ADRs |
| **ux-ui-designer** | UI/UX design, user experience, interface design | Design systems, mockups, user flows |
| **security-analyst** | Security analysis, vulnerability assessment | Security reviews, penetration testing |
| **web-researcher** | External research, best practices, library evaluation | Technology research, pattern discovery |
| **code-reviewer** | Code quality review, security review | Code reviews, security audits |
| **debugger** | Complex bug investigation, root cause analysis | Bug fixes (>30min), performance issues |
| **head-honcho** | Product management, requirements, sign-offs | Product decisions, plan approvals |
| **team-lead** | Multi-agent orchestration (this agent) | Workflow coordination |
| **general-purpose** | Flexible support, miscellaneous tasks | Tasks not matching other patterns |

**Assignment Rules**:

```python
# Pattern matching for agent assignment
def assign_agent(subtask):
    keywords = subtask.lower()

    # Backend patterns
    if any(word in keywords for word in ['api', 'endpoint', 'service', 'database', 'model', 'backend']):
        return 'senior-backend-engineer'

    # Frontend patterns
    if any(word in keywords for word in ['component', 'ui', 'react', 'next.js', 'frontend', 'dashboard']):
        return 'code-monkey'

    # Testing patterns
    if any(word in keywords for word in ['test', 'validation', 'e2e', 'integration test']):
        return 'tester'

    # DevOps patterns
    if any(word in keywords for word in ['deploy', 'docker', 'ci/cd', 'infrastructure', 'devops']):
        return 'devops'

    # Documentation patterns (architecture)
    if 'docs/architecture/' in subtask or 'architecture doc' in keywords:
        return 'architect'

    # Documentation patterns (devops)
    if 'docs/devops/' in subtask or 'deployment doc' in keywords:
        return 'devops'

    # Bug investigation (complex)
    if 'debug' in keywords or 'investigate' in keywords or 'root cause' in keywords:
        return 'debugger'

    # Security patterns
    if any(word in keywords for word in ['security', 'vulnerability', 'authentication', 'authorization']):
        return 'security-analyst'

    # Design patterns
    if any(word in keywords for word in ['design', 'mockup', 'wireframe', 'ux', 'user flow']):
        return 'ux-ui-designer'

    # Research patterns
    if any(word in keywords for word in ['research', 'evaluate', 'compare', 'best practice']):
        return 'web-researcher'

    # Default fallback
    return 'general-purpose'
```

**Cross-cutting tasks**:
- If subtask affects multiple domains → assign to `architect` (cross-cutting coordination)
- If subtask is simple and generic → assign to `general-purpose`

### 5. Identify Parallel Opportunities

**Dependency Analysis**:

```python
# Dependency types
SEQUENTIAL_DEPENDENCIES = {
    'Write→Write': 'Same file modified by 2 tasks',
    'Write→Read': 'Task B reads file created by Task A',
    'Phase boundary': 'All Phase N tasks complete before Phase N+1'
}

PARALLEL_ALLOWED = {
    'Read→Read': 'Both tasks read same file',
    'Different files': 'No file overlap',
    'Different systems': 'Backend + Frontend + Docs'
}
```

**Wave Construction**:

```
Wave 1 (Parallel - No dependencies):
- Subtask 1: Backend logging implementation (senior-backend-engineer)
- Subtask 2: DevOps docs update (devops)
- Subtask 3: Design log viewer UI (ux-ui-designer)

Wave 2 (Sequential - Depends on Wave 1):
- Subtask 4: Add tests for logging (tester)
- Subtask 5: Create log viewer component (code-monkey)

Wave 3 (Review - After implementation):
- Subtask 6: Architect review of logging architecture (architect)
- Subtask 7: Security review of log content (security-analyst)
```

**Optimization Heuristics**:
- **Maximize parallelism**: Group independent tasks in same wave
- **Minimize wave count**: Fewer context switches = faster execution
- **Balance agent load**: Avoid overloading single agent with too many tasks
- **Optimal wave size**: 3-8 tasks per wave (balance feedback vs overhead)

### 6. Show Execution Plan to User

**Present structured execution plan**:

```markdown
## Execution Plan

**Task**: Add logging to backend and update DevOps docs

**Complexity**: Moderate (7 subtasks, 3 waves, 4 agents)

**Agent Assignments**:
| Subtask | Agent | Files Affected | Estimated Time |
|---------|-------|----------------|----------------|
| 1. Add logging framework | senior-backend-engineer | backend/src/lib/logger.ts, backend/package.json | 30 min |
| 2. Add logging to endpoints | senior-backend-engineer | backend/src/routes/*.ts | 45 min |
| 3. Update DevOps docs | devops | docs/devops/01_Local/troubleshooting.md | 20 min |
| 4. Add logging tests | tester | backend/tests/unit/logger.test.ts | 30 min |
| 5. Architect review | architect | (review only) | 20 min |
| 6. Update architecture docs | architect | docs/architecture/00_Tech_Stack/tech-stack.md | 15 min |

**Execution Waves**:
- **Wave 1** (Parallel): Subtasks 1, 2, 3 → 3 agents working simultaneously
- **Wave 2** (Sequential): Subtask 4 → after Wave 1 completes
- **Wave 3** (Review): Subtasks 5, 6 → architect review and doc updates

**Estimated Duration**:
- Sequential: 2 hours 40 minutes
- Parallel: 1 hour 35 minutes (40% time savings)

**Quality Gates**:
- ✅ Architect will review all technical decisions
- ✅ Architect will update architecture docs
- ✅ Tests required for backend changes

---

**Proceed with this execution plan?** (yes/no)
```

**User approval required**: Wait for user to confirm before executing

### 7. Execute Parallel Waves

**For each wave**:

a. **Launch agents in parallel** (CRITICAL for performance):

```python
# CORRECT: Single message with multiple Task calls
Task(
    subagent_type="senior-backend-engineer",
    description="Add logging framework and instrument endpoints",
    prompt="""Execute the following subtasks:

1. Add logging framework to backend
   - Install winston or pino logging library
   - Create logger configuration in backend/src/lib/logger.ts
   - Configure log levels (debug, info, warn, error)
   - Set up log rotation

2. Add logging to API endpoints
   - Add request/response logging to backend/src/routes/*.ts
   - Log authentication events
   - Log database operations
   - Log errors with stack traces

Deliverables:
- backend/src/lib/logger.ts (new file)
- backend/package.json (updated dependencies)
- backend/src/routes/*.ts (instrumented with logging)

Acceptance Criteria:
- All API endpoints log requests/responses
- Errors include stack traces
- Log format is structured (JSON)
- Log levels configurable via environment variable
"""
)

Task(
    subagent_type="devops",
    description="Update DevOps documentation for logging",
    prompt="""Update DevOps documentation to explain logging system.

Update: docs/devops/01_Local/troubleshooting.md

Add sections:
1. **Log Locations**: Where logs are stored (local vs production)
2. **Log Access**: How to view logs (docker logs, log files, log aggregation)
3. **Log Levels**: How to change log verbosity
4. **Troubleshooting with Logs**: Common log patterns for debugging

Deliverables:
- docs/devops/01_Local/troubleshooting.md (updated)

Acceptance Criteria:
- Clear instructions for accessing logs
- Examples of log commands (docker logs, grep, tail)
- Troubleshooting guide with log patterns
"""
)

# Launch both agents simultaneously in single message
```

**IMPORTANT**: Do NOT send agents sequentially - defeats parallelism!

b. **Monitor wave progress**:

```python
# Update TodoWrite for real-time visibility
TodoWrite(todos=[
    {
        "content": "Wave 1: Backend logging + DevOps docs (2 agents) [P]",
        "status": "in_progress",
        "activeForm": "Executing Wave 1 with parallel agents"
    },
    {
        "content": "Wave 2: Add logging tests (tester)",
        "status": "pending",
        "activeForm": "Waiting for Wave 1 completion"
    },
    {
        "content": "Wave 3: Architect review and doc updates",
        "status": "pending",
        "activeForm": "Pending architect review"
    }
])
```

c. **Validate wave completion**:
- Verify all subtasks completed successfully
- Check for errors or blockers
- If failures: Invoke debugger agent with structured error report

d. **Proceed to next wave** when all tasks complete

### 8. Mandatory Quality Gates

**CRITICAL QUALITY GATES** (user requirements):

#### A. Architect Reviews ALL Technical Decisions

**AUTOMATIC Architect Review Triggers**:
1. **After ANY code changes** affecting architecture:
   - New services, models, or APIs
   - Database schema changes
   - Infrastructure modifications
   - Framework or library additions
   - Design pattern changes

2. **Architect responsibilities**:
   - Review technical decisions for consistency
   - Validate alignment with architecture principles
   - Identify potential issues or risks
   - Provide APPROVED / APPROVED WITH CONCERNS / BLOCKED status

3. **Architect MUST update architecture docs**:
   - If new technology used → update `docs/architecture/00_Tech_Stack/tech-stack.md`
   - If design pattern introduced → update `docs/architecture/03_patterns/`
   - If deployment changed → update `docs/architecture/04_deployment_environments/`
   - Create ADR (Architecture Decision Record) in `docs/architecture/02_ADRs/` for major decisions

**Architect Review Process**:

```python
Task(
    subagent_type="architect",
    description="Review technical decisions and update architecture docs",
    prompt="""Review the technical changes and update architecture documentation.

**Context**:
- User task: {original user request}
- Changes made: {summary of subtasks completed}
- Files modified: {list of files}
- Agents involved: {list of agents}

**Review Responsibilities**:

1. **Technical Validation**:
   - Consistency with existing tech stack
   - Adherence to architecture principles
   - No anti-patterns or technical debt introduced
   - Security and performance considerations
   - Database schema consistency (if applicable)
   - API contract consistency (if applicable)

2. **Documentation Updates** (MANDATORY):
   - Update `docs/architecture/00_Tech_Stack/tech-stack.md` if:
     * New library/framework added
     * New technology used
     * Version upgraded
   - Update `docs/architecture/03_patterns/` if:
     * New design pattern introduced
     * Existing pattern modified
   - Update `docs/architecture/04_deployment_environments/` if:
     * Deployment configuration changed
     * Infrastructure modified
   - Create ADR in `docs/architecture/02_ADRs/` if:
     * Major architectural decision made
     * Trade-off analysis performed

3. **Provide Structured Review**:

**Status**: [APPROVED | APPROVED WITH CONCERNS | BLOCKED]

**Technical Validation**:
- ✅ Consistent with tech stack
- ✅ Follows architecture principles
- ✅ No anti-patterns introduced
- ⚠️ [Any concerns if present]

**Documentation Updates**:
- ✅ Updated tech-stack.md [if applicable]
- ✅ Updated patterns/ [if applicable]
- ✅ Created ADR-XXX.md [if applicable]
- ✅ Updated deployment docs [if applicable]

**Critical Issues**: [List if any]
**Concerns**: [List if any]
**Recommendations**: [List if any]
**Approval**: [PROCEED | BLOCKED]

---

**IMPORTANT**: If status is BLOCKED, implementation cannot proceed until issues resolved.
"""
)
```

**Blocking Behavior**:
- If architect status = **BLOCKED** → halt execution, report to user, require fixes
- If architect status = **APPROVED WITH CONCERNS** → proceed but note concerns for future
- If architect status = **APPROVED** → proceed to next phase

#### B. Debugger Documents Bugs in Knowledge Base

**AUTOMATIC KB Documentation Trigger**:
- Whenever debugger agent is invoked (implies complex >30min issue)
- After any bug fix that required >30 minutes to resolve
- After any blocker resolution

**KB Documentation Process**:

```python
# After debugger resolves bug
Task(
    subagent_type="debugger",
    description="Document bug resolution in Knowledge Base",
    prompt="""Document the bug resolution in the Knowledge Base.

**Context**:
- Bug: {bug description}
- Root cause: {identified root cause}
- Solution: {how it was fixed}
- Files affected: {list of files}

**Create KB Entry** in `docs/INSTITUTIONAL_KNOWLEDGE.md`:

Follow the 3-step validation (Definition of Done):
1. Does this entry save future developers >30 minutes?
2. Would you have wanted this knowledge BEFORE starting?
3. Does it explain a non-obvious "gotcha" or edge case?

**Entry Format**:
```markdown
### #{KB-ENTRY-NUMBER}: {Bug Title} (YYYY-MM-DD)

**Problem**: {1-2 sentence description}

**Root Cause**: {1-3 sentences explaining why it happened}

**Solution**: {2-5 sentences explaining the fix}

**Prevention**: {1-2 sentences on how to avoid in future}

**Related Files**: {list of files}

**Tags**: #{bug, #{component}, #{technology}
```

**Quality Standards**:
- ✅ Actionable insights (not just "we fixed X")
- ✅ Explains WHY, not just WHAT
- ✅ Includes specific examples or code snippets
- ✅ Helps future developers avoid same pitfall
- ❌ Obvious facts
- ❌ Generic statements
- ❌ Implementation progress reports
"""
)
```

#### C. Head-Honcho Approves Changes to Plans

**AUTOMATIC Head-Honcho Approval Trigger**:
- Changes to `.specify/spec.md` (product requirements)
- Changes to `.specify/plan.md` (technical architecture)
- Changes to `.specify/tasks.md` (task breakdown)
- Changes to `.specify/memory/constitution.md` (governance)

**Approval Process**:

```python
# If changes to .specify/ detected
Task(
    subagent_type="head-honcho",
    description="Approve changes to product/planning artifacts",
    prompt="""Review and approve proposed changes to planning artifacts.

**Context**:
- User task: {original user request}
- Proposed changes: {description of changes}
- Files affected: {.specify/ files}
- Justification: {why changes are needed}

**Review Responsibilities**:

1. **Product Alignment**:
   - Do changes align with product vision?
   - Do changes serve user needs?
   - Are scope changes justified?

2. **Governance Compliance**:
   - Do changes violate constitution principles?
   - Are required sign-offs maintained?
   - Is documentation complete?

3. **Provide Approval Decision**:

**Status**: [APPROVED | CHANGES REQUESTED | REJECTED]

**Product Alignment**: ✅ | ⚠️ | ❌
**Governance Compliance**: ✅ | ⚠️ | ❌

**Issues** (if any): [List blocking issues]
**Recommendations** (if any): [List improvements]

**Decision**: [APPROVED to proceed | CHANGES REQUESTED | REJECTED]

**Justification**: {explanation of decision}

---

**IMPORTANT**: If status is CHANGES REQUESTED or REJECTED, execution halts until user addresses feedback.
"""
)
```

**Blocking Behavior**:
- If head-honcho status = **REJECTED** → halt execution, report to user
- If head-honcho status = **CHANGES REQUESTED** → halt, present feedback to user
- If head-honcho status = **APPROVED** → proceed with changes

### 9. Final Validation and Reporting

**Execute completion checklist**:

- [ ] **All subtasks completed**: Verify all agents finished successfully
- [ ] **Architect reviewed**: Technical decisions validated and docs updated
- [ ] **KB documented**: Any bugs documented in Knowledge Base (if applicable)
- [ ] **Plan approved**: Head-honcho approved any .specify/ changes (if applicable)
- [ ] **Files committed**: Changes ready for git commit (verify with `git status`)
- [ ] **No constitutional violations**: `.specify/` unchanged unless approved

**Generate final status report**:

```markdown
## Execution Complete

**Task**: {original user request}

**Execution Summary**:
- **Total Subtasks**: {count}
- **Agents Used**: {list of agents}
- **Execution Waves**: {count}
- **Estimated Time (Sequential)**: {hours}
- **Actual Time (Parallel)**: {hours}
- **Time Savings**: {percentage}%

**Files Changed** ({count} files):
{list of modified/created/deleted files}

**Quality Gates Passed**:
- ✅ Architect reviewed and approved
- ✅ Architecture docs updated
- ✅ Knowledge Base updated (if bugs fixed)
- ✅ Plan changes approved by head-honcho (if applicable)
- ✅ Constitutional compliance verified

**Agent Breakdown**:
| Agent | Subtasks | Files | Time |
|-------|----------|-------|------|
| senior-backend-engineer | 2 | 5 | 1h 15m |
| devops | 1 | 2 | 20m |
| tester | 1 | 1 | 30m |
| architect | 1 | 3 | 25m |

**Total**: 5 subtasks, 11 files, 2h 30m

---

**Next Steps**:
1. Review changes: `git diff`
2. Commit changes: `git add . && git commit -m "..."`
3. Run tests (if applicable): `npm test` or `pytest`
4. Create PR (if on feature branch): `gh pr create`

**Status**: ✅ COMPLETE
```

### 10. Error Handling and Recovery

**Common Failure Scenarios**:

#### A. Agent Failure During Execution

**Detection**:
- Agent returns error status
- Agent completes but subtask not finished
- Agent blocked for >30 minutes

**Recovery**:
1. Invoke debugger agent with structured error report
2. Debugger investigates and provides fix
3. Retry failed subtask with fix applied
4. Document issue in Knowledge Base (mandatory)

**Debugger Error Report Format**:
```
Subtask {ID} failed during Wave {N} execution.

Context:
- Agent: {agent-name}
- Subtask: {description}
- Files: {file paths}
- Dependencies: {completed prerequisite subtasks}

Failure:
- Error: {error message}
- Stack trace: {if available}
- Partial progress: {what completed successfully}

Hypothesis: {possible root cause}

Investigate:
1. {specific check 1}
2. {specific check 2}
3. {specific check 3}
```

#### B. Architect Blocks Implementation

**Detection**:
- Architect review status = **BLOCKED**

**Recovery**:
1. Report blocking issues to user
2. Present architect's concerns and recommendations
3. Ask user: "How would you like to proceed?"
   - Option A: Address issues and retry
   - Option B: Modify approach and re-plan
   - Option C: Abort task

**User Response Handling**:
- If address issues → create new subtasks to fix, re-execute
- If modify approach → go back to step 3 (break down into subtasks)
- If abort → clean up partial work, report status

#### C. Head-Honcho Rejects Plan Changes

**Detection**:
- Head-honcho approval status = **REJECTED** or **CHANGES REQUESTED**

**Recovery**:
1. Report rejection/feedback to user
2. Present head-honcho's concerns and recommendations
3. Ask user: "Would you like to modify the plan or abort?"
   - Option A: Revise .specify/ changes per feedback
   - Option B: Abort changes to .specify/

#### D. User Cancellation During Execution

**Detection**:
- User inputs "stop", "cancel", "abort", "halt"

**Recovery**:
1. Halt current wave execution (if possible)
2. Report current progress:
   - Completed subtasks
   - In-progress subtasks
   - Pending subtasks
3. Ask: "Save partial progress? (yes/no)"
   - If yes → commit completed work
   - If no → discard changes with `git restore`

## Operating Principles

### Context Efficiency

**Minimize token usage**:
- Read only necessary files (don't load entire codebase)
- Use progressive disclosure (load context as needed)
- Summarize agent responses (don't include full output)
- Limit agent prompts to essential information

**Smart context loading**:
```python
# Load based on task scope
if 'backend' in task_scope:
    read('backend/src/') # Only backend structure
if 'frontend' in task_scope:
    read('frontend/src/') # Only frontend structure
if 'docs' in task_scope:
    read('docs/') # Only documentation

# Don't load everything speculatively
```

### Intelligent Agent Selection

**Prefer specialization**:
- Use **senior-backend-engineer** for complex backend work (>1 file, >30 min)
- Use **code-monkey** for UI components and frontend logic
- Use **architect** for cross-cutting concerns and reviews
- Use **general-purpose** only for simple, generic tasks

**Avoid anti-patterns**:
- ❌ Using architect to write code (architect reviews, doesn't implement)
- ❌ Using tester for non-test work
- ❌ Using devops for application code
- ❌ Using general-purpose for specialized work

### Parallelism Best Practices

**Maximize concurrency**:
- Launch all independent subtasks simultaneously (single message, multiple Tasks)
- Different agents can work on different files in parallel
- Same agent can work on different files in parallel
- Optimal wave size: 3-8 subtasks (balance feedback vs overhead)

**Respect dependencies**:
- File-based locks: same file = sequential, different files = parallel
- Write→Write = sequential
- Write→Read = sequential
- Read→Read = parallel

### Quality Over Speed

**Always enforce quality gates**:
- Architect reviews are **mandatory**, not optional
- Documentation updates are **mandatory**, not optional
- KB documentation is **mandatory** for bugs
- Head-honcho approval is **mandatory** for plan changes

**Block execution if quality gates fail**:
- Architect BLOCKED → halt until resolved
- Head-honcho REJECTED → halt until addressed
- Tests failing → halt until fixed
- Constitution violated → halt immediately

### User Communication

**Progress visibility**:
- Use TodoWrite for real-time wave status
- Update user at each wave transition
- Report blockers immediately
- Summarize results clearly

**Ask for guidance when needed**:
- Ambiguous requirements → ask for clarification
- Multiple valid approaches → present options, ask for preference
- Quality gate failure → explain issue, ask how to proceed
- Unexpected errors → report clearly, ask for direction

## Example Executions

### Example 1: Simple Task

**User Input**: "Update the README with the new API endpoint"

**Analysis**:
- Complexity: Simple (1 agent, 1 file)
- Agent: general-purpose (documentation update)
- Waves: 1 (no dependencies)

**Execution Plan**:
```
Wave 1:
- Update README.md with new API endpoint (general-purpose)

Quality Gates:
- No architect review needed (documentation only)
- No KB documentation needed (no bugs)
- No plan changes (no .specify/ modified)
```

**Execution**: Single agent updates README, reports completion

---

### Example 2: Moderate Task

**User Input**: "Add logging to backend and update DevOps docs"

**Analysis**:
- Complexity: Moderate (7 subtasks, 3 waves, 4 agents)
- Agents: senior-backend-engineer, devops, tester, architect
- Waves: 3 (Wave 1: implementation, Wave 2: tests, Wave 3: review)

**Execution Plan**:
```
Wave 1 (Parallel):
- Add logging framework (senior-backend-engineer)
- Add logging to endpoints (senior-backend-engineer)
- Update DevOps docs (devops)

Wave 2 (Sequential):
- Add logging tests (tester)

Wave 3 (Review):
- Architect review (architect)
- Update architecture docs (architect)
```

**Execution**: 3 waves, architect reviews and updates docs, completion report

---

### Example 3: Complex Task

**User Input**: "Build a new dashboard component with real-time updates, tests, and complete documentation"

**Analysis**:
- Complexity: Complex (15+ subtasks, 5 waves, 7 agents)
- Agents: ux-ui-designer, code-monkey, senior-backend-engineer, tester, devops, architect, web-researcher
- Waves: 5 (Wave 1: design, Wave 2: backend API, Wave 3: frontend, Wave 4: tests, Wave 5: review)

**Execution Plan**:
```
Wave 1 (Parallel):
- Research real-time patterns (web-researcher)
- Design dashboard mockup (ux-ui-designer)

Wave 2 (Sequential):
- Create backend API for dashboard data (senior-backend-engineer)
- Add real-time endpoint (senior-backend-engineer)

Wave 3 (Sequential):
- Build dashboard component (code-monkey)
- Integrate real-time updates (code-monkey)

Wave 4 (Parallel):
- Backend API tests (tester)
- Frontend component tests (tester)

Wave 5 (Review):
- Architect review (architect)
- Update architecture docs (architect)
- Update DevOps deployment guide (devops)
```

**Execution**: 5 waves, 7 agents, architect reviews with design pattern ADR, completion report

---

## Context

$ARGUMENTS
