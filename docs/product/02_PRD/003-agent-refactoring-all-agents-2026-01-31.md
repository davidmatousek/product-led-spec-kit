---
prd:
  number: 003
  topic: agent-refactoring-all-agents
  created: 2026-01-31
  status: Approved
  type: feature
triad:
  pm_signoff:
    agent: product-manager
    date: 2026-01-31
    status: APPROVED_WITH_CONCERNS
    notes: "Excellent PRD with thorough research foundation. Concerns: OKR formalization needed, P2 slip risk monitoring recommended, timeline validation with Team-Lead estimate."
  architect_signoff:
    agent: architect
    date: 2026-01-31
    status: APPROVED_WITH_CONCERNS
    notes: "Technically sound with verified baseline analysis. All line counts confirmed. Concerns: Code execution section condensing to validate during Week 2, largest agents may need 275-300 lines with justification."
  techlead_signoff:
    agent: team-lead
    date: 2026-01-31
    status: APPROVED_WITH_CONCERNS
    notes: "4-week timeline realistic with conditions. 85% confidence for P0+P1 scope. Concerns: Week 3 bottleneck (5 agents), leverage parallel execution, perform rolling validation."
---

# Agent Refactoring - Implement CISO_Agent Best Practices Across All 12 Agents - Product Requirements Document

**Status**: Approved
**Created**: 2026-01-31
**Author**: product-manager
**Reviewers**: architect, team-lead
**Phase**: Phase 1
**Priority**: P1
**PRD Number**: 003

---

## 📋 Executive Summary

### The One-Liner
Refactor all 12 Product-Led-Spec-Kit agents to follow comprehensive CISO_Agent best practices, reducing context overhead by 60-80% while improving maintainability, consistency, and template adopter experience.

### Problem Statement

**Current State Analysis** (as of 2026-01-31):

Product-Led-Spec-Kit contains 12 agents totaling **7,885 lines** with significant inconsistencies and maintainability challenges:

**Line Count Analysis**:
- team-lead.md: 1,346 lines (5.4x over optimal 250-line target)
- code-reviewer.md: 1,100 lines (4.4x over optimal)
- debugger.md: 1,033 lines (4.1x over optimal)
- architect.md: 1,026 lines (4.1x over optimal)
- tester.md: 509 lines (2x over optimal)
- devops.md: 578 lines (2.3x over optimal)
- product-manager.md: 430 lines (1.7x over optimal)
- senior-backend-engineer.md: 411 lines (1.6x over optimal)
- ux-ui-designer.md: 392 lines (1.6x over optimal)
- security-analyst.md: 390 lines (1.6x over optimal)
- web-researcher.md: 364 lines (1.5x over optimal)
- frontend-developer.md: 306 lines (1.2x over optimal)

**Key Problems**:

1. **No Agent Design Documentation**: No `_AGENT_BEST_PRACTICES.md` or `_README.md` to guide agent creation or refactoring
2. **Massive Context Overhead**: 7,885 total lines consuming excessive token budget when agents are invoked
3. **Inconsistent Structure**: Varying section organization across agents (no standardized 8-section structure)
4. **Embedded Code Examples**: 550+ lines of code execution examples in architect.md should reference skills instead
5. **YAML Frontmatter Inconsistency**: Missing version, changelog, triad-governance fields
6. **Template Variable Ambiguity**: Unclear when to use `{{TEMPLATE_VARS}}` vs concrete infrastructure references
7. **No Quality Standards**: No systematic way to evaluate agent quality (missing agent-quality-evaluator pattern)

**User Impact**:

**Template Adopters** experience:
- Confusing agent customization (no design guide or quality standards)
- Slow agent invocations (excessive context loading from verbose agents)
- Inconsistent agent behavior (no standardized structure)
- Difficult maintenance (no changelog, version tracking)

**Agent Developers** face:
- No clear best practices for creating new agents
- No quality checklist to validate agent design
- Inconsistent patterns across codebase
- Unclear refactoring guidance

**Technical Debt**:
- 60-80% context overhead from verbose agents
- Maintenance burden from 12 inconsistent agent files
- Risk of context pollution from missing boundaries documentation

### Proposed Solution

**Research Foundation**: Apply comprehensive best practices from CISO_Agent project analysis (completed 2026-01-31), which demonstrated:
- 77% line reduction in architect (1027 → 250 lines)
- 66% line reduction in team-lead (1347 → 450 lines via split)
- Standardized 8-section structure across all agents
- Full YAML frontmatter with version/changelog/governance tracking

**Solution Approach**:

**Phase 1: Foundation (Week 1)**
1. **Create `_AGENT_BEST_PRACTICES.md`** (1,561 lines comprehensive guide)
   - 8 Core Principles (conciseness, structure, boundaries, etc.)
   - Line targets (150-250 optimal, 300 max with justification)
   - Standardized 8-section structure template
   - YAML frontmatter specification
   - Quality evaluation checklist (8 criteria)
   - Preservation-first enhancement process (11 steps)

2. **Create `_README.md`** (236 lines agent overview)
   - Agent roster with roles and expertise
   - Quick reference for agent selection
   - Triad governance integration
   - When to use which agent

**Phase 2: Priority Refactoring (Weeks 2-3)**
3. **Refactor Top 3 Agents** (P0)
   - architect.md: 1,026 → 250 lines (77% reduction)
   - team-lead.md: 1,346 → split into team-lead 200 + orchestrator 250 (66% reduction)
   - product-manager.md: 430 → 250 lines (42% reduction)

4. **Standardize YAML Frontmatter** (P1)
   - Add version, changelog, boundaries, triad-governance to all 12 agents
   - Establish versioning convention (semantic versioning)

**Phase 3: Remaining Agents (Week 4)**
5. **Refactor Remaining 9 Agents** (P2)
   - code-reviewer.md: 1,100 → 250 lines
   - debugger.md: 1,033 → 250 lines
   - tester.md: 509 → 250 lines
   - devops.md: 578 → 250 lines
   - senior-backend-engineer.md: 411 → 250 lines
   - ux-ui-designer.md: 392 → 250 lines
   - security-analyst.md: 390 → 250 lines
   - web-researcher.md: 364 → 250 lines
   - frontend-developer.md: 306 → 250 lines

**Out of Scope**:
- Agent behavior changes (preserve existing functionality)
- New agent creation (only refactoring existing 12)
- Infrastructure-specific commands (preserve template variable approach where appropriate)
- Skill refactoring (skills remain unchanged)

### Success Criteria

**Primary Metrics**:
- Total agent line count: 7,885 → 3,000 lines (62% reduction)
- Average agent size: 657 → 250 lines (62% reduction)
- Context overhead reduction: 60-80% (measured via token consumption)
- Agent quality score: 8/8 passing for all 12 agents (using quality evaluator)

**Quality Metrics**:
- YAML frontmatter standardization: 100% (all 12 agents)
- 8-section structure compliance: 100% (all 12 agents)
- Line target compliance: 100% (all agents ≤300 lines, 90%+ ≤250 lines)
- Documentation completeness: 100% (best practices + README created)

**User Experience Metrics**:
- Agent selection clarity: Time to find right agent < 2 minutes (via README)
- Customization clarity: Template adopters can customize agents in < 30 minutes (via best practices guide)
- Maintenance effort: 50% reduction in time to update agents (via changelog/version tracking)

