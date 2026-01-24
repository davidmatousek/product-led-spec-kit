# Quickstart: Claude Code v2.1.16 Integration

## Prerequisites

- Claude Code v2.1.16 or higher installed
- Product-Led Spec Kit initialized in your project

## Verify Claude Code Version

```bash
# Check version
claude --version

# Expected: claude-code version 2.1.16 (or higher)
```

## Feature Availability by Version

| Feature | Minimum Version | Status |
|---------|-----------------|--------|
| Context Forking | v2.1.0 | Available |
| Parallel Execution Fixes | v2.1.16 | Available |
| Task Dependency Tracking | v2.1.16 | Custom wrapper |
| CLAUDECODE Env Var | v0.2.47 | Available |

## Quick Feature Test

### 1. Test Context Forking

Create a test skill with fork context:

```bash
mkdir -p .claude/skills
cat > .claude/skills/test-fork.md << 'EOF'
---
name: test-fork
description: Test context forking
context: fork
agent: Explore
---

List the files in the current directory and report findings.
EOF
```

Run the skill:
```bash
/test-fork
```

Expected: Skill runs in isolated context, reports file listing.

### 2. Test Version Detection

```bash
# Check if CLAUDECODE env var is set
if [ -n "$CLAUDECODE" ]; then
  echo "Running in Claude Code environment"
else
  echo "Not in Claude Code or version < 0.2.47"
fi
```

### 3. Test Parallel Triad Review

Run the Triad plan command with parallel reviews:

```bash
/triad.plan
```

Expected: PM and Architect reviews run simultaneously, completing faster than sequential.

## Using Context Forking in Triad

### PM Review (Read-Only Fork)

```yaml
# .claude/skills/pm-review.md
---
name: pm-review
description: PM product alignment review
context: fork
agent: Explore
---

Review the specification at specs/{feature-id}/spec.md for:
1. Product vision alignment
2. User value clarity
3. Success criteria measurability

Provide structured review with APPROVED or CHANGES_REQUESTED verdict.
```

### Architect Review (Read-Only Fork)

```yaml
# .claude/skills/architect-review.md
---
name: architect-review
description: Architect technical review
context: fork
agent: Explore
---

Review the plan at specs/{feature-id}/plan.md for:
1. Tech stack consistency
2. Architecture alignment
3. No anti-patterns introduced

Provide structured review with APPROVED, APPROVED_WITH_CONCERNS, or CHANGES_REQUESTED verdict.
```

## Enabling Task Dependencies

Task dependencies are defined in tasks.md using the `depends_on` field:

```markdown
## Tasks

### T001: Set up version detection
- **Status**: pending
- **Depends on**: none
- **Agent**: senior-backend-engineer

### T002: Implement context forking
- **Status**: pending
- **Depends on**: T001
- **Agent**: senior-backend-engineer
```

## Graceful Degradation

If running on older Claude Code versions:

1. **Context forking unavailable (< v2.1.0)**:
   - Reviews run sequentially instead of parallel
   - Warning message displayed

2. **Parallel fixes unavailable (< v2.1.16)**:
   - Memory usage may increase in long sessions
   - Consider shorter workflow sessions

## Troubleshooting

### Fork Not Working

1. Check skill frontmatter has `context: fork`
2. Verify agent type is valid: `Explore`, `Plan`, or `general-purpose`
3. Ensure Claude Code version >= 2.1.0

### Version Not Detected

1. Check if running inside Claude Code (not direct API)
2. Verify `claude --version` returns valid version
3. Check `CLAUDECODE` environment variable presence

### Parallel Reviews Running Sequential

1. Ensure both PM and Architect Task calls are in same message
2. Verify feature flag not disabled
3. Check for dependency conflicts

## Next Steps

1. Read [research.md](./research.md) for detailed findings
2. Review [data-model.md](./data-model.md) for entity structures
3. Check [contracts/integration-contracts.md](./contracts/integration-contracts.md) for API specs
