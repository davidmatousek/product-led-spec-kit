# Product Backlog

**Purpose**: Features and ideas that didn't make the current MVP or release cut.

---

## What Goes Here

- Features identified during `/triad.prd` that are "nice to have"
- Ideas from `/triad.prd` that were descoped from MVP
- User requests that align with vision but aren't prioritized yet
- Technical improvements that aren't urgent

## Naming Convention

```
_backlog/
├── README.md (this file)
├── feature-idea-name.md
├── deferred-from-mvp-001.md
└── future-enhancement-name.md
```

## Template for Backlog Items

```markdown
# [Feature Name]

**Added**: YYYY-MM-DD
**Source**: [/triad.prd | User Request | Team Idea]
**Priority**: [High | Medium | Low]
**Effort Estimate**: [Small | Medium | Large | Unknown]

## Description
[1-3 sentences describing the feature]

## Why It Was Deferred
[Why this didn't make the current cut]

## When to Revisit
[Trigger or timeframe for reconsidering this feature]

## Notes
[Any additional context]
```

## Moving Items Out of Backlog

When a backlog item is ready to build:

1. Create a PRD: `/triad.prd <feature-name>`
2. Reference the backlog item in the PRD
3. Move or delete the backlog file
4. Follow normal Triad workflow

## Review Cadence

Review the backlog:
- **Quarterly**: During OKR planning
- **After MVP Launch**: Prioritize next wave of features
- **When Capacity Opens**: Look for quick wins

---

*The backlog is where good ideas wait for their time.*