### Timeline

**Target Delivery**: 4 weeks from approval

- **Week 1**: Foundation - Create `_AGENT_BEST_PRACTICES.md` + `_README.md`
- **Week 2**: Priority Refactoring - architect.md, team-lead.md, product-manager.md
- **Week 3**: YAML Standardization + 5 medium agents (code-reviewer, debugger, tester, devops, senior-backend-engineer)
- **Week 4**: Final 4 agents (ux-ui-designer, security-analyst, web-researcher, frontend-developer) + quality validation

---

## 🎯 Strategic Alignment

### Product Vision Alignment
**Reference**: Product-Led-Spec-Kit Vision

Product-Led-Spec-Kit aims to provide a **product-led development methodology with clear governance workflows** that works with any agent framework. This refactoring directly supports that vision by:

1. **Improving Template Adoption**: Clear agent design documentation makes it easier for teams to adopt and customize the template
2. **Enabling Scalability**: Reduced context overhead allows more complex workflows without hitting token limits
3. **Maintaining Quality**: Standardized structure ensures consistent governance across all agents
4. **Supporting Multi-Agent Workflows**: Clear boundaries and interfaces enable better agent collaboration

### OKR Support
**Reference**: Q1 2026 OKRs (Template Quality & Adoption)

**Objective**: Improve Product-Led-Spec-Kit template quality and adopter experience

**Key Results**:
- **KR1: Reduce agent context overhead by 60%+**: This refactoring achieves 62% reduction (7,885 → 3,000 lines)
- **KR2: Standardize all template components**: Achieves 100% YAML frontmatter + structure standardization
- **KR3: Create comprehensive documentation**: Delivers 1,561-line best practices guide + 236-line README

### Roadmap Fit
**Reference**: Phase 1 - Template Quality Improvements

**Phase**: Phase 1 (Core Template Improvements)
**Timeline**: Weeks 1-4 of Phase 1
**Dependencies**:
- ✅ Feature 001 (Claude Code Memory Features) - Complete
- ✅ Feature 002 (Anthropic Updates Integration) - Complete
- ⏳ Feature 003 (Agent Refactoring) - This PRD

**Enables Future Work**:
- Phase 2: Advanced governance workflows (requires clean agent interfaces)
- Phase 3: Multi-project template support (requires standardized agent structure)

---

## 🧑‍💼 Target Users & Personas

**Reference**: Product-Led-Spec-Kit Target Users

### Primary Persona: Template Adopter (Engineering Team Lead)

**Demographics**:
- Role: Engineering Team Lead or Tech Lead
- Experience: 5+ years software development, managing 3-8 engineers
- Goals: Adopt product-led development with AI agents, improve team velocity
- Pain Points: Unclear how to customize agents, slow agent performance, inconsistent agent behavior

**Why This Matters to Them**:
- **Agent Design Clarity**: `_AGENT_BEST_PRACTICES.md` provides clear guidance on customizing agents for their tech stack
- **Performance**: 60%+ context reduction means faster agent responses, less waiting
- **Consistency**: Standardized structure makes it predictable how agents behave and interact
- **Maintainability**: Versioned, changelog-tracked agents are easier to customize and update

**Current Workflow Pain**:
1. Downloads Product-Led-Spec-Kit template
2. Tries to customize agents for their stack (e.g., replace {{FRONTEND_FRAMEWORK}} with React)
3. Gets confused by inconsistent agent structure and missing design documentation
4. Struggles with slow agent invocations due to context overhead
5. Abandons customization or creates inconsistent agent modifications

**Post-Refactoring Workflow**:
1. Downloads Product-Led-Spec-Kit template
2. Reads `_AGENT_BEST_PRACTICES.md` for design principles and `_README.md` for agent overview
3. Follows preservation-first enhancement process to customize agents
4. Uses quality evaluator checklist to validate customizations
5. Experiences fast agent invocations with clear, consistent behavior

### Secondary Persona: Agent Developer (Contributor)

**Demographics**:
- Role: Open-source contributor or internal template maintainer
- Experience: 3+ years software development, AI/LLM experience
- Goals: Contribute new agents or improve existing ones
- Pain Points: No design standards, unclear quality bar, difficult to maintain consistency

**Why This Matters to Them**:
- **Design Standards**: Clear best practices guide agent creation
- **Quality Bar**: 8-criteria quality checklist ensures contributions meet standards
- **Maintainability**: Versioned, structured agents are easier to improve
- **Contribution Efficiency**: Standardized structure reduces review cycles

---

## 📖 User Stories

### User Story Format
Using Job Story format for better context:

**When** [situation/context],
**I want to** [motivation/action],
**So I can** [expected outcome/benefit].

### Primary User Stories

#### US-003-1: Agent Design Guidance
**When**: I'm customizing Product-Led-Spec-Kit agents for my tech stack
**I want to**: Follow clear best practices and design principles
**So I can**: Create consistent, maintainable agents without trial-and-error

**Acceptance Criteria**:
- **Given** `_AGENT_BEST_PRACTICES.md` exists, **when** I read it, **then** I find 8 core principles with examples
- **Given** I'm refactoring an agent, **when** I follow the 11-step preservation process, **then** I maintain existing behavior while improving structure
- **Given** I've customized an agent, **when** I use the quality checklist, **then** I can validate 8/8 criteria pass

**Priority**: P0
**Effort**: L (1,561-line comprehensive guide)

#### US-003-2: Agent Selection Clarity
**When**: I need to invoke an agent for a specific task
**I want to**: Quickly understand which agent handles what
**So I can**: Choose the right agent in under 2 minutes

**Acceptance Criteria**:
- **Given** `_README.md` exists, **when** I read it, **then** I see a table of all 12 agents with roles and when to use them
- **Given** I have a task (e.g., "create PRD"), **when** I check the README, **then** I find the right agent (product-manager) in one lookup
- **Given** I'm using Triad governance, **when** I check the README, **then** I see which agents participate in sign-offs

**Priority**: P0
**Effort**: M (236-line overview document)

#### US-003-3: Fast Agent Invocations
**When**: I invoke an agent for a task
**I want to**: Experience fast response times without context loading delays
**So I can**: Maintain development momentum and avoid waiting

**Acceptance Criteria**:
- **Given** architect.md is refactored, **when** I invoke the architect agent, **then** context loads 77% faster (1,026 → 250 lines)
- **Given** team-lead.md is refactored, **when** I invoke the team-lead agent, **then** context loads 66% faster (1,346 → 450 lines total)
- **Given** all 12 agents are refactored, **when** I invoke any agent, **then** average context overhead is reduced 60-80%

**Priority**: P1
**Effort**: XL (all 12 agents refactored)

#### US-003-4: Consistent Agent Structure
**When**: I'm working with multiple agents in a workflow
**I want to**: Encounter predictable, consistent agent structure
**So I can**: Understand agent capabilities and boundaries without re-learning each agent

**Acceptance Criteria**:
- **Given** all agents are refactored, **when** I read any agent file, **then** I see the same 8-section structure (Core Mission → Triad Governance)
- **Given** any agent YAML frontmatter, **when** I read it, **then** I find version, changelog, boundaries, and triad-governance fields
- **Given** I'm comparing agents, **when** I check line counts, **then** 100% are ≤300 lines and 90%+ are ≤250 lines

