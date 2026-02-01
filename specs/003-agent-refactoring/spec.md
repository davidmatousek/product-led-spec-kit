---
prd_reference: docs/product/02_PRD/003-agent-refactoring-all-agents-2026-01-31.md
triad:
  pm_signoff:
    agent: product-manager
    date: 2026-01-31
    status: APPROVED
    notes: "All PRD requirements addressed. User stories mapped to scenarios. Success criteria match PRD metrics. Scope correctly constrained. User-focused without implementation details. Ready for planning phase."
  architect_signoff: null  # Added by /triad.plan
  techlead_signoff: null   # Added by /triad.tasks
---

# Feature Specification: Agent Refactoring - CISO_Agent Best Practices

**Status**: Approved
**Feature Number**: 003
**PRD Reference**: [003-agent-refactoring-all-agents-2026-01-31.md](../../docs/product/02_PRD/003-agent-refactoring-all-agents-2026-01-31.md)
**Created**: 2026-01-31
**Author**: Specification generated from PRD

---

## 1. Feature Overview

### 1.1 Problem Statement

Product-Led-Spec-Kit contains 12 agents with significant maintainability and usability challenges:

- **No design guidance**: Template adopters lack documentation on how to customize or create agents
- **Excessive verbosity**: 7,885 total lines across agents cause slow context loading and high token consumption
- **Inconsistent structure**: Agents vary in organization, making behavior unpredictable
- **Missing version tracking**: No changelog or versioning makes updates difficult to track
- **Unclear scope boundaries**: Agents lack clear documentation of what they do and don't handle

These problems result in template adopters experiencing confusion during customization, slow agent responses, and inconsistent agent behavior across workflows.

### 1.2 Proposed Solution

Standardize all 12 agents using proven best practices:

1. **Create agent design documentation** covering principles, structure templates, and quality standards
2. **Reduce agent verbosity** from 7,885 to approximately 3,000 lines (62% reduction)
3. **Standardize agent structure** using a consistent 8-section format
4. **Add version tracking** with semantic versioning and changelogs in each agent
5. **Split oversized agents** where concerns are separable (e.g., team-lead governance vs orchestration)

### 1.3 Target Users

**Primary**: Template Adopters (Engineering Team Leads)
- Need to customize agents for their tech stack
- Require clear documentation and consistent patterns
- Value fast agent responses and predictable behavior

**Secondary**: Agent Developers (Contributors)
- Need clear standards for creating or improving agents
- Require quality criteria to validate contributions
- Value maintainable, well-documented agent code

---

## 2. User Scenarios & Testing

### Scenario 1: Agent Discovery and Selection

**Actor**: Template Adopter
**Goal**: Find the right agent for a specific task

**Given** a template adopter needs to invoke an agent
**When** they check the agent overview documentation
**Then** they find all 12 agents listed with roles, expertise, and use cases
**And** they identify the correct agent within 2 minutes

**Acceptance Criteria**:
- Agent overview document exists with complete roster
- Each agent has clear "when to use" guidance
- Triad governance participation is documented per agent

### Scenario 2: Agent Customization

**Actor**: Template Adopter
**Goal**: Customize an agent for their specific technology stack

**Given** a template adopter wants to modify an agent
**When** they follow the documented best practices process
**Then** they successfully customize the agent without breaking existing behavior
**And** they can validate their changes against a quality checklist

**Acceptance Criteria**:
- Best practices document includes step-by-step customization process
- Quality checklist provides 8 pass/fail criteria
- Template variable guidance clarifies when to use placeholders vs concrete values

### Scenario 3: Fast Agent Response

**Actor**: Template Adopter
**Goal**: Experience responsive agent invocations without delays

**Given** agents have been refactored for conciseness
**When** an agent is invoked for a task
**Then** context loading is significantly faster than before
**And** agent execution feels responsive

**Acceptance Criteria**:
- All agents are 250 lines or fewer (300 max with documented justification)
- Total agent line count reduced from 7,885 to approximately 3,000
- No loss of agent capabilities

### Scenario 4: Consistent Agent Experience

**Actor**: Template Adopter
**Goal**: Encounter predictable structure across all agents

**Given** all agents follow the same structural standard
**When** reviewing any agent file
**Then** the same 8 sections appear in the same order
**And** metadata fields are consistent across all agents

