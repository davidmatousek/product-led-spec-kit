---
description: Execute implementation with parallel agent orchestration using specialized agents and architect review oversight
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

1. Run `.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks` from repo root and parse FEATURE_DIR and AVAILABLE_DOCS list. All paths must be absolute. For single quotes in args like "I'm Groot", use escape syntax: e.g 'I'\''m Groot' (or double-quote if possible: "I'm Groot").

2. **Check checklists status** (if FEATURE_DIR/checklists/ exists):

   **If FEATURE_DIR/checklists/ does NOT exist**:
   - Skip checklist validation
   - Display: "No checklists found - proceeding with implementation"
   - Automatically proceed to step 3

   **If FEATURE_DIR/checklists/ exists**:
   - Scan all checklist files in the checklists/ directory
   - For each checklist, count:
     * Total items: All lines matching `- [ ]` or `- [X]` or `- [x]` (case-insensitive)
     * Completed items: Lines matching `- [X]` or `- [x]`
     * Incomplete items: Lines matching `- [ ]`
     * Nested items: Count indented items toward parent completion
   - Create a status table:
     ```
     | Checklist | Total | Completed | Incomplete | Status |
     |-----------|-------|-----------|------------|--------|
     | ux.md     | 12    | 12        | 0          | ✓ PASS |
     | test.md   | 8     | 5         | 3          | ✗ FAIL |
     | security.md | 6   | 6         | 0          | ✓ PASS |
     ```
   - Calculate overall status:
     * **PASS**: All checklists have 0 incomplete items
     * **FAIL**: One or more checklists have incomplete items

   **If any checklist is incomplete**:
   - Display the table with incomplete item counts
   - **STOP** and ask: "Some checklists are incomplete. Do you want to proceed with implementation anyway? (yes/no)"
   - Wait for user response before continuing
   - If user says "no" or "wait" or "stop", halt execution
   - If user says "yes" or "proceed" or "continue":
     * Proceed to step 3
     * **Auto-complete checklist items as tasks finish**: When task TXX completes, mark corresponding checklist item [X]

   **If all checklists are complete**:
   - Display the table showing all checklists passed
   - Automatically proceed to step 3