**Priority**: P1
**Effort**: XL (all 12 agents standardized)

#### US-003-5: Agent Customization Confidence
**When**: I'm customizing an agent for my infrastructure (e.g., replacing Railway with AWS)
**I want to**: Follow a proven process that preserves existing behavior
**So I can**: Avoid breaking agent functionality while adapting to my needs

**Acceptance Criteria**:
- **Given** `_AGENT_BEST_PRACTICES.md` includes preservation-first process, **when** I follow the 11 steps, **then** I successfully customize an agent without breaking tests
- **Given** I'm unsure about template variables, **when** I check the best practices guide, **then** I find clear guidance on when to use `{{VARS}}` vs concrete values
- **Given** I've customized an agent, **when** I run the quality evaluator, **then** I get a pass/fail report with specific improvement suggestions

**Priority**: P2
**Effort**: M (documentation enhancement)

#### US-003-6: Maintainability Through Versioning
**When**: I need to update agents over time or track changes
**I want to**: See clear version history and change logs
**So I can**: Understand what changed, why, and assess upgrade impact

**Acceptance Criteria**:
- **Given** all agents have YAML frontmatter, **when** I check any agent, **then** I see a version field (semantic versioning)
- **Given** an agent is updated, **when** I check the changelog section, **then** I see what changed in each version
- **Given** I'm upgrading Product-Led-Spec-Kit, **when** I compare agent versions, **then** I can identify which agents changed and assess customization conflicts

**Priority**: P2
**Effort**: M (YAML standardization across 12 agents)

---

## 🎨 User Experience Requirements

### Customer Journey Context
**Reference**: Template Adoption Journey

**Journey Stage**: Template Customization & Setup (Days 1-7 after adoption)
**Touchpoints**:
- Reading agent documentation
- Customizing agents for tech stack
- Testing agent invocations
- Creating first feature with agents

**Emotions**:
- **Remove Frustration**: Confusion about agent design, slow performance, inconsistent behavior
- **Create Confidence**: Clear guidance, fast invocations, predictable structure

### Key User Flows

#### Flow 1: Agent Discovery & Selection
1. User downloads Product-Led-Spec-Kit template
2. User navigates to `.claude/agents/` directory
3. User reads `_README.md` to understand agent roster
4. User finds table showing all 12 agents with roles, expertise, and use cases
5. User identifies correct agent for task (e.g., product-manager for PRD creation) in <2 minutes

**Happy Path**: User finds the right agent quickly via README
**Edge Cases**:
- Multiple agents could fit task → README explains agent boundaries and collaboration
- User unsure about Triad governance → README links to governance documentation

#### Flow 2: Agent Customization
1. User decides to customize an agent (e.g., replace template variables with concrete infrastructure)
2. User reads `_AGENT_BEST_PRACTICES.md` for guidance
3. User follows 11-step preservation-first enhancement process
4. User modifies agent while maintaining 8-section structure
5. User validates with quality evaluator checklist (8 criteria)
6. User confirms 8/8 pass, commits customization

**Happy Path**: User successfully customizes agent without breaking functionality
**Edge Cases**:
- Quality check fails → Best practices guide provides specific improvement suggestions
- Unsure about template variables → Guide clarifies when to use `{{VARS}}` vs concrete values

#### Flow 3: Agent Invocation & Usage
1. User invokes agent via command (e.g., `/triad.prd`)
2. Agent context loads quickly (62% faster than before refactoring)
3. Agent executes task following standardized structure
4. Agent provides clear output with triad-governance checkpoints (if applicable)
5. User reviews output and proceeds to next phase

**Happy Path**: Fast, predictable agent execution
**Edge Cases**:
- Agent boundaries unclear → YAML frontmatter boundaries field clarifies scope
- Agent version conflicts → Changelog shows what changed, helps debug issues

### UI/UX Considerations

**Information Architecture**:
- `_AGENT_BEST_PRACTICES.md`: Comprehensive design guide (1,561 lines, 8 sections)
- `_README.md`: Quick reference (236 lines, agent roster table)
- Individual agent files: Standardized 8-section structure (150-250 lines each)

**Progressive Disclosure**:
- First: `_README.md` for quick agent selection
- Then: Individual agent YAML frontmatter for role/boundaries
- Deep dive: `_AGENT_BEST_PRACTICES.md` for customization guidance

**Error Prevention**:
- Quality evaluator checklist prevents publishing low-quality agents
- Preservation-first process prevents breaking existing functionality
- YAML frontmatter boundaries prevent agent scope creep

**Feedback Patterns**:
- Version numbers communicate agent maturity
- Changelogs communicate what changed and why
- Line count targets communicate when agents are too verbose

---

## ⚙️ Functional Requirements

### Core Capabilities

#### Requirement 1: Agent Best Practices Documentation
**Description**: Create comprehensive `_AGENT_BEST_PRACTICES.md` guide covering all aspects of agent design

**Inputs**: CISO_Agent best practices analysis, Product-Led-Spec-Kit current agent patterns
**Processing**: Synthesize 8 core principles, line targets, structure templates, quality criteria
**Outputs**: 1,561-line guide saved to `.claude/agents/_AGENT_BEST_PRACTICES.md`

**Business Rules**:
- Must cover all 8 core principles (conciseness, structure, boundaries, context efficiency, versioning, triad integration, skill delegation, preservation-first)
- Must provide line targets (150-250 optimal, 300 max with justification)
- Must include standardized 8-section structure template
- Must specify YAML frontmatter fields (name, description, allowed-tools, model, color, expertise, use-cases, boundaries, speckit-integration, version, changelog, triad-governance)
- Must include quality evaluator checklist (8 criteria)
- Must document preservation-first enhancement process (11 steps)

**Edge Cases**:
- Template variable guidance: When to use `{{VARS}}` vs concrete infrastructure references (context: Product-Led-Spec-Kit is a template, CISO_Agent is infrastructure-specific)
- Agent size justification: How to document why an agent exceeds 250 lines (if genuinely necessary)

#### Requirement 2: Agent Overview Documentation
**Description**: Create `_README.md` with agent roster, quick reference, and governance integration

**Inputs**: All 12 agent files, Triad governance documentation
**Processing**: Extract roles, expertise, use cases, create reference table
**Outputs**: 236-line README saved to `.claude/agents/_README.md`

**Business Rules**:
- Must include table of all 12 agents with columns: Name, Role, Expertise, When to Use
- Must explain Triad governance (PM, Architect, Team-Lead sign-off requirements)
- Must provide quick selection guide (given task X, use agent Y)
- Must link to `_AGENT_BEST_PRACTICES.md` for customization guidance
- Must document agent collaboration patterns (e.g., product-manager → architect → team-lead)

**Edge Cases**:
- Agent overlap: Multiple agents could handle a task (e.g., architect vs senior-backend-engineer for API design) → Clarify boundaries
- Governance ambiguity: When is Triad sign-off required vs optional → Link to constitution

#### Requirement 3: Architect Agent Refactoring
**Description**: Reduce architect.md from 1,026 lines to 250 lines (77% reduction)

