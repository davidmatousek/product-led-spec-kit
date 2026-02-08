---
prd_reference: docs/product/02_PRD/005-product-discovery-lifecycle-2026-02-07.md
triad:
  pm_signoff:
    agent: product-manager
    date: 2026-02-07
    status: APPROVED
    notes: "All PRD requirements (FR-1 through FR-6) fully addressed with expanded acceptance criteria. All five user stories covered with given/when/then scenarios. Scope aligned — FR-7 (backlog auto-creation) and Scenario 6 (first-time setup) are justified additions, not scope creep. Success criteria measurable and correctly adjusted for optional PDL (NFR-1). All six Triad review concerns (3 Architect + 3 Team-Lead) explicitly resolved. Ready for planning."
  architect_signoff: null  # Added by /triad.plan
  techlead_signoff: null   # Added by /triad.tasks
---

# Feature Specification: Product Discovery Lifecycle (PDL)

**Status**: Approved
**Feature Number**: 005
**PRD Reference**: [005-product-discovery-lifecycle-2026-02-07.md](../../docs/product/02_PRD/005-product-discovery-lifecycle-2026-02-07.md)
**Created**: 2026-02-07
**Author**: Specification generated from PRD

---

## 1. Feature Overview

### 1.1 Problem Statement

Product-Led Spec Kit currently starts at `/triad.prd` — assuming the decision to build a feature has already been made. There is no structured process for:

1. **Capturing raw ideas** during development, brainstorming, or user feedback sessions
2. **Evaluating idea value** against other ideas using a consistent scoring framework
3. **Validating ideas** with product management before committing to PRD creation
4. **Maintaining a prioritized product backlog** of validated user stories ready for development

Without a discovery phase, teams jump straight into PRD creation. This leads to wasted effort on low-value features, inconsistent prioritization decisions, and no traceability from the original idea through to the shipped feature.

### 1.2 Proposed Solution

Add a Product Discovery Lifecycle (PDL) that provides four stages before the Triad workflow begins:

1. **Idea Capture**: Record raw ideas with structured metadata in a central ideas list
2. **ICE Scoring**: Score each idea on Impact, Confidence, and Effort to determine priority tier
3. **PM Validation**: Product Manager reviews scored ideas and approves promotion to the product backlog
4. **Product Backlog**: Validated ideas are converted to user stories and maintained in a prioritized backlog

PDL is implemented as four commands (`/pdl.run`, `/pdl.idea`, `/pdl.score`, `/pdl.validate`) backed by skills in `.claude/skills/pdl-*/`. The workflow is **optional** — teams can still start directly at `/triad.prd` — but recommended for product-led discipline.

### 1.3 Target Users

**Primary**: Template Adopter (Developer/Tech Lead)
- Currently has no structured way to capture and evaluate ideas before PRD creation
- Ideas get lost, pursued without prioritization, or evaluated ad hoc
- Benefits from a lightweight discovery workflow that filters ideas before Triad governance

**Secondary**: Product Manager (or PM-wearing-developer)
- Currently lacks a central place to track ideas, a scoring framework, or a formal validation gate
- Benefits from ICE scoring framework and validation authority over what enters the backlog

---

## 2. User Scenarios & Testing

### Scenario 1: Capture and Score an Idea

**Actor**: Template Adopter
**Goal**: Record a new feature idea with an ICE score

**Given** a user has a feature idea during development or brainstorming
**When** they run `/pdl.idea "Add dark mode support for the dashboard"`
**Then** an entry is added to `docs/product/_backlog/01_IDEAS.md` with a unique IDEA-NNN identifier, description, source, date, ICE score, and status
**And** the system prompts for ICE score input using quick-assessment options (High/Medium/Low for each dimension)
**And** if the total ICE score is below 12, the idea is auto-deferred with status "Deferred"
**And** if the total ICE score is 12 or above, the idea status is set to "Scoring"

