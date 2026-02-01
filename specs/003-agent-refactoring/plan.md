---
triad:
  pm_signoff:
    agent: product-manager
    date: 2026-01-31
    status: APPROVED
    notes: "All spec requirements addressed. User scenarios mapped to phases. Success criteria measurable and aligned with PRD metrics. Scope correctly constrained to refactoring only. Phased approach delivers incremental user value. Foundation-first approach ensures consistent standards."
  architect_signoff:
    agent: architect
    date: 2026-01-31
    status: APPROVED
    notes: "Architecture is sound. 8-section structure, YAML frontmatter, and team-lead split are technically appropriate. Risk mitigation adequate with quantified contingencies. Line targets achievable via preservation-first process. 4-week timeline validated. Recommendation: validate line targets with architect.md before team-lead split."
  techlead_signoff: null  # Added by /triad.tasks
---

# Technical Plan: Agent Refactoring - CISO_Agent Best Practices

## Metadata

- **Feature ID**: 003
- **Feature Name**: Agent Refactoring - CISO_Agent Best Practices
- **Status**: Approved
- **Created**: 2026-01-31
- **Author**: architect
- **Spec Reference**: specs/003-agent-refactoring/spec.md
- **PRD Reference**: docs/product/02_PRD/003-agent-refactoring-all-agents-2026-01-31.md
- **Priority**: P0
- **pm_signoff**: APPROVED
- **pm_signoff_date**: 2026-01-31
- **architect_signoff**: APPROVED
- **architect_signoff_date**: 2026-01-31

---

## Technical Context

### Current State Analysis

**Agent Metrics** (Before Refactoring):

| Agent | Lines | Category | Issues |
|-------|-------|----------|--------|
| team-lead.md | 1,346 | P0 Critical | Combines governance + orchestration |
| code-reviewer.md | 1,100 | P1 Medium | Excessive embedded examples |
| debugger.md | 1,033 | P1 Medium | Verbose debugging patterns |
| architect.md | 1,026 | P0 Critical | 550+ lines of code examples |
| devops.md | 578 | P1 Medium | Mixed template vars + concrete |
| tester.md | 509 | P1 Medium | Verbose BDD patterns |
| product-manager.md | 430 | P0 Critical | Verbose communication sections |
| senior-backend-engineer.md | 411 | P1 Medium | Standard verbosity |
| ux-ui-designer.md | 392 | P2 Final | Standard verbosity |
| security-analyst.md | 390 | P2 Final | Standard verbosity |
| web-researcher.md | 364 | P2 Final | Standard verbosity |
| frontend-developer.md | 306 | P2 Final | Minimal reduction needed |
| **TOTAL** | **7,885** | | **62% reduction target** |

**Pain Points**:
1. **Slow context loading**: Large agent files consume excessive tokens
2. **Inconsistent structure**: No standard section format across agents
3. **Missing metadata**: No version tracking, boundaries, or governance info
4. **No design guidance**: Template adopters lack documentation for customization
5. **Unclear scope**: Agents don't document what they DON'T do

### Target State

**Agent Metrics** (After Refactoring):

| Agent | Target Lines | Change |
|-------|--------------|--------|
| All 12 agents | ≤250 (300 max) | ~62% reduction |
| team-lead.md | 200 | Governance focus |
| orchestrator.md (NEW) | 250 | Workflow orchestration |
| **TOTAL** | ~3,000 | 62% reduction |

**Key Improvements**:
- Standardized 8-section structure across all agents
- YAML frontmatter with version, changelog, boundaries, governance
- Comprehensive best practices documentation
- Quick-reference agent overview document
- Clear separation of team-lead governance vs orchestration

### Technology Choices

| Component | Approach | Rationale |
|-----------|----------|-----------|
| Structure | 8-section template | Consistency, predictability |
| Metadata | YAML frontmatter | Standard, parseable, familiar |
| Versioning | Semantic versioning | Industry standard (MAJOR.MINOR.PATCH) |
| Process | Preservation-first | Ensures no capability loss |
| Validation | 8-point quality checklist | Measurable, binary pass/fail |

---

## Constitution Check

### Applicable Principles

| Principle | Status | Notes |
|-----------|--------|-------|
| I. General-Purpose Architecture | ✅ Compliant | Template vars preserved for tech choices |
| III. Backward Compatibility | ✅ Compliant | All agent capabilities preserved |
| VI. Testing Excellence | ⚠️ Manual | Validation through quality checklist |
| VII. Definition of Done | ✅ Planned | 3-step validation at each phase |
| IX. Git Workflow | ✅ Compliant | Feature branch, PRs required |
| X. Product-Spec Alignment | ✅ Compliant | PM sign-off on spec complete |
| XI. SDLC Triad | ✅ Compliant | Triad workflow preserved in agents |