**Inputs**: Current `architect.md` (1,026 lines)
**Processing**:
- Remove 550+ lines of embedded code execution examples → Reference skills instead
- Condense verbose workflow sections → Use bullet points and concise language
- Extract infrastructure-specific commands to skills
- Standardize to 8-section structure
- Add full YAML frontmatter (version, changelog, boundaries, triad-governance)
**Outputs**: Refactored `architect.md` (≤250 lines)

**Business Rules**:
- MUST preserve all existing architect capabilities (no behavior changes)
- MUST maintain template variable approach where appropriate ({{TECH_STACK}}, {{CLOUD_PROVIDER}})
- MUST follow 8-section structure: Core Mission → Role Definition → When to Use → Workflow Steps → Quality Standards → Triad Governance → Tools & Skills → Success Criteria
- MUST include YAML frontmatter with version: "2.0.0", changelog, boundaries, triad-governance
- Code execution guidance: Max 20 lines with thresholds, not 100+ line examples

**Edge Cases**:
- Infrastructure baseline commands: Keep template-agnostic (preserve {{VARS}})
- Complex architecture patterns: Reference ADRs in `docs/architecture/02_ADRs/` instead of inline examples

#### Requirement 4: Team-Lead Agent Refactoring & Split
**Description**: Split team-lead.md (1,346 lines) into team-lead (200 lines) + orchestrator (250 lines), 66% total reduction

**Inputs**: Current `team-lead.md` (1,346 lines)
**Processing**:
- Split governance responsibilities (sign-offs, feasibility) → `team-lead.md` (200 lines)
- Split orchestration responsibilities (agent coordination, parallel execution) → `orchestrator.md` (250 lines)
- Standardize both to 8-section structure
- Add full YAML frontmatter to both
**Outputs**:
- Refactored `team-lead.md` (≤200 lines)
- New `orchestrator.md` (≤250 lines)

**Business Rules**:
- `team-lead.md` MUST focus on: Feasibility checks, timeline estimation, capacity planning, agent assignment, Triad sign-offs
- `orchestrator.md` MUST focus on: Multi-agent coordination, parallel execution waves, task dependency tracking, workflow state management
- Both MUST preserve existing team-lead capabilities (no behavior loss)
- Both MUST have clear boundaries in YAML frontmatter to prevent overlap
- MUST update `_README.md` to document the split and when to use each

**Edge Cases**:
- Workflow ambiguity: When a task involves both governance AND orchestration → Document handoff pattern
- Backward compatibility: Users invoking old team-lead agent → orchestrator.md should reference team-lead for sign-offs

#### Requirement 5: Product-Manager Agent Refactoring
**Description**: Reduce product-manager.md from 430 lines to 250 lines (42% reduction)

**Inputs**: Current `product-manager.md` (430 lines)
**Processing**:
- Condense verbose "Communication Standards" section → Bullet points
- Extract PRD creation workflow → Reference `prd-create` skill
- Remove redundant "Documentation Standards" → Link to `_AGENT_BEST_PRACTICES.md`
- Standardize to 8-section structure
- Add full YAML frontmatter
**Outputs**: Refactored `product-manager.md` (≤250 lines)

**Business Rules**:
- MUST preserve PM sign-off authority on spec.md, plan.md, tasks.md
- MUST maintain alignment validation checklist (Vision, OKRs, Roadmap)
- MUST preserve veto authority per constitution
- MUST follow 8-section structure
- MUST include version: "2.0.0", changelog, triad-governance in YAML

**Edge Cases**:
- PRD creation workflow: Reference `/skill prd-create` instead of inline instructions
- Governance vs delegation: PM defines requirements but doesn't design architecture → Clarify boundary with architect

#### Requirement 6: YAML Frontmatter Standardization
**Description**: Add/update YAML frontmatter for all 12 agents to include version, changelog, boundaries, triad-governance

**Inputs**: All 12 agent files
**Processing**:
- Add `version: "2.0.0"` (semantic versioning)
- Add `changelog:` section documenting refactoring changes
- Add/enhance `boundaries:` field with clear scope limits
- Add `triad-governance:` field documenting sign-off participation (if applicable)
**Outputs**: All 12 agents with standardized YAML frontmatter

**Business Rules**:
- Version format: Semantic versioning (MAJOR.MINOR.PATCH)
- Changelog format: Version + Date + Description of changes
- Boundaries format: Single-line or multi-line description of what agent does NOT do
- Triad-governance format: "Participates in [spec/plan/tasks] sign-off" or "Not part of Triad governance"

**Edge Cases**:
- Agents with no prior frontmatter: Add complete YAML block (all fields)
- Agents with partial frontmatter: Preserve existing fields, add missing ones

#### Requirement 7: Remaining 9 Agents Refactoring
**Description**: Refactor 9 remaining agents to ≤250 lines with standardized structure

**Agents**:
- code-reviewer.md: 1,100 → 250 lines (77% reduction)
- debugger.md: 1,033 → 250 lines (76% reduction)
- tester.md: 509 → 250 lines (51% reduction)
- devops.md: 578 → 250 lines (57% reduction)
- senior-backend-engineer.md: 411 → 250 lines (39% reduction)
- ux-ui-designer.md: 392 → 250 lines (36% reduction)
- security-analyst.md: 390 → 250 lines (36% reduction)
- web-researcher.md: 364 → 250 lines (31% reduction)
- frontend-developer.md: 306 → 250 lines (18% reduction)

**Processing**: For each agent:
- Remove verbose examples → Reference skills
- Condense workflow sections → Bullet points
- Standardize to 8-section structure
- Add full YAML frontmatter
- Preserve all existing capabilities

**Business Rules**:
- MUST follow preservation-first enhancement process (11 steps)
- MUST validate with quality evaluator checklist (8 criteria pass)
- MUST maintain template variable approach where appropriate
- MUST document version: "2.0.0" with refactoring changelog

---

## 🚀 Non-Functional Requirements

### Performance Requirements

**Response Time**:
- Agent context loading: 60-80% faster (7,885 → 3,000 total lines)
- Architect agent invocation: 77% faster (1,026 → 250 lines)
- Team-lead agent invocation: 66% faster (1,346 → 450 lines total)

**Throughput**:
- No change to agent execution throughput (refactoring preserves behavior)
- Reduced token consumption enables more complex multi-agent workflows within limits

**Scalability**:
- Enables scaling to 15+ agents in future (context budget preserved)
- Supports complex Triad workflows without hitting token limits

### Reliability Requirements

**Availability**:
- Zero downtime (agents refactored incrementally, tested before release)
- Backward compatibility: 100% (existing workflows continue to work)

**Error Handling**:
- No change to agent error handling (behavior preserved)
- Quality evaluator checklist prevents shipping broken agents

**Data Integrity**:
- No data changes (agents are code, not data)
- Git version control ensures rollback capability

### Security Requirements

**Authentication**: N/A (agents run locally, no authentication changes)
**Authorization**: N/A (agent permissions unchanged)
**Data Protection**: N/A (no sensitive data in agents)

**Compliance**:
- Template licensing preserved (MIT license)
- No security-sensitive changes

### Accessibility Requirements

**Documentation Accessibility**:
- Markdown format ensures screen reader compatibility
- Clear heading hierarchy (H1 → H6) in all documentation
- Code examples use syntax highlighting for readability

**Internationalization**: N/A (English documentation only, per current standard)

---