**Acceptance Criteria**:
- New row appended to the IDEAS table with auto-incremented IDEA-NNN identifier
- ICE score recorded as composite: Total (I:n C:n E:n)
- Status correctly set based on auto-defer threshold (< 12 = Deferred, >= 12 = Scoring)
- Source field captured (Brainstorm, Customer Feedback, Team Idea, or User Request)
- Date set to current date in YYYY-MM-DD format

### Scenario 2: Run Full Discovery Flow

**Actor**: Template Adopter
**Goal**: Take an idea from capture to backlog-ready in one step

**Given** a user has a feature idea they want to evaluate end-to-end
**When** they run `/pdl.run "User authentication with OAuth2 support"`
**Then** the idea is captured in `01_IDEAS.md` with ICE scoring
**And** if the ICE score is >= 12, PM validation is automatically invoked
**And** if PM approves, a user story is generated in "As a... I want... so that..." format
**And** the user story is added to `docs/product/_backlog/02_USER_STORIES.md` with status "Ready for PRD"
**And** the idea status in `01_IDEAS.md` is updated to "Validated"

**Acceptance Criteria**:
- Full flow executes: capture → score → validate → backlog entry
- Auto-deferred ideas (score < 12) stop after scoring with guidance to use `/pdl.validate` for override
- PM validation uses the product-manager agent for review
- User story follows "As a [persona], I want [action], so that [benefit]" format
- Traceability maintained: user story references source IDEA-NNN

### Scenario 3: Validate a Deferred Idea

**Actor**: Template Adopter
**Goal**: Promote a previously deferred or scored idea to the product backlog

**Given** an idea IDEA-003 exists with status "Deferred" (ICE score of 10)
**When** the user runs `/pdl.validate IDEA-003`
**Then** the PM agent reviews the idea and provides approval or rejection
**And** if PM approves, the idea status updates to "Validated" in `01_IDEAS.md`
**And** a user story is generated and added to `02_USER_STORIES.md`
**And** the override is documented with PM rationale

**Acceptance Criteria**:
- PM agent invoked with idea details for validation
- Override of auto-defer is documented with PM rationale in the user story entry
- Idea status in `01_IDEAS.md` updated to "Validated"
- User story created with proper format and source reference

### Scenario 4: Re-Score an Existing Idea

**Actor**: Template Adopter
**Goal**: Update an idea's ICE score when circumstances change

**Given** an idea IDEA-005 exists with an outdated ICE score
**When** the user runs `/pdl.score IDEA-005`
**Then** the system prompts for new ICE scores using quick-assessment options
**And** the `01_IDEAS.md` entry is updated with new scores and current date
**And** if the new score changes the priority tier (e.g., from Deferred to Scoring), the status updates accordingly

**Acceptance Criteria**:
- Existing IDEAS.md entry updated in place (not duplicated)
- New ICE score, date, and status recorded
- If score crosses auto-defer threshold, status changes appropriately
- Previous score is replaced (no score history maintained in table)

### Scenario 5: PDL to Triad Handoff

**Actor**: Template Adopter
**Goal**: Create a PRD from a validated backlog item

**Given** a user story US-001 exists in `02_USER_STORIES.md` with status "Ready for PRD"
**When** the user runs `/triad.prd` for that feature
**Then** the PRD frontmatter includes `source.idea_id` and `source.story_id` traceability fields
**And** the user story status in `02_USER_STORIES.md` updates to "In PRD"

**Acceptance Criteria**:
- PRD frontmatter contains source traceability fields linking back to PDL artifacts
- User story status updated when PRD creation begins
- Complete traceability chain maintained: IDEA → User Story → PRD → spec → plan → tasks

### Scenario 6: First-Time PDL Setup

**Actor**: Template Adopter
**Goal**: Set up PDL backlog files for the first time

**Given** a new project has no `01_IDEAS.md` or `02_USER_STORIES.md` files
**When** the user runs any PDL command for the first time
**Then** the command creates `docs/product/_backlog/01_IDEAS.md` with the IDEAS table header
**And** the command creates `docs/product/_backlog/02_USER_STORIES.md` with the USER STORIES table header
**And** the `_backlog/README.md` is updated to reflect the PDL structure

