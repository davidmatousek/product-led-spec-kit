---
prd:
  number: 5
  topic: product-discovery-lifecycle
  created: 2026-02-07
  status: Approved
  type: feature
triad:
  pm_signoff:
    agent: product-manager
    date: 2026-02-07
    status: APPROVED
    notes: "PDL strengthens the product-led promise by adding structured discovery before delivery. Well-scoped adaptation of proven framework."
  architect_signoff:
    agent: architect
    date: 2026-02-07
    status: APPROVED_WITH_CONCERNS
    notes: "Architecture is sound. Three concerns for spec phase: (1) Skills need command wrappers in .claude/commands/ for user-facing /pdl.* invocation; (2) Backlog restructure from individual files to consolidated tables needs migration note; (3) Document single-user assumption for ID generation."
  techlead_signoff:
    agent: team-lead
    date: 2026-02-07
    status: APPROVED_WITH_CONCERNS
    notes: "Feasible, 6-8 hours realistic estimate. Three concerns: (1) Naming delta from source (PRODUCT_BACKLOG→USER_STORIES) requires careful adaptation; (2) User story generation is net-new logic not present in source; (3) ICE score range consistency (1-10 theoretical vs 9/6/3 quick-assessment) needs alignment."
---

# Product Discovery Lifecycle (PDL) - Product Requirements Document

**Status**: Approved
**Created**: 2026-02-07
**Author**: product-manager
**Reviewers**: architect, team-lead
**Priority**: P1 (High)

---

## Executive Summary

### The One-Liner
Add a structured idea-to-backlog discovery workflow (PDL) that answers "Should we build this?" before the Triad answers "How do we build this?"

### Problem Statement
Product-Led Spec Kit currently starts at `/triad.prd` — assuming the decision to build has already been made. There is no structured process for capturing raw ideas, scoring their value, converting them to user stories, or maintaining a prioritized product backlog. Teams jump straight into PRD creation without a discovery phase, leading to wasted effort on low-value features and missing a critical governance gate.

### Proposed Solution
Import and adapt the proven Product Discovery Lifecycle (PDL) framework from the CISO_Agent project. PDL adds four stages before the Triad workflow: Idea Capture, ICE Scoring, PM Validation, and Product Backlog management. This creates complete traceability from raw idea to shipped feature.

### Success Criteria
- All new features pass through PDL discovery before PRD creation
- ICE scoring auto-defers low-value ideas (score < 12)
- Complete traceability chain: IDEA → User Story → PRD → spec → plan → tasks → code
- PDL commands (`/pdl.run`, `/pdl.idea`, `/pdl.score`, `/pdl.validate`) are functional and documented

---

## Strategic Alignment

### Product Vision Alignment
Product-Led Spec Kit is a product-led development methodology template. Adding PDL strengthens the "product-led" promise by ensuring every feature starts with a product decision, not a technical one.

### Roadmap Fit
PDL fills the gap between "someone has an idea" and "let's write a PRD." It's the missing first phase of the complete product delivery lifecycle.

---

## Target Users & Personas

### Primary Persona: Template Adopter (Developer/Tech Lead)
- **Role**: Developer or tech lead using Product-Led Spec Kit for their project
- **Pain Points**: No structured way to capture and evaluate ideas before committing to PRD creation; ideas get lost or pursued without prioritization
- **Goals**: Systematic idea evaluation, clear prioritization, reduced wasted effort on low-value features
- **How PDL Helps**: Provides lightweight discovery workflow that filters ideas before heavy Triad governance kicks in

### Secondary Persona: Product Manager (or PM-wearing-developer)
- **Role**: Person responsible for product decisions in a project using this template
- **Pain Points**: No central place to track ideas, no scoring framework, no formal validation gate
- **How PDL Helps**: Gives PM a structured framework (ICE scoring) and validation authority over what enters the backlog

---

## User Stories

### US-001: Capture and Score an Idea
**When** I have a new feature idea during development or brainstorming,
**I want to** capture it with an ICE score in a structured format,
**So I can** evaluate it against other ideas without losing it or making ad-hoc decisions.