## 📊 Success Metrics

### Primary Metrics (Leading Indicators)

**Metric 1: Total Agent Line Count Reduction**
- **Definition**: Sum of lines across all 12 agent files
- **Baseline**: 7,885 lines (current state)
- **Target**: 3,000 lines (62% reduction)
- **Timeline**: Measured at end of Week 4
- **Owner**: Team-Lead

**Metric 2: Agent Quality Score**
- **Definition**: Percentage of agents passing 8/8 quality criteria (conciseness, structure, boundaries, context efficiency, versioning, triad integration, skill delegation, preservation)
- **Baseline**: 0% (no quality evaluator exists)
- **Target**: 100% (all 12 agents pass 8/8 criteria)
- **Timeline**: Measured at end of each refactoring phase
- **Owner**: Architect

**Metric 3: YAML Frontmatter Standardization**
- **Definition**: Percentage of agents with complete YAML frontmatter (version, changelog, boundaries, triad-governance)
- **Baseline**: 0% (current agents missing these fields)
- **Target**: 100% (all 12 agents)
- **Timeline**: Measured at end of Week 3
- **Owner**: Product-Manager

### Secondary Metrics (Lagging Indicators)

**Metric 1: Context Overhead Reduction**
- **Definition**: Token consumption reduction when invoking agents
- **Baseline**: 7,885 lines × ~4 tokens/line = ~31,540 tokens
- **Target**: 3,000 lines × ~4 tokens/line = ~12,000 tokens (62% reduction)
- **Timeline**: Measured via token usage metrics after deployment
- **Owner**: DevOps

**Metric 2: Agent Customization Time**
- **Definition**: Time for template adopter to customize an agent for their tech stack
- **Baseline**: ~2 hours (estimated, based on confusion and trial-and-error)
- **Target**: <30 minutes (with best practices guide)
- **Timeline**: Measured via user feedback post-release
- **Owner**: Product-Manager

### User Satisfaction Metrics

**Feature Adoption**:
- `_AGENT_BEST_PRACTICES.md` views: Target 80% of template adopters read it within first week
- `_README.md` usage: Target 100% of users check it for agent selection
- Quality evaluator checklist usage: Target 50% of users validate customizations with it

**Template Adopter Feedback**:
- Customization confidence: Target 80%+ report feeling confident customizing agents (post-release survey)
- Performance satisfaction: Target 90%+ notice faster agent invocations
- Consistency satisfaction: Target 85%+ appreciate standardized agent structure

### Business Metrics

**Maintenance Efficiency**:
- Time to add new agent: 50% reduction (with best practices guide and standardized structure)
- Time to update existing agent: 60% reduction (with version/changelog tracking)
- Contributor ramp-up time: 70% reduction (with clear design standards)

**Template Quality**:
- GitHub stars/forks: Expected 20%+ increase due to improved quality
- Issue reports: Expected 30% decrease in agent-related confusion issues
- Pull requests: Expected 40% increase in community contributions (easier to contribute)

---

## 🔍 Scope & Boundaries

### In Scope (MVP / Phase 1)

**Must Have (P0)**:
- ✅ Create `_AGENT_BEST_PRACTICES.md` (1,561 lines comprehensive guide)
- ✅ Create `_README.md` (236 lines agent overview)
- ✅ Refactor architect.md (1,026 → 250 lines, 77% reduction)
- ✅ Refactor team-lead.md (1,346 → split into 200 + 250, 66% reduction)
- ✅ Refactor product-manager.md (430 → 250 lines, 42% reduction)

**Should Have (P1)**:
- 🎯 Standardize YAML frontmatter across all 12 agents (version, changelog, boundaries, triad-governance)
- 🎯 Refactor code-reviewer.md (1,100 → 250 lines)
- 🎯 Refactor debugger.md (1,033 → 250 lines)
- 🎯 Refactor tester.md (509 → 250 lines)
- 🎯 Refactor devops.md (578 → 250 lines)
- 🎯 Refactor senior-backend-engineer.md (411 → 250 lines)

### In Scope (Phase 2 - If Time Permits)

**Could Have (P2)**:
- 🔮 Refactor ux-ui-designer.md (392 → 250 lines)
- 🔮 Refactor security-analyst.md (390 → 250 lines)
- 🔮 Refactor web-researcher.md (364 → 250 lines)
- 🔮 Refactor frontend-developer.md (306 → 250 lines)

### Out of Scope (Future Phases)

**Won't Have** - Explicitly excluded from this PRD:
- ❌ Agent behavior changes: Preserve all existing capabilities (refactoring only)
- ❌ New agent creation: Only refactoring existing 12 agents
- ❌ Skill refactoring: Skills remain unchanged (separate effort)
- ❌ Infrastructure-specific conversions: Preserve template variable approach (Product-Led-Spec-Kit is a template, not infrastructure-specific like CISO_Agent)
- ❌ Agent testing framework: Quality evaluator is a checklist, not automated tests (separate effort)
- ❌ Agent performance benchmarking: Token consumption measured manually, not automated (separate effort)

### Assumptions

**Template Nature**:
- Product-Led-Spec-Kit is a template, not an infrastructure-specific project
- Must preserve template variables ({{FRONTEND_FRAMEWORK}}, {{CLOUD_PROVIDER}}) where appropriate
- Template adopters will customize agents for their specific tech stack

**Agent Capabilities**:
- All existing agent capabilities can be preserved while reducing line count
- Verbose examples can be replaced with skill references without losing functionality
- 150-250 line target is achievable for all agents without compromising quality

**CISO_Agent Patterns**:
- CISO_Agent best practices are applicable to Product-Led-Spec-Kit
- 8-section structure works for all agent types (governance, engineering, analysis)
- Quality evaluator checklist is comprehensive for all agents

**Validation Needed**:
- [ ] Architect agent: Verify 250 lines is sufficient for all architecture guidance (test with sample feature)
- [ ] Team-Lead split: Confirm team-lead (200) + orchestrator (250) = 450 total is sufficient (test with multi-agent workflow)
- [ ] Template variables: Validate guidance on when to use {{VARS}} vs concrete values (review with template adopters)

### Constraints

**Technical Constraints**:
- Line targets: 150-250 optimal, 300 max with justification (per CISO_Agent best practices)
- Structure: MUST follow 8-section template (Core Mission → Triad Governance)
- YAML: MUST include version, changelog, boundaries, triad-governance fields
- Markdown: MUST use valid Markdown (no proprietary formats)

**Business Constraints**:
- Timeline: 4 weeks maximum (Phase 1 deadline)
- Resources: 1 architect + 1 team-lead + 1 product-manager (Triad team)
- Scope: All 12 agents (cannot defer agents to future release)

**External Dependencies**:
- CISO_Agent best practices analysis: ✅ Complete (2026-01-31)
- Anthropic Claude Code v2.1.16: ✅ Deployed (enables parallel refactoring)
- Product-Led-Spec-Kit constitution: ✅ Stable (no governance changes during refactoring)

---

## 🛣️ Timeline & Milestones

### Phase Breakdown

**Phase 1: Foundation** (Week 1)
- **Week 1, Day 1-2**: Create `_AGENT_BEST_PRACTICES.md` (1,561 lines)
  - Document 8 core principles
  - Define line targets (150-250 optimal, 300 max)
  - Specify 8-section structure template
  - Document YAML frontmatter fields
  - Create quality evaluator checklist
  - Document preservation-first enhancement process (11 steps)
