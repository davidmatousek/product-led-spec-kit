# Research: Claude Code v2.1.16 Integration

## Metadata

- **Feature ID**: 002
- **Feature Name**: Anthropic Claude Code Updates Integration
- **Research Date**: 2026-01-24
- **Status**: Complete

---

## Research Objectives

1. Understand native task dependency tracking system in Claude Code v2.1.16
2. Investigate context forking for agent isolation
3. Evaluate parallel execution improvements
4. Determine version detection capabilities

---

## Findings

### 1. Native Task Dependency Tracking System

**Decision**: Implement custom dependency wrapper using TodoWrite for visibility

**Rationale**:
- Native TodoWrite tool provides progress tracking (`pending`, `in_progress`, `completed`)
- No declarative DAG API for expressing "Task A depends on Task B"
- Dependency tracking is inference-based, not programmatic enforcement
- Spec Kit must implement dependency logic in command code

**Alternatives Considered**:
| Alternative | Pros | Cons | Decision |
|-------------|------|------|----------|
| Wait for native dependency API | Less code to maintain | Unknown timeline, blocks feature | Rejected |
| Use third-party orchestration (Claude Flow) | Full dependency DAG | External dependency, complexity | Rejected |
| Custom TodoWrite integration | Visibility into progress | Not true dependency enforcement | Accepted |

**Limitations**:
- Dependencies must be encoded in task descriptions rather than declaratively
- No native circular dependency detection
- Manual enforcement required in Triad commands

---

### 2. Context Forking for Agent Isolation

**Decision**: Use `context: fork` frontmatter for Triad agent isolation

**Rationale**:
- Native support via `context: fork` in SKILL.md frontmatter
- Prevents context pollution between parallel agents
- Forked contexts start fresh; only skill content becomes prompt
- Results (not intermediate state) merge back to parent

**API Pattern**:
```yaml
---
name: pm-review
description: PM review in isolated context
context: fork
agent: Explore
---

Review specification for product alignment...
```

**Built-in Subagents**:
| Agent | Model | Tools | Use Case |
|-------|-------|-------|----------|
| Explore | Haiku | Read-only | PM/Architect read-only reviews |
| Plan | Inherit | Read-only | Planning research |
| general-purpose | Inherit | All | Tasks requiring modifications |

**Lifecycle**:
1. Create isolated context fork
2. Load agent-specific context (skill becomes prompt)
3. Execute in isolation
4. Return results (not state) to parent
5. Destroy fork

**Limitations**:
- `context: fork` only makes sense for skills with explicit task instructions
- Forked skills don't inherit conversation history
- Subagents cannot spawn sub-subagents

---

### 3. Parallel Execution Improvements

**Decision**: Require Claude Code v2.1.16+ for full benefits (automatic)

**Rationale**:
- Multiple memory leak fixes across versions v2.1.0 through v2.1.16
- Orphaned tool result cleanup prevents API errors
- No Spec Kit code changes required

**Fixes Included in v2.1.16**:

| Version | Fix | Impact |
|---------|-----|--------|
| v2.1.0 | Memory leak in git diff parsing | Long sessions stable |
| v2.1.7 | Orphaned tool_result errors | Error handling |
| v2.1.9 | Long sessions parallel tool call failures | API stability |
| v2.1.14 | Memory leak (stream resources) | Resource management |
| v2.1.14 | Memory issues in parallel subagents | Concurrent execution |
| v2.1.16 | OOM crashes resuming subagent sessions | Session resumption |

**Alternatives Considered**:
- Backport fixes to v2.1.15: Rejected (maintenance burden, upstream handles this)

**Limitations**:
- Users on v2.1.15 may experience degraded parallel performance

---

### 4. Version Detection Capabilities

**Decision**: Use `CLAUDECODE` environment variable for feature detection

**Rationale**:
- Available since v0.2.47 (March 2025)
- Allows scripts to detect Claude Code execution environment
- Enables graceful degradation for older versions

**Detection Pattern**:
```bash
# Check if running in Claude Code environment
if [ -n "$CLAUDECODE" ]; then
  # v2.1.16+ features enabled
fi

# Alternative: Parse CLI version
CLAUDE_VERSION=$(claude --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
```

**Alternatives Considered**:
| Alternative | Pros | Cons | Decision |
|-------------|------|------|----------|
| Native version API | Clean integration | Doesn't exist | Rejected |
| TTY detection hack | Works pre-v0.2.47 | Unreliable | Rejected |
| CLAUDECODE env var | Official, reliable | Presence only | Accepted |

**Limitations**:
- No semantic version environment variable
- Must implement version parsing manually if needed
- Feature detection adds complexity to codebase

---

## Integration Priorities

| Priority | Feature | Effort | Value | Timeline |
|----------|---------|--------|-------|----------|
| P0 | Context Forking | Low | High | Week 2 |
| P0 | Parallel Execution | None | High | Automatic |
| P1 | Task Dependency Wrapper | Medium | Medium | Week 3 |
| P2 | Version Detection | Medium | Medium | Week 3 |

---

## Best Practices

### Context Forking
- Only use `context: fork` for skills with explicit task instructions
- Choose appropriate agent type (Explore for read-only, general-purpose for write)
- Keep forked skill content focused and actionable

### Parallel Execution
- Batch independent tool calls in single message for parallel execution
- Monitor memory in long-running workflows
- Design for graceful cleanup on interruption

### Version Detection
- Check `CLAUDECODE` environment variable at runtime
- Provide graceful degradation messages for older versions
- Document minimum version requirements clearly

---

## Sources

- [Skills Documentation](https://code.claude.com/docs/en/skills)
- [Subagents Documentation](https://code.claude.com/docs/en/sub-agents)
- [Agent SDK](https://platform.claude.com/docs/en/agent-sdk/overview)
- [Todo Tracking](https://platform.claude.com/docs/en/agent-sdk/todo-tracking)
- [GitHub CHANGELOG](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md)
- [GitHub Issue #531 - CLAUDECODE env var](https://github.com/anthropics/claude-code/issues/531)

---

## Conclusion

Claude Code v2.1.16 provides significant capabilities for Spec Kit integration:

1. **Context forking** is production-ready - primary integration focus (low effort, high value)
2. **Parallel execution fixes** are automatic - no Spec Kit changes needed
3. **Task dependency tracking** requires custom wrapper - native API provides visibility not enforcement
4. **Version detection** needs manual implementation via `CLAUDECODE` environment variable

Recommended approach: Prioritize context forking and parallel execution for P0, with custom dependency wrapper and version detection as P1/P2.
