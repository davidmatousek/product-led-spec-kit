# Data Model: Anthropic Claude Code Updates Integration

## Metadata

- **Feature ID**: 002
- **Feature Name**: Anthropic Claude Code Updates Integration
- **Created**: 2026-01-24
- **Author**: architect

---

## Overview

This document defines the data structures for integrating Claude Code v2.1.16 features with Product-Led Spec Kit. The primary entities are Task Dependencies (for workflow orchestration) and Context Forks (for agent isolation).

---

## Entities

### 1. TaskDependency

Represents a relationship between tasks defining execution prerequisites.

```typescript
interface TaskDependency {
  // Unique identifier for this dependency relationship
  id: string;                    // UUID v4

  // The task that has the dependency
  task_id: string;               // References Task.id

  // Array of prerequisite task IDs that must complete first
  depends_on: string[];          // Array of Task.id references

  // Current status of the dependency check
  dependency_status: 'waiting' | 'satisfied' | 'blocked';

  // Timestamp when all dependencies were satisfied (null if not yet)
  satisfied_at: string | null;   // ISO 8601 datetime

  // Error message if blocked
  block_reason: string | null;

  // Metadata
  created_at: string;            // ISO 8601 datetime
  updated_at: string;            // ISO 8601 datetime
}
```

**State Transitions**:
```
waiting → satisfied (all depends_on tasks completed)
waiting → blocked (any depends_on task failed)
blocked → waiting (after failed task is fixed and retried)
```

**Validation Rules**:
- `depends_on` must not include `task_id` (no self-dependency)
- All IDs in `depends_on` must reference existing tasks
- Circular dependencies must be detected and rejected

---

### 2. Task (Extended)

Extended from existing Spec Kit task structure to support dependencies.

```typescript
interface Task {
  // Core task fields (existing)
  id: string;                    // e.g., "T001", "T002"
  title: string;
  description: string;
  status: 'pending' | 'in_progress' | 'completed' | 'failed';

  // NEW: Dependency-related fields
  depends_on: string[];          // Array of task IDs that must complete first
  blocked_by: string[];          // Computed: tasks currently blocking this one

  // NEW: Agent assignment
  assigned_agent: string | null; // e.g., "senior-backend-engineer", "frontend-developer"

  // NEW: Execution context
  context_fork_id: string | null;// Reference to ContextFork if running in isolation

  // Metadata
  priority: 'P0' | 'P1' | 'P2';
  estimated_hours: number | null;
  actual_hours: number | null;
  created_at: string;
  updated_at: string;
  completed_at: string | null;
}
```

**Dependency Resolution**:
- Task cannot start (`in_progress`) until all `depends_on` tasks are `completed`
- If any `depends_on` task is `failed`, task status becomes `blocked`
- `blocked_by` is computed dynamically from `depends_on` + current task statuses

---

### 3. ContextFork

Represents an isolated execution context for an agent.

```typescript
interface ContextFork {
  // Unique identifier for the fork
  fork_id: string;               // UUID v4

  // Parent context (null for root)
  parent_context_id: string | null;

  // Agent executing in this fork
  agent_id: string;              // e.g., "product-manager", "architect"

  // Task being executed (if applicable)
  task_id: string | null;        // Reference to Task.id

  // Fork configuration
  fork_type: 'skill' | 'subagent';
  context_mode: 'fork' | 'inherit';  // fork = isolated, inherit = shared

  // Lifecycle timestamps
  created_at: string;            // ISO 8601 datetime
  started_at: string | null;     // When execution began
  completed_at: string | null;   // When execution finished
  destroyed_at: string | null;   // When fork was cleaned up

  // Status
  status: 'created' | 'running' | 'completed' | 'failed' | 'destroyed';

  // Results (populated on completion)
  result: ContextForkResult | null;

  // Error info (populated on failure)
  error: ContextForkError | null;
}
```

**Lifecycle**:
```
created → running → completed → destroyed
created → running → failed → destroyed
```

---

### 4. ContextForkResult

Results returned from a completed context fork.

```typescript
interface ContextForkResult {
  // Verdict for review operations
  verdict: 'APPROVED' | 'APPROVED_WITH_CONCERNS' | 'CHANGES_REQUESTED' | null;

  // Summary/report from the agent
  summary: string;

  // Artifacts created/modified
  artifacts: ContextForkArtifact[];

  // Recommendations or findings
  findings: ContextForkFinding[];

  // Execution metadata
  execution_time_ms: number;
  tokens_used: number | null;
}

interface ContextForkArtifact {
  type: 'file_created' | 'file_modified' | 'report';
  path: string;
  description: string;
}

interface ContextForkFinding {
  severity: 'critical' | 'warning' | 'info';
  category: string;
  message: string;
  file_path: string | null;
  line_number: number | null;
}
```