**Acceptance Criteria**:
- All 12 agents use identical 8-section structure
- All agents include version, changelog, boundaries, and governance metadata
- Section naming and order is identical

### Scenario 5: Agent Version Tracking

**Actor**: Agent Developer
**Goal**: Understand what changed in an agent over time

**Given** agents include version metadata and changelogs
**When** reviewing agent history or planning updates
**Then** version numbers indicate release history
**And** changelogs document what changed and why

**Acceptance Criteria**:
- All agents have semantic version numbers
- All agents have changelog entries for the refactoring
- Version format is consistent (MAJOR.MINOR.PATCH)

### Scenario 6: Team-Lead/Orchestrator Separation

**Actor**: Workflow User
**Goal**: Invoke the correct agent for governance vs workflow orchestration tasks

**Given** team-lead responsibilities are split into two agents
**When** needing sign-off or feasibility checks
**Then** the user invokes team-lead agent
**And** when needing multi-agent coordination, the user invokes orchestrator agent

**Acceptance Criteria**:
- team-lead.md focuses on governance (sign-offs, feasibility, capacity)
- orchestrator.md focuses on workflow (agent coordination, parallel execution)
- Clear handoff pattern documented between the two agents
- Both agents combined are under 450 lines total

---

## 3. Functional Requirements

### FR-1: Agent Best Practices Documentation

**Description**: Create comprehensive documentation for agent design principles and standards

**Requirements**:
- Document 8 core principles: conciseness, structure, boundaries, context efficiency, versioning, triad integration, skill delegation, preservation-first enhancement
- Provide line targets: 150-250 lines optimal, 300 lines maximum with justification
- Include standardized 8-section structure template
- Specify required metadata fields for agent files
- Include quality evaluation checklist with 8 criteria
- Document step-by-step preservation-first enhancement process

**Acceptance Criteria**:
- Best practices document is complete and comprehensive
- Covers all 8 principles with examples
- Template adopters can use it to customize agents successfully

### FR-2: Agent Overview Documentation

**Description**: Create quick-reference documentation for agent selection and understanding

**Requirements**:
- List all agents with their roles and expertise areas
- Provide quick selection guidance (given task X, use agent Y)
- Document Triad governance participation per agent
- Explain agent collaboration patterns and handoffs
- Link to best practices for customization details

**Acceptance Criteria**:
- Overview document exists with complete agent roster
- Includes table format for easy scanning
- Users can find appropriate agent within 2 minutes

### FR-3: Agent Refactoring - Priority Tier (P0)

**Description**: Refactor the three most critical agents for reduced verbosity

**Agents**:
- **architect**: Reduce from 1,026 to 250 lines (77% reduction)
  - Remove embedded code examples, reference skills instead
  - Condense workflow sections to bullet points
  - Preserve all architecture capabilities

- **team-lead**: Split from 1,346 lines into two agents (66% total reduction)
  - team-lead (200 lines): Governance - sign-offs, feasibility, capacity, assignments
  - orchestrator (250 lines): Workflows - agent coordination, parallel execution, task tracking

- **product-manager**: Reduce from 430 to 250 lines (42% reduction)
  - Condense verbose communication/documentation sections
  - Reference PRD creation skill instead of inline instructions

**Acceptance Criteria**:
- All priority agents are at target line counts
- All capabilities preserved (tested with representative tasks)
- 8-section structure applied consistently
- Full metadata added to each agent

### FR-4: Agent Refactoring - Standard Tier (P1)

**Description**: Refactor five medium-complexity agents for reduced verbosity

**Agents**:
- **code-reviewer**: 1,100 → 250 lines (77% reduction)
- **debugger**: 1,033 → 250 lines (76% reduction)
- **tester**: 509 → 250 lines (51% reduction)
- **devops**: 578 → 250 lines (57% reduction)
- **senior-backend-engineer**: 411 → 250 lines (39% reduction)

**Acceptance Criteria**:
- All standard tier agents at target line counts
- All capabilities preserved
- 8-section structure applied consistently
- Full metadata added to each agent

### FR-5: Agent Refactoring - Completion Tier (P2)

**Description**: Refactor remaining four agents for reduced verbosity