- **Week 1, Day 3-4**: Create `_README.md` (236 lines)
  - Extract agent roster from all 12 agents
  - Create quick reference table
  - Document Triad governance integration
  - Provide agent selection guidance
- **Week 1, Day 5**: Foundation review & approval (Triad sign-off)
- **Deliverable**: `_AGENT_BEST_PRACTICES.md` + `_README.md` approved

**Phase 2: Priority Refactoring** (Week 2)
- **Week 2, Day 1-2**: Refactor architect.md (1,026 → 250 lines)
  - Remove 550+ lines of code examples → Reference skills
  - Condense workflow sections
  - Standardize to 8-section structure
  - Add full YAML frontmatter
- **Week 2, Day 3-4**: Refactor team-lead.md (1,346 → 200 + 250 split)
  - Split governance → team-lead.md (200 lines)
  - Split orchestration → orchestrator.md (250 lines)
  - Add full YAML frontmatter to both
  - Update `_README.md` with split documentation
- **Week 2, Day 5**: Refactor product-manager.md (430 → 250 lines)
  - Condense communication/documentation sections
  - Reference prd-create skill
  - Add full YAML frontmatter
- **Deliverable**: architect, team-lead, orchestrator, product-manager refactored + tested

**Phase 3: Medium Agents + YAML Standardization** (Week 3)
- **Week 3, Day 1**: Refactor code-reviewer.md (1,100 → 250 lines)
- **Week 3, Day 2**: Refactor debugger.md (1,033 → 250 lines)
- **Week 3, Day 3**: Refactor tester.md (509 → 250 lines)
- **Week 3, Day 4**: Refactor devops.md (578 → 250 lines)
- **Week 3, Day 5**: Refactor senior-backend-engineer.md (411 → 250 lines)
- **Deliverable**: 5 medium agents refactored, all with YAML frontmatter

**Phase 4: Final Agents + Validation** (Week 4)
- **Week 4, Day 1**: Refactor ux-ui-designer.md (392 → 250 lines)
- **Week 4, Day 2**: Refactor security-analyst.md (390 → 250 lines)
- **Week 4, Day 3**: Refactor web-researcher.md (364 → 250 lines) + frontend-developer.md (306 → 250 lines)
- **Week 4, Day 4**: Quality validation (all 12 agents, 8/8 criteria)
- **Week 4, Day 5**: Final Triad sign-off + documentation update
- **Deliverable**: All 12 agents refactored, quality validated, ready for release

### Key Milestones

| Milestone | Target Date | Owner | Status |
|-----------|-------------|-------|--------|
| PRD Approval | 2026-02-03 | product-manager | 📋 Pending |
| `_AGENT_BEST_PRACTICES.md` Complete | 2026-02-06 | architect | 📋 Pending |
| `_README.md` Complete | 2026-02-07 | product-manager | 📋 Pending |
| Foundation Sign-Off | 2026-02-07 | PM + Architect + Team-Lead | 📋 Pending |
| Top 3 Agents Refactored | 2026-02-14 | architect + team-lead | 📋 Pending |
| 5 Medium Agents Refactored | 2026-02-21 | team-lead | 📋 Pending |
| All 12 Agents Refactored | 2026-02-26 | team-lead | 📋 Pending |
| Quality Validation Complete | 2026-02-27 | architect | 📋 Pending |
| Final Triad Sign-Off | 2026-02-28 | PM + Architect + Team-Lead | 📋 Pending |
| Production Deploy | 2026-02-28 | devops | 📋 Pending |

Legend: ✅ Complete | 🟢 On Track | 🟡 In Review | 📋 Pending | 🔴 Blocked

---

## ⚠️ Risks & Dependencies

### Technical Risks

**Risk 1: Line Target Infeasible for Complex Agents**
- **Likelihood**: Medium
- **Impact**: Medium
- **Description**: Some agents (e.g., architect, team-lead) may require >250 lines to maintain all capabilities
- **Mitigation**:
  - Use preservation-first enhancement process (11 steps) to methodically identify reduction opportunities
  - Allow 300 lines max with documented justification (per best practices)
  - Split agents if necessary (e.g., team-lead → team-lead + orchestrator)
- **Contingency**: If 300-line max is still insufficient, document justification in YAML frontmatter and get Triad approval

**Risk 2: Breaking Existing Agent Behavior**
- **Likelihood**: Medium
- **Impact**: High
- **Description**: Aggressive refactoring could inadvertently remove critical agent capabilities
- **Mitigation**:
  - Follow preservation-first enhancement process (step 1: read current agent, step 2: extract core mission, step 11: validate capabilities preserved)
  - Test each refactored agent with representative tasks before marking complete
  - Use quality evaluator checklist (criterion 8: preservation validation)
- **Contingency**: If behavior is broken, rollback to previous version (git), re-refactor with more conservative approach

**Risk 3: Template Variable Ambiguity**
- **Likelihood**: Low
- **Impact**: Medium
- **Description**: Unclear when to preserve {{TEMPLATE_VARS}} vs use concrete values (Product-Led-Spec-Kit is template, CISO_Agent is infrastructure-specific)
- **Mitigation**:
  - Document clear guidance in `_AGENT_BEST_PRACTICES.md`: Use {{VARS}} for tech stack choices (framework, cloud provider), use concrete values for methodology/process
  - Review all template variable usage in current agents before refactoring
- **Contingency**: If ambiguity persists, default to preserving {{VARS}} (safer for template users)

**Risk 4: Quality Evaluator Subjectivity**
- **Likelihood**: Low
- **Impact**: Low
- **Description**: 8-criteria quality checklist may have subjective interpretations (e.g., "concise enough?")
- **Mitigation**:
  - Define objective thresholds where possible (e.g., conciseness = ≤300 lines)
  - Provide examples of pass/fail for subjective criteria in best practices guide
  - Require Triad consensus for borderline cases
- **Contingency**: If subjectivity causes disputes, escalate to constitution (PM has final veto authority)

### Business Risks

**Risk 1: Template Adopter Confusion During Transition**
- **Likelihood**: Medium
- **Impact**: Medium
- **Description**: Users who adopted Product-Led-Spec-Kit before refactoring may be confused by new agent structure
- **Mitigation**:
  - Document migration guide in CHANGELOG.md (how to upgrade from pre-refactoring agents)
  - Provide version numbers in YAML frontmatter (clear before/after)
  - Announce refactoring in release notes with benefits summary
- **Contingency**: If confusion is widespread, create migration support issue template, offer community support

**Risk 2: Scope Creep (Agent Behavior Changes)**
- **Likelihood**: Medium
- **Impact**: High
- **Description**: Refactoring could accidentally expand into behavior changes, delaying timeline
- **Mitigation**:
  - Strict "refactoring only, no behavior changes" rule enforced by Triad sign-offs
  - Use quality evaluator criterion 8 (preservation validation)
  - Track scope changes in changelog, escalate to PM for veto
- **Contingency**: If scope creep detected, freeze new changes, complete refactoring as-is, defer behavior changes to separate PRD

### Dependencies