**Acceptance Criteria**:
- Missing backlog files are auto-created with proper table structure
- Existing individual backlog feature files are preserved (not deleted)
- README.md updated with PDL workflow description

---

## 3. Functional Requirements

### FR-1: Ideas Management (01_IDEAS.md)

**Description**: Structured capture and tracking of raw ideas with ICE scoring in a consolidated markdown table.

**File Location**: `docs/product/_backlog/01_IDEAS.md`

**Table Structure**:
| Field | Format | Description |
|-------|--------|-------------|
| ID | IDEA-NNN | Auto-incremented unique identifier (NNN = zero-padded 3-digit) |
| Idea | Text | Natural language description of the feature idea |
| Source | Enum | One of: Brainstorm, Customer Feedback, Team Idea, User Request |
| Date | YYYY-MM-DD | Date the idea was captured or last re-scored |
| Status | Enum | One of: New, Scoring, Validated, Deferred, Rejected |
| ICE Score | Composite | Total (I:n C:n E:n) — e.g., "24 (I:9 C:9 E:6)" |

**Business Rules**:
- ICE Total = Impact + Confidence + Effort (additive, each 1-10, max 30)
- Score < 12: Auto-defer with status "Deferred"
- Score 12-17: P2 (Medium) — Consider when capacity allows
- Score 18-24: P1 (High) — Queue for next sprint
- Score 25-30: P0 (Critical) — Fast-track to development
- ID generation: Parse existing table to find highest NNN, increment by 1
- Single-user assumption: No concurrent editing safeguards (document this limitation)

**Acceptance Criteria**:
- New ideas are appended as table rows with all fields populated
- Auto-defer gate enforced at score < 12
- IDs are unique and sequentially incremented
- Re-scoring updates the existing row rather than creating a new one

### FR-2: User Stories / Product Backlog (02_USER_STORIES.md)

**Description**: Validated ideas converted to user story format in a prioritized backlog table.

**File Location**: `docs/product/_backlog/02_USER_STORIES.md`

**Table Structure**:
| Field | Format | Description |
|-------|--------|-------------|
| Priority | Integer | Rank order (1 = highest), initially derived from ICE score tier |
| Story ID | US-NNN | Auto-incremented unique identifier |
| Story | Text | "As a [persona], I want [action], so that [benefit]" format |
| ICE Score | Integer | Carried from source idea |
| Source | Reference | IDEA-NNN reference linking back to the source idea |
| Status | Enum | One of: Ready for PRD, In PRD, In Development, Delivered |

**Business Rules**:
- Only PM-validated ideas become user stories
- User stories must use "As a [persona], I want [action], so that [benefit]" format
- Stories are initially prioritized by ICE score tier; PM can reorder
- Priority is a simple integer rank (1 = top priority)
- Status updates: "Ready for PRD" → "In PRD" (when `/triad.prd` starts) → "In Development" → "Delivered"

**Acceptance Criteria**:
- Only PM-approved ideas appear in this table
- Each entry links to its source IDEA-NNN
- User story format is consistently applied
- Status field accurately reflects current lifecycle stage

### FR-3: ICE Scoring Framework

**Description**: Three-dimensional scoring system for idea prioritization using both numeric and quick-assessment inputs.

**Scoring Dimensions**:
| Dimension | Scale | Question | Quick Assessment |
|-----------|-------|----------|-----------------|
| Impact | 1-10 | How much value does this deliver to users? | High(9): Transformative, Med(6): Solid improvement, Low(3): Minor enhancement |
| Confidence | 1-10 | How sure are we this will succeed? | High(9): Proven pattern, Med(6): Some unknowns, Low(3): Speculative |
| Effort | 1-10 | How easy is this to build? (10 = easiest) | High(9): Days of work, Med(6): Weeks of work, Low(3): Months of work |

