<div align="center">

# Product-Led Spec Kit

**A governance-first development template with SDLC Triad collaboration**

[![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)](CHANGELOG.md)
[![Claude Code](https://img.shields.io/badge/Claude_Code-v2.1.16+-purple.svg)](https://claude.ai/claude-code)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

[Getting Started](#-quick-start) •
[Commands](#-commands) •
[How It Works](#-how-it-works) •
[Documentation](#-documentation) •
[Contributing](#-contributing)

</div>

---

## Why Product-Led Spec Kit?

Building software with AI agents? **Governance matters.** Product-Led Spec Kit ensures your AI-assisted development follows proper product management principles with clear sign-offs at every stage.

| Challenge | Solution |
|-----------|----------|
| AI agents making unauthorized decisions | **Triple sign-off** gates (PM → Architect → Team-Lead) |
| Specs drifting from product vision | **PM approval** required before any implementation |
| Technical debt from ungoverned changes | **Architect checkpoints** at every milestone |
| Unclear ownership and accountability | **SDLC Triad** with defined veto authority |

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🎯 Product-Led Governance
- PM-driven product vision and alignment
- Dual sign-off (PM + Architect) before implementation
- Feature specs linked to PRDs and OKRs

</td>
<td width="50%">

### 🔺 SDLC Triad Framework
- **PM**: Defines What & Why
- **Architect**: Defines How
- **Team-Lead**: Defines When & Who

</td>
</tr>
<tr>
<td width="50%">

### ⚡ Parallel Reviews (v2.0)
- Context forking for simultaneous reviews
- Triple sign-off executes in parallel
- Automatic result merging by severity

</td>
<td width="50%">

### 🛠️ Modular Rules System
- Concise CLAUDE.md (~80 lines)
- Topic-specific rule files in `.claude/rules/`
- Zero merge conflicts

</td>
</tr>
</table>

---

## 🚀 Quick Start

### Installation

```bash
# Clone the template
git clone https://github.com/davidmatousek/product-led-spec-kit.git my-project
cd my-project

# Run interactive setup
make init
```

The init script will prompt for your project details and configure everything automatically.

<details>
<summary><b>📋 Manual Setup</b></summary>

If you prefer manual configuration:

```bash
# Clone repository
git clone https://github.com/davidmatousek/product-led-spec-kit.git my-project
cd my-project

# Edit constitution with your project details
# Replace all {{PLACEHOLDER}} variables in:
vim .specify/memory/constitution.md
```

**Required variables:**
| Variable | Example |
|----------|---------|
| `{{PROJECT_NAME}}` | my-saas-platform |
| `{{PROJECT_DESCRIPTION}}` | AI-powered analytics dashboard |
| `{{TECH_STACK_DATABASE}}` | PostgreSQL |
| `{{TECH_STACK_VECTOR}}` | pgvector |
| `{{TECH_STACK_AUTH}}` | JWT |
| `{{RATIFICATION_DATE}}` | 2026-01-31 |

</details>

### Verify Installation

```bash
make check
```

### Your First Feature

```bash
# 1. Create your first PRD (includes optional vision workshop)
/triad.prd user-authentication

# 2. Follow the Spec Kit workflow
/triad.specify    # Define requirements → PM sign-off
/triad.plan       # Technical design → PM + Architect sign-off
/triad.tasks      # Task breakdown → Triple sign-off
/triad.implement  # Execute with checkpoints
```

---

## 📖 Commands

### Triad Commands (Recommended)

Full governance with automatic sign-offs at each stage.

| Command | Description | Sign-offs |
|---------|-------------|-----------|
| `/triad.prd <topic>` | Create PRD (includes optional vision workshop) | Triad review |
| `/triad.specify` | Create spec.md | PM |
| `/triad.plan` | Create plan.md | PM + Architect |
| `/triad.tasks` | Create tasks.md | PM + Architect + Team-Lead |
| `/triad.implement` | Execute with checkpoints | Architect gates |
| `/triad.close-feature` | Close with doc updates | — |

### Vanilla Commands

Fast prototyping without governance gates.

| Command | Description |
|---------|-------------|
| `/speckit.specify` | Create spec.md |
| `/speckit.plan` | Create plan.md |
| `/speckit.tasks` | Create tasks.md |
| `/speckit.implement` | Execute tasks |
| `/speckit.analyze` | Verify consistency |

---

## 🔄 How It Works

```mermaid
flowchart LR
    subgraph "Phase 0: PRD"
        A["/triad.prd"] --> B{Triad Review}
    end

    subgraph "Phase 1: Specify"
        B --> C["/triad.specify"]
        C --> D{PM Sign-off}
    end

    subgraph "Phase 2: Plan"
        D --> E["/triad.plan"]
        E --> F{PM + Architect}
    end

    subgraph "Phase 3: Tasks"
        F --> G["/triad.tasks"]
        G --> H{Triple Sign-off}
    end

    subgraph "Phase 4: Implement"
        H --> I["/triad.implement"]
        I --> J[Architect Checkpoints]
    end

    J --> K["/triad.close-feature"]
```

### Sign-off Requirements

| Artifact | Required Approvals | Purpose |
|----------|-------------------|---------|
| `spec.md` | PM | Product alignment |
| `plan.md` | PM + Architect | Technical soundness |
| `tasks.md` | PM + Architect + Team-Lead | Execution readiness |

### Veto Authority

| Scenario | Who Can Veto | Grounds |
|----------|-------------|---------|
| PRD infrastructure claims | Architect | Contradicts baseline |
| PRD technical approach | Architect | Technically infeasible |
| PRD timeline estimate | Team-Lead | Ignores capacity |
| spec.md alignment | PM | Misaligned with vision |
| plan.md architecture | Architect | Violates principles |
| tasks.md timeline | Team-Lead | Unrealistic breakdown |

---

## 📁 Project Structure

```
product-led-spec-kit/
├── .claude/
│   ├── agents/           # 13 specialized agents
│   ├── skills/           # Automation capabilities
│   ├── commands/         # Triad + Vanilla commands
│   └── rules/            # Modular governance rules
│       ├── governance.md
│       ├── git-workflow.md
│       ├── deployment.md
│       └── ...
├── .specify/
│   ├── spec.md           # Feature specification
│   ├── plan.md           # Technical design
│   ├── tasks.md          # Task breakdown
│   └── memory/
│       └── constitution.md  # ← CUSTOMIZE THIS
├── docs/
│   ├── product/          # Vision, PRDs, roadmaps
│   ├── architecture/     # System design, ADRs
│   ├── devops/           # Deployment guides
│   └── core_principles/  # Methodologies
├── specs/                # Per-feature specifications
├── CLAUDE.md             # AI agent context
└── CHANGELOG.md          # Version history
```

---

## 🏛️ Core Principles

<details>
<summary><b>View all 11 governance principles</b></summary>

1. **General-Purpose Architecture** — Domain-agnostic, works with any workflow
2. **API-First Design** — API contracts before UI/MCP implementation
3. **Backward Compatibility** — 100% local `.specify/` file support
4. **Concurrency & Data Integrity** — ACID guarantees, task locking
5. **Privacy & Data Isolation** — Per-user/org isolation, encryption at rest
6. **Testing Excellence** — Mandatory test coverage (80% minimum)
7. **Definition of Done** — 3-step validation (Deployed, Tested, User Validated)
8. **Observability & Root Cause Analysis** — Five Whys methodology
9. **Git Workflow** — Feature branches only, never commit to main
10. **Product-Spec Alignment** — PM + Architect dual sign-off
11. **SDLC Triad Collaboration** — PM + Architect + Tech-Lead workflow

> **Note:** These principles are universal. Customize only the System Architecture Constraints section in the constitution.

</details>

---

## 📚 Documentation

| Document | Purpose |
|----------|---------|
| [Constitution](.specify/memory/constitution.md) | Governance principles (customize this) |
| [CHANGELOG](CHANGELOG.md) | Version history |
| [MIGRATION](MIGRATION.md) | Upgrade guide |
| [Triad Workflow](docs/SPEC_KIT_TRIAD.md) | Collaboration guide |

---

## 🔄 Syncing with Upstream

This template extends [Spec Kit](https://github.com/spec-kit-ops/spec-kit). To get upstream updates:

```bash
# Add upstream remote (one-time)
git remote add upstream https://github.com/spec-kit-ops/spec-kit.git

# Sync with upstream
git fetch upstream
git merge upstream/main
```

<details>
<summary><b>File ownership during merge</b></summary>

| Keep Yours | Accept Theirs | Manual Merge |
|------------|---------------|--------------|
| `.specify/memory/constitution.md` | `.claude/` | `CLAUDE.md` |
| `docs/product/` | `.specify/templates/` | `.gitignore` |
| `docs/planning/FORK_SETUP.md` | `docs/core_principles/` | `Makefile` |

</details>

---

## 🤝 Contributing

### To This Template

```bash
# Fork and clone
git clone https://github.com/YOUR_USERNAME/product-led-spec-kit.git
cd product-led-spec-kit

# Create feature branch
git checkout -b feature/your-improvement

# Make changes and submit PR
```

### To Upstream Spec Kit

Improvements benefiting all users should go to [spec-kit-ops/spec-kit](https://github.com/spec-kit-ops/spec-kit).

---

## 📄 License

This project is licensed under the MIT License — see [LICENSE](LICENSE) for details.

---

## 💬 Support

- **Issues**: [GitHub Issues](https://github.com/davidmatousek/product-led-spec-kit/issues)
- **Discussions**: [GitHub Discussions](https://github.com/davidmatousek/product-led-spec-kit/discussions)
- **Upstream**: [spec-kit-ops/spec-kit](https://github.com/spec-kit-ops/spec-kit)

---

<div align="center">

**[⬆ Back to Top](#product-led-spec-kit)**

Made with the SDLC Triad: PM + Architect + Team-Lead

</div>