**Acceptance Criteria**:
- Given a user runs `/pdl.idea <description>`, when the command completes, then an entry is added to `docs/product/_backlog/01_IDEAS.md` with unique ID, description, date, ICE score, and status
- Given the ICE score is calculated, when the total is < 12, then the idea is auto-deferred
- Given the ICE score is calculated, when the total is >= 12, then the idea status is set to "Scoring"

**Priority**: P0
**Effort**: M

### US-002: Run Full Discovery Flow
**When** I have a feature idea I want to evaluate end-to-end,
**I want to** run a single command that captures, scores, validates, and adds to the backlog,
**So I can** go from raw idea to "Ready for PRD" in one step.

**Acceptance Criteria**:
- Given a user runs `/pdl.run <description>`, when the flow completes, then the idea is captured, scored, validated by PM, and added to the product backlog
- Given the ICE score is >= 12, when PM approves, then a user story entry is created in `docs/product/_backlog/02_USER_STORIES.md`
- Given the flow completes successfully, when the user checks the backlog, then the entry shows status "Ready for PRD"

**Priority**: P0
**Effort**: L

### US-003: Validate a Deferred or Scored Idea
**When** I want to promote a previously scored or deferred idea to the product backlog,
**I want to** run PM validation on it,
**So I can** move it forward to PRD creation even if it was auto-deferred.

**Acceptance Criteria**:
- Given a user runs `/pdl.validate IDEA-NNN`, when PM approves, then the idea status updates to "Validated" and a user story is created in the backlog
- Given a user runs `/pdl.validate` on an auto-deferred idea, when PM approves, then the override is documented with rationale

**Priority**: P1
**Effort**: S

### US-004: Re-Score an Existing Idea
**When** circumstances have changed since an idea was first scored,
**I want to** re-evaluate its ICE score,
**So I can** promote or deprioritize it based on current context.

**Acceptance Criteria**:
- Given a user runs `/pdl.score IDEA-NNN`, when new scores are provided, then the IDEAS.md entry is updated with new scores and date
- Given the new score changes priority tier, when the update completes, then the status reflects the new tier

**Priority**: P2
**Effort**: S

### US-005: Complete Traceability from Idea to PRD
**When** I create a PRD using `/triad.prd`,
**I want to** link it back to the source idea and user story,
**So I can** trace any feature back to its original motivation and validation.

**Acceptance Criteria**:
- Given a PRD is created from a backlog item, when the PRD frontmatter is generated, then it includes `source.idea_id` and `source.story_id` fields
- Given a user views the traceability chain, when they follow links, then they can navigate: IDEA → User Story → PRD → spec → plan → tasks

**Priority**: P1
**Effort**: M

---

## Functional Requirements

### FR-1: Ideas Management (01_IDEAS.md)

**Description**: Structured capture and tracking of raw ideas with ICE scoring.

**File Location**: `docs/product/_backlog/01_IDEAS.md`

**Data Model**:
| Field | Type | Description |
|-------|------|-------------|
| ID | IDEA-NNN | Auto-incremented unique identifier |
| Idea | text | Natural language description |
| Source | enum | Brainstorm, Customer Feedback, Team Idea, User Request |
| Date | date | Capture date (YYYY-MM-DD) |
| Status | enum | New, Scoring, Validated, Deferred, Rejected |
| ICE Score | composite | Total (I:n C:n E:n) |

**Business Rules**:
- ICE Total = Impact + Confidence + Effort (each 1-10, max 30)
- Score < 12: Auto-defer with status "Deferred"
- Score 12-17: P2 (Medium) - Consider when capacity allows
- Score 18-24: P1 (High) - Queue for next sprint
- Score 25-30: P0 (Critical) - Fast-track to development

### FR-2: User Stories / Product Backlog (02_USER_STORIES.md)

**Description**: Validated ideas converted to user story format with prioritization.

**File Location**: `docs/product/_backlog/02_USER_STORIES.md`

**Data Model**:
| Field | Type | Description |
|-------|------|-------------|
| Priority | int | Rank order (1 = highest) |
| Story ID | US-NNN | Auto-incremented unique identifier |
| Story | text | "As a... I want... so that..." format |
| ICE Score | int | Carried from source idea |
| Source | ref | IDEA-NNN reference |
| Status | enum | Ready for PRD, In PRD, In Development, Delivered |

