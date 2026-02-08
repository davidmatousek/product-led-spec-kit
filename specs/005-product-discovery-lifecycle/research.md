# Research Summary: Product Discovery Lifecycle (PDL)

**Feature**: 005 - Product Discovery Lifecycle
**PRD**: docs/product/02_PRD/005-product-discovery-lifecycle-2026-02-07.md
**Date**: 2026-02-07

---

## Knowledge Base Findings

- No existing KB entries for product discovery, ICE scoring, or backlog management workflows
- Existing KB patterns focus on architecture, performance, and RCA categories
- KB infrastructure supports manual file-based entries with quality scoring
- Recommendation: Create KB entries for PDL patterns post-implementation

## Codebase Analysis

### Existing Skill Structure
- 10 skills in `.claude/skills/`: architecture-validator, code-execution-helper, git-workflow-helper, implementation-checkpoint, kb-create, kb-query, prd-create, root-cause-analyzer, spec-validator, thinking-lens
- SKILL.md format: Minimal frontmatter (name + description), imperative instructions, <500 lines
- Key pattern: `prd-create` skill wrapped by `triad.prd` command — PDL skills should follow same pattern

### Command Wrapper Pattern
- 11 commands in `.claude/commands/`: triad.prd, triad.specify, triad.plan, triad.tasks, triad.implement, triad.close-feature, triad.clarify, triad.analyze, triad.checklist, triad.constitution, execute, continue
- Format: YAML frontmatter (description), structured steps, quality checklist
- PDL commands (`pdl.run`, `pdl.idea`, `pdl.score`, `pdl.validate`) need both skills and command wrappers

### Backlog Structure
- Current: `docs/product/_backlog/README.md` with individual file template (deferred features)
- PDL will restructure to consolidated tables: `01_IDEAS.md` + `02_USER_STORIES.md`
- Migration guidance needed for adopters with existing individual backlog files

### Source Material (CISO_Agent)
- Proven PDL implementation exists at `/Users/david/Projects/CISO_Agent/`
- Commands: pdl.idea, pdl.score, pdl.validate, pdl.run
- Documentation: PDL_QUICKSTART.md, PDL_TRIAD_LIFECYCLE.md
- Key delta: Source uses `02_PRODUCT_BACKLOG.md` / `PDL-NNN`; this project uses `02_USER_STORIES.md` / `US-NNN`

## Architecture Constraints

### Constitution Compliance
- **Principle III (Local-First)**: All PDL data in markdown files — no databases or external services
- **Principle VI (Testing)**: PDL skills need test coverage
- **Principle IX (Git Workflow)**: Branch `005-product-discovery-lifecycle`
- **Principle X (Product-Spec Alignment)**: PRD approved before spec
- **Principle XI (Triad Collaboration)**: PM owns discovery; Architect not involved until PRD phase

### Governance Model
- PDL is a **pre-Triad workflow** — PM has sole validation authority
- PDL is **optional** — teams can still start at `/triad.prd`
- ICE scoring provides auto-defer gate (score < 12)
- PM can override auto-defer with documented rationale

### Technical Constraints
- Skills must follow Anthropic Agent Skills open standard (SKILL.md)
- No `triggers`, `allowed-tools`, or non-standard frontmatter fields
- Single-user/single-agent assumption for markdown table ID generation
- No file-level locking mechanism

## Industry Research

### ICE Scoring Best Practices
- ICE = Impact × Confidence × Ease (some use additive: I + C + E)
- PRD uses **additive** model (max 30) which is simpler and sufficient for discovery
- Quick assessment (High/Med/Low → 9/6/3) reduces friction vs. 1-10 granularity
- Common pitfall: Inconsistent interpretation of scores across evaluators
- Mitigation: Provide clear anchors for each level

### Product Discovery Patterns
- Industry standard: Explore problem → Brainstorm → Prototype → Test → Select
- PDL maps to lightweight version: Capture → Score → Validate → Backlog
- Marty Cagan's four questions: Valuable? Usable? Feasible? Strategic?
- Key principle: Spend time understanding the problem before jumping to solutions

### Prioritization Framework Comparison
- ICE best for: Quick pre-work prioritization (matches PDL use case)
- RICE better for: Comprehensive roadmap planning (adds Reach dimension)
- MoSCoW better for: MVP scope definition
- PDL correctly uses ICE for lightweight discovery gate

### References
- [ProductPlan: ICE Scoring Model](https://www.productplan.com/glossary/ice-scoring-model/)
- [Airfocus: 5 Stages of Product Discovery](https://airfocus.com/product-learn/5-stages-product-discovery/)
- [Productboard: Product Discovery Framework](https://www.productboard.com/blog/step-by-step-framework-for-better-product-discovery/)

## Recommendations for Spec

1. **Address all 6 Triad review concerns** from PRD (3 Architect + 3 Team-Lead)
2. **Define user story transformation step explicitly** — net-new logic not in source
3. **Align ICE documentation**: Additive scoring (I+C+E, max 30), quick-assessment anchors, consistent thresholds
4. **Include migration guidance** for backlog restructure (individual files → consolidated tables)
5. **Document single-user assumption** for ID generation without file locking
6. **Specify command wrapper pattern** — each skill needs a `.claude/commands/pdl.*.md` wrapper
7. **Keep PDL optional** — no enforcement gate before `/triad.prd`
8. **Use "As a... I want... so that..." format** for user stories (not feature descriptions)
