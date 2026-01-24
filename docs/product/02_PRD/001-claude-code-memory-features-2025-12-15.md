# Claude Code Memory Features Enhancement - Product Requirements Document

**Status**: Draft
**Created**: 2025-12-15
**Author**: product-manager
**Reviewers**: architect, team-lead
**Phase**: Phase 1
**Priority**: P1
**PRD Number**: 001

---

## Executive Summary

### The One-Liner
Make Claude Code agents load context faster and maintain CLAUDE.md easier by splitting rules into topic files and using @-reference syntax instead of manual cat commands.

### Problem Statement
Product-Led Spec Kit currently uses a monolithic CLAUDE.md file (192 lines) with manual `cat` commands for context loading. This creates three problems:

1. **Maintainability**: Single 192-line file is hard to navigate and update - changes to one topic (e.g., git workflow) require editing a massive file containing unrelated topics
2. **Context Loading Friction**: Agents must manually execute bash `cat` commands to load context, adding latency and requiring multi-step operations
3. **Scaling Limitations**: As methodology grows, CLAUDE.md will become unwieldy (300+ lines projected by Phase 3)

**Current User Pain**: When agents need specific context (e.g., deployment policy), they must:
1. Read CLAUDE.md to find the right file path
2. Execute a separate `cat` command
3. Parse the output
Total: 3 steps, ~5-10 seconds latency

**Desired State**: Agents simply reference `@.claude/rules/deployment.md` in CLAUDE.md, and Claude Code automatically loads that context inline. Total: 1 step, instant.

### Proposed Solution

**Feature 1: Modular Rules Directory**
Split CLAUDE.md into focused topic files in `.claude/rules/`:
- `rules/governance.md` - Triad workflow, sign-off requirements
- `rules/git-workflow.md` - Branch naming, PR policies
- `rules/deployment.md` - DevOps agent requirements
- `rules/scope.md` - Project boundaries
- `rules/commands.md` - Command reference
- `rules/context-loading.md` - Context loading guide

**Feature 4: Import Syntax with @-references**
Replace manual `cat` instructions with automatic `@path/to/file.md` imports that Claude Code loads seamlessly.

**Benefits**:
- Reduce CLAUDE.md size from 192 lines to ~80 lines (58% reduction)
- Improve topic-specific editing (change git workflow without touching deployment policy)
- Eliminate context loading latency (instant vs 5-10 seconds)
- Scale methodology gracefully (add new rules without bloating CLAUDE.md)

### Success Criteria

**Primary Metrics**:
- CLAUDE.md line count: 192 → 80 lines (58% reduction)
- Context loading steps: 3 steps → 1 step (67% reduction)
- Context loading time: 5-10 seconds → instant (<1 second)

**Quality Metrics**:
- All existing CLAUDE.md content preserved (100% fidelity)
- No broken references after migration
- Agents can load all contexts successfully

### Timeline
**Target Delivery**: TBD - Pending Tech-Lead feasibility check

**Estimated Effort**: TBD - Pending Tech-Lead estimation

---

## Strategic Alignment

### Product Vision Alignment
**Reference**: docs/product/01_Product_Vision/README.md

This feature supports Product-Led Spec Kit's vision of providing a **methodology and governance template** that works with any agent workflow. By making CLAUDE.md modular and context loading frictionless, we improve the developer experience for teams adopting this template.

**Alignment**:
- Improves template usability (easier to customize and maintain)
- Reduces cognitive load (focused topic files vs monolithic doc)
- Demonstrates best practices (modular architecture, DRY principle)

### OKR Support
**Reference**: N/A (No OKRs defined yet - template project)

**Future OKR Candidate** (when defined):
- Objective: Improve developer onboarding and adoption
- KR1: Reduce time-to-first-PR from 2 hours → 1 hour
- KR2: Increase template adoption rate by 30%

**This feature contributes to**:
- Faster onboarding (easier to understand modular rules)
- Better maintainability (encourages template customization)

### Roadmap Fit
**Reference**: N/A (No formal roadmap yet - template project)

**Recommended Phase**: Phase 1 (Foundation)
**Rationale**: Core infrastructure improvement that benefits all future features. Should be completed before methodology scales further.

**Dependencies**: None (standalone feature)

---

## Target Users & Personas

**Reference**: docs/product/01_Product_Vision/README.md

### Primary Persona: Template Adopter

**Demographics**:
- Role: Software engineer, tech lead, or architect
- Experience: Familiar with Claude Code, AI-assisted development
- Goals: Adopt Product-Led Spec Kit for their team project
- Pain Points:
  - Overwhelmed by monolithic CLAUDE.md during initial customization
  - Unclear where to edit specific governance rules
  - Manual context loading slows down agent workflows