**Business Rules**:
- Only PM-validated ideas become user stories
- User stories use "As a [persona], I want [action], so that [benefit]" format
- Stories are prioritized by ICE score initially, PM can reorder

### FR-3: ICE Scoring Framework

**Description**: Three-dimensional scoring system for idea prioritization.

**Scoring Dimensions**:
| Dimension | Scale | Question | Quick Assessment |
|-----------|-------|----------|-----------------|
| Impact | 1-10 | How much value does this deliver? | High(9): Transformative, Med(6): Solid improvement, Low(3): Minor enhancement |
| Confidence | 1-10 | How sure are we this will work? | High(9): Proven pattern, Med(6): Some unknowns, Low(3): Speculative |
| Effort | 1-10 | How easy is this to build? (10=easy) | High(9): Days, Med(6): Weeks, Low(3): Months |

**Auto-Defer Gate**: Total < 12 → auto-deferred (can be overridden by PM via `/pdl.validate`)

### FR-4: PDL Commands (Skills)

Four skills to be created in `.claude/skills/`:

| Command | Skill Directory | Purpose | Input | Output |
|---------|----------------|---------|-------|--------|
| `/pdl.run <idea>` | `pdl-run/` | Full discovery flow | Idea description | Product Backlog entry |
| `/pdl.idea <idea>` | `pdl-idea/` | Capture + score | Idea description | IDEAS.md entry |
| `/pdl.score <id>` | `pdl-score/` | Re-score existing | IDEA-NNN | Updated ICE score |
| `/pdl.validate <id>` | `pdl-validate/` | PM validation gate | IDEA-NNN | User Story + Backlog entry |

### FR-5: PDL → Triad Handoff

**Description**: Clean handoff from discovery to delivery.

**Handoff Point**: Product Backlog entry with status "Ready for PRD"

**Flow**:
```
PDL completes                          Triad begins
─────────────────────────────          ─────────────────────────────
/pdl.run "Add dark mode"               /triad.prd dark-mode
    │                                      │
    ├── IDEA-001 captured                  ├── PRD with sign-offs
    ├── ICE: 24                            ├── /triad.specify
    ├── PM approved                        ├── /triad.plan
    └── US-001 in Product Backlog ════▶    ├── /triad.tasks
                                           └── /triad.implement
        "Ready for PRD"                        "Feature shipped"
```

**Traceability in PRD Frontmatter**:
```yaml
source:
  idea_id: IDEA-001
  story_id: US-001
```

### FR-6: Documentation

**Description**: Guide documentation for the PDL workflow.

**Deliverables**:
| Document | Location | Purpose |
|----------|----------|---------|
| PDL Quickstart Guide | `docs/guides/PDL_QUICKSTART.md` | Quick reference for PDL usage |
| PDL + Triad Lifecycle | `docs/guides/PDL_TRIAD_LIFECYCLE.md` | Complete lifecycle documentation |
| Backlog README update | `docs/product/_backlog/README.md` | Updated to reflect PDL structure |

---

## Scope & Boundaries

### In Scope (This PRD)

**Must Have (P0)**:
- `01_IDEAS.md` structure with ICE scoring table
- `02_USER_STORIES.md` structure with prioritized backlog
- `/pdl.run` skill (full discovery flow)
- `/pdl.idea` skill (capture + score)
- `/pdl.score` skill (re-score existing)
- `/pdl.validate` skill (PM validation gate)
- PDL Quickstart documentation
- PDL + Triad Lifecycle documentation
- Updated `_backlog/README.md`

**Should Have (P1)**:
- Source traceability fields in PRD frontmatter (`source.idea_id`, `source.story_id`)
- Status flow updates across artifacts (IDEA status updates when PRD starts)

### Out of Scope

**Won't Have** - Explicitly excluded:
- Automated PDL-to-Triad pipeline (handoff remains manual via `/triad.prd`)
- Web UI for idea management (local files only per Constitution Principle III)
- Integration with external issue trackers (Jira, Linear, etc.)
- Multi-project backlog aggregation
- Historical analytics or reporting on ICE scores

### Assumptions
- Adopters will customize the PDL workflow to their team's needs (it's a template)
- ICE scoring thresholds (12 for auto-defer) are sensible defaults; adopters can adjust
- The `_backlog/` directory already exists in the project structure

