# PRD Index - {{PROJECT_NAME}}

**Last Updated**: {{CURRENT_DATE}}
**Owner**: Product Manager (product-manager)
**Total PRDs**: 0

---

## Overview

This directory contains Product Requirements Documents (PRDs) for {{PROJECT_NAME}}. Each PRD defines the **What** and **Why** for a feature or initiative.

---

## PRD Registry

| ID | Title | Status | Created | Owner | Related Spec |
|----|-------|--------|---------|-------|--------------|
| 000 | Example Feature PRD | Example | {{CURRENT_DATE}} | product-manager | N/A |
| <!-- Add new PRDs here --> |

---

## PRD Lifecycle

### 1. Draft
- PM creates PRD using `/triad.prd <topic>`
- Architect provides baseline (if infrastructure)
- Tech-Lead provides feasibility check
- Architect provides technical review

### 2. Review
- PM incorporates Triad feedback
- Stakeholders provide input
- PM addresses feedback

### 3. Approved
- All Triad sign-offs complete
- PM marks as "Approved" in this INDEX
- Ready for `/triad.specify`

### 4. In Progress
- Spec, plan, and tasks created
- Implementation underway

### 5. Delivered
- Feature meets Definition of Done
- PRD archived or marked complete

---

## Creating a New PRD

```bash
# Use Triad workflow for automatic validation
/triad.prd <your-feature-topic>

# Manual workflow (not recommended)
/speckit.prd <your-feature-topic>
```

**PRD Naming Convention**: `NNN-topic-YYYY-MM-DD.md`
- `NNN`: Sequential number (001, 002, 003, ...)
- `topic`: Kebab-case description
- `YYYY-MM-DD`: Creation date

**Example**: `001-user-authentication-2025-01-15.md`

---

## PRD Template

See `000-example-feature.md` for an annotated PRD template.

**Required Sections**:
1. **Problem Statement**: User problem being solved
2. **Target Users**: Which persona(s) benefit
3. **Success Metrics**: Measurable outcomes
4. **Requirements**: Functional and non-functional requirements
5. **Scope**: In-scope and out-of-scope items
6. **Dependencies**: Prerequisites and blockers
7. **Timeline**: Estimated effort (from Tech-Lead feasibility)

---

## PRD Quality Standards

All approved PRDs must have:
- ✅ Clear problem statement tied to user pain points
- ✅ Target personas from `docs/product/01_Product_Vision/target-users.md`
- ✅ Measurable success metrics
- ✅ Well-defined scope (in/out)
- ✅ Triad validation complete (baseline, feasibility, technical review)
- ✅ Technical accuracy >95% (< 3 inaccuracies)

---

## Related Documentation

- `docs/product/01_Product_Vision/` - Strategic vision and personas
- `docs/SPEC_KIT_TRIAD.md` - Triad workflow guide
- `docs/core_principles/PRODUCT_SPEC_ALIGNMENT.md` - Sign-off requirements
- `.claude/skills/prd-create/` - PRD creation skill
- `.claude/agents/product-manager.md` - Product Manager agent

---

**Template Instructions**: Delete the example PRD and this message after creating your first real PRD.