3. Load and analyze the implementation context:
   - **REQUIRED**: Read tasks.md for the complete task list and execution plan
   - **REQUIRED**: Read plan.md for tech stack, architecture, and file structure
   - **IF EXISTS**: Read data-model.md for entities and relationships
   - **IF EXISTS**: Read contracts/ for API specifications and test requirements
   - **IF EXISTS**: Read research.md for technical decisions and constraints
   - **IF EXISTS**: Read quickstart.md for integration scenarios

   **CHECK FOR AGENT ASSIGNMENTS**:
   - Look for agent assignment document in docs/agents/head-honcho/*Agent-Assignment-Plan*.md
   - If found: Use the documented agent assignments and wave execution plan
   - If not found: Proceed with automatic agent assignment based on task analysis

4. **Project Setup Verification** (Simplified):

   **Essential Setup Only** (delegate complex setup to devops agent):
   - Check if repository is a git repo: `git rev-parse --git-dir 2>/dev/null`
   - If git repo exists:
     * Verify .gitignore exists (create with basic patterns if missing)
     * Patterns: `node_modules/`, `*.pyc`, `__pycache__/`, `dist/`, `build/`, `.env*`, `.DS_Store`, `.vscode/`, `.idea/`
   - If Dockerfile exists:
     * Verify .dockerignore exists (basic patterns: `node_modules/`, `.git/`, `*.log*`, `.env*`)

   **For all other ignore files** (.eslintignore, .prettierignore, .terraformignore, .helmignore):
   - Delegate to devops agent if needed during Phase 10+ (infrastructure tasks)
   - Focus: Verify minimum viable project setup, don't deep-dive into patterns

5. **Parse tasks.md and build agent orchestration plan**:

   **Extract task metadata**:
   - Task ID (T001, T002, etc.)
   - Parallel marker ([P] if present)
   - Story/Phase grouping ([US1], [US2], etc.)
   - Description and file paths
   - Completion status ([X] or [ ])

   **Identify execution waves**:
   - **Wave**: Group of tasks that can execute in parallel
   - **Sequential tasks** (no [P]): Must run in order within phase
   - **Parallel tasks** ([P]): Can run simultaneously in same wave
   - **Phase boundaries**: All tasks in Phase N must complete before Phase N+1

   **Automatic agent assignment** (if no assignment plan found):

   **Available Specialized Agents** (13 total):
   - **head-honcho**: Product specifications, user stories, requirements
   - **architect**: Technical architecture, design reviews, documentation
   - **senior-backend-engineer**: API, database, models, services, business logic
   - **code-monkey**: Frontend UI, React components, client-side code
   - **tester**: BDD tests, smoke tests, E2E tests, validation, test infrastructure
   - **devops**: Infrastructure, deployment, CI/CD, Docker, Cloud services
   - **code-reviewer**: Code quality review, security review, architecture validation
   - **debugger**: Complex bug investigation, root cause analysis, issue resolution
   - **ux-ui-designer**: UI/UX design, user experience, interface design
   - **web-researcher**: External research, best practices, library evaluation
   - **security**: Security analysis, vulnerability assessment, security patterns
   - **team-lead**: Multi-agent workflow coordination (this agent)
   - **Jimmy**: General-purpose tasks, flexible support

   **Agent Assignment Quick Reference**:

   | Task Pattern | Agent | Examples |
   |--------------|-------|----------|
   | API, database, models, services, `.py`, `.java` | senior-backend-engineer | "Create UserService", "Add API endpoint" |
   | UI, React, components, `.tsx`, `.jsx` | code-monkey | "Create LoginForm component" |
   | Tests, BDD, validation, `tests/`, `spec/` | tester | "Write integration tests" |
   | Deployment, CI/CD, Docker, `deployment/` | devops | "Deploy to staging" |
   | Architecture, design docs, `.md` files in `docs/` | architect | "Update architecture docs" |
   | UI/UX, design system, mockups | ux-ui-designer | "Create design system" |
   | Security patterns, vulnerability scanning | security | "Add input validation" |
   | Library research, best practices | web-researcher | "Research FastAPI auth patterns" |
   | Code review, quality gates | code-reviewer | "Review authentication module" |
   | Complex debugging (>30min) | debugger | "Debug race condition" |

   **Fallback Assignment Rules**:
   - If task matches **multiple patterns** (e.g., backend + frontend) → architect (for cross-cutting work)
   - If task matches **no pattern** → Jimmy (general-purpose agent)
   - If task is **documentation-only** (`.md` files, no code) → architect

   **File Dependency Types** (determines sequential vs parallel):
   - **Write→Write**: Same file modified by 2 tasks → SEQUENTIAL (T001 then T002)
   - **Write→Read**: T001 creates, T002 reads → SEQUENTIAL (T001 must finish first)
   - **Read→Read**: Both tasks read same file → PARALLEL (no conflict)
   - **Different files**: No dependency → PARALLEL

   **Build wave execution plan**:
   ```
   Wave 1 (Parallel):
   - T002 [P] → senior-backend-engineer
   - T003 [P] → senior-backend-engineer
   - T004 [P] → code-monkey

   Wave 2 (Sequential):
   - T005 → senior-backend-engineer (depends on Wave 1)
   - T006 → senior-backend-engineer (depends on T005)

   Wave 3 (Parallel):
   - T010 [P] [US1] → tester
   - T015 [P] [US2] → tester
   - T020 [P] [US3] → code-monkey
   ```

6. **Execute parallel wave orchestration**:

   **For each wave**:

   a. **Identify ready tasks**:
      - All dependencies met
      - Not yet completed
      - Part of current wave

   b. **Group tasks by agent**:
      - Combine multiple tasks for same agent into single batch
      - Preserve task IDs and descriptions

   c. **Launch agents in parallel** (CRITICAL):
      ```python
      # SINGLE MESSAGE with multiple Task calls for true parallelism
      Task(
          subagent_type="senior-backend-engineer",
          description="Execute backend tasks T001-T007",
          prompt="Execute tasks T001-T007 from specs/{feature-id}/tasks.md..."
      )
      Task(
          subagent_type="code-monkey",
          description="Execute frontend tasks T020-T025",
          prompt="Execute tasks T020-T025 from specs/{feature-id}/tasks.md..."
      )
      Task(
          subagent_type="tester",
          description="Execute test tasks T030-T035",
          prompt="Execute tasks T030-T035 from specs/{feature-id}/tasks.md..."
      )

      # INCORRECT: Sequential calls defeat parallelism
      # Don't send separate messages - combine all Task calls in ONE message
      ```

   d. **Wave Progress Monitoring**:
      - **Start timestamp**: Record wave start time
      - **Periodic check**: Every 15 minutes, query task completion status (read tasks.md)
      - **Completion signal**: Agent finishes when tasks marked [X] in tasks.md
      - **Blocking signal**: If NO tasks marked [X] after 30 minutes → invoke debugger agent
      - **Partial progress**: If SOME tasks [X] but not all → agent is making progress, continue waiting
      - Update TodoWrite with real-time wave status

   e. **Validate wave completion**:
      - Read tasks.md to verify all wave tasks marked [X]
      - Check for partial completion or failures
      - If failures: invoke debugger agent with structured error report (see below)

   f. **Proceed to next wave** when all tasks complete

   **Wave Execution Edge Cases**:
   - **Single-agent wave**: If all tasks go to same agent, send as single batch (no parallelism needed)
   - **Mixed wave** (sequential + parallel): Execute sequential first, then parallel batch
   - **Wave failure**: If N tasks succeed but M tasks fail, mark succeeded as [X], retry failed with debugger agent
   - **Empty wave**: Skip if all tasks already complete (avoid launching agents with no work)

7. **🏗️ CRITICAL: Architect Review for Technical Decisions**:

   **IMPORTANT**: The architect agent MUST review all technical decisions to maintain consistency across the entire tech stack:
   - **Thin Client** (MCP thin client)
   - **MCP Server** (FastMCP backend)
   - **Frontend Application** (Next.js)
   - **Backend Application** (FastAPI)
   - **PostgreSQL Database** (schema, queries, indexes)

   **AUTOMATIC Architect Review Triggers** (orchestrator MUST invoke):
   1. **After task generation** (validate tasks align with plan.md) - BLOCKING BEFORE IMPLEMENTATION
   2. **After Foundational phase** (Phase 2) completes - BLOCKING BEFORE USER STORIES
   3. **After any phase that introduces new**:
      - Database tables (new models)
      - External integrations (new APIs, webhooks)
      - Deployment patterns (new infrastructure)
   4. **Every 50 tasks completed** (for large features >100 tasks) - CHECKPOINT REVIEW
   5. **Before feature completion** (final validation) - BLOCKING BEFORE LAUNCH

   **MANUAL Architect Review Triggers** (orchestrator prompts user):
   1. Before implementing new database schemas (if not caught by automatic trigger)
   2. Before adding new libraries/frameworks (if architectural impact unclear)
   3. When agent reports "this pattern feels wrong" or raises architectural concern

   **Architect review process**:
   ```python
   Task(
       subagent_type="architect",
       description="Review {component} technical design",
       prompt="""Review the technical design for {component} implementation.

       Context:
       - Feature: {feature-id}
       - Component: {component-name}
       - Changes: {description of changes}
       - Files affected: {file paths}
       - Phase: {current phase}
       - Progress: {X/Y tasks complete}

       Validate:
       1. Consistency with existing tech stack (thin client, MCP, frontend, backend, database)
       2. Adherence to architectural patterns from plan.md
       3. Database schema consistency (if applicable)
       4. API contract consistency (if applicable)
       5. Security and performance considerations

       Provide structured output:
       **Status**: [APPROVED | APPROVED WITH CONCERNS | BLOCKED]
       **Critical Issues**: List blocking issues (empty if none)
       **Concerns**: List improvements to address (can be post-launch)
       **Recommendations**: List nice-to-have improvements
       **Risks**: List potential risks (with mitigation strategies)
       **Approval**: Clear decision to proceed or block
       """
   )
   ```

   **Block implementation if architect status is BLOCKED** until issues are resolved.

8. **📚 CRITICAL: Knowledge Base Capture**:

   **IMPORTANT**: Capture ALL genuine insights, bug solutions, and patterns discovered during implementation.

   **Knowledge Base Location**: `docs/kb/KB.md`

   **What to capture**:

   a. **Genuine Insights** (not obvious or trivial):
      - Unexpected behavior or edge cases discovered
      - Non-obvious solutions to complex problems
      - Performance optimizations that worked
      - Integration patterns that solved real challenges
      - Library/framework quirks and workarounds

   b. **Bug Solutions**:
      - Root cause analysis (5 Whys if complex)
      - Reproduction steps
      - Solution implementation details
      - Prevention strategies

   c. **Patterns and Best Practices**:
      - Reusable code patterns
      - Architectural decisions and rationale
      - Testing strategies that proved effective
      - Deployment configurations that worked

   **Knowledge Base Capture Triggers** (orchestrator MUST check):
   1. **AUTOMATIC**: After debugger agent invoked (implies >30min issue)
   2. **AUTOMATIC**: After any task marked "BLOCKED" then unblocked (resolution = learning)
   3. **AUTOMATIC**: After architect raises concern, then implementation changes (decision = learning)
   4. **PROMPT AGENT**: At end of each phase, ask: "Any non-obvious learnings to capture?"
   5. **REJECT EMPTY**: If agent says "no learnings", probe deeper: "What took longest? Any surprises?"

   **How to capture**:
   ```python
   # After solving complex issue or discovering pattern
   Task(
       subagent_type="architect",  # or appropriate agent
       description="Capture knowledge base entry",
       prompt="""Create knowledge base entry for {topic}.

       Context:
       - What problem was solved: {description}
       - Root cause (if bug): {root cause}
       - Solution implemented: {solution details}
       - Why this is non-obvious: {insight}
       - Files affected: {file paths}

       Entry must pass approval checklist:
       1. Does this entry save future developers >30 minutes?
       2. Would you have wanted this knowledge BEFORE starting?
       3. Does it explain a non-obvious "gotcha" or edge case?

       Length guidelines: 100-300 words (concise but complete)
       - Title: 5-10 words
       - Problem: 1-2 sentences
       - Root Cause: 1-3 sentences
       - Solution: 2-5 sentences
       - Prevention: 1-2 sentences

       Add entry to docs/kb/KB.md following existing format.
       """
   )
   ```

   **KB Entry Approval Checklist** (orchestrator MUST validate):
   1. Does this entry save future developers >30 minutes?
   2. Would you have wanted this knowledge BEFORE starting?
   3. Does it explain a non-obvious "gotcha" or edge case?
   4. If NO to any above → REJECT entry, ask agent to revise

   **Quality standards**:
   - ✅ Captures actionable insights (not "we implemented X")
   - ✅ Explains WHY, not just WHAT
   - ✅ Includes specific examples or code snippets
   - ✅ Helps future developers avoid same pitfall
   - ❌ Obvious facts ("we use PostgreSQL for database")
   - ❌ Generic statements ("testing is important")
   - ❌ Implementation progress reports

9. **Progress tracking and error handling**:

   **Wave-level tracking with TodoWrite**:

   Structure todos as waves for parallel visibility:
   ```python
   TodoWrite(todos=[
     {
       "content": "Wave 1: 3 test agents (T061-T063) [P] - tester",
       "status": "in_progress",
       "activeForm": "Launching Wave 1 test agents"
     },
     {
       "content": "Wave 2: Backend services (T064-T071) - senior-backend-engineer",
       "status": "pending",
       "activeForm": "Launching Wave 2 backend services"
     },
     {
       "content": "Wave 3: Frontend components (T072-T075) [P] - code-monkey",
       "status": "pending",
       "activeForm": "Launching Wave 3 frontend components"
     },
     {
       "content": "Architect Review: Validate US3 tier upgrade flow",
       "status": "pending",
       "activeForm": "Conducting architect review of US3"
     }
   ])
   ```

   **Wave Naming Convention**: "Wave N: [Task Count] [Agent Type] (Task Range) [P if parallel] - agent-name"

   **Structured Error Reporting for Debugger Agent**:

   When task fails, orchestrator provides:
   ```
   Task TXX ({task description}) failed during Wave N execution.

   Context:
   - Agent: {agent-name}
   - Files: {file paths}
   - Dependencies: {completed prerequisite tasks}
   - Phase: {current phase}

   Failure:
   - Error: {error message or signal}
   - Stack trace: {if available}

   Hypothesis: {possible root cause}

   Investigate:
   1. {specific check 1}
   2. {specific check 2}
   3. {specific check 3}
   ```

   **Error handling**:
   - If wave fails: Identify failed tasks
   - Invoke debugger agent with structured error report (above)
   - Retry failed tasks after fixes
   - Continue to next wave only when all tasks complete

   **Blocking detection**:
   - Monitor agent progress (>30min no updates = blocked)
   - Invoke debugger agent for blocked tasks
   - Update Knowledge Base with blocker resolution (AUTOMATIC trigger)

   **Task completion**:
   - Mark completed tasks as [X] in tasks.md after each wave
   - Verify file changes match expected task outputs
   - Confirm no constitutional violations (.specify/ unchanged)

10. **Completion Validation Checklist**:

    Execute this checklist BEFORE marking feature complete:

    - [ ] **Tasks File**: Read tasks.md, verify 0 tasks with `- [ ]` status (all must be `- [X]`)
    - [ ] **Tests Pass**: Run test suite, verify 0 failures (if test infrastructure exists)
    - [ ] **Architect Approval**: Architect agent conducted final review and approved (BLOCKING)
    - [ ] **Knowledge Base**: At least 1 entry per 50 tasks (or explicit "no learnings" justification)
    - [ ] **Constitutional Compliance**: Verify .specify/ directory unchanged (no spec modifications during implementation)
    - [ ] **Integration Test**: Run quickstart.md validation script (if exists in feature directory)
    - [ ] **Performance Targets**: Verify NFRs met (if defined in spec.md Section "Non-Functional Requirements")
    - [ ] **User Stories**: Each user story has independent test scenario passing (if defined in spec.md)

    **If ANY checklist item fails**: Feature is NOT complete, create blocking tasks to address.

    **Report final status with summary**:
    ```
    Feature {feature-id} Implementation Complete

    Execution Summary:
    - Total Tasks: {count}
    - Total Waves: {count}
    - Agents Utilized: {list}
    - Sequential Estimate: {hours}
    - Actual Duration: {hours}
    - Parallel Efficiency: {percentage}% time savings
    - Architect Reviews: {count}
    - Knowledge Base Entries: {count}

    Quality Gates Passed:
    ✅ All tasks marked [X] in tasks.md
    ✅ Architect final review approved
    ✅ Knowledge base updated with {count} learnings
    ✅ Constitutional compliance verified
    ✅ Tests passing (if applicable)
    ✅ User story test scenarios validated
    ```

    **Parallel Efficiency Calculation**:
    ```
    Formula: Efficiency = 1 - (Actual Time / Sequential Time)

    Where:
    - Sequential Time: Sum of all task durations (if run one-by-one)
    - Actual Time: Wall-clock time from start to finish (with parallelism)

    Example: 203 tasks × 1 hour = 203 hours sequential
             Actual: 95 hours parallel
             Efficiency: 1 - (95/203) = 53% time savings
    ```

## Orchestration Best Practices

**Maximize Parallelism**:
- Launch all [P] tasks in same wave simultaneously
- Use SINGLE message with multiple Task calls
- Different agents can work on different files in parallel
- Optimal wave size: 6-15 tasks (balanced feedback vs overhead)

**Respect Dependencies**:
- Phase boundaries are hard stops (complete all before next)
- Sequential tasks within phase must run in order
- File-based locks: same file = sequential, different files = parallel
- Write→Write or Write→Read = sequential, Read→Read = parallel

**Quality Gates**:
- Architect review AUTOMATICALLY after task generation, foundational phase, and every 50 tasks
- Architect review BLOCKS implementation if status is BLOCKED
- Knowledge base capture AUTOMATICALLY triggered by debugger invocation or blocker resolution
- Constitutional compliance: verify no .specify/ modifications

**Agent Coordination**:
- Backend + Frontend + Testing agents can work simultaneously
- Use file paths to detect conflicts
- TodoWrite for real-time visibility into parallel execution
- Structured error reporting for efficient debugging

Note: This command uses parallel agent orchestration for maximum efficiency. Complex features with 50+ tasks can be reduced from 220 hours sequential to 95 hours parallel (57% faster).
