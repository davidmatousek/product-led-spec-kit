# Claude Agent Infrastructure

This directory contains the complete agent orchestration infrastructure for product-led spec kit development, including 12 specialized agents, 9 automation skills, and 19 slash commands for streamlined feature development.

## Overview

The infrastructure is organized into three main components:

1. **Agents** (`agents/`) - 12 specialized AI agents for different development roles
2. **Skills** (`skills/`) - 9 reusable automation capabilities
3. **Commands** (`commands/`) - 19 slash commands for workflow automation

---

## Agents (`agents/`)

### Core Development Team (6 agents)

| Agent | Role | Primary Responsibilities |
|-------|------|-------------------------|
| **product-manager** | Product Manager | Product specifications, user stories, requirements gathering, stakeholder communication |
| **architect** | Technical Architect | System design, architecture review, technical decision documentation, baseline infrastructure analysis |
| **team-lead** | Development Lead | Multi-agent orchestration, parallel task coordination, workflow management, progress tracking |
| **senior-backend-engineer** | Backend Developer | API implementation, business logic, database design, server-side code |
| **frontend-developer** | Frontend Developer | UI components, client-side logic, design system implementation |
| **tester** | QA Engineer | BDD tests, integration tests, test coverage, quality assurance |

### Specialized Support Team (6 agents)

| Agent | Role | Primary Responsibilities |
|-------|------|-------------------------|
| **devops** | DevOps Engineer | Infrastructure, deployment, CI/CD, environment management |
| **code-reviewer** | Code Quality | Code review, architecture validation, security review, quality gates |
| **debugger** | Troubleshooter | Root cause analysis, complex debugging, issue resolution |
| **web-researcher** | Research Specialist | Technical research, best practices, library evaluation, documentation analysis |
| **ux-ui-designer** | UX/UI Designer | Design systems, user experience, interface specifications, mockups |
| **security-analyst** | Security Expert | Security analysis, vulnerability assessment, threat modeling, dependency scanning |

### Agent Customization

All agents are **templatized** with the following variables for project-specific customization:

```
{{PROJECT_NAME}}          - Your project name (e.g., "my-saas-app")
{{BACKEND_FRAMEWORK}}     - Backend framework (e.g., "Express", "Fastify", "NestJS")
{{FRONTEND_FRAMEWORK}}    - Frontend framework (e.g., "React", "Vue", "Svelte")
{{DATABASE}}              - Database system (e.g., "PostgreSQL", "MySQL", "MongoDB")
{{DATABASE_PROVIDER}}     - Database provider (e.g., "Supabase", "Neon", "AWS RDS")
{{CLOUD_PROVIDER}}        - Cloud platform (e.g., "Vercel", "AWS", "Railway")
{{BACKEND_PATH}}          - Backend source path (e.g., "backend/src", "server/src")
{{FRONTEND_PATH}}         - Frontend source path (e.g., "frontend/src", "client/src")
```

**To customize agents for your project:**
1. Search and replace template variables in `.claude/agents/*.md`
2. Update tech stack references to match your choices
3. Adjust file path patterns to match your project structure

---

## Skills (`skills/`)

Skills are reusable automation capabilities that agents can invoke to perform specialized tasks.

### Product & Planning Skills

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| **prd-create** | Create Product Requirements Documents (PRDs) | Starting new features, defining product scope |
| **implementation-checkpoint** | Create implementation checkpoints for long features | Mid-feature progress tracking, wave completion |

### Architecture & Validation Skills

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| **architecture-validator** | Validate architectural decisions and consistency | Before finalizing plan.md, after major design changes |
| **speckit-validator** | Validate spec.md, plan.md, tasks.md consistency | Before PRs, after task generation |

### Knowledge Management Skills

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| **kb-create** | Create structured knowledge base articles | Documenting patterns, bugs, architectural decisions |
| **kb-query** | Query knowledge base for similar solutions | Before implementing, when stuck on problems |

### Development Support Skills

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| **root-cause-analyzer** | Perform 5 Whys root cause analysis | Complex bugs, recurring issues, workflow blockers |
| **code-execution-helper** | Execute code for quota checks, API validation | Pre-flight quota checks, resource validation |
| **git-workflow-helper** | Git workflow automation (commits, PRs, branches) | Creating commits, managing branches, PR creation |

**Skills are domain-agnostic** and require minimal customization beyond `{{PROJECT_NAME}}` substitution.

---