---

### 5. ContextForkError

Error information for failed context forks.

```typescript
interface ContextForkError {
  code: string;                  // e.g., "TIMEOUT", "RESOURCE_LIMIT", "EXECUTION_ERROR"
  message: string;
  stack_trace: string | null;
  recoverable: boolean;
}
```

---

### 6. VersionDetection

Runtime version detection for feature flags.

```typescript
interface VersionDetection {
  // Detected Claude Code version
  version: string | null;        // Semantic version or null if undetected

  // Parsed version components
  major: number | null;
  minor: number | null;
  patch: number | null;

  // Feature availability flags
  features: FeatureFlags;

  // Detection metadata
  detected_at: string;           // ISO 8601 datetime
  detection_method: 'env_var' | 'cli' | 'fallback';
}

interface FeatureFlags {
  context_forking: boolean;      // Requires v2.1.0+
  parallel_execution_fixes: boolean;  // Requires v2.1.16+
  task_dependency_tracking: boolean;  // Requires v2.1.16+
  env_var_detection: boolean;    // Requires v0.2.47+
}
```

**Feature Detection Rules**:
```typescript
const detectFeatures = (version: string | null): FeatureFlags => ({
  context_forking: compareVersions(version, '2.1.0') >= 0,
  parallel_execution_fixes: compareVersions(version, '2.1.16') >= 0,
  task_dependency_tracking: compareVersions(version, '2.1.16') >= 0,
  env_var_detection: version !== null  // If detected, env var works
});
```

---

## Relationships

```
┌─────────────────────────────────────────────────────────────┐
│                    Entity Relationships                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────┐         depends_on         ┌──────────┐       │
│  │   Task   │ ────────────────────────► │   Task   │       │
│  └──────────┘         (many-to-many)     └──────────┘       │
│       │                                                      │
│       │ executes_in                                          │
│       ▼                                                      │
│  ┌──────────────┐                                            │
│  │ ContextFork  │                                            │
│  └──────────────┘                                            │
│       │                                                      │
│       │ produces                                             │
│       ▼                                                      │
│  ┌──────────────────┐                                        │
│  │ ContextForkResult│                                        │
│  └──────────────────┘                                        │
│                                                              │
│  ┌──────────────────┐     enables      ┌──────────────┐     │
│  │ VersionDetection │ ───────────────► │ FeatureFlags │     │
│  └──────────────────┘                   └──────────────┘     │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## File Storage Patterns

### Tasks with Dependencies (tasks.md)

```markdown
## Tasks

### T001: Set up version detection
- **Status**: pending
- **Depends on**: none
- **Agent**: senior-backend-engineer
- **Priority**: P0

### T002: Implement context forking for PM reviews
- **Status**: pending
- **Depends on**: T001
- **Agent**: senior-backend-engineer
- **Priority**: P0

### T003: Implement context forking for Architect reviews
- **Status**: pending
- **Depends on**: T001
- **Agent**: senior-backend-engineer
- **Priority**: P0

### T004: Add parallel execution in Triad commands
- **Status**: pending
- **Depends on**: T002, T003
- **Agent**: senior-backend-engineer
- **Priority**: P0
```

### Context Fork Configuration (skill frontmatter)

```yaml
---
name: pm-review
description: PM review of specification
context: fork
agent: Explore
---
```

---

## Validation Rules Summary

| Entity | Rule | Error Code |
|--------|------|------------|
| TaskDependency | No self-dependency | ERR_SELF_DEPENDENCY |
| TaskDependency | No circular dependencies | ERR_CIRCULAR_DEPENDENCY |
| TaskDependency | All depends_on must exist | ERR_INVALID_DEPENDENCY |
| ContextFork | Fork must complete before destroy | ERR_PREMATURE_DESTROY |
| ContextFork | Cannot fork from destroyed context | ERR_FORK_FROM_DESTROYED |
| VersionDetection | Version must be semver format | ERR_INVALID_VERSION |

---

## Migration Notes

### From Spec Kit v1.x (no dependencies)

Existing tasks.md files without `depends_on` field:
- Interpreted as `depends_on: []` (no dependencies)
- Tasks execute in definition order by default
- No changes required for backward compatibility

### From Sequential to Parallel Execution

Existing Triad commands using sequential agent invocation:
- Can opt-in to parallel execution where agents are independent
- PM + Architect reviews can run in parallel context forks
- No changes to result merging logic

---

## Appendix: Type Definitions (TypeScript)

Full type definitions available at:
`specs/002-anthropic-updates-integration/contracts/types.ts`