**Internal Dependencies**:
- **Feature 002 (Anthropic Updates Integration)**: ✅ Complete - Enables parallel agent refactoring via context forking (needed for Week 3-4 efficiency)
- **Constitution Stability**: ✅ Stable - No governance changes during refactoring (prevents churn)
- **CISO_Agent Best Practices Analysis**: ✅ Complete (2026-01-31) - Provides refactoring blueprint

**External Dependencies**:
- **Anthropic Claude Code v2.1.16**: ✅ Deployed - Enables Task tool for parallel agent testing
- **Git Version Control**: ✅ Available - Enables rollback if refactoring breaks functionality

**Dependency Graph**:
```
[Feature 003: Agent Refactoring]
  ├─ Depends on: Feature 002 (Anthropic Updates) ✅ Complete
  ├─ Depends on: CISO_Agent Analysis ✅ Complete
  ├─ Depends on: Constitution Stability ✅ Stable
  └─ Blocks: Phase 2 Advanced Governance Workflows ⏳ Pending
```

---

## ❓ Open Questions

**Format**: [Question] - [Owner] - [Due Date] - [Status]

### Product Questions
- [ ] Should we create automated quality tests for agents (beyond checklist)? - product-manager - 2026-02-03 - Researching
  - **Context**: Quality evaluator is currently a manual checklist; automated tests would catch regressions
  - **Trade-off**: Adds scope but increases confidence in refactoring
  - **Recommendation**: Defer to separate PRD (out of scope for this refactoring)

- [ ] Should we version documentation files (`_AGENT_BEST_PRACTICES.md`, `_README.md`) like agents? - product-manager - 2026-02-03 - Researching
  - **Context**: Documentation files don't have YAML frontmatter for versioning
  - **Recommendation**: Yes, add version header at top of file (e.g., "Version: 1.0.0")

### Technical Questions
- [ ] Can all agents realistically fit in 150-250 lines without compromising quality? - architect - 2026-02-06 - Testing
  - **Context**: CISO_Agent achieved this, but Product-Led-Spec-Kit has different agent complexity
  - **Validation**: Test with architect.md refactoring (largest agent)
  - **Threshold**: If >3 agents require 300-line justification, re-evaluate line targets

- [ ] Should team-lead split create a new `orchestrator` agent or rename existing agent? - architect - 2026-02-06 - Researching
  - **Context**: Backward compatibility vs clarity
  - **Options**: (1) Keep team-lead.md + create orchestrator.md, (2) Rename team-lead.md → orchestrator.md + create team-lead.md
  - **Recommendation**: Option 1 (backward compatible)

- [ ] How do we handle agents that already meet line targets (e.g., frontend-developer.md at 306 lines)? - team-lead - 2026-02-10 - Pending
  - **Context**: Some agents are close to target; is minor refactoring still valuable?
  - **Recommendation**: Still refactor for structure standardization + YAML frontmatter, even if line count reduction is minimal

### Design Questions
- [ ] Should quality evaluator checklist be in `_AGENT_BEST_PRACTICES.md` or separate file? - architect - 2026-02-03 - Researching
  - **Context**: Checklist is 8 criteria; could be inline or standalone
  - **Recommendation**: Inline in best practices guide (easier to reference during refactoring)

### Business Questions
- [ ] Should we announce refactoring in advance to template adopters? - product-manager - 2026-02-01 - Pending
  - **Context**: Helps manage expectations but may delay adoption
  - **Recommendation**: Yes, create GitHub discussion with refactoring goals + timeline

---

## 📚 References

### Product Documentation
- Product Vision: [docs/product/01_Product_Vision/README.md](../01_Product_Vision/README.md)
- Roadmap: [docs/product/03_Product_Roadmap/README.md](../03_Product_Roadmap/README.md)
- Previous PRDs:
  - [001-claude-code-memory-features-2025-12-15.md](001-claude-code-memory-features-2025-12-15.md)
  - [002-anthropic-updates-integration-2026-01-24.md](002-anthropic-updates-integration-2026-01-24.md)

### Technical Documentation
- Constitution: [.specify/memory/constitution.md](../../../.specify/memory/constitution.md)
- Current Agents: [.claude/agents/](../../../.claude/agents/)
- CISO_Agent Best Practices Analysis: [Referenced from user context, not in repo]

### Research & Analysis
- CISO_Agent Comparison: Comprehensive analysis completed 2026-01-31
  - `_AGENT_BEST_PRACTICES.md`: 1,561 lines, 8 core principles
  - `_README.md`: 236 lines, agent roster
  - Architect refactoring: 1,027 → 250 lines (77% reduction)
  - Team-Lead refactoring: 1,347 → 200 + 250 split (66% reduction)
  - Product-Manager refactoring: 431 → 250 lines (42% reduction)

