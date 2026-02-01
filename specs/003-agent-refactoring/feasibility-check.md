# Feasibility Check: Agent Refactoring - All 12 Agents

**Feature**: 003-agent-refactoring-all-agents
**Date**: 2026-01-31
**Tech-Lead**: Claude (team-lead agent)

---

## Effort Estimation

**Work Streams**:

1. **Foundation Documentation (Week 1)**: 16-20 hours
   - Create `_AGENT_BEST_PRACTICES.md` (1,561 lines): 12-14 hours
     - Research synthesis from CISO_Agent patterns
     - Document 8 core principles with examples
     - Create 8-section structure template
     - Write preservation-first 11-step process
     - Develop quality evaluator checklist
   - Create `_README.md` (236 lines): 4-6 hours
     - Extract agent roster from all 12 agents
     - Create quick reference table
     - Document Triad governance integration

2. **Priority Agent Refactoring (Week 2)**: 24-32 hours
   - architect.md (1,026→250 lines, 77% reduction): 10-12 hours
     - Remove 550+ lines of code examples
     - Condense workflows
     - Reference skills instead of embedding
   - team-lead.md split (1,346→200+250, 66% reduction): 12-16 hours
     - Split governance vs orchestration concerns
     - Create new orchestrator.md
     - Update cross-references and handoff patterns
   - product-manager.md (430→250 lines, 42% reduction): 2-4 hours
     - Condense communication/documentation sections
     - Reference prd-create skill

3. **Medium Agents + YAML Standardization (Week 3)**: 30-40 hours
   - code-reviewer.md (1,100→250, 77%): 8-10 hours
   - debugger.md (1,033→250, 76%): 8-10 hours
   - tester.md (509→250, 51%): 4-5 hours
   - devops.md (578→250, 57%): 5-6 hours
   - senior-backend-engineer.md (411→250, 39%): 3-4 hours
   - YAML frontmatter standardization (all 12 agents): 2-5 hours

4. **Final Agents (Week 4)**: 12-16 hours
   - ux-ui-designer.md (392→250, 36%): 3-4 hours
   - security-analyst.md (390→250, 36%): 3-4 hours
   - web-researcher.md (364→250, 31%): 2-3 hours
   - frontend-developer.md (306→250, 18%): 2-3 hours
   - Quality validation (all 12 agents, 8/8 criteria): 2-2 hours

5. **Testing & Validation**: 8-12 hours
   - Test each refactored agent with representative tasks
   - Validate preservation of capabilities
   - YAML frontmatter consistency check
   - Quality evaluator validation (8 criteria × 12 agents)
   - Final Triad sign-offs

**Total Effort**: 90-120 hours (2.25-3 work-weeks at 40 hours/week)

**Confidence Level**: **High (90%)**

**Confidence Rationale**:
- CISO_Agent blueprint provides proven refactoring pattern (already validated architect 77% reduction)
- Line counts verified (7,885 total confirmed)
- Clear preservation-first process minimizes risk of breaking functionality
- Phased approach allows course correction after priority agents
- Team has experience with similar refactoring (Feature 001, 002 completed)

---

## Agent Assignment Preview

**Agents Required**:

**Primary Agent (Refactoring Work)**:
- **architect**: 90-120 hours - Lead ALL refactoring work
  - Week 1: Create foundation docs (16-20h)
  - Week 2: Refactor priority agents (24-32h)
  - Week 3: Refactor medium agents + YAML (30-40h)
  - Week 4: Refactor final agents + validation (12-16h)
  - Testing throughout (8-12h)

**Supporting Agents (Reviews & Validation)**:
- **product-manager**: 6-8 hours - PM sign-offs at each phase
  - Week 1: Foundation review (2h)
  - Week 2: Priority agents review (2h)
  - Week 3: Medium agents review (1h)
  - Week 4: Final review (1-3h)

- **team-lead**: 4-6 hours - Feasibility checks and final sign-off
  - Week 1: Foundation feasibility (this document, 1h)
  - Week 2: Priority agents capacity check (1h)
  - Week 4: Final timeline validation and sign-off (2-4h)

**Workload Distribution**: **ARCHITECT HEAVILY LOADED (100% capacity all 4 weeks)**

**Workload Notes**:
- **Critical Bottleneck**: Single architect agent handling all 12 agent refactorings
- **Capacity Concern**: 90-120 hours over 4 weeks = 22.5-30 hours/week (56-75% of 40-hour week)
- **Risk**: If architect encounters blockers, entire timeline at risk (no parallel execution possible for refactoring work)
- **Mitigation Opportunity**: Some agents could potentially be refactored in parallel batches if we had multiple agents with refactoring expertise, but architect is the domain expert per CISO_Agent best practices