### Constraints
- **Local-first**: All data stored in markdown files per Constitution Principle III
- **Template-only**: No application code; this is methodology and governance
- **Skills format**: Must follow Anthropic Agent Skills open standard (SKILL.md frontmatter)
- **Existing structure**: Must integrate with existing `docs/product/_backlog/` directory

---

## Risks & Dependencies

### Risks

**Risk 1**: PDL adds overhead that discourages adoption
- **Likelihood**: Medium
- **Impact**: Medium
- **Mitigation**: `/pdl.run` provides single-command fast path; PDL is optional (teams can still start at `/triad.prd`)

**Risk 2**: ICE scoring feels arbitrary for solo developers
- **Likelihood**: Medium
- **Impact**: Low
- **Mitigation**: Provide quick assessment options (High/Medium/Low) that map to numeric scores; scoring is guidance, not gatekeeping

**Risk 3**: Backlog files grow unwieldy with many ideas
- **Likelihood**: Low
- **Impact**: Low
- **Mitigation**: Include archival guidance in documentation; status-based filtering

### Dependencies

**Internal Dependencies**:
- Existing `docs/product/_backlog/` directory structure
- `.claude/skills/` directory for skill definitions
- Triad workflow commands (for handoff integration)

**External Dependencies**: None

---

## Open Questions

- [x] Should PDL be mandatory or optional before `/triad.prd`? → **Optional** (teams can still start directly at `/triad.prd`; PDL is recommended but not enforced)
- [ ] Should we add a `docs/product/_backlog/03_ARCHIVE.md` for completed/rejected ideas? → Owner: PM, deferred to implementation

---

## References

### Source Material
- CISO_Agent PDL Quickstart: `/Users/david/Projects/CISO_Agent/docs/guides/PDL_QUICKSTART.md`
- CISO_Agent PDL+Triad Lifecycle: `/Users/david/Projects/CISO_Agent/docs/guides/PDL_TRIAD_LIFECYCLE.md`

### Product Documentation
- Product Vision: `docs/product/01_Product_Vision/README.md`
- PRD Index: `docs/product/02_PRD/INDEX.md`
- Backlog: `docs/product/_backlog/README.md`
- Triad Guide: `docs/SPEC_KIT_TRIAD.md`

### Governance
- Constitution: `.specify/memory/constitution.md`
- SKILL.md Standard: Anthropic Agent Skills open standard (agentskills.io)

---

## Triad Review Findings (Address in Spec Phase)

### Architect Concerns
1. **Skills need command wrappers** (Medium): PDL skills in `.claude/skills/pdl-*/` need corresponding command files in `.claude/commands/` (e.g., `pdl.run.md`, `pdl.idea.md`) for user-facing `/pdl.*` invocation, matching the existing `prd-create` → `triad.prd` pattern.
2. **Backlog migration note** (Low): The restructure from individual backlog files to consolidated tables should include guidance for adopters who may have existing individual files.
3. **Concurrent edit safety** (Low): Document single-user/single-agent assumption for markdown table ID generation since there is no file-level locking.

### Team-Lead Concerns
1. **Naming delta** (Medium): Source uses `02_PRODUCT_BACKLOG.md` / `PDL-NNN`; PRD specifies `02_USER_STORIES.md` / `US-NNN`. All references in adapted skills must be updated.
2. **User story generation is net-new** (Medium): Source produces feature descriptions, not "As a... I want... so that..." format. The pdl-validate and pdl-run skills must include an explicit transformation step to generate user stories.
3. **ICE score consistency** (Low): Ensure consistent documentation between theoretical 1-10 scale and practical High(9)/Medium(6)/Low(3) quick-assessment prompts.

---

## Approval & Sign-Off

| Role | Agent | Status | Date | Comments |
|------|-------|--------|------|----------|
| Product Manager | product-manager | ✅ Approved | 2026-02-07 | PDL strengthens product-led governance |
| Architect | architect | ⚠ Approved with Concerns | 2026-02-07 | 3 concerns for spec phase (see above) |
| Team Lead | team-lead | ⚠ Approved with Concerns | 2026-02-07 | 3 concerns for spec phase (see above) |

---

## Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-02-07 | product-manager | Initial PRD |
