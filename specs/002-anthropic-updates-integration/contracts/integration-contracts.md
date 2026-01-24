# Integration Contracts: Claude Code v2.1.16

## Metadata

- **Feature ID**: 002
- **Feature Name**: Anthropic Claude Code Updates Integration
- **Created**: 2026-01-24
- **Author**: architect

---

## Overview

This document defines the integration contracts between Product-Led Spec Kit and Claude Code v2.1.16 features. These are interface specifications, not implementation details.

---

## 1. Context Fork Interface

### Skill Frontmatter Contract

Skills opt into context forking via YAML frontmatter:

```yaml
---
# Required fields
name: string              # Unique skill identifier
description: string       # Human-readable description

# Context forking fields
context: 'fork' | 'inherit'  # fork = isolated, inherit = shared (default)
agent: string             # Built-in agent: 'Explore', 'Plan', 'general-purpose'

# Optional fields
allowed_tools: string[]   # Tools available to forked context
skills: string[]          # Other skills to preload in fork
model: string             # Model override: 'sonnet', 'opus', 'haiku'
---
```

### Built-in Agents

| Agent | Tools | Model | Use Case |
|-------|-------|-------|----------|
| `Explore` | Read-only (Glob, Grep, Read, WebFetch, WebSearch) | Haiku | PM/Architect reviews |
| `Plan` | Read-only | Inherit | Planning research |
| `general-purpose` | All | Inherit | Tasks requiring modifications |

### Fork Lifecycle Events

```
Event: FORK_CREATED
Payload: { fork_id, parent_context_id, agent_id, created_at }

Event: FORK_STARTED
Payload: { fork_id, started_at }

Event: FORK_COMPLETED
Payload: { fork_id, completed_at, result }

Event: FORK_FAILED
Payload: { fork_id, failed_at, error }

Event: FORK_DESTROYED
Payload: { fork_id, destroyed_at }
```

---

## 2. Task Dependency Interface

### TodoWrite Tool Contract

The TodoWrite tool manages task lists with status tracking:

```typescript
// Tool name: TodoWrite
interface TodoWriteParams {
  todos: TodoItem[];
}

interface TodoItem {
  content: string;           // Task description (imperative form)
  activeForm: string;        // Present continuous form for status
  status: 'pending' | 'in_progress' | 'completed';
}
```

### Dependency Encoding in Task Content

Since TodoWrite lacks native dependency support, dependencies are encoded in task content:

```markdown
## Pattern: Dependency in Task Content

### T002: Implement context forking for PM reviews
- **Status**: pending
- **Depends on**: T001 (Version detection)
- **Agent**: senior-backend-engineer

The depends_on field is parsed by Spec Kit commands, not by Claude Code.
```

### Dependency Resolution Contract

```typescript
// Spec Kit internal dependency resolver
interface DependencyResolver {
  // Check if task can start
  canStart(taskId: string): boolean;

  // Get blocking tasks
  getBlockers(taskId: string): string[];

  // Get ready-to-start tasks (no blockers)
  getReadyTasks(): string[];

  // Detect circular dependencies
  validateDependencyGraph(): ValidationResult;
}

interface ValidationResult {
  valid: boolean;
  errors: DependencyError[];
}

interface DependencyError {
  type: 'SELF_DEPENDENCY' | 'CIRCULAR' | 'MISSING_TASK';
  taskId: string;
  details: string;
}
```

---

## 3. Version Detection Interface

### Environment Variable Contract

```bash
# CLAUDECODE environment variable (v0.2.47+)
# Presence indicates running in Claude Code environment
# Value is not documented; presence check only

if [ -n "$CLAUDECODE" ]; then
  echo "Running in Claude Code"
fi
```

### CLI Version Contract

```bash
# claude --version output format
# Example: "claude-code version 2.1.16"
claude --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+'
```

### Feature Detection Contract

```typescript
interface FeatureDetector {
  // Detect current Claude Code version
  detectVersion(): VersionInfo;

  // Check if specific feature is available
  hasFeature(feature: FeatureName): boolean;

  // Get all feature flags
  getFeatureFlags(): FeatureFlags;
}

type FeatureName =
  | 'context_forking'
  | 'parallel_execution_fixes'
  | 'task_dependency_tracking'
  | 'env_var_detection';

interface VersionInfo {
  version: string | null;
  major: number | null;
  minor: number | null;
  patch: number | null;
  detected_at: string;
  detection_method: 'env_var' | 'cli' | 'fallback';
}

interface FeatureFlags {
  context_forking: boolean;           // v2.1.0+
  parallel_execution_fixes: boolean;  // v2.1.16+
  task_dependency_tracking: boolean;  // v2.1.16+
  env_var_detection: boolean;         // v0.2.47+
}
```