### Validation Gates

- [ ] Best practices documentation complete
- [ ] Agent overview documentation complete
- [ ] All 12 agents pass 8/8 quality criteria
- [ ] Total line count ≤3,500 (target ~3,000)
- [ ] All agent capabilities preserved (validated per agent)
- [ ] YAML frontmatter consistent across all agents

---

## Architecture Overview

### 8-Section Agent Structure

```
┌──────────────────────────────────────────────────────────┐
│                  STANDARD AGENT STRUCTURE                 │
├──────────────────────────────────────────────────────────┤
│                                                           │
│  ┌─────────────────────────────────────────────────────┐ │
│  │ YAML FRONTMATTER                                     │ │
│  │ - version: x.y.z                                     │ │
│  │ - changelog: [entries]                               │ │
│  │ - boundaries: [scope limits]                         │ │
│  │ - triad-governance: [participation]                  │ │
│  └─────────────────────────────────────────────────────┘ │
│                                                           │
│  Section 1: CORE MISSION (What agent does)              │
│  Section 2: ROLE DEFINITION (Place in workflow)         │
│  Section 3: WHEN TO USE (Trigger phrases, use cases)    │
│  Section 4: WORKFLOW STEPS (Step-by-step process)       │
│  Section 5: QUALITY STANDARDS (Acceptance criteria)     │
│  Section 6: TRIAD GOVERNANCE (Sign-off participation)   │
│  Section 7: TOOLS & SKILLS (Available capabilities)     │
│  Section 8: SUCCESS CRITERIA (Effectiveness measures)   │
│                                                           │
└──────────────────────────────────────────────────────────┘
```

### Team-Lead Split Architecture

```
┌────────────────────────────────────────────────────────────┐
│              TEAM-LEAD SPLIT PATTERN                        │
├────────────────────────────────────────────────────────────┤
│                                                             │
│  BEFORE (1,346 lines)                                      │
│  ┌────────────────────────────────────────────────────┐   │
│  │           team-lead.md (MONOLITHIC)                 │   │
│  │  ┌─────────────────┐  ┌─────────────────┐          │   │
│  │  │   Governance    │  │  Orchestration  │          │   │
│  │  │   - Sign-offs   │  │  - Coordination │          │   │
│  │  │   - Feasibility │  │  - Parallel exec│          │   │
│  │  │   - Capacity    │  │  - Task tracking│          │   │
│  │  │   - Assignments │  │  - Agent dispatch│         │   │
│  │  └─────────────────┘  └─────────────────┘          │   │
│  └────────────────────────────────────────────────────┘   │
│                          │                                 │
│                          ▼                                 │
│  AFTER (450 lines total)                                  │
│  ┌──────────────────┐    ┌──────────────────┐            │
│  │  team-lead.md    │    │  orchestrator.md │            │
│  │  (200 lines)     │    │  (250 lines)     │            │
│  │                  │    │                   │            │
│  │  GOVERNANCE:     │    │  WORKFLOWS:       │            │
│  │  • Sign-offs     │    │  • Agent dispatch │            │
│  │  • Feasibility   │◄───│  • Parallel exec  │            │
│  │  • Capacity      │    │  • Task tracking  │            │
│  │  • Assignments   │───►│  • Coordination   │            │
│  │                  │    │                   │            │
│  │  Use when:       │    │  Use when:        │            │
│  │  "Sign off"      │    │  "Orchestrate"    │            │
│  │  "Is it feasible"│    │  "Coordinate"     │            │
│  │  "Assign agents" │    │  "Execute tasks"  │            │
│  └──────────────────┘    └──────────────────┘            │
│                                                             │
│  Handoff Pattern:                                          │
│  team-lead assigns → orchestrator executes → team-lead    │
│  validates completion                                      │
│                                                             │
└────────────────────────────────────────────────────────────┘
```

### Refactoring Data Flow