**Agents**:
- **ux-ui-designer**: 392 → 250 lines (36% reduction)
- **security-analyst**: 390 → 250 lines (36% reduction)
- **web-researcher**: 364 → 250 lines (31% reduction)
- **frontend-developer**: 306 → 250 lines (18% reduction)

**Acceptance Criteria**:
- All completion tier agents at target line counts
- All capabilities preserved
- 8-section structure applied consistently
- Full metadata added to each agent

### FR-6: Metadata Standardization

**Description**: Add consistent metadata to all 12 agents

**Required Fields**:
- version: Semantic versioning (MAJOR.MINOR.PATCH)
- changelog: Version history with dates and descriptions
- boundaries: Clear scope definition (what agent does NOT do)
- triad-governance: Sign-off participation (if applicable)

**Acceptance Criteria**:
- All 12 agents have all required metadata fields
- Format is consistent across all agents
- Semantic versioning is correctly applied

### FR-7: Quality Validation

**Description**: Validate all refactored agents against quality criteria

**Quality Criteria** (8 items):
1. Conciseness: ≤300 lines (preferably ≤250)
2. Structure: Follows 8-section template
3. Boundaries: Metadata clearly defines scope
4. Context efficiency: References skills, minimal code examples
5. Versioning: Has version and changelog
6. Triad integration: Documents governance participation
7. Skill delegation: Delegates appropriate work to skills
8. Preservation: All original capabilities preserved

**Acceptance Criteria**:
- All 12 agents pass 8/8 quality criteria
- Any exceptions are documented with justification
- Quality checklist completed and recorded

---

## 4. Non-Functional Requirements

### NFR-1: Performance - Context Loading

**Requirement**: Agent invocations should load context faster due to reduced verbosity
**Measure**: Total agent lines reduced from 7,885 to approximately 3,000 (62% reduction)
**Verification**: Line count audit after all refactoring complete

### NFR-2: Maintainability - Consistency

**Requirement**: Agents should be easy to update and extend
**Measure**: 100% of agents use identical 8-section structure and metadata format
**Verification**: Structure audit showing uniform organization

### NFR-3: Reliability - Capability Preservation

**Requirement**: Refactoring must not remove or break existing agent capabilities
**Measure**: All agents pass preservation validation testing
**Verification**: Each agent tested with representative tasks from current workflows

### NFR-4: Usability - Documentation Quality

**Requirement**: Documentation should enable self-service agent customization
**Measure**: Template adopters can customize an agent in under 30 minutes
**Verification**: User feedback on documentation clarity (post-release)

---

## 5. Success Criteria

### Primary Metrics

| Metric | Baseline | Target | How to Measure |
|--------|----------|--------|----------------|
| Total agent lines | 7,885 | ~3,000 | Line count audit |
| Average agent size | 657 lines | ~250 lines | Line count per agent |
| Agents at target size | 0/12 | 12/12 | Count agents ≤300 lines |
| Quality score | N/A | 8/8 for all | Quality checklist validation |

### Secondary Metrics

| Metric | Baseline | Target | How to Measure |
|--------|----------|--------|----------------|
| Metadata standardization | 0% | 100% | Metadata field audit |
| Structure compliance | 0% | 100% | Section structure audit |
| Documentation coverage | 0% | 100% | Best practices + overview docs exist |

### User Experience Outcomes

- Template adopters can find the right agent within 2 minutes
- Template adopters can customize agents in under 30 minutes
- Agent responses feel noticeably faster
- Agent behavior is predictable across different agents

---

## 6. Scope & Boundaries

### In Scope

- Creation of agent best practices documentation
- Creation of agent overview documentation
- Refactoring of all 12 existing agents for conciseness
- Splitting team-lead agent into team-lead + orchestrator
- Standardization of 8-section structure across all agents
- Addition of version, changelog, boundaries, and governance metadata

### Out of Scope

- **Agent behavior changes**: This is refactoring only, no new features
- **New agent creation**: Only existing 12 agents are included
- **Skill modifications**: Skills remain unchanged
- **Automated testing framework**: Quality validation is manual checklist
- **Performance benchmarking infrastructure**: Token measurement is manual

### Assumptions

- Line targets (150-250 optimal, 300 max) are achievable for all agents without capability loss
- 8-section structure works for all agent types (governance, engineering, analysis)
- Template variable patterns ({{VAR}}) should be preserved for tech stack choices
- CISO_Agent patterns are applicable to Product-Led-Spec-Kit context