**Optimization Opportunities**:
- Week 3 Medium Agents (5 agents): Could theoretically parallelize if we trained a second refactoring agent, saving 15-20 hours
- Week 4 Final Agents (4 agents): Similarly could parallelize, saving 6-8 hours
- **Decision**: Keep sequential with single architect to maintain consistency and quality (CISO_Agent pattern expertise)

---

## Timeline Estimate

**Critical Path**: Foundation docs → Priority agents → Medium agents → Final agents (sequential dependency chain)

**Dependencies**:
- **Foundation First (Blocking)**: `_AGENT_BEST_PRACTICES.md` must exist before refactoring any agents (provides templates, guidelines, quality checklist)
- **Priority Before Medium (Recommended)**: Architect + Team-Lead refactoring validates line targets and preservation process before scaling to 9 remaining agents
- **Sequential Within Phases**: Each agent refactoring builds expertise for next (learning curve optimization)

**Parallel Opportunities**:
- **Week 1**: Foundation docs could be split (best practices guide vs README) → Minimal time savings (2-3 hours)
- **Week 3**: Medium agents (5 agents) theoretically parallel IF we had multiple refactoring experts → Not recommended (consistency risk)
- **Week 4**: Final agents (4 agents) theoretically parallel → Same limitation
- **Conclusion**: Minimal viable parallel execution due to single-expert constraint (architect domain expertise)

**Realistic Timeline**:

- **Optimistic**: **3 weeks** (90 hours / 30 hours per week = 3 weeks)
  - Assumes: All refactorings under 250 lines achievable, no major preservation issues, minimal rework
  - Conditions: Architect works 30h/week focused time, no blockers, quality checks pass on first attempt
  - Probability: 20-30%

- **Realistic**: **4 weeks** (105 hours / 26 hours per week = 4.03 weeks)
  - Assumes: Some agents require 300-line justification, minor rework after reviews, typical blockers
  - Conditions: Architect works 26h/week (65% capacity), 1-2 agents need second pass, normal review cycles
  - Probability: 60-70% (MATCHES PRD TIMELINE)

- **Pessimistic**: **5-6 weeks** (120 hours / 20 hours per week = 6 weeks)
  - Assumes: Multiple agents exceed 300 lines (require redesign), preservation issues found in testing, team-lead split complexity
  - Conditions: Architect works 20h/week (50% capacity, competing priorities), 3-4 agents need major rework, extended Triad review cycles
  - Probability: 10-20%

**Confidence Level**: **High (90%)**

**Recommendation**: **4-week timeline is REALISTIC and ACHIEVABLE**

- PRD proposed 4 weeks aligns with realistic scenario (105 hours / 26h per week)
- High confidence based on CISO_Agent proven blueprint
- Phased approach allows early detection of issues (Priority agents in Week 2)
- Built-in buffer: Optimistic path completes in 3 weeks, giving 1-week buffer

---

## Risk Assessment

**Timeline Risks**:

**Risk 1: Line Target Infeasible (250 lines) for Complex Agents**
- **Likelihood**: Medium (40%)
- **Impact**: Medium (adds 5-10 hours if agents need 300-line redesign)
- **Description**: Some agents (architect, team-lead, code-reviewer) may genuinely require >250 lines to preserve all capabilities without compromising quality
- **Mitigation**:
  - Allow 300-line max with documented justification (per best practices)
  - Use team-lead split pattern (1,346→200+250) if agent has separable concerns
  - Priority agents (Week 2) validate line targets early (course correction if needed)
- **Contingency**: If >3 agents require 300-line justification, extend timeline by 1 week and re-evaluate line targets with Triad

**Risk 2: Team-Lead Split Complexity (Governance vs Orchestration)**
- **Likelihood**: Medium (30%)
- **Impact**: Medium-High (adds 8-12 hours if handoff patterns unclear)
- **Description**: Splitting team-lead.md into team-lead (governance) + orchestrator (workflow) may create ambiguous boundaries or complex handoff patterns
- **Mitigation**:
  - Document clear decision criteria in `_README.md`: Use team-lead for sign-offs/feasibility, orchestrator for agent coordination
  - Test with representative multi-agent workflow (ensure handoff works)
  - Update all cross-references in other agents
- **Contingency**: If split proves too complex, keep unified team-lead.md at 450 lines (still 66% reduction) and document justification