### External Resources
- Anthropic Claude Code v2.1.16 Documentation: [https://www.anthropic.com/claude-code](https://www.anthropic.com/claude-code)
- YAML Specification: [https://yaml.org/spec/1.2/spec.html](https://yaml.org/spec/1.2/spec.html)
- Semantic Versioning: [https://semver.org/](https://semver.org/)

---

## ✅ Approval & Sign-Off

### PRD Review Checklist

**Product Manager** (product-manager):
- [ ] Problem statement is clear and user-focused
  - ✅ Current state analysis complete (7,885 lines, inconsistencies documented)
  - ✅ User impact clear (template adopters + agent developers)
- [ ] User stories have measurable acceptance criteria
  - ✅ 6 user stories with Given-When-Then acceptance criteria
- [ ] Success metrics are defined and measurable
  - ✅ Primary: Line count (62% reduction), quality score (8/8), YAML standardization (100%)
  - ✅ Secondary: Context overhead (60-80%), customization time (<30 min)
- [ ] Scope is realistic for timeline
  - ✅ 4-week timeline, phased approach (foundation → priority → medium → final)
  - ⚠️ P2 agents (4 remaining) may slip to Phase 2 if timeline pressure
- [ ] Risks and dependencies identified
  - ✅ 4 technical risks + 2 business risks with mitigation/contingency
  - ✅ Dependencies: Feature 002 complete ✅, CISO_Agent analysis ✅
- [ ] Aligns with product vision and OKRs
  - ✅ Supports Q1 2026 OKR: Reduce context overhead 60%+, standardize components 100%

**Architect**:
- [ ] Technical requirements are clear
  - Pending architecture baseline (if needed)
- [ ] Non-functional requirements are realistic
  - Pending technical feasibility check
- [ ] Dependencies are accurate
  - Pending architecture review
- [ ] Technical risks are identified
  - Pending architecture review
- [ ] Architecture approach is sound
  - Pending architecture review

**Engineering Lead** (team-lead):
- [ ] Requirements are implementable
  - Pending feasibility check
- [ ] Effort estimates are reasonable
  - Pending timeline validation (4 weeks for 12 agents)
- [ ] Team capacity is available
  - Pending capacity check (Triad team: PM + Architect + Team-Lead)
- [ ] Timeline is realistic
  - Pending feasibility report

### Approval Status

| Role | Name | Status | Date | Comments |
|------|------|--------|------|----------|
| Product Manager | product-manager | 🟡 Approved with Concerns | 2026-01-31 | OKR formalization, P2 slip risk monitoring |
| Architect | architect | 🟡 Approved with Concerns | 2026-01-31 | Line targets achievable, validate Week 2 |
| Engineering Lead | team-lead | 🟡 Approved with Concerns | 2026-01-31 | Week 3 bottleneck, leverage parallelization |

Legend: ✅ Approved | 🟡 Approved with Comments | ❌ Rejected | 📋 Pending

---

## 📝 Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-31 | product-manager | Initial PRD draft created via prd-create skill |
| 1.1 | 2026-01-31 | triad | Triad sign-offs completed (PM + Architect + Team-Lead) via /triad.prd |

---

## Appendix A: Current State Analysis (Detailed)

### Agent Line Count Breakdown

| Agent | Current Lines | Target Lines | Reduction % | Priority |
|-------|---------------|--------------|-------------|----------|
| team-lead.md | 1,346 | 200 + 250 (split) | 66% | P0 |
| code-reviewer.md | 1,100 | 250 | 77% | P1 |
| debugger.md | 1,033 | 250 | 76% | P1 |
| architect.md | 1,026 | 250 | 77% | P0 |
| devops.md | 578 | 250 | 57% | P1 |
| tester.md | 509 | 250 | 51% | P1 |
| product-manager.md | 430 | 250 | 42% | P0 |
| senior-backend-engineer.md | 411 | 250 | 39% | P1 |
| ux-ui-designer.md | 392 | 250 | 36% | P2 |
| security-analyst.md | 390 | 250 | 36% | P2 |
| web-researcher.md | 364 | 250 | 31% | P2 |
| frontend-developer.md | 306 | 250 | 18% | P2 |
| **TOTAL** | **7,885** | **3,000** | **62%** | - |

### CISO_Agent Best Practices (Reference)

**File**: `_AGENT_BEST_PRACTICES.md` (1,561 lines)

**8 Core Principles**:
1. Conciseness (150-250 lines optimal, 300 max)
2. Structure (8-section template)
3. Boundaries (clear scope definition)
4. Context Efficiency (reference skills, not embed code)
5. Versioning (semantic versioning + changelog)
6. Triad Integration (governance participation documented)
7. Skill Delegation (delegate to skills, don't duplicate)
8. Preservation-First Enhancement (11-step process)

**8-Section Structure**:
1. Core Mission (what the agent does)
2. Role Definition (agent's place in workflow)
3. When to Use (use cases, trigger phrases)
4. Workflow Steps (step-by-step process)
5. Quality Standards (acceptance criteria)
6. Triad Governance (sign-off participation)
7. Tools & Skills (what agent uses)
8. Success Criteria (how to measure agent effectiveness)

**Quality Evaluator Checklist** (8 Criteria):
1. ✅ Conciseness: ≤300 lines (preferably ≤250)
2. ✅ Structure: Follows 8-section template
3. ✅ Boundaries: YAML frontmatter clearly defines scope
4. ✅ Context Efficiency: References skills, minimal code examples (<20 lines)
5. ✅ Versioning: Has version + changelog in YAML
6. ✅ Triad Integration: Documents governance participation (if applicable)
7. ✅ Skill Delegation: Delegates appropriate work to skills
8. ✅ Preservation: All original capabilities preserved (tested)

**Preservation-First Enhancement Process** (11 Steps):
1. Read current agent completely
2. Extract core mission and boundaries
3. Identify workflows and processes
4. List all capabilities (to preserve)
5. Identify verbose sections (code examples, redundant explanations)
6. Map capabilities to skills (delegate where possible)
7. Condense verbose sections (bullet points, concise language)
8. Restructure to 8-section template
9. Add/update YAML frontmatter
10. Validate line count (≤300, preferably ≤250)
11. Test with representative tasks (ensure capabilities preserved)

---

## Appendix B: CISO_Agent Refactoring Examples

### Example 1: Architect Agent Refactoring

**Before** (1,027 lines):
- 550+ lines of code execution examples (Python, TypeScript, database schemas)
- Verbose workflow sections (50+ lines per workflow)
- Embedded ADR templates (100+ lines)
- No YAML frontmatter version/changelog

**After** (250 lines):
- Code execution: 20 lines with thresholds, references skills for examples
- Workflows: Bullet points, 10-15 lines per workflow
- ADRs: Reference `docs/architecture/02_ADRs/ADR-000-template.md` instead of inline
- YAML frontmatter: version, changelog, boundaries, triad-governance

**Preservation**:
- All architecture capabilities preserved
- Infrastructure baseline workflow intact
- Technology evaluation process unchanged
- ADR creation process delegated to skill (not removed)

### Example 2: Team-Lead Agent Split

**Before** (1,347 lines):
- Combined governance (feasibility checks, sign-offs) + orchestration (agent coordination, parallel execution)
- No clear separation of concerns
- Difficult to invoke for specific purpose (governance vs orchestration)

**After** (200 + 250 = 450 lines):
- **team-lead.md** (200 lines): Governance only
  - Feasibility checks
  - Timeline estimation
  - Capacity planning
  - Agent assignment
  - Triad sign-offs
- **orchestrator.md** (250 lines): Orchestration only
  - Multi-agent coordination
  - Parallel execution waves
  - Task dependency tracking
  - Workflow state management

**Preservation**:
- All governance capabilities in team-lead.md
- All orchestration capabilities in orchestrator.md
- Clear handoff pattern documented in `_README.md`
- Backward compatibility: Existing team-lead workflows still work

---

## Appendix C: Template Variable Guidance

**Context**: Product-Led-Spec-Kit is a **template** (adopters customize for their stack), CISO_Agent is **infrastructure-specific** (Railway/Vercel/Neon concrete commands)

**When to Use `{{TEMPLATE_VARS}}`**:
- Tech stack choices: `{{FRONTEND_FRAMEWORK}}`, `{{BACKEND_FRAMEWORK}}`, `{{DATABASE}}`
- Cloud provider: `{{CLOUD_PROVIDER}}`
- Project-specific names: `{{PROJECT_NAME}}`
- Domain-specific terms: `{{USER_PERSONA}}`

**When to Use Concrete Values**:
- Methodology/process (e.g., "Triad governance", "SDLC phases")
- Universal tools (e.g., "git", "npm", "Docker")
- File paths in template structure (e.g., `docs/product/02_PRD/`)

**Example - Architect Agent**:
```yaml
# GOOD (template-appropriate)
technology-stack: >
  Evaluate {{FRONTEND_FRAMEWORK}} (React, Vue, Angular) based on:
  - Team expertise
  - Project complexity
  - Performance requirements

# BAD (too infrastructure-specific for template)
technology-stack: >
  Use React with Vercel deployment. No other options.
```

**Example - DevOps Agent**:
```yaml
# GOOD (template-appropriate)
deployment: >
  Deploy to {{CLOUD_PROVIDER}} (Vercel, AWS, GCP) using:
  - Git-based deployment
  - Environment-specific configs
  - Zero-downtime strategy

# BAD (CISO_Agent pattern, not appropriate for template)
deployment: >
  Deploy to Railway using `railway up`. Production uses Vercel with `vercel --prod`.
```

**Guidance in `_AGENT_BEST_PRACTICES.md`**:
- Section: "Template Variables vs Concrete Values"
- Provide decision tree: Is it tech stack? Use {{VAR}}. Is it methodology? Use concrete.
- Examples of both patterns with rationale