### Dependencies

- **PRD-003 approval**: ✅ Approved with concerns by Triad
- **CISO_Agent analysis**: ✅ Complete (provides refactoring blueprint)
- **Feature 002 (Anthropic Updates)**: ✅ Complete (enables parallel execution)

---

## 7. Key Entities

### Agent File Structure

| Section | Purpose | Required |
|---------|---------|----------|
| Core Mission | What the agent does | Yes |
| Role Definition | Agent's place in workflow | Yes |
| When to Use | Use cases and trigger phrases | Yes |
| Workflow Steps | Step-by-step process | Yes |
| Quality Standards | Acceptance criteria | Yes |
| Triad Governance | Sign-off participation | Yes |
| Tools & Skills | What agent uses | Yes |
| Success Criteria | Effectiveness measures | Yes |

### Metadata Fields

| Field | Format | Purpose |
|-------|--------|---------|
| version | MAJOR.MINOR.PATCH | Release tracking |
| changelog | Version + Date + Description | Change history |
| boundaries | Text description | Scope limits |
| triad-governance | Participation level | Governance role |

### Agent Categories

| Priority | Agents | Total Lines (Before) | Target Lines |
|----------|--------|---------------------|--------------|
| P0 | architect, team-lead, product-manager | 2,802 | 700 |
| P1 | code-reviewer, debugger, tester, devops, senior-backend-engineer | 3,631 | 1,250 |
| P2 | ux-ui-designer, security-analyst, web-researcher, frontend-developer | 1,452 | 1,000 |

---

## 8. Risks & Mitigations

### Risk 1: Line Targets Infeasible for Complex Agents

**Likelihood**: Medium | **Impact**: Medium
**Description**: Some agents may genuinely require >250 lines to preserve capabilities
**Mitigation**: Allow 300 lines maximum with documented justification; use agent splitting pattern if concerns are separable

### Risk 2: Breaking Existing Agent Behavior

**Likelihood**: Medium | **Impact**: High
**Description**: Aggressive reduction could inadvertently remove critical capabilities
**Mitigation**: Follow preservation-first process; test each agent with representative tasks; validate against quality criteria

### Risk 3: Template Variable Ambiguity

**Likelihood**: Low | **Impact**: Medium
**Description**: Unclear when to use {{TEMPLATE_VARS}} vs concrete values
**Mitigation**: Document clear guidance: tech stack choices use placeholders, methodology uses concrete values

### Risk 4: Team-Lead Split Complexity

**Likelihood**: Medium | **Impact**: Medium
**Description**: Separating governance from orchestration may create unclear boundaries
**Mitigation**: Document clear decision criteria; test handoff patterns; update all cross-references

---

## 9. Open Questions

*No critical clarifications needed - PRD provides comprehensive requirements and feasibility has been validated.*

---

## Appendix A: Current State Summary

### Agent Line Counts (Before Refactoring)

| Agent | Current Lines | Target | Reduction |
|-------|---------------|--------|-----------|
| team-lead.md | 1,346 | 200 + 250 (split) | 66% |
| code-reviewer.md | 1,100 | 250 | 77% |
| debugger.md | 1,033 | 250 | 76% |
| architect.md | 1,026 | 250 | 77% |
| devops.md | 578 | 250 | 57% |
| tester.md | 509 | 250 | 51% |
| product-manager.md | 430 | 250 | 42% |
| senior-backend-engineer.md | 411 | 250 | 39% |
| ux-ui-designer.md | 392 | 250 | 36% |
| security-analyst.md | 390 | 250 | 36% |
| web-researcher.md | 364 | 250 | 31% |
| frontend-developer.md | 306 | 250 | 18% |
| **TOTAL** | **7,885** | **~3,000** | **62%** |

### Quality Criteria Checklist

1. ✓ Conciseness: ≤300 lines (preferably ≤250)
2. ✓ Structure: Follows 8-section template
3. ✓ Boundaries: Metadata clearly defines scope
4. ✓ Context efficiency: References skills, minimal code examples
5. ✓ Versioning: Has version and changelog
6. ✓ Triad integration: Documents governance participation
7. ✓ Skill delegation: Delegates appropriate work to skills
8. ✓ Preservation: All original capabilities preserved
