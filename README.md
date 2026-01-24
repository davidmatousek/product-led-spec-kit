# Product-Led Spec Kit Template

**A product-led governance template for Spec Kit with SDLC Triad collaboration framework**

---

## Overview

Product-Led Spec Kit is a specialized template that extends the base [Spec Kit](https://github.com/spec-kit-ops/spec-kit) repository with:

- **Product-led governance principles** - PM-driven product vision and alignment
- **SDLC Triad collaboration framework** - PM + Architect + Tech-Lead sign-offs
- **Templatized constitution** - Easy customization with `{{PLACEHOLDERS}}`
- **Product management workflows** - PRD creation, OKRs, roadmaps, user stories

This template is ideal for teams building SaaS products, multi-agent systems, or any project requiring tight Product-Architecture-Engineering alignment.

---

## What's Included

### Core Governance
- **Templatized Constitution** (`.specify/memory/constitution.md`) - 11 core principles with `{{PLACEHOLDERS}}` for easy customization
- **SDLC Triad Framework** - PM + Architect + Tech-Lead collaboration with veto authority
- **Product-Spec Alignment** - Dual sign-off requirements (PM + Architect) before implementation

### Directory Structure
```
product-led-spec-kit/
├── .claude/
│   ├── agents/                 # 13 specialized agents
│   ├── skills/                 # 8 automation capabilities
│   ├── commands/               # Spec Kit + Triad commands
│   └── rules/                  # Modular governance rules (NEW)
│       ├── governance.md       # Sign-off requirements, Triad workflow
│       ├── git-workflow.md     # Branch naming, PR policies
│       ├── deployment.md       # DevOps agent policy
│       ├── scope.md            # Project boundaries
│       ├── commands.md         # Triad + Vanilla commands
│       └── context-loading.md  # Context loading guide
├── .specify/
│   └── memory/
│       └── constitution.md     # Templatized governance (CUSTOMIZE THIS)
├── docs/
│   ├── product/                # Product vision, PRDs, roadmaps, OKRs, user stories
│   ├── architecture/           # System design, ADRs, patterns
│   ├── devops/                 # Deployment and infrastructure
│   ├── core_principles/        # Methodology (Five Whys, DoD, etc.)
│   ├── testing/                # Testing standards and strategies
│   └── planning/
│       └── FORK_SETUP.md       # How to sync with upstream spec-kit
├── specs/                      # Feature specifications (.specify/ artifacts)
├── scripts/                    # Automation scripts
├── CLAUDE.md                   # AI agent context (70 lines with @-references)
├── MIGRATION.md                # Migration guide for modular rules
└── README.md                   # This file
```

---

## Quick Start

### Installation Options

**Option 1: Interactive Setup (Recommended)**
```bash
# Clone the template
git clone https://github.com/YOUR_ORG/product-led-spec-kit.git my-project
cd my-project

# Run interactive initialization
make init

# Or directly:
./scripts/init.sh
```

The init script will:
- Prompt for project name, description, tech stack
- Replace all template variables automatically
- Remove itself after initialization
- Display next steps

**Option 2: Manual Setup**
```bash
# Clone this repository
git clone https://github.com/YOUR_ORG/product-led-spec-kit.git my-project
cd my-project

# Manually replace template variables (see Step 2)
```

**Option 3: Fork on GitHub** (for contributing back)
```bash
# See docs/planning/FORK_SETUP.md for detailed instructions
# 1. Fork github.com/spec-kit-ops/spec-kit
# 2. Rename to product-led-spec-kit
# 3. Clone your fork
```

### Step 1: Verify Setup

After installation, verify everything is ready:

```bash
make check
```

This checks:
- Node.js and Git installed
- Claude Code installed (optional)
- Project structure (constitution, agents, commands)
- File integrity

### Step 2: Customize Constitution (If Manual Setup)

Edit `.specify/memory/constitution.md` and replace all template variables:

```bash
# Required replacements:
# {{PROJECT_NAME}}         → your-project-name
# {{PROJECT_DESCRIPTION}}  → Brief description
# {{TECH_STACK_DATABASE}}  → PostgreSQL, MySQL, etc.
# {{TECH_STACK_VECTOR}}    → pgvector, Pinecone, Qdrant, etc.
# {{TECH_STACK_AUTH}}      → JWT, OAuth2, Auth0, etc.
# {{RATIFICATION_DATE}}    → 2025-12-04 (deployment date)
```

**Automated replacement** (optional):
```bash
# Create a script to replace all variables at once
sed -i '' 's/{{PROJECT_NAME}}/my-saas-platform/g' .specify/memory/constitution.md
sed -i '' 's/{{TECH_STACK_DATABASE}}/PostgreSQL/g' .specify/memory/constitution.md
sed -i '' 's/{{TECH_STACK_VECTOR}}/pgvector/g' .specify/memory/constitution.md
sed -i '' 's/{{TECH_STACK_AUTH}}/JWT/g' .specify/memory/constitution.md
sed -i '' 's/{{RATIFICATION_DATE}}/2025-12-04/g' .specify/memory/constitution.md
```

### Step 3: First Steps

After initialization, follow the on-screen instructions:

**1. Define Your Product Vision** (START HERE)
```bash
# In Claude Code - interactive workshop to capture YOUR ideas
/triad.vision
```

This will ask you 5 questions about your problem, users, and solution, then generate:
- `docs/product/01_Product_Vision/product-vision.md`
- `docs/product/01_Product_Vision/target-users.md`
- `docs/product/01_Product_Vision/competitive-landscape.md`

**2. Create Your First PRD**
```bash
# After vision is defined
/triad.prd <your-first-feature>
```

**3. Follow Spec Kit Workflow**
```bash
/triad.specify   # Define requirements with PM sign-off
/triad.plan      # Create technical plan with PM + Architect sign-off
/triad.tasks     # Generate tasks with triple sign-off
/triad.implement # Execute implementation with checkpoints
```

### Step 4: Build Your Product

After vision and first PRD, continue building:

```bash
# Product documentation (created automatically)
docs/product/01_Product_Vision/  # Created by /triad.vision
docs/product/02_PRD/             # Created by /triad.prd
docs/product/_backlog/           # Features deferred from MVP

# Add as you grow
docs/product/03_Product_Roadmap/ # Quarterly planning
docs/product/06_OKRs/            # Objectives and Key Results
```

**Tip**: When scoping your MVP, move non-essential features to `_backlog/` with notes on why they were deferred and when to revisit.

### Step 5: Initialize Git (If Not Already Done)

```bash
# Initialize repository
git init
git add .
git commit -m "feat(init): initialize product-led-spec-kit from template"

# Connect to remote
git remote add origin https://github.com/YOUR_ORG/your-project.git
git push -u origin main
```

---

## Modular Rules System

CLAUDE.md uses **@-references** to load governance rules from modular files, enabling:

- **Instant context loading** - Rules load automatically when agents read CLAUDE.md (<1 second vs 5-10 seconds with manual `cat` commands)
- **Topic-specific editing** - Edit `.claude/rules/git-workflow.md` without touching deployment or governance rules
- **No merge conflicts** - Team members can edit different rule files simultaneously
- **Concise overview** - CLAUDE.md is 70 lines (reduced from 192) with clear topic summaries

### How @-references Work

When an agent reads CLAUDE.md, lines like:
```markdown
@.claude/rules/governance.md
```

Are automatically expanded inline by Claude Code - no manual commands needed.

### Customizing Rules

Edit any rule file in `.claude/rules/` to customize governance for your team:

```bash
# Example: Customize git branch naming
vim .claude/rules/git-workflow.md

# Example: Add custom security rules
vim .claude/rules/security.md  # Create new file
# Then add @.claude/rules/security.md to CLAUDE.md
```

See [MIGRATION.md](MIGRATION.md) for detailed customization guide.

---

## How It Works

### SDLC Triad Collaboration

Every feature goes through structured collaboration:

**Phase 0: PRD Creation** (PM leads)
1. PM creates PRD using `/triad.prd` command
2. Architect provides infrastructure baseline (if deployment work)
3. Tech-Lead validates timeline and capacity
4. Architect reviews technical accuracy
5. PM finalizes PRD with Triad feedback

**Phase 1: Specification** (PM approves)
1. Create spec.md using `/triad.specify`
2. PM validates product alignment
3. Get PM sign-off before planning

**Phase 2: Planning** (PM + Architect approve)
1. Create plan.md using `/triad.plan`
2. PM validates product requirements met
3. Architect validates technical soundness
4. Get dual sign-off before task creation

**Phase 3: Task Breakdown** (PM + Architect + Tech-Lead approve)
1. Create tasks.md using `/triad.tasks`
2. PM validates prioritization aligns with product goals
3. Architect validates implementation approach
4. Tech-Lead generates agent assignments and timeline
5. Get triple sign-off before implementation

**Phase 4: Implementation** (with checkpoints)
1. Execute using `/triad.implement`
2. Automatic architect checkpoints at milestones
3. Validation gates prevent drift

**Phase 5: Closure**
1. Close feature using `/triad.close-feature`
2. Parallel documentation updates
3. Definition of Done validation

### Veto Authority Matrix

| Scenario | Who Can Veto | Grounds |
|----------|-------------|---------|
| PRD infrastructure claims | Architect | Claims contradict baseline |
| PRD technical approach | Architect | Technically infeasible |
| PRD timeline estimate | Tech-Lead | Ignores capacity constraints |
| spec.md product alignment | PM | Misaligned with vision/OKRs |
| plan.md architecture | Architect | Violates architecture principles |
| tasks.md timeline | Tech-Lead | Unrealistic breakdown |

---

## Key Commands

### Triad Commands (With Governance)
```bash
/triad.prd <topic>         # Create PRD with Triad validation
/triad.specify             # Create spec.md with PM sign-off
/triad.plan                # Create plan.md with PM + Architect sign-off
/triad.tasks               # Create tasks.md with triple sign-off
/triad.implement           # Execute with architect checkpoints
/triad.close-feature {NNN} # Close feature with documentation updates
```

### Vanilla Commands (Fast Prototyping)
```bash
/speckit.specify           # Create spec.md (no governance)
/speckit.plan              # Create plan.md (no governance)
/speckit.tasks             # Create tasks.md (no governance)
/speckit.implement         # Execute tasks (no checkpoints)
/speckit.analyze           # Verify cross-artifact consistency
```

---

## Core Principles (Universal)

The constitution contains 11 core principles:

1. **General-Purpose Architecture** - Domain-agnostic, works with any workflow
2. **API-First Design** - API contracts before UI/MCP implementation
3. **Backward Compatibility** - 100% local `.specify/` file support
4. **Concurrency & Data Integrity** - ACID guarantees, task locking
5. **Privacy & Data Isolation** - Per-user/org isolation, encryption at rest
6. **Testing Excellence** - Mandatory test coverage (80% minimum)
7. **Definition of Done** - 3-step validation (Deployed, Tested, User Validated)
8. **Observability & Root Cause Analysis** - Five Whys methodology
9. **Git Workflow** - Feature branches only, never commit to main
10. **Product-Spec Alignment** - PM + Architect dual sign-off
11. **SDLC Triad Collaboration** - PM + Architect + Tech-Lead workflow

**These principles are universal and should NOT be modified.** Customize only the System Architecture Constraints section.

---

## Syncing with Upstream

This template is a fork of [spec-kit](https://github.com/spec-kit-ops/spec-kit). To get upstream updates:

```bash
# Add upstream remote (one-time)
git remote add upstream https://github.com/spec-kit-ops/spec-kit.git

# Sync with upstream
git fetch upstream
git merge upstream/main

# Resolve conflicts (see docs/planning/FORK_SETUP.md)
```

**File Ownership**:
- **KEEP OURS**: `.specify/memory/constitution.md`, `docs/planning/FORK_SETUP.md`, `docs/product/`
- **ACCEPT THEIRS**: `.claude/`, `.specify/templates/`, `docs/core_principles/`
- **MANUAL MERGE**: `CLAUDE.md`, `.gitignore`, `Makefile`

See `docs/planning/FORK_SETUP.md` for detailed sync instructions.

---

## Documentation

- **Constitution**: `.specify/memory/constitution.md` - Governance principles
- **Migration Guide**: `MIGRATION.md` - How to customize modular rules
- **Fork Setup**: `docs/planning/FORK_SETUP.md` - How to sync with upstream
- **Triad Workflow**: `docs/core_principles/TRIAD_COLLABORATION.md` - Detailed collaboration guide (from upstream)
- **Product-Spec Alignment**: `docs/core_principles/PRODUCT_SPEC_ALIGNMENT.md` - PM sign-off process (from upstream)

---

## Contributing

### To This Template

Improvements to product-led governance:
1. Fork this repository
2. Create feature branch: `git checkout -b feature/improvement`
3. Make changes
4. Submit PR

### To Upstream Spec Kit

Improvements to core Spec Kit (benefits all users):
1. Fork `github.com/spec-kit-ops/spec-kit`
2. Make changes
3. Submit PR to upstream
4. After upstream accepts, sync to product-led-spec-kit

---

## License

[Add your license here - MIT, Apache 2.0, etc.]

---

## Support

- **Issues**: [GitHub Issues](https://github.com/YOUR_ORG/product-led-spec-kit/issues)
- **Discussions**: [GitHub Discussions](https://github.com/YOUR_ORG/product-led-spec-kit/discussions)
- **Upstream Spec Kit**: [spec-kit-ops/spec-kit](https://github.com/spec-kit-ops/spec-kit)

---

**Version**: 1.1.0
**Last Updated**: 2025-12-15
**Maintainer**: Architect Agent

### Changelog

**v1.1.0** (2025-12-15) - Modular Rules System
- Added `.claude/rules/` directory with 6 topic-specific governance files
- Refactored CLAUDE.md from 192 to 70 lines using @-references
- Added MIGRATION.md guide for customization
- Instant context loading (<1 second vs 5-10 seconds)

**v1.0.0** (2025-12-04) - Initial Release
- Product-led governance template
- SDLC Triad collaboration framework
- Templatized constitution