**Why This Matters to Them**:
When adopting the template, they need to customize CLAUDE.md for their project. With modular rules, they can:
- Edit git workflow without touching deployment policy (reduces merge conflicts)
- Understand each governance domain independently (faster learning)
- Extend methodology with custom rules (add new `.claude/rules/` files)

**Value Delivered**:
- 60% faster CLAUDE.md customization (focused files vs monolithic)
- Clearer mental model of template governance structure
- Confidence to modify template without breaking unrelated features

### Secondary Persona: Spec Kit Maintainer

**Demographics**:
- Role: Open source maintainer or internal platform team
- Experience: Maintains Product-Led Spec Kit template
- Goals: Keep template up-to-date, add new methodology features
- Pain Points:
  - CLAUDE.md will become unmaintainable as methodology scales (300+ lines projected)
  - Hard to refactor governance without breaking users' customizations
  - Difficult to version governance policies independently

**Why This Matters to Them**:
Modular rules enable:
- Independent versioning (bump git-workflow.md without changing deployment.md)
- Easier governance evolution (add new rules without refactoring entire CLAUDE.md)
- Clearer git diffs (changes to one topic don't pollute unrelated sections)

**Value Delivered**:
- Sustainable template growth (scales to 500+ lines methodology without chaos)
- Maintainable governance architecture
- Better collaboration (multiple contributors can edit different rules simultaneously)

---

## User Stories

### User Story Format
Using Intercom's Job Story format for better context:

**When** [situation/context],
**I want to** [motivation/action],
**So I can** [expected outcome/benefit].

### Primary User Stories

#### US-001: Modular Rules for Template Customization
**When**: I'm adopting Product-Led Spec Kit and need to customize git workflow for my team,
**I want to**: Edit only `.claude/rules/git-workflow.md` without touching deployment or governance rules,
**So I can**: Customize git policies without risk of breaking unrelated governance features.

**Acceptance Criteria**:
- **Given** CLAUDE.md references `.claude/rules/git-workflow.md`, **when** I edit that file, **then** CLAUDE.md automatically reflects changes
- **Given** modular rules structure exists, **when** I update git-workflow.md, **then** deployment.md and governance.md remain unchanged
- **Given** I'm new to the template, **when** I open `.claude/rules/`, **then** I see clearly named topic files (git-workflow.md, deployment.md, etc.)

**Priority**: P0 (Must Have)
**Effort**: M (Medium)

#### US-002: Instant Context Loading with @-references
**When**: An agent needs to load deployment policy context,
**I want to**: Reference `@.claude/rules/deployment.md` in CLAUDE.md,
**So I can**: Load context instantly without manual bash commands.

**Acceptance Criteria**:
- **Given** CLAUDE.md contains `@.claude/rules/deployment.md`, **when** agent reads CLAUDE.md, **then** deployment.md content is loaded inline automatically
- **Given** agent needs deployment context, **when** they use @-reference, **then** context loads in <1 second (vs 5-10 seconds for cat command)
- **Given** @-reference is used, **when** referenced file doesn't exist, **then** agent receives clear error message

**Priority**: P0 (Must Have)
**Effort**: L (Large - depends on Claude Code @-syntax support)

#### US-003: Reduced CLAUDE.md Size
**When**: I open CLAUDE.md to understand template governance,
**I want to**: See a concise overview (80 lines) with clear topic references,
**So I can**: Quickly understand governance structure without scrolling through 192 lines.

**Acceptance Criteria**:
- **Given** modular rules are implemented, **when** I read CLAUDE.md, **then** it is ≤80 lines (58% reduction from 192 lines)
- **Given** I need specific governance topic, **when** I read CLAUDE.md, **then** I see clear reference to topic-specific rule file
- **Given** CLAUDE.md is refactored, **when** I compare old vs new, **then** 100% of content is preserved in modular structure

**Priority**: P0 (Must Have)
**Effort**: S (Small - content migration)

#### US-004: Topic-Specific Rule Editing
**When**: I need to update deployment policy for my project,
**I want to**: Edit only `.claude/rules/deployment.md`,
**So I can**: Change deployment rules without navigating unrelated governance content.

**Acceptance Criteria**:
- **Given** deployment policy exists in `.claude/rules/deployment.md`, **when** I need to update it, **then** I can find and edit it in <30 seconds
- **Given** I'm collaborating with team, **when** I update deployment.md, **then** no merge conflicts with teammate editing git-workflow.md
- **Given** rules are modular, **when** I add custom rule, **then** I can create new `.claude/rules/custom.md` without modifying core files

**Priority**: P1 (Should Have)
**Effort**: S (Small)

---

## User Experience Requirements

### Customer Journey Context
**Reference**: N/A (No customer journey maps yet - template project)

**Journey Stage**: Adoption and Customization
**Touchpoints**:
- Initial template clone
- CLAUDE.md review and customization
- Agent context loading during development

**Emotions**:
- Before: Overwhelmed (monolithic CLAUDE.md), Frustrated (slow context loading)
- After: Confident (clear structure), Efficient (instant context loading)

### Key User Flows

#### Flow 1: Customize Git Workflow Rule
1. User opens `.claude/rules/git-workflow.md`
2. User edits branch naming convention (e.g., change `NNN-feature-name` to `feat/NNN-description`)
3. User saves file
4. User opens CLAUDE.md - sees updated git workflow via @-reference
5. Agent reads CLAUDE.md - automatically loads updated git-workflow.md

**Happy Path**: User customizes git workflow in <2 minutes without touching other rules

**Edge Cases**:
- User deletes git-workflow.md → CLAUDE.md shows clear error "@.claude/rules/git-workflow.md not found"
- User creates invalid markdown in git-workflow.md → Agent receives parsing error with line number

#### Flow 2: Agent Loads Deployment Context
1. Agent needs deployment policy context
2. Agent reads CLAUDE.md
3. CLAUDE.md contains `@.claude/rules/deployment.md`
4. Claude Code automatically loads deployment.md inline
5. Agent uses deployment context without additional commands

**Happy Path**: Agent loads deployment context in <1 second (vs 5-10 seconds manual cat)

**Edge Cases**:
- deployment.md doesn't exist → Agent receives "File not found" error with clear recovery path
- deployment.md has circular @-reference → Agent receives "Circular reference detected" error

#### Flow 3: Add Custom Rule
1. User needs custom governance rule (e.g., "code review process")
2. User creates `.claude/rules/code-review.md`
3. User adds `@.claude/rules/code-review.md` to CLAUDE.md under relevant section
4. User commits both files
5. Agents automatically load code-review.md when reading CLAUDE.md

**Happy Path**: User extends governance with custom rules in <5 minutes

**Edge Cases**:
- User forgets to add @-reference in CLAUDE.md → Rule file exists but agents don't load it (no breaking change)

### UI/UX Considerations

**Information Architecture**:
- `.claude/rules/` directory organizes governance by topic
- CLAUDE.md acts as "table of contents" with @-references
- Each rule file is self-contained and focused

**Progressive Disclosure**:
- CLAUDE.md shows high-level overview
- @-references load detailed policies only when needed
- Users drill down into specific topics as needed

**Error Prevention**:
- Clear naming convention (`.claude/rules/<topic>.md`)
- @-reference syntax is explicit and validated
- File not found errors provide recovery guidance

**Feedback Patterns**:
- @-reference loads visibly (agent confirms context loaded)
- File errors show clear path to resolution
- Git diffs show focused changes (one rule file)

---

## Functional Requirements

### Core Capabilities

#### FR-1: Modular Rules Directory Structure
**Description**: Create `.claude/rules/` directory with topic-specific governance files

**Inputs**: Existing CLAUDE.md content
**Processing**: Extract governance topics into focused files
**Outputs**: `.claude/rules/` directory with 6 topic files

**Business Rules**:
- Each rule file covers one governance domain (git, deployment, governance, etc.)
- Rule files use clear, descriptive names (git-workflow.md, not git.md)
- All content from CLAUDE.md is preserved in rule files (100% fidelity)
- CLAUDE.md shrinks to ≤80 lines (overview + @-references)

**Edge Cases**:
- Content spans multiple topics → Place in most relevant file, cross-reference in CLAUDE.md
- Custom user additions to CLAUDE.md → Document migration path in changelog

**Rule File Breakdown**:
1. `governance.md` - SDLC Triad workflow, sign-off requirements (lines 83-153 from CLAUDE.md)
2. `git-workflow.md` - Branch naming, commit standards, PR policies (lines 11-15 from CLAUDE.md)
3. `deployment.md` - DevOps agent policy, verification requirements (lines 155-166 from CLAUDE.md)
4. `scope.md` - Project boundaries, what this is/isn't (lines 48-57 from CLAUDE.md)
5. `commands.md` - Triad vs Vanilla command reference (lines 59-81 from CLAUDE.md)
6. `context-loading.md` - Context loading guide by domain (lines 97-122 from CLAUDE.md)

#### FR-2: @-reference Import Syntax
**Description**: Replace manual `cat` commands with `@path/to/file.md` syntax that Claude Code loads automatically

**Inputs**: File path in `@path/to/file.md` format
**Processing**: Claude Code detects @-reference and loads file inline
**Outputs**: File content embedded at reference location

**Business Rules**:
- @-references use relative paths from repository root (e.g., `@.claude/rules/git-workflow.md`)
- Referenced files must exist at specified path
- Circular references are detected and prevented
- @-references can be nested (rule file can reference another rule file, max depth: 3)

**Edge Cases**:
- File not found → Error: "@path/to/file.md not found. Create file or update reference."
- Circular reference → Error: "Circular @-reference detected: A → B → A"
- Permission denied → Error: "Cannot read @path/to/file.md. Check file permissions."

**Implementation Note**: This feature depends on Claude Code supporting @-reference syntax. If not supported natively, document workaround in Appendix B.

#### FR-3: CLAUDE.md Refactoring
**Description**: Refactor CLAUDE.md from 192-line monolith to 80-line overview with @-references

**Inputs**: Current CLAUDE.md (192 lines)
**Processing**:
- Extract topics to `.claude/rules/` files
- Replace extracted content with @-references
- Preserve structural flow and readability
**Outputs**: Refactored CLAUDE.md (≤80 lines)

**Business Rules**:
- CLAUDE.md retains high-level structure (Core Constraints, Commands, Governance, etc.)
- Each section has 1-2 sentence summary + @-reference to detailed rule file
- No content loss (100% of original CLAUDE.md preserved in refactored structure)
- Backward compatibility: Users who haven't migrated can still use old CLAUDE.md

**Edge Cases**:
- Users with custom CLAUDE.md modifications → Provide migration guide in MIGRATION.md
- Existing agent prompts reference CLAUDE.md line numbers → Update agent docs with new structure

#### FR-4: Migration Documentation
**Description**: Create migration guide for users with customized CLAUDE.md

**Inputs**: User's customized CLAUDE.md
**Processing**: Step-by-step migration instructions
**Outputs**: MIGRATION.md guide + migration validation script

**Business Rules**:
- Migration is opt-in, not forced (backward compatibility)
- Migration guide includes diff examples
- Validation script checks migration completeness
- Rollback instructions provided

**Edge Cases**:
- User skips migration → Old CLAUDE.md still works (no breaking changes)
- User partially migrates → Validation script identifies missing content

### Data Requirements

**Data Model**:
```
Directory: .claude/rules/
Files:
  - governance.md: string (markdown) - Triad workflow content
  - git-workflow.md: string (markdown) - Git policies
  - deployment.md: string (markdown) - Deployment policies
  - scope.md: string (markdown) - Project boundaries
  - commands.md: string (markdown) - Command reference
  - context-loading.md: string (markdown) - Context guide

File: CLAUDE.md
Content: string (markdown) - Overview + @-references
```

**Validation Rules**:
- Rule files: Valid markdown format
- @-references: Path exists, no circular references
- CLAUDE.md: ≤80 lines, all @-references valid

**Data Lifecycle**:
- **Creation**: Rule files created during migration
- **Updates**: Users edit rule files directly, CLAUDE.md updates via @-references
- **Deletion**: Rule files can be removed if CLAUDE.md @-reference is also removed
- **Retention**: Rule files persisted in git, no expiration

### Integration Requirements

**External Systems**: None (local file operations only)

**APIs**: None

**Events/Webhooks**: None

**Claude Code Integration**:
- **@-reference syntax**: Requires Claude Code to support `@path/to/file.md` inline loading
- **Fallback**: If @-syntax not supported, document manual `cat` alternative in README

---

## Non-Functional Requirements

### Performance Requirements

**Response Time**:
- @-reference context loading: <1 second (vs 5-10 seconds for manual cat)
- CLAUDE.md parse time: <100ms (reduced file size improves parsing)
- Rule file edit-to-reload: <500ms (agent detects file changes)

**Throughput**:
- Support loading 10+ @-references in single CLAUDE.md read
- Handle rule files up to 500 lines each (future scaling)

**Scalability**:
- Modular structure scales to 20+ rule files without performance degradation
- Nested @-references supported up to depth 3

### Reliability Requirements

**Availability**:
- Rule files are local filesystem (100% availability if filesystem accessible)
- No network dependencies (offline-first)

**Error Handling**:
- File not found: Clear error with path and suggestion
- Circular reference: Detect and prevent with error message
- Parse errors: Show line number and validation failure

**Data Integrity**:
- Migration preserves 100% of CLAUDE.md content
- Rule file edits are atomic (no partial writes)
- Git tracks all changes (version control)

### Security Requirements

**Authentication**: None (local filesystem access only)

**Authorization**: Standard filesystem permissions (user owns files)

**Data Protection**:
- No encryption needed (configuration files, not secrets)
- Files versioned in git (audit trail)

**Compliance**: None (local development tool, no user data)

### Accessibility Requirements

**WCAG Compliance**: N/A (markdown files, not web UI)

**Screen Reader Support**: N/A

**Keyboard Navigation**: N/A

**Internationalization**:
- Rule files use English (template language)
- Users can create localized rule files if needed (e.g., `.claude/rules/es/`)

---

## Success Metrics

### Primary Metrics (Leading Indicators)

**Metric 1: CLAUDE.md Line Count Reduction**
- **Definition**: Number of lines in CLAUDE.md before and after refactoring
- **Baseline**: 192 lines (current)
- **Target**: ≤80 lines (58% reduction)
- **Timeline**: Measured at migration completion
- **Owner**: product-manager

**Metric 2: Context Loading Time Reduction**
- **Definition**: Time for agent to load governance context
- **Baseline**: 5-10 seconds (manual cat command + parse)
- **Target**: <1 second (@-reference inline loading)
- **Timeline**: Measured during agent testing
- **Owner**: team-lead

**Metric 3: Rule File Modularity Score**
- **Definition**: Percentage of CLAUDE.md content extracted to focused rule files
- **Baseline**: 0% (monolithic)
- **Target**: 60% (majority of content modularized)
- **Timeline**: Measured at migration completion
- **Owner**: product-manager

### Secondary Metrics (Lagging Indicators)

**Metric 1: Template Customization Time**
- **Definition**: Time for new user to customize git workflow rule
- **Baseline**: 10-15 minutes (navigate monolithic CLAUDE.md, edit, verify)
- **Target**: 2-5 minutes (find rule file, edit, done)
- **Timeline**: Measured via user testing after migration
- **Owner**: product-manager

**Metric 2: Governance Update Frequency**
- **Definition**: Number of governance rule updates per month
- **Baseline**: 1-2 updates/month (friction from monolithic file)
- **Target**: 4-6 updates/month (easier to iterate on focused files)
- **Timeline**: Measured 3 months post-migration
- **Owner**: team-lead

### User Satisfaction Metrics

**Template Usability**:
- User feedback: "CLAUDE.md is easier to understand" (qualitative)
- Time to first template customization: <1 hour (from template clone)

**Developer Experience**:
- Agent context loading: "Instant and seamless" (qualitative feedback)
- Maintenance burden: "Low" (focused file editing)

### Business Metrics

**Adoption Impact**:
- This feature improves template usability, potentially increasing adoption rate
- Measurement: Track template downloads/forks after feature release

**Maintenance Efficiency**:
- Reduced time maintaining template governance
- Fewer merge conflicts from multi-contributor updates

---

## Scope & Boundaries

### In Scope (MVP / Phase 1)

**Must Have (P0)**:
- ✅ Create `.claude/rules/` directory structure with 6 topic files (governance, git-workflow, deployment, scope, commands, context-loading)
- ✅ Refactor CLAUDE.md from 192 lines → ≤80 lines with @-references
- ✅ Document @-reference syntax and usage patterns
- ✅ Create migration guide (MIGRATION.md) for users with custom CLAUDE.md
- ✅ Validate 100% content preservation (no loss from migration)

**Should Have (P1)**:
- 🎯 Migration validation script (checks completeness)
- 🎯 Example of custom rule file creation
- 🎯 Nested @-reference support (depth 2)

### Out of Scope (Future Phases)

**Could Have (P2)** - Not in MVP:
- 🔮 Automatic CLAUDE.md migration tool (users migrate manually in MVP)
- 🔮 Rule file linting/validation (basic markdown validation only in MVP)
- 🔮 Rule file templates for custom governance (users create from scratch in MVP)
- 🔮 @-reference autocomplete in IDE (manual path entry in MVP)

**Won't Have** - Explicitly excluded:
- ❌ Web UI for editing rule files (CLI/text editor only)
- ❌ Real-time collaboration on rule files (standard git workflow)
- ❌ Rule file versioning beyond git (git is sufficient)
- ❌ Dynamic @-reference resolution based on context (static paths only)

### Assumptions

**Assumption 1: Claude Code @-syntax Support**
- Assumption: Claude Code supports `@path/to/file.md` inline loading syntax
- Validation Needed: Test @-syntax with Claude Code, document in Appendix B

**Assumption 2: Markdown Compatibility**
- Assumption: Rule files use standard markdown (no custom extensions)
- Validation: Verify markdown renders correctly in Claude Code

**Assumption 3: User Familiarity with Git**
- Assumption: Template users understand git, can merge customizations
- Validation: User testing with git novices

**Validation Checklist**:
- [ ] Test @-syntax with Claude Code (Architecture spike)
- [ ] Validate markdown rendering across different viewers
- [ ] User test migration guide with git novice

### Constraints

**Technical Constraints**:
- Claude Code @-syntax availability: If not supported, MVP delivers rule files + migration guide, defers @-syntax to Phase 2
- File path length limits: Rule file paths must be <255 characters (filesystem limit)

**Business Constraints**:
- Timeline: Must complete before methodology scales to 300+ lines
- Resources: Single developer (product-manager + architect collaboration)

**External Dependencies**:
- Claude Code feature support: @-reference syntax (critical path dependency)
- If unavailable: Fallback to documented `cat` pattern with modular rules (partial value delivered)

---

## Timeline & Milestones

### Phase Breakdown

**Phase 1: Planning & Spike** (Week 1)
- Week 1, Day 1-2: Architect spike on @-syntax support
- Week 1, Day 3-5: PRD approval, spec.md creation
- **Deliverable**: PRD approved, @-syntax feasibility validated

**Phase 2: Implementation** (Week 2)
- Week 2, Day 1-2: Create `.claude/rules/` directory, migrate content
- Week 2, Day 3: Refactor CLAUDE.md with @-references
- Week 2, Day 4: Create MIGRATION.md guide
- Week 2, Day 5: Testing and validation
- **Deliverable**: Modular rules implemented, CLAUDE.md refactored

**Phase 3: Documentation & Rollout** (Week 3)
- Week 3, Day 1-2: Update template documentation (README, constitution references)
- Week 3, Day 3: User testing with sample customizations
- Week 3, Day 4-5: Address feedback, finalize
- **Deliverable**: Feature complete, documented, tested

### Key Milestones

| Milestone | Target Date | Owner | Status |
|-----------|-------------|-------|--------|
| PRD Approval | 2025-12-XX | product-manager | 🟡 In Review |
| @-syntax Spike Complete | TBD | architect | 📋 Pending |
| Spec Complete | TBD | product-manager | 📋 Pending |
| Plan Complete | TBD | architect | 📋 Pending |
| Rule Files Created | TBD | frontend-developer | 📋 Pending |
| CLAUDE.md Refactored | TBD | frontend-developer | 📋 Pending |
| Migration Guide Complete | TBD | product-manager | 📋 Pending |
| Testing Complete | TBD | team-lead | 📋 Pending |
| User Validation | TBD | product-manager | 📋 Pending |
| Feature Complete | TBD | team-lead | 📋 Pending |

Legend: ✅ Complete | 🟢 On Track | 🟡 In Review | 📋 Pending | 🔴 Blocked

**Timeline Note**: Specific dates pending Tech-Lead feasibility check and @-syntax spike results.

---

## Risks & Dependencies

### Technical Risks

**Risk 1: Claude Code @-syntax Not Supported**
- **Likelihood**: Medium
- **Impact**: High (core feature depends on it)
- **Mitigation**: Conduct architecture spike in Phase 1 (before full implementation commitment)
- **Contingency**: If unavailable, deliver modular rules + migration guide only (defer @-syntax to Phase 2 when supported)

**Risk 2: Migration Complexity for Custom CLAUDE.md**
- **Likelihood**: Medium
- **Impact**: Medium (user friction)
- **Mitigation**: Provide comprehensive MIGRATION.md with examples, validation script
- **Contingency**: Offer migration support via GitHub Discussions, create video walkthrough

**Risk 3: Circular @-reference Detection Failure**
- **Likelihood**: Low
- **Impact**: Medium (infinite loop, agent hang)
- **Mitigation**: Implement depth limit (max 3 levels), add circular reference detection
- **Contingency**: Document manual @-reference verification in migration guide

### Business Risks

**Risk 1: Low User Adoption of Migration**
- **Likelihood**: Medium
- **Impact**: Medium (users don't benefit from modular rules)
- **Mitigation**: Make migration opt-in, ensure backward compatibility (old CLAUDE.md still works)
- **Contingency**: Evangelize benefits via blog post, showcase examples

**Risk 2: Template Fragmentation (Old vs New Structure)**
- **Likelihood**: Medium
- **Impact**: Low (support burden)
- **Mitigation**: Provide clear upgrade path, deprecation timeline
- **Contingency**: Support both structures for 6 months, then sunset old CLAUDE.md

### Dependencies

**Internal Dependencies**:
- **Architect Spike**: @-syntax feasibility investigation (blocking Phase 2 implementation)
- **Constitution Update**: May need to reference modular rules structure (non-blocking)

**External Dependencies**:
- **Claude Code @-syntax Support**: Critical path dependency (if unavailable, MVP scope reduces to modular files only)
- **Markdown Spec**: Standard markdown compatibility (low risk, well-established)

**Dependency Graph**:
```
[This Feature: Claude Code Memory]
  ├─ Depends on: Claude Code @-syntax support (critical, spike in Phase 1)
  ├─ Depends on: Constitution Principle X (references CLAUDE.md structure) (minor, docs update)
  └─ Blocks: None (standalone feature)
```

---

## Open Questions

**Format**: [Question] - [Owner] - [Due Date] - [Status]

### Product Questions
- [ ] Should we provide automated migration script or manual guide only? - product-manager - Week 1, Day 1 - Pending
- [ ] What's the right granularity for rule files (6 files vs 10+ files)? - product-manager - Week 1, Day 2 - Pending
- [ ] Do we need rule file templates for custom governance? - product-manager - Week 1, Day 3 - Pending

### Technical Questions
- [ ] Does Claude Code support `@path/to/file.md` inline loading syntax? - architect - Week 1, Day 1 - Pending (SPIKE)
- [ ] What's the max depth for nested @-references (2 vs 3 vs unlimited)? - architect - Week 1, Day 2 - Pending
- [ ] How do we detect and prevent circular @-references? - architect - Week 1, Day 3 - Pending
- [ ] Should we validate markdown syntax in rule files? - architect - Week 1, Day 4 - Pending

### Design Questions
- [ ] Should CLAUDE.md include rule file summaries or just @-references? - product-manager - Week 1, Day 2 - Pending
- [ ] What's the best naming convention for rule files (kebab-case vs snake_case)? - architect - Week 1, Day 1 - Pending

### Business Questions
- [ ] What's the expected adoption rate for modular rules? - product-manager - Week 2 - Researching
- [ ] Should we sunset old CLAUDE.md structure (timeline)? - product-manager - Week 3 - Pending

---

## References

### Product Documentation
- Product Vision: docs/product/01_Product_Vision/README.md (template overview)
- OKRs: N/A (not defined yet)
- Roadmap: N/A (not defined yet)
- User Stories: N/A (not defined yet)
- Customer Journeys: N/A (not defined yet)

### Technical Documentation
- Constitution: .specify/memory/constitution.md (Principle X: Product-Spec Alignment)
- CLAUDE.md: Current monolithic structure (migration source)
- Spec Kit Triad: docs/SPEC_KIT_TRIAD.md (workflow reference)

### Research & Analysis
- User Research: N/A (to be conducted)
- Competitive Analysis: N/A (unique to this template)
- Market Analysis: N/A (internal tooling)

### External Resources
- Claude Code Documentation: [Link TBD after @-syntax spike]
- Markdown Specification: [CommonMark](https://commonmark.org/)

---

## Triad Validation

### Current State Analysis
**Completion Percentage**: 0% (greenfield feature)
- CLAUDE.md: Exists (192 lines, monolithic)
- `.claude/rules/`: Does not exist
- @-reference syntax: Not implemented

**Baseline**: This is a feature PRD (not infrastructure), no architect baseline needed per Constitution Principle XI.

### Tech-Lead Feasibility
**Report**: TBD - Pending `/triad.feasibility` execution
- **Timeline Estimate**: TBD (pending tech-lead)
- **Agent Assignments**: TBD (pending tech-lead)
- **Confidence**: TBD (pending tech-lead)

### Architect Technical Review
**Report**: TBD - Pending architect review after PRD draft
- **Verdict**: Pending
- **Technical Notes**: @-syntax spike required before implementation

---

## Approval & Sign-Off

### PRD Review Checklist

**Product Manager** (product-manager):
- [ ] Problem statement is clear and user-focused
- [ ] User stories have measurable acceptance criteria
- [ ] Success metrics are defined and measurable
- [ ] Scope is realistic for timeline
- [ ] Risks and dependencies identified
- [ ] Aligns with product vision (template usability)

**Architect**:
- [ ] Technical requirements are clear
- [ ] @-syntax spike identified as critical dependency
- [ ] Non-functional requirements are realistic
- [ ] Dependencies are accurate
- [ ] Technical risks are identified

**Engineering Lead** (team-lead):
- [ ] Requirements are implementable
- [ ] Effort estimates will be provided in feasibility check
- [ ] Team capacity will be validated
- [ ] Timeline will be estimated

### Approval Status

| Role | Name | Status | Date | Comments |
|------|------|--------|------|----------|
| Product Manager | product-manager | 📋 Pending | - | Awaiting Triad review |
| Architect | architect | 📋 Pending | - | @-syntax spike required |
| Engineering Lead | team-lead | 📋 Pending | - | Feasibility check pending |

Legend: ✅ Approved | 🟡 Approved with Comments | ❌ Rejected | 📋 Pending

---

## Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2025-12-15 | product-manager | Initial PRD draft |

---

## Appendix A: Current CLAUDE.md Structure Analysis

**Line Count Breakdown** (192 total lines):
- Core Constraints: 9 lines
- Git Workflow: 5 lines
- Project Structure: 25 lines
- Scope Boundaries: 9 lines
- Commands: 22 lines (Triad + Vanilla)
- SDLC Triad Workflow: 13 lines
- Context Loading: 26 lines
- Governance Workflow: 29 lines
- Deployment Policy: 12 lines
- Key Principles: 9 lines
- Tips: 4 lines
- Tech Stack: 4 lines
- Recent Changes: 3 lines
- Active Technologies: 2 lines

**Extraction Targets for `.claude/rules/`**:
1. `governance.md`: Lines 124-153 (Governance Workflow) - 29 lines
2. `git-workflow.md`: Lines 11-15 (Git Workflow) - 5 lines + expanded
3. `deployment.md`: Lines 155-166 (Deployment Policy) - 12 lines
4. `scope.md`: Lines 48-57 (Scope Boundaries) - 9 lines
5. `commands.md`: Lines 59-81 (Commands) - 22 lines
6. `context-loading.md`: Lines 97-122 (Context Loading) - 26 lines

**Total Extractable**: ~103 lines (54% of CLAUDE.md)
**Remaining in CLAUDE.md**: ~89 lines (Core Constraints, Project Structure, Key Principles, etc.)

**Target CLAUDE.md Size**: ≤80 lines (after adding @-references and light editing)

---

## Appendix B: @-reference Syntax Spike Plan

**Objective**: Validate Claude Code support for `@path/to/file.md` inline loading

**Test Cases**:
1. **Basic @-reference**: `@.claude/rules/test.md` → File content loaded inline
2. **Nested @-reference**: test.md contains `@.claude/rules/nested.md` → Nested content loaded
3. **File not found**: `@.claude/rules/missing.md` → Clear error message
4. **Circular reference**: A references B, B references A → Error detected
5. **Relative paths**: `@.claude/rules/sub/file.md` → Subdirectory support

**Acceptance Criteria**:
- [ ] Claude Code loads @-referenced files inline (no manual cat needed)
- [ ] Nested @-references work (depth 2 minimum)
- [ ] File not found errors are clear and actionable
- [ ] Circular references are detected and prevented

**Deliverable**: Spike report documenting:
- @-syntax support status (YES/NO)
- Max nesting depth supported
- Error handling behavior
- Workarounds if unsupported

**Timeline**: Week 1, Day 1 (2 hours)
**Owner**: architect

---

## Appendix C: Migration Guide Outline

**MIGRATION.md Structure** (to be created in implementation):

```markdown
# Migrating to Modular CLAUDE.md

## Overview
This guide helps you migrate from monolithic CLAUDE.md (192 lines) to modular `.claude/rules/` structure.

## Why Migrate?
- Easier maintenance (edit focused rule files)
- Faster context loading (@-references vs manual cat)
- Clearer governance structure

## Migration Steps

### Step 1: Back Up Current CLAUDE.md
[Instructions]

### Step 2: Create `.claude/rules/` Directory
[Instructions]

### Step 3: Extract Governance Content
[Instructions with line number references]

### Step 4: Update CLAUDE.md with @-references
[Instructions with examples]

### Step 5: Validate Migration
[Run validation script]

## Validation Script
[Bash script to check migration completeness]

## Rollback Instructions
[How to revert if needed]

## FAQ
[Common questions and answers]
```

**Deliverable**: Complete MIGRATION.md during implementation (Phase 2)

---

**End of PRD**