**Scoring Input**:
- Skills should present the quick-assessment table and ask the user to select High/Medium/Low for each dimension
- Quick-assessment maps to numeric values: High=9, Medium=6, Low=3
- Users may also provide custom numeric values (1-10) for finer granularity
- Total = Impact + Confidence + Effort (additive, range 3-30)

**Auto-Defer Gate**: Total < 12 → auto-deferred (can be overridden by PM via `/pdl.validate`)

**Priority Tiers**:
| Score Range | Priority | Action |
|-------------|----------|--------|
| 25-30 | P0 (Critical) | Fast-track to development |
| 18-24 | P1 (High) | Queue for next sprint |
| 12-17 | P2 (Medium) | Consider when capacity allows |
| < 12 | Deferred | Auto-defer; requires PM override to proceed |

**Acceptance Criteria**:
- Quick-assessment options presented with clear anchors for each level
- Both quick-assessment and custom numeric input accepted
- ICE total computed correctly as additive sum
- Priority tier assigned based on score range
- Auto-defer gate applied at threshold < 12

### FR-4: PDL Skills and Commands

**Description**: Four skills with corresponding command wrappers providing the PDL workflow.

**Skill and Command Mapping**:
| User Command | Skill Directory | Command Wrapper | Purpose |
|--------------|----------------|-----------------|---------|
| `/pdl.run <idea>` | `.claude/skills/pdl-run/` | `.claude/commands/pdl.run.md` | Full discovery flow: capture → score → validate → backlog |
| `/pdl.idea <idea>` | `.claude/skills/pdl-idea/` | `.claude/commands/pdl.idea.md` | Capture idea + ICE scoring only |
| `/pdl.score IDEA-NNN` | `.claude/skills/pdl-score/` | `.claude/commands/pdl.score.md` | Re-score an existing idea |
| `/pdl.validate IDEA-NNN` | `.claude/skills/pdl-validate/` | `.claude/commands/pdl.validate.md` | PM validation gate + user story generation |

**Skill Format Requirements**:
- Each SKILL.md follows Anthropic Agent Skills open standard
- Frontmatter: `name` (required), `description` (required), optional `license`, `compatibility`, `metadata`
- No `triggers`, `allowed-tools`, or non-standard fields
- Body under 500 lines, imperative form, include examples

**Command Wrapper Requirements**:
- Each command `.md` file in `.claude/commands/` provides user-facing invocation
- Format matches existing triad commands: YAML frontmatter with `description`, structured steps
- Commands parse user arguments and delegate to skill logic

**User Story Generation** (pdl-validate and pdl-run skills):
- When PM approves an idea, the skill must transform the idea description into user story format
- Transformation: Extract persona (default to "Template Adopter" if unspecified), action, and benefit from the idea
- Output format: "As a [persona], I want [action], so that [benefit]"
- The generated user story should be presented to the user for confirmation before writing to `02_USER_STORIES.md`

**Acceptance Criteria**:
- All four skills created with valid SKILL.md frontmatter
- All four command wrappers created and discoverable via `/pdl.*` invocation
- `/pdl.run` orchestrates the full flow end-to-end
- `/pdl.idea` captures and scores without PM validation
- `/pdl.score` updates existing idea scores
- `/pdl.validate` invokes PM agent and generates user story on approval
- User story generation produces grammatically correct "As a... I want... so that..." output

### FR-5: PDL → Triad Handoff

**Description**: Clean handoff from discovery to delivery with source traceability.

**Handoff Flow**:
```
PDL completes                          Triad begins
─────────────────────────────          ─────────────────────────────
/pdl.run "Add dark mode"               /triad.prd dark-mode
    │                                      │
    ├── IDEA-001 captured                  ├── PRD with source traceability
    ├── ICE: 24 (I:9 C:9 E:6)            ├── /triad.specify
    ├── PM approved                        ├── /triad.plan
    └── US-001 in Backlog ════════════▶   ├── /triad.tasks
                                           └── /triad.implement
        "Ready for PRD"                        "Feature shipped"
```