```
┌────────────────────────────────────────────────────────────┐
│              PRESERVATION-FIRST REFACTORING FLOW           │
├────────────────────────────────────────────────────────────┤
│                                                             │
│  1. INVENTORY (Read original)                              │
│         │                                                  │
│         ▼                                                  │
│  2. EXTRACT CAPABILITIES (List all functions)              │
│         │                                                  │
│         ▼                                                  │
│  3. CATEGORIZE SECTIONS                                    │
│     ├── Keep (core functionality)                         │
│     ├── Condense (verbose explanations → bullets)         │
│     ├── Reference (code examples → skill refs)            │
│     └── Remove (redundant, obvious, outdated)             │
│         │                                                  │
│         ▼                                                  │
│  4. APPLY 8-SECTION TEMPLATE                              │
│         │                                                  │
│         ▼                                                  │
│  5. ADD YAML FRONTMATTER                                  │
│     - version, changelog, boundaries, governance          │
│         │                                                  │
│         ▼                                                  │
│  6. VALIDATE                                              │
│     - 8/8 quality criteria                                │
│     - Line count ≤300                                     │
│     - Capabilities preserved                              │
│         │                                                  │
│         ▼                                                  │
│  7. TEST WITH REPRESENTATIVE TASKS                        │
│                                                             │
└────────────────────────────────────────────────────────────┘
```

---

## Implementation Phases

### Phase 0: Foundation Documentation (Week 1)

**Objective**: Create comprehensive design guidance before refactoring agents

**Deliverables**:
1. `_AGENT_BEST_PRACTICES.md` (~400 lines)
   - 8 core principles with examples
   - Standardized 8-section structure template
   - Required metadata fields specification
   - Quality evaluation checklist (8 criteria)
   - Preservation-first enhancement process (11 steps)
   - Template variable guidance

2. `_README.md` (~150 lines)
   - Agent roster table (all 12 agents)
   - Role/expertise/use-cases for each
   - Quick selection guidance
   - Triad governance participation matrix
   - Agent collaboration patterns

**Technical Approach**:
- Synthesize patterns from CISO_Agent analysis
- Create reusable section templates
- Document decision criteria for template vars

**Validation**:
- [ ] All 8 principles documented with examples
- [ ] 8-section template ready for use
- [ ] Quality checklist provides binary pass/fail
- [ ] Template adopters can follow process

**Estimated Effort**: 16-20 hours

---

### Phase 1: Priority Agents (P0) - Week 2

**Objective**: Refactor 3 most critical agents + create orchestrator

**Agents**:

| Agent | Before | After | Reduction | Approach |
|-------|--------|-------|-----------|----------|
| architect.md | 1,026 | 250 | 77% | Remove code examples, reference skills |
| team-lead.md | 1,346 | 200 | 85% | Split governance from orchestration |
| orchestrator.md | N/A | 250 | NEW | Extract from team-lead |
| product-manager.md | 430 | 250 | 42% | Condense verbose sections |

**Technical Approach**:

**architect.md** (1,026 → 250):
```
REMOVE: 550+ lines of embedded code examples
CONDENSE: Workflow sections to bullet points
REFERENCE: Skills for code generation patterns
PRESERVE: Architecture decision authority, review criteria
```

**team-lead.md split** (1,346 → 200 + 250):
```
team-lead.md (GOVERNANCE - 200 lines):
  - Triad sign-offs
  - Feasibility checks
  - Capacity validation
  - Agent assignments
  - Veto authority

orchestrator.md (WORKFLOWS - 250 lines):
  - Multi-agent coordination
  - Parallel execution waves
  - Task tracking
  - Agent dispatch
  - Progress monitoring
```

**product-manager.md** (430 → 250):
```
CONDENSE: Communication/documentation sections
REFERENCE: prd-create skill for PRD generation
PRESERVE: Veto authority, product alignment criteria
```

**Validation**:
- [ ] All P0 agents at target line counts
- [ ] 8-section structure applied
- [ ] YAML frontmatter added
- [ ] team-lead/orchestrator handoff documented
- [ ] Test with representative tasks

**Estimated Effort**: 24-32 hours

---

### Phase 2: Standard Agents (P1) - Week 3

**Objective**: Refactor 5 medium-complexity agents

**Agents**:

| Agent | Before | After | Reduction | Approach |
|-------|--------|-------|-----------|----------|
| code-reviewer.md | 1,100 | 250 | 77% | Remove embedded review examples |
| debugger.md | 1,033 | 250 | 76% | Condense patterns, keep 5 Whys |
| tester.md | 509 | 250 | 51% | Reference testing skills |
| devops.md | 578 | 250 | 57% | Balance template vars |
| senior-backend-engineer.md | 411 | 250 | 39% | Standard refactoring |

**Technical Approach**:

**code-reviewer.md** (1,100 → 250):
```
REMOVE: Embedded review checklists (move to skill)
CONDENSE: Review workflow to core steps
PRESERVE: All review categories, finding formats
```

