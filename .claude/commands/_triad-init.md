---
name: triad-init
description: Triad command initialization with version detection and feature flags
internal: true
---

# Triad Command Initialization

This internal command is sourced by all Triad commands to initialize version detection and feature flags.

## Initialization Steps

### 1. Detect Claude Code Version

```bash
# Source version detection utilities
source .claude/lib/version/detect.sh 2>/dev/null || true
source .claude/lib/version/feature-flags.sh 2>/dev/null || true
```

### 2. Log Version Status

```
[TRIAD] Claude Code: v${SPECKIT_CLAUDE_VERSION:-unknown}
[TRIAD] Features: context_forking=${SPECKIT_FEATURE_CONTEXT_FORKING:-false}, parallel_execution=${SPECKIT_FEATURE_PARALLEL_EXECUTION:-false}
```

### 3. Feature Availability

The following features are version-dependent:

| Feature | Required Version | Flag |
|---------|-----------------|------|
| Context Forking | v2.1.0+ | SPECKIT_FEATURE_CONTEXT_FORKING |
| Parallel Execution | v2.1.16+ | SPECKIT_FEATURE_PARALLEL_EXECUTION |
| Task Dependencies | v2.1.16+ | SPECKIT_FEATURE_TASK_DEPENDENCIES |

### 4. Graceful Degradation

If features are unavailable:

- **Context Forking OFF**: Reviews execute in shared context (sequential recommended)
- **Parallel Execution OFF**: Reviews execute sequentially (PM → Architect → Tech-Lead)
- **Task Dependencies OFF**: Manual dependency coordination required

## Usage by Triad Commands

All Triad commands should check feature flags before using advanced features:

```markdown
## Pre-flight Check

Before executing, verify version and features:

1. Source initialization: `source .claude/commands/_triad-init.md` (conceptually)
2. Check parallel support: If SPECKIT_FEATURE_PARALLEL_EXECUTION=true, use parallel Task calls
3. Check context forking: If SPECKIT_FEATURE_CONTEXT_FORKING=true, skills run in isolated contexts
4. Log any degradation: Use .claude/lib/version/degradation.sh for user messaging

## Execution Mode Decision

**If v2.1.16+ (full features)**:
- Launch PM + Architect reviews in parallel via single message with two Task calls
- Skills execute in forked contexts
- Results merge automatically

**If v2.1.15 (limited features)**:
- Execute reviews sequentially (PM first, then Architect)
- Log degradation message explaining limited mode
- All workflows still function correctly
```

## Implementation Notes

- This is a conceptual initialization guide, not an executable script
- Each Triad command should include version-awareness logic
- Graceful degradation ensures backward compatibility
- Users on older versions see clear messaging about limited functionality