**PRD Frontmatter Extension**:
```yaml
source:
  idea_id: IDEA-001
  story_id: US-001
```

**Status Updates**: When `/triad.prd` creates a PRD from a backlog item, the corresponding user story status in `02_USER_STORIES.md` should update from "Ready for PRD" to "In PRD".

**Acceptance Criteria**:
- PRD frontmatter includes source traceability when created from a PDL backlog item
- User story status updates when PRD creation begins
- Complete traceability chain: IDEA → User Story → PRD → spec → plan → tasks

### FR-6: Documentation

**Description**: Guide documentation for the PDL workflow.

**Deliverables**:
| Document | Location | Purpose |
|----------|----------|---------|
| PDL Quickstart Guide | `docs/guides/PDL_QUICKSTART.md` | Quick reference: commands, ICE scoring, workflow |
| PDL + Triad Lifecycle | `docs/guides/PDL_TRIAD_LIFECYCLE.md` | Complete lifecycle: idea to shipped feature |
| Backlog README update | `docs/product/_backlog/README.md` | Updated to reflect PDL structure and migration guidance |

**Documentation Requirements**:
- Quickstart covers: Available commands, ICE scoring reference, example workflows, common questions
- Lifecycle doc covers: Complete flow diagram, stage descriptions, governance gates, traceability model
- Backlog README covers: PDL table structure, migration guidance from individual files, review cadence

**Acceptance Criteria**:
- All three documents created with accurate content
- Documentation references only `/pdl.*` and `/triad.*` commands
- Migration guidance helps adopters transition from individual backlog files to consolidated tables
- Examples use realistic idea descriptions and ICE scores

### FR-7: Backlog File Auto-Creation

**Description**: PDL commands auto-create backlog files when they don't exist.

**Behavior**: When any PDL command runs and `01_IDEAS.md` or `02_USER_STORIES.md` doesn't exist:
- Create the file with the appropriate table header row
- Preserve any existing individual backlog files (do not delete them)

**01_IDEAS.md Initial Content**:
```markdown
# Ideas Backlog

| ID | Idea | Source | Date | Status | ICE Score |
|----|------|--------|------|--------|-----------|
```

**02_USER_STORIES.md Initial Content**:
```markdown
# Product Backlog - User Stories

| Priority | Story ID | Story | ICE Score | Source | Status |
|----------|----------|-------|-----------|--------|--------|
```

**Acceptance Criteria**:
- Missing files created automatically on first PDL command execution
- Existing files are appended to, not overwritten
- Individual backlog feature files are preserved alongside new table-based files

---

## 4. Non-Functional Requirements

### NFR-1: PDL Is Optional

**Requirement**: PDL must not be a mandatory gate before `/triad.prd`
**Measure**: Teams can run `/triad.prd` without any PDL artifacts existing
**Verification**: Running `/triad.prd` on a project with no `01_IDEAS.md` or `02_USER_STORIES.md` succeeds without warnings

### NFR-2: Local-First Data Storage

**Requirement**: All PDL data stored in markdown files within the project repository
**Measure**: Zero external service dependencies for PDL operation
**Verification**: PDL commands function with no internet connection (except for PM agent invocation)

### NFR-3: Skill File Size

**Requirement**: Each SKILL.md file remains under 500 lines
**Measure**: Line count of each PDL SKILL.md file
**Verification**: `wc -l .claude/skills/pdl-*/SKILL.md` shows all under 500

### NFR-4: Single-User Assumption

**Requirement**: Document that PDL assumes single-user/single-agent editing of backlog files
**Measure**: Limitation documented in PDL Quickstart and Backlog README
**Verification**: Documentation mentions concurrent editing limitation

---

## 5. Success Criteria

### Primary Metrics