**debugger.md** (1,033 → 250):
```
PRESERVE: 5 Whys methodology reference
CONDENSE: Debugging patterns to bullets
REMOVE: Verbose example debugging sessions
```

**tester.md** (509 → 250):
```
REFERENCE: Testing skills for BDD patterns
CONDENSE: Testing workflow sections
PRESERVE: Gherkin format, step definition patterns
```

**devops.md** (578 → 250):
```
PRESERVE: Deployment verification requirements
BALANCE: Template vars ({{CLOUD_PROVIDER}}) vs concrete
CONDENSE: Environment-specific sections
```

**senior-backend-engineer.md** (411 → 250):
```
STANDARD: Apply 8-section template
CONDENSE: Implementation guidance
PRESERVE: All backend patterns
```

**Validation**:
- [ ] All P1 agents at target line counts
- [ ] 8-section structure applied
- [ ] YAML frontmatter added
- [ ] Test with representative tasks

**Estimated Effort**: 30-40 hours

---

### Phase 3: Final Agents (P2) - Week 4

**Objective**: Refactor remaining 4 agents + comprehensive validation

**Agents**:

| Agent | Before | After | Reduction | Approach |
|-------|--------|-------|-----------|----------|
| ux-ui-designer.md | 392 | 250 | 36% | Standard refactoring |
| security-analyst.md | 390 | 250 | 36% | Preserve security patterns |
| web-researcher.md | 364 | 250 | 31% | Standard refactoring |
| frontend-developer.md | 306 | 250 | 18% | Structure + YAML only |

**Technical Approach**:

**All P2 agents follow standard process**:
```
1. Apply 8-section template
2. Add YAML frontmatter
3. Condense verbose sections
4. Preserve all capabilities
5. Validate against checklist
```

**Final Validation Tasks**:
```
1. Quality audit: All 12 agents pass 8/8 criteria
2. Line count audit: Total ≤3,500 (target ~3,000)
3. Structure audit: All use identical 8-section format
4. Metadata audit: All have required YAML fields
5. Capability audit: Representative task testing
```

**Validation**:
- [ ] All P2 agents at target line counts
- [ ] All 12 agents pass quality checklist
- [ ] Documentation complete
- [ ] Triad final sign-off

**Estimated Effort**: 20-28 hours

---

## Technical Decisions

### Decision 1: 8-Section Structure Standard

**Decision**: All agents use identical 8-section structure

**Rationale**:
- Predictability for template adopters
- Easier navigation and customization
- Consistent location for governance info
- Enables automated validation

**Sections**:
1. Core Mission
2. Role Definition
3. When to Use
4. Workflow Steps
5. Quality Standards
6. Triad Governance
7. Tools & Skills
8. Success Criteria

---

### Decision 2: Team-Lead Split Pattern

**Decision**: Split team-lead into governance (team-lead) + orchestration (orchestrator)

**Rationale**:
- Clear separation of concerns
- Each agent fits within 250-line target
- Enables focused use-case selection
- Reduces cognitive load per agent

**Handoff Pattern**:
```
team-lead: "Here are agent assignments"
     │
     ▼
orchestrator: "Executing wave 1 tasks in parallel..."
     │
     ▼
team-lead: "Validating completion, signing off"
```

---

### Decision 3: Template Variable Strategy

**Decision**: Preserve template vars for tech choices, use concrete values for methodology

**Rationale**:
- Template adopters customize tech stack
- Methodology is Product-Led-Spec-Kit specific
- Clear distinction prevents confusion

**Examples**:
```markdown
# Preserve template var (tech choice):
{{FRONTEND_FRAMEWORK}}, {{DATABASE}}, {{CLOUD_PROVIDER}}

# Use concrete value (methodology):
"Product-Led-Spec-Kit", "Triad workflow", "5 Whys"
```

---

### Decision 4: Quality Checklist Criteria

**Decision**: 8-point binary checklist for validation

**Criteria**:
1. **Conciseness**: ≤300 lines (preferably ≤250)
2. **Structure**: Follows 8-section template
3. **Boundaries**: Metadata clearly defines scope
4. **Context efficiency**: References skills, minimal code examples
5. **Versioning**: Has version and changelog
6. **Triad integration**: Documents governance participation
7. **Skill delegation**: Delegates appropriate work to skills
8. **Preservation**: All original capabilities preserved

---

## Risk Mitigation

### Risk 1: Line Targets Infeasible

**Risk**: Some agents may genuinely require >250 lines