---

## 4. Triad Command Integration Contracts

### Parallel Agent Invocation

```typescript
// Contract: Parallel Task calls for Triad reviews
// PM and Architect reviews run simultaneously in separate context forks

interface ParallelReviewInvocation {
  // Both tasks launched in single message
  tasks: [
    {
      subagent_type: 'product-manager';
      description: 'PM sign-off review';
      context: 'fork';  // Isolated context
    },
    {
      subagent_type: 'architect';
      description: 'Architect technical review';
      context: 'fork';  // Isolated context
    }
  ];
}
```

### Review Result Merging

```typescript
// Contract: Merging parallel review results

interface ReviewResultMerger {
  // Merge PM and Architect reviews
  mergeReviews(
    pmResult: ReviewResult,
    architectResult: ReviewResult
  ): MergedReviewResult;
}

interface ReviewResult {
  agent: 'product-manager' | 'architect';
  verdict: 'APPROVED' | 'APPROVED_WITH_CONCERNS' | 'CHANGES_REQUESTED';
  findings: Finding[];
  recommendations: string[];
}

interface MergedReviewResult {
  overall_status: 'APPROVED' | 'CHANGES_REQUESTED';
  pm_verdict: ReviewResult;
  architect_verdict: ReviewResult;
  blocking_issues: Finding[];
  all_recommendations: string[];
}
```

---

## 5. Graceful Degradation Contract

### Fallback Behavior for v2.1.15

```typescript
interface GracefulDegradation {
  // When context forking unavailable
  onForkingUnavailable(): FallbackStrategy;

  // When parallel execution unstable
  onParallelUnstable(): FallbackStrategy;
}

interface FallbackStrategy {
  strategy: 'sequential' | 'skip' | 'warn_and_continue';
  message: string;
}

// Example fallback strategies
const FALLBACKS = {
  context_forking: {
    strategy: 'sequential',
    message: 'Context forking unavailable (requires v2.1.0+). Running reviews sequentially.'
  },
  parallel_execution: {
    strategy: 'sequential',
    message: 'Parallel execution fixes unavailable (requires v2.1.16+). Running with reduced parallelism.'
  }
};
```

---

## 6. Error Contracts

### Fork Errors

```typescript
interface ContextForkError {
  code: 'FORK_FAILED' | 'FORK_TIMEOUT' | 'FORK_RESOURCE_LIMIT' | 'FORK_AGENT_ERROR';
  message: string;
  recoverable: boolean;
  recovery_action: 'retry' | 'fallback_sequential' | 'abort';
}
```

### Dependency Errors

```typescript
interface DependencyError {
  code: 'SELF_DEPENDENCY' | 'CIRCULAR_DEPENDENCY' | 'MISSING_DEPENDENCY' | 'BLOCKED_TASK';
  message: string;
  task_id: string;
  related_tasks: string[];
}
```

### Version Detection Errors

```typescript
interface VersionDetectionError {
  code: 'VERSION_UNDETECTED' | 'VERSION_PARSE_ERROR' | 'FEATURE_UNAVAILABLE';
  message: string;
  fallback_version: string | null;
}
```

---

## 7. Configuration Contract

### Environment-Based Configuration

```bash
# Optional: Override version detection
SPEC_KIT_CLAUDE_VERSION=2.1.16

# Optional: Force feature flags (for testing)
SPEC_KIT_FORCE_CONTEXT_FORK=true
SPEC_KIT_FORCE_PARALLEL=true

# Optional: Disable features (for debugging)
SPEC_KIT_DISABLE_CONTEXT_FORK=false
SPEC_KIT_DISABLE_PARALLEL=false
```

### Skill Configuration

```yaml
# .claude/skills/pm-review.md frontmatter
---
name: pm-review
description: PM review with context isolation
context: fork
agent: Explore
allowed_tools:
  - Read
  - Glob
  - Grep
---
```

---

## Appendix: Migration from Sequential to Parallel

### Before (Sequential Triad)

```
1. /speckit.plan completes
2. Invoke PM agent (wait for completion)
3. Invoke Architect agent (wait for completion)
4. Merge results
5. Update frontmatter
```

### After (Parallel Triad with Forks)

```
1. /speckit.plan completes
2. Launch PM fork + Architect fork (parallel)
3. Wait for both to complete
4. Merge results from both forks
5. Update frontmatter
```

### Timing Impact

| Workflow | Sequential | Parallel |
|----------|------------|----------|
| PM Review | 2-3 min | 2-3 min |
| Architect Review | 3-4 min | 3-4 min |
| **Total** | **5-7 min** | **3-4 min** |
| Savings | - | ~40-45% |