| Metric | Target | How to Measure |
|--------|--------|----------------|
| PDL commands functional | All 4 commands (`/pdl.run`, `/pdl.idea`, `/pdl.score`, `/pdl.validate`) execute successfully | Manual end-to-end test of each command |
| Ideas captured with ICE scores | Ideas appended to `01_IDEAS.md` with correct format | Verify table structure after `/pdl.idea` |
| Auto-defer gate works | Ideas with score < 12 receive "Deferred" status | Score an idea with Low/Low/Low (total 9) |
| PM validation gate works | PM agent reviews and approves/rejects ideas | Run `/pdl.validate` and verify agent invocation |
| User stories generated | Validated ideas produce "As a... I want... so that..." entries | Check `02_USER_STORIES.md` after `/pdl.validate` |
| Traceability chain complete | IDEA → User Story → PRD link maintained | Follow source references across all artifacts |

### Secondary Metrics

| Metric | Target | How to Measure |
|--------|--------|----------------|
| Documentation complete | 3 documents created (Quickstart, Lifecycle, README update) | Files exist with accurate content |
| Skills follow open standard | All 4 SKILL.md files have valid frontmatter | Review frontmatter fields |
| Command wrappers discoverable | All 4 commands listed in system | `/pdl.*` commands appear in skill listings |
| Backlog auto-creation works | Files created when missing | Run PDL command on project without backlog files |

### User Experience Outcomes

- Template adopters can capture, score, and validate ideas in under 2 minutes per idea
- The full `/pdl.run` flow takes a single command to go from idea to backlog-ready
- PDL integrates seamlessly with existing Triad workflow without disrupting it
- ICE scoring provides clear, consistent prioritization guidance
- PM validation provides a lightweight governance gate before heavy Triad process

---

## 6. Scope & Boundaries

### In Scope

**Must Have (P0)**:
- `01_IDEAS.md` table structure with ICE scoring
- `02_USER_STORIES.md` table structure with prioritized backlog
- `/pdl.run` skill + command (full discovery flow)
- `/pdl.idea` skill + command (capture + score)
- `/pdl.score` skill + command (re-score existing)
- `/pdl.validate` skill + command (PM validation gate + user story generation)
- PDL Quickstart documentation
- PDL + Triad Lifecycle documentation
- Updated `_backlog/README.md` with PDL structure and migration guidance
- Backlog file auto-creation on first use

**Should Have (P1)**:
- Source traceability fields in PRD frontmatter (`source.idea_id`, `source.story_id`)
- Status flow updates in `02_USER_STORIES.md` when PRD creation begins

### Out of Scope

- Automated PDL-to-Triad pipeline (handoff remains manual via `/triad.prd`)
- Web UI for idea management (local files only per Constitution Principle III)
- Integration with external issue trackers (Jira, Linear, etc.)
- Multi-project backlog aggregation
- Historical analytics or reporting on ICE scores
- Score history tracking (re-scoring replaces the previous score)
- Archive file for completed/rejected ideas (`03_ARCHIVE.md` deferred)

### Assumptions

- Adopters will customize ICE scoring thresholds to their team's needs (12 is a sensible default)
- The `docs/product/_backlog/` directory already exists in the project structure
- User story generation can produce reasonable output from natural language idea descriptions
- PM validation can be performed by the product-manager agent in a single review pass
- Single-user/single-agent editing of backlog files (no concurrent edit safeguards needed)

### Dependencies

**Internal**:
- Existing `docs/product/_backlog/` directory structure
- `.claude/skills/` directory for skill definitions
- `.claude/commands/` directory for command wrappers
- Triad workflow commands (for handoff integration)
- product-manager agent (for PM validation in `/pdl.validate`)

**External**: None

---

## 7. Key Entities

### PDL Command Inventory

| Command | Skill | Lines (Est.) | Inputs | Outputs |
|---------|-------|-------------|--------|---------|
| `/pdl.idea <desc>` | pdl-idea | ~150 | Idea description | 01_IDEAS.md entry |
| `/pdl.score IDEA-NNN` | pdl-score | ~100 | Idea ID | Updated ICE score in 01_IDEAS.md |
| `/pdl.validate IDEA-NNN` | pdl-validate | ~200 | Idea ID | 02_USER_STORIES.md entry |
| `/pdl.run <desc>` | pdl-run | ~150 | Idea description | Full flow: IDEAS + USER_STORIES entries |