**Risk 3: Preservation Validation Failures (Breaking Existing Behavior)**
- **Likelihood**: Low-Medium (25%)
- **Impact**: High (adds 10-20 hours per failed agent for rollback + redesign)
- **Description**: Aggressive refactoring could inadvertently remove critical capabilities despite preservation-first process
- **Mitigation**:
  - Test each refactored agent with 3-5 representative tasks from current workflows
  - Use quality evaluator criterion 8 (preservation validation)
  - Phased rollout (Priority agents first, validate before scaling to 9 remaining)
- **Contingency**: If preservation fails, rollback to git version, re-refactor with more conservative approach (fewer cuts, more references to original)

**Capacity Risks**:

**Risk 1: Architect Agent Bottleneck (Single Point of Failure)**
- **Likelihood**: Medium (35%)
- **Impact**: High (timeline extends 2-3 weeks if architect unavailable)
- **Description**: 100% of refactoring work depends on single architect agent; if blocked or unavailable, entire timeline at risk
- **Mitigation**:
  - Prioritize architect focus time (minimize competing requests during 4-week period)
  - Front-load Week 1-2 (Foundation + Priority) to establish patterns for Weeks 3-4
  - Document refactoring patterns in `_AGENT_BEST_PRACTICES.md` so others could theoretically continue
- **Contingency**: If architect blocked >1 week, consider training Jimmy (general-purpose agent) on refactoring patterns to handle simpler agents (frontend-developer, web-researcher)

**Risk 2: Triad Review Bottlenecks (PM + Architect + Team-Lead Availability)**
- **Likelihood**: Low (20%)
- **Impact**: Medium (adds 3-5 days if reviews delayed)
- **Description**: Triad sign-offs required at end of each phase; if reviewers unavailable, phase transitions delayed
- **Mitigation**:
  - Schedule Triad review windows in advance (end of Week 1, 2, 3, 4)
  - Use parallel review (Claude Code v2.1.16 context forking) where possible
  - Architect self-reviews during refactoring (catches issues early)
- **Contingency**: If review delayed >3 days, escalate to user for prioritization decision

**Scope Risks**:

**Risk 1: Scope Creep (Behavior Changes vs Refactoring Only)**
- **Likelihood**: Low-Medium (30%)
- **Impact**: High (adds 20-40 hours if behavior changes sneak in)
- **Description**: During refactoring, architect may identify improvement opportunities (better patterns, missing features) and expand beyond "refactoring only" mandate
- **Mitigation**:
  - Strict "preservation-first" rule enforced by quality checklist
  - Separate "Improvement Opportunities" document for post-refactoring work
  - PM veto authority on any behavior changes
- **Contingency**: If scope creep detected, freeze new changes, complete refactoring as-is, defer improvements to Feature 004 PRD

**Risk 2: Template Variable Ambiguity ({{VARS}} vs Concrete Values)**
- **Likelihood**: Low (15%)
- **Impact**: Low-Medium (adds 2-5 hours for clarification + rework)
- **Description**: Unclear when to preserve template variables ({{FRONTEND_FRAMEWORK}}) vs use concrete values (Product-Led-Spec-Kit is template, not infrastructure-specific)
- **Mitigation**:
  - Document clear guidance in `_AGENT_BEST_PRACTICES.md` (Week 1)
  - Decision tree: Tech stack choices = {{VAR}}, methodology = concrete
  - Review current agent {{VAR}} usage before refactoring
- **Contingency**: If ambiguity persists, default to preserving {{VARS}} (safer for template adopters)

**Risk 3: YAML Frontmatter Standardization Inconsistencies**
- **Likelihood**: Low (10%)
- **Impact**: Low (adds 1-2 hours for consistency fixes)
- **Description**: 12 agents may have slightly different YAML formats (multi-line vs single-line, field order variations)
- **Mitigation**:
  - Define exact YAML template in `_AGENT_BEST_PRACTICES.md`
  - Validate all 12 agents with same linter/checker
  - Week 3 dedicated YAML standardization pass
- **Contingency**: Automated script to normalize YAML format if manual inconsistencies found

---

## Feasibility Verdict

**Overall Assessment**: **FEASIBLE** ✅

**Reasoning**: PRD's 4-week timeline aligns with realistic effort estimate (90-120 hours at 26h/week = 4 weeks). CISO_Agent blueprint provides proven pattern (architect 77% reduction already validated). Phased approach allows early risk detection. High confidence (90%) in timeline achievability.

**Recommendations for PM**:

1. **Approve 4-week timeline** (matches realistic scenario, not optimistic)
   - Week 1: Foundation (16-20h)
   - Week 2: Priority agents (24-32h)
   - Week 3: Medium agents + YAML (30-40h)
   - Week 4: Final agents + validation (12-16h)

2. **Accept architect bottleneck risk** with mitigation
   - Single architect handles all refactoring (domain expertise required)
   - Minimize competing priorities for architect during 4-week period
   - Front-load Week 1-2 to establish patterns

3. **Plan for 300-line exceptions** (2-3 agents likely)
   - Allow documented justification for agents exceeding 250 lines
   - Require quality checklist still 8/8 pass (conciseness criterion adjusted)
   - Example: code-reviewer.md may need 280 lines (still 75% reduction from 1,100)

4. **Validate line targets after Priority agents** (Week 2)
   - Use architect.md (1,026→250) and team-lead split (1,346→450) as validation
   - If both achieve targets with preservation, proceed to medium agents
   - If either fails, pause and re-evaluate line targets before scaling

5. **Consider P2 agents (4 final) as stretch goal**
   - If Week 3 runs over, move P2 agents (ux-ui-designer, security-analyst, web-researcher, frontend-developer) to follow-up sprint
   - Still achieves 67% of agents (8/12) and 75% of line reduction if P0+P1 complete
   - Lower risk than rushing quality

**Next Steps**:

1. **PM**: Review feasibility check and approve/modify timeline
2. **Architect**: Begin Week 1 Foundation work on PM approval
   - Create `_AGENT_BEST_PRACTICES.md` (12-14h)
   - Create `_README.md` (4-6h)
3. **Team-Lead**: Schedule Triad review windows (end of each week)
4. **All**: Commit to 4-week focused effort (minimize competing priorities)

---

## Appendix: Effort Breakdown by Agent

| Agent | Current Lines | Target Lines | Reduction % | Estimated Effort | Rationale |
|-------|---------------|--------------|-------------|------------------|-----------|
| **architect.md** | 1,026 | 250 | 77% | 10-12 hours | Remove 550+ lines code examples, condense workflows, reference skills |
| **team-lead.md (split)** | 1,346 | 200 + 250 | 66% | 12-16 hours | Complex split (governance vs orchestration), create new orchestrator.md, update cross-refs |
| **product-manager.md** | 430 | 250 | 42% | 2-4 hours | Simpler refactoring, condense verbose sections, reference prd-create skill |
| **code-reviewer.md** | 1,100 | 250 | 77% | 8-10 hours | Large reduction, complex review workflows, preserve all quality criteria |
| **debugger.md** | 1,033 | 250 | 76% | 8-10 hours | Large reduction, preserve 5 Whys methodology, condense debugging patterns |
| **tester.md** | 509 | 250 | 51% | 4-5 hours | Moderate reduction, preserve BDD patterns, reference testing skills |
| **devops.md** | 578 | 250 | 57% | 5-6 hours | Moderate reduction, balance template vars vs concrete, preserve deployment patterns |
| **senior-backend-engineer.md** | 411 | 250 | 39% | 3-4 hours | Smaller reduction, straightforward refactoring |
| **ux-ui-designer.md** | 392 | 250 | 36% | 3-4 hours | Smaller reduction, straightforward refactoring |
| **security-analyst.md** | 390 | 250 | 36% | 3-4 hours | Smaller reduction, preserve security patterns |
| **web-researcher.md** | 364 | 250 | 31% | 2-3 hours | Minimal reduction, straightforward refactoring |
| **frontend-developer.md** | 306 | 250 | 18% | 2-3 hours | Minimal reduction, mostly structure + YAML standardization |

**Total Agent Refactoring**: 62-81 hours (excludes foundation docs, testing, validation)

**Complexity Factors**:
- **High Complexity** (12-16h each): team-lead split (new agent creation, cross-refs)
- **Medium-High Complexity** (8-12h each): architect, code-reviewer, debugger (large reductions, critical workflows)
- **Medium Complexity** (4-6h each): tester, devops (moderate reductions, balance preservation vs conciseness)
- **Low Complexity** (2-4h each): product-manager, senior-backend-engineer, ux-ui-designer, security-analyst, web-researcher, frontend-developer (straightforward refactoring)

---

**Feasibility Check Completed**: 2026-01-31 at 14:23 PST
**Time Spent**: 27 minutes (within 30-minute target ✅)
**Confidence**: High (90%)
**Verdict**: FEASIBLE - Approve 4-week timeline