**Mitigation**:
- Allow 300 lines max with documented justification
- Use splitting pattern (like team-lead) if concerns separable
- Validate line targets in Phase 1 before scaling

**Contingency**: If >3 agents need 300+ lines, re-evaluate targets

---

### Risk 2: Breaking Agent Behavior

**Risk**: Aggressive reduction removes critical capabilities

**Mitigation**:
- Preservation-first process (inventory before cutting)
- Test each agent with 3-5 representative tasks
- Quality checklist criterion 8 (preservation validation)
- Git allows rollback if issues found

**Contingency**: Rollback and re-refactor with more conservative approach

---

### Risk 3: Team-Lead Split Complexity

**Risk**: Unclear boundaries between team-lead and orchestrator

**Mitigation**:
- Document clear decision criteria
- Test handoff patterns with representative workflow
- Update all cross-references

**Contingency**: Keep unified at 450 lines if split too complex

---

## Success Criteria

| Criteria | Target | Measurement |
|----------|--------|-------------|
| Total Agent Lines | ~3,000 | Line count audit |
| Agents at Target | 12/12 ≤300 | Per-agent audit |
| Quality Score | 8/8 all agents | Checklist validation |
| Structure Compliance | 100% | Section audit |
| Capability Preservation | 100% | Task testing |
| Documentation Coverage | 100% | Best practices + README |

---

## Dependencies

### Internal Dependencies

| Dependency | Status | Notes |
|------------|--------|-------|
| spec.md | ✅ Complete | PM approved |
| feasibility-check.md | ✅ Complete | Tech-lead approved |
| PRD-003 | ✅ Approved | Triad approved with concerns |

### External Dependencies

| Dependency | Status | Notes |
|------------|--------|-------|
| CISO_Agent analysis | ✅ Complete | Blueprint for refactoring |
| Feature 002 | ✅ Complete | Enables parallel execution |

---

## Implementation Order

```
Week 1: Phase 0 - Foundation Documentation
        └── _AGENT_BEST_PRACTICES.md
        └── _README.md
        └── Triad review

Week 2: Phase 1 - Priority Agents (P0)
        ├── architect.md
        ├── team-lead.md (split)
        ├── orchestrator.md (new)
        └── product-manager.md
        └── Triad review

Week 3: Phase 2 - Standard Agents (P1)
        ├── code-reviewer.md
        ├── debugger.md
        ├── tester.md
        ├── devops.md
        └── senior-backend-engineer.md
        └── Triad review

Week 4: Phase 3 - Final Agents (P2)
        ├── ux-ui-designer.md
        ├── security-analyst.md
        ├── web-researcher.md
        └── frontend-developer.md
        └── Final validation
        └── Triad sign-off
```

**Critical Path**: Phase 0 → Phase 1 → Phase 2 → Phase 3

**No Parallel Opportunity**: Single architect expertise required for consistency

---

## Appendix A: YAML Frontmatter Template

```yaml
---
version: 2.0.0
changelog:
  - version: 2.0.0
    date: 2026-01-31
    changes:
      - Refactored per CISO_Agent best practices
      - Applied 8-section standard structure
      - Reduced from {X} to {Y} lines ({Z}% reduction)
      - Added version tracking and boundaries
boundaries:
  does_not_handle:
    - List of things agent explicitly does NOT do
    - Helps template adopters understand scope limits
triad_governance:
  participates_in:
    - List of Triad workflow stages (e.g., plan sign-off)
  veto_authority:
    - Domains where agent has veto power
---
```

---

## Appendix B: Quality Evaluation Checklist

```markdown
## Agent Quality Checklist

**Agent**: [name]
**Date**: [YYYY-MM-DD]
**Evaluator**: [agent/human]

### Criteria (8/8 required)

| # | Criterion | Pass/Fail | Notes |
|---|-----------|-----------|-------|
| 1 | Conciseness: ≤300 lines | [ ] | Line count: ___ |
| 2 | Structure: 8-section template | [ ] | Missing sections: ___ |
| 3 | Boundaries: Scope documented | [ ] | |
| 4 | Context efficiency: Skill refs | [ ] | Code examples: ___ |
| 5 | Versioning: version + changelog | [ ] | |
| 6 | Triad: Governance documented | [ ] | |
| 7 | Skill delegation: Appropriate | [ ] | |
| 8 | Preservation: Capabilities intact | [ ] | Tested with: ___ |

**Result**: [PASS / FAIL]
**Notes**: [any exceptions or justifications]
```

---

**End of Technical Plan**