### File Inventory

| File | Location | Action |
|------|----------|--------|
| `01_IDEAS.md` | `docs/product/_backlog/` | Create (new) |
| `02_USER_STORIES.md` | `docs/product/_backlog/` | Create (new) |
| `README.md` | `docs/product/_backlog/` | Update (existing) |
| `pdl-idea/SKILL.md` | `.claude/skills/` | Create (new) |
| `pdl-score/SKILL.md` | `.claude/skills/` | Create (new) |
| `pdl-validate/SKILL.md` | `.claude/skills/` | Create (new) |
| `pdl-run/SKILL.md` | `.claude/skills/` | Create (new) |
| `pdl.idea.md` | `.claude/commands/` | Create (new) |
| `pdl.score.md` | `.claude/commands/` | Create (new) |
| `pdl.validate.md` | `.claude/commands/` | Create (new) |
| `pdl.run.md` | `.claude/commands/` | Create (new) |
| `PDL_QUICKSTART.md` | `docs/guides/` | Create (new) |
| `PDL_TRIAD_LIFECYCLE.md` | `docs/guides/` | Create (new) |

### Triad Review Concern Resolution

| Concern | Source | Resolution |
|---------|--------|------------|
| Skills need command wrappers | Architect #1 | FR-4 specifies command wrappers in `.claude/commands/pdl.*.md` for each skill |
| Backlog migration guidance | Architect #2 | FR-6 includes migration guidance in updated `_backlog/README.md` |
| Concurrent edit safety | Architect #3 | NFR-4 documents single-user assumption in Quickstart and README |
| Naming delta (PDL-NNN → US-NNN) | Team-Lead #1 | FR-2 uses US-NNN for user stories, IDEA-NNN for ideas consistently |
| User story generation is net-new | Team-Lead #2 | FR-4 defines explicit transformation step in pdl-validate and pdl-run |
| ICE score consistency | Team-Lead #3 | FR-3 aligns 1-10 scale with High(9)/Med(6)/Low(3) quick-assessment anchors |

---

## 8. Risks & Mitigations

### Risk 1: PDL Adds Overhead That Discourages Adoption

**Likelihood**: Medium | **Impact**: Medium
**Description**: Users may perceive PDL as unnecessary process overhead for small teams or solo developers
**Mitigation**: PDL is optional (NFR-1); `/pdl.run` provides single-command fast path; quick-assessment ICE scoring reduces friction; documentation emphasizes lightweight nature

### Risk 2: ICE Scoring Feels Arbitrary for Solo Developers

**Likelihood**: Medium | **Impact**: Low
**Description**: Solo developers may not see value in scoring their own ideas
**Mitigation**: Quick-assessment options (High/Medium/Low) make scoring fast and intuitive; ICE provides a record-keeping framework even for solo use; auto-defer gate prevents idea pile-up

### Risk 3: User Story Generation Produces Low-Quality Output

**Likelihood**: Medium | **Impact**: Medium
**Description**: Transforming natural language idea descriptions into "As a... I want... so that..." format may produce awkward or inaccurate user stories
**Mitigation**: Generated user stories are presented for user confirmation before writing; user can edit the story before it's committed to the backlog; default persona ("Template Adopter") used when no persona is evident

### Risk 4: Backlog Files Grow Unwieldy

**Likelihood**: Low | **Impact**: Low
**Description**: The consolidated IDEAS and USER STORIES tables may become difficult to navigate with many entries
**Mitigation**: Include archival guidance in documentation; status-based filtering; future `03_ARCHIVE.md` can be added if needed

---

## 9. Open Questions

*No critical clarifications needed. The PRD provides comprehensive requirements with approved Triad sign-offs, all six Triad review concerns are addressed in the functional requirements, and research findings confirm feasibility.*
