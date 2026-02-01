# Agent Baseline Metrics

**Feature**: 003-agent-refactoring
**Date**: 2026-01-31
**Purpose**: Document current agent file sizes before refactoring

---

## Agent Line Counts

| Agent | Lines | Category |
|-------|-------|----------|
| architect.md | 1,026 | Core Triad |
| team-lead.md | 1,346 | Core Triad |
| product-manager.md | 430 | Core Triad |
| code-reviewer.md | 1,100 | Quality |
| debugger.md | 1,033 | Quality |
| tester.md | 509 | Quality |
| devops.md | 578 | Infrastructure |
| senior-backend-engineer.md | 411 | Engineering |
| ux-ui-designer.md | 392 | Design |
| security-analyst.md | 390 | Security |
| web-researcher.md | 364 | Research |
| frontend-developer.md | 306 | Engineering |

---

## Summary Statistics

| Metric | Value |
|--------|-------|
| **Total Agents** | 12 |
| **Total Lines** | 7,885 |
| **Average Lines per Agent** | 657 |
| **Largest Agent** | team-lead.md (1,346 lines) |
| **Smallest Agent** | frontend-developer.md (306 lines) |

---

## Size Distribution

| Size Category | Agents | Count |
|---------------|--------|-------|
| Large (>1,000 lines) | architect, team-lead, code-reviewer, debugger | 4 |
| Medium (500-1,000 lines) | devops, tester | 2 |
| Small (<500 lines) | product-manager, senior-backend-engineer, ux-ui-designer, security-analyst, web-researcher, frontend-developer | 6 |

---

## Refactoring Priority

Based on size and complexity, recommended refactoring priority:

1. **team-lead.md** (1,346 lines) - Largest file, highest potential for modularization
2. **code-reviewer.md** (1,100 lines) - Second largest
3. **debugger.md** (1,033 lines) - Third largest
4. **architect.md** (1,026 lines) - Fourth largest

These 4 agents represent 57% of total lines (4,505 of 7,885).

---

## Backup Reference

- Backup branch: `003-agent-backup`
- Created: 2026-01-31
- Base commit: Current state of `003-agent-refactoring` branch