## Commands (`commands/`)

### Triad Commands (Recommended - Automatic Governance)

The **SDLC Triad** ensures Product-Architecture-Engineering alignment with automatic sign-offs:

| Command | Purpose | Auto Sign-offs |
|---------|---------|----------------|
| `/triad.prd <topic>` | Create PRD with PM + Architect + Tech-Lead validation | 3-way (PM, Architect, Tech-Lead) |
| `/triad.specify` | Create spec.md with PM sign-off | 1-way (PM) |
| `/triad.plan` | Create plan.md with PM + Architect sign-off | 2-way (PM, Architect) |
| `/triad.tasks` | Create tasks.md with triple sign-off | 3-way (PM, Architect, Tech-Lead) |
| `/triad.implement` | Execute with architect checkpoints | Architect checkpoints at milestones |
| `/triad.close-feature {NNN}` | Close feature with parallel doc updates | Automatic documentation |

**Supporting Triad Commands:**
- `/triad.architect-baseline` - Architect provides infrastructure baseline for PRDs
- `/triad.feasibility` - Tech-Lead provides timeline estimates before PM finalizes PRD

### Vanilla Commands (Fast Prototyping - No Governance)

For rapid prototyping without automatic governance:

| Command | Purpose | Governance |
|---------|---------|-----------|
| `/speckit.specify` | Create spec.md | Manual |
| `/speckit.plan` | Create plan.md | Manual |
| `/speckit.tasks` | Create tasks.md | Manual |
| `/speckit.implement` | Execute tasks | Manual |
| `/speckit.clarify` | Ask 5 clarification questions | N/A |
| `/speckit.analyze` | Cross-artifact consistency check | N/A |
| `/speckit.checklist` | Generate custom task checklist | N/A |
| `/speckit.constitution` | Create/update project constitution | N/A |

### Orchestration Commands

| Command | Purpose | Use Case |
|---------|---------|----------|
| `/team-lead.implement` | Execute with parallel agent orchestration | Multi-wave implementation with 3+ agents |
| `/execute` | Execute any task with optimal agent orchestration | General-purpose task execution |
| `/continue` | Generate session continuation prompt | Long features spanning multiple sessions |

---

## Workflow Examples

### Example 1: Full Feature Development (Triad Workflow)

```bash
# 1. Create PRD with automatic validation
/triad.prd "User authentication with OAuth2"

# 2. Create specification with PM sign-off
/triad.specify

# 3. Create architecture with PM + Architect sign-off
/triad.plan

# 4. Generate tasks with triple sign-off (PM + Architect + Tech-Lead)
/triad.tasks

# 5. Execute implementation with architect checkpoints
/triad.implement

# 6. Close feature with documentation updates
/triad.close-feature 001
```

**Automatic Sign-offs**: PM approves product requirements, Architect approves technical design, Tech-Lead optimizes task assignment for parallel execution.

### Example 2: Rapid Prototyping (Vanilla Workflow)

```bash
# Skip governance for speed
/speckit.specify
/speckit.plan
/speckit.tasks
/team-lead.implement
```

**No Automatic Sign-offs**: Faster but requires manual validation.

### Example 3: Parallel Multi-Agent Implementation

```bash
# Tech-Lead coordinates 3+ agents working in parallel
/team-lead.implement

# Example orchestration:
# Wave 1: web-researcher (research best practices)
# Wave 2: senior-backend-engineer (API implementation)
# Wave 3: frontend-developer + tester (UI + tests in parallel)
# Wave 4: code-reviewer (quality gates)
```

---

## Customization Guide

### 1. Replace Template Variables

Search and replace in all `.claude/agents/*.md` files:

```bash
# Example: Customize for Express + Vue + MySQL project
sed -i 's/{{BACKEND_FRAMEWORK}}/Express/g' .claude/agents/*.md
sed -i 's/{{FRONTEND_FRAMEWORK}}/Vue/g' .claude/agents/*.md
sed -i 's/{{DATABASE}}/MySQL/g' .claude/agents/*.md
sed -i 's/{{CLOUD_PROVIDER}}/AWS/g' .claude/agents/*.md
sed -i 's/{{PROJECT_NAME}}/my-project/g' .claude/agents/*.md .claude/skills/**/*.md .claude/commands/*.md
```

### 2. Adjust File Paths

Update `{{BACKEND_PATH}}` and `{{FRONTEND_PATH}}` to match your project structure:

```bash
# Example: Backend in "server/src", frontend in "app/src"
sed -i 's/{{BACKEND_PATH}}/server\/src/g' .claude/agents/*.md
sed -i 's/{{FRONTEND_PATH}}/app\/src/g' .claude/agents/*.md
```

### 3. Add Project-Specific Context

Edit individual agent files to add:
- Project-specific conventions (naming, patterns)
- Team-specific processes
- Technology-specific best practices

---

## Agent Invocation Patterns

### Using the Task Tool (Recommended)

```
Task: "Implement authentication module per spec.md"
Agent: senior-backend-engineer
Context: .specify/spec.md, .specify/plan.md
Expected Output: backend/src/auth/* implementation
```

### Using SlashCommand Tool

```
SlashCommand: /triad.tasks
Context: .specify/spec.md and plan.md must exist
Expected Output: .specify/tasks.md with dependency-ordered tasks
```

### Parallel Agent Invocation

```python
# Launch 3 agents in parallel (SINGLE message)
Task(subagent_type="senior-backend-engineer", prompt="Implement T010-T020")
Task(subagent_type="frontend-developer", prompt="Implement T030-T040")
Task(subagent_type="tester", prompt="Implement T050-T060")
```

---

## Directory Structure

```
.claude/
├── agents/           → 12 specialized agents
│   ├── product-manager.md
│   ├── architect.md
│   ├── team-lead.md
│   ├── senior-backend-engineer.md
│   ├── frontend-developer.md
│   ├── tester.md
│   ├── devops.md
│   ├── code-reviewer.md
│   ├── debugger.md
│   ├── web-researcher.md
│   ├── ux-ui-designer.md
│   └── security-analyst.md
│
├── skills/           → 9 automation capabilities
│   ├── prd-create/
│   ├── implementation-checkpoint/
│   ├── architecture-validator/
│   ├── speckit-validator/
│   ├── kb-create/
│   ├── kb-query/
│   ├── root-cause-analyzer/
│   ├── code-execution-helper/
│   └── git-workflow-helper/
│
├── commands/         → 19 slash commands
│   ├── triad.prd.md
│   ├── triad.architect-baseline.md
│   ├── triad.feasibility.md
│   ├── triad.specify.md
│   ├── triad.plan.md
│   ├── triad.tasks.md
│   ├── triad.implement.md
│   ├── triad.close-feature.md
│   ├── speckit.specify.md
│   ├── speckit.plan.md
│   ├── speckit.tasks.md
│   ├── speckit.implement.md
│   ├── speckit.clarify.md
│   ├── speckit.analyze.md
│   ├── speckit.checklist.md
│   ├── speckit.constitution.md
│   ├── team-lead.implement.md
│   ├── execute.md
│   └── continue.md
│
└── README.md         → This file
```

---

## Key Principles

1. **Triad Workflow** - Use `/triad.*` commands for automatic governance (PM + Architect + Tech-Lead sign-offs)
2. **Parallel Execution** - Team-lead orchestrates agents working on different files simultaneously
3. **Constitutional Compliance** - All agents respect `.specify/memory/constitution.md` principles
4. **Knowledge Capture** - Use KB skills to document patterns, bugs, and architectural decisions
5. **Quality Gates** - Code-reviewer validates before deployment, architect checkpoints during implementation

---

## Tips

- **Start with Triad**: Use `/triad.*` commands for production features (automatic governance)
- **Use Vanilla for Prototypes**: Use `/speckit.*` commands for quick experiments (no governance overhead)
- **Parallel Orchestration**: Invoke `/team-lead.implement` for features with 20+ tasks across multiple domains
- **Research First**: Use `web-researcher` agent before implementing with unfamiliar libraries
- **Checkpoint Long Features**: Use `implementation-checkpoint` skill for features spanning multiple sessions
- **Review Before Deploy**: Always invoke `code-reviewer` agent in Phase 5 before production deployment

---

## Recent Changes

- **2025-12-04**: Initial infrastructure setup for product-led-spec-kit template
  - Copied 12 agents, 9 skills, 19 commands from spec-kit-ops
  - Applied templatization with 8 template variables
  - Created comprehensive README documentation

---

## Support

For detailed documentation on:
- **Triad Workflow**: See `docs/SPEC_KIT_TRIAD.md`
- **Constitution**: See `.specify/memory/constitution.md`
- **Methodology**: See `docs/core_principles/`
- **Agent Details**: See individual agent files in `agents/`
