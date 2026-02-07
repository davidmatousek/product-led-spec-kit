# PRD Technical Review: Remove SpecKit Commands & Transfer to Triad

**Reviewer**: Architect
**Date**: 2026-02-07
**PRD Topic**: Remove SpecKit Commands and Transfer Content to Triad
**Review Type**: Technical Feasibility & Architecture

---

## Executive Summary

**STATUS**: APPROVED_WITH_CONCERNS

This PRD proposes a significant architectural consolidation of the command layer by inlining speckit command logic into triad commands and eliminating the speckit command files. The technical approach is sound and feasible, but implementation risks require careful attention to maintain system stability.

---

## Technical Feasibility Analysis

### Architecture Assessment

**Current Architecture**:
- Triad commands (6 files) act as governance wrappers
- Speckit commands (8 files) contain core implementation logic
- Triad commands invoke speckit commands via Skill tool
- Clear separation: governance layer (triad) vs. execution layer (speckit)

**Proposed Architecture**:
- Triad commands (10 files) contain both governance + core logic
- Speckit command files deleted entirely
- Single-layer architecture with integrated governance

**Technical Verdict**: ✅ FEASIBLE

The merge is architecturally sound because:
1. Commands are markdown prompt templates, not executable code
2. No runtime dependencies or API contracts to maintain
3. Skill tool invocations can be replaced with inline instructions
4. File length increase is manageable (governance + logic fits in single files)

### Technology Stack Compatibility

**Current Stack**:
- Claude Code CLI command system
- Markdown-based command definitions
- Skill tool for command composition
- Bash scripts for underlying operations

**Impact Assessment**: ✅ NO BREAKING CHANGES

All underlying technology remains unchanged:
- `.specify/scripts/bash/` scripts: NO CHANGES
- Templates: NO CHANGES
- Agents: NO CHANGES
- Only command prompt files are being consolidated

---

## Scalability Review

### File Size Impact

**Before**:
- Triad commands: ~100-180 lines each (governance only)
- Speckit commands: ~150-230 lines each (logic only)

**After (estimated)**:
- Combined triad commands: ~250-400 lines each (governance + logic)

**Scalability Verdict**: ✅ ACCEPTABLE

Markdown files at 400 lines remain maintainable. However, consider:
- **Concern**: If governance or logic grows significantly in future, single files could become unwieldy
- **Mitigation**: Document clear section boundaries within merged files for easier navigation
- **Threshold**: Monitor for commands exceeding 500 lines (consider modularization if reached)

### Command Discovery & Navigation

**Before**: 14 total command files (6 triad + 8 speckit)
**After**: 10 total command files (10 triad)

**Impact**: ✅ IMPROVED

- 29% reduction in total command files
- Simpler mental model (one command set instead of two)
- Eliminated confusion about which command to use

---

## Security Considerations

### Access Control

**Current State**:
- Both command sets have equal access to filesystem, scripts, and tools
- No permission boundaries between speckit and triad

**Post-Merge State**:
- Same access level, consolidated into single command set

**Security Verdict**: ✅ NO NEW RISKS

This is a code organization refactor, not a permission or access change.

### Data Flow & Validation

**Risk**: Merged commands contain more complex logic paths (governance gates + execution)

**Mitigation Requirements**:
1. Preserve all existing validation checkpoints from speckit commands
2. Ensure governance gates from triad commands remain intact
3. Maintain error handling for both layers

**Recommendation**: Include validation testing in implementation plan to confirm no regression in:
- PRD prerequisite checking
- File existence validation
- Frontmatter parsing
- Sign-off status verification

---

## Performance Assessment

### Execution Performance

**Before**: Triad command → Skill tool invocation → Speckit command execution
**After**: Triad command → Direct execution (no Skill tool indirection)

**Performance Verdict**: ✅ SLIGHT IMPROVEMENT

Eliminating Skill tool invocation layer may reduce overhead, though impact is minimal (sub-second for prompt loading).

### Development Workflow Impact

**Concern**: Longer files may slow down iterative editing and testing

**Mitigation**:
- Use clear section markers within merged files
- Consider editor folding/navigation aids in documentation
- Maintain comprehensive inline comments for complex flows

---

## Migration Risks & Mitigation

### High-Risk Areas

| Risk | Severity | Mitigation |
|------|----------|------------|
| **Cross-reference errors** | HIGH | Comprehensive grep for `/speckit.` in all docs, update to `/triad.` |
| **Incomplete logic transfer** | HIGH | Diff-based validation: ensure all speckit content appears in corresponding triad file |
| **Broken governance gates** | MEDIUM | Test each merged command with validation scenarios |
| **Documentation drift** | MEDIUM | Parallel doc updates as part of implementation (FR-4) |
| **User confusion during transition** | LOW | Clear migration guide if users have local modifications |

### Critical Success Factors

1. **Validation Strategy**: Must verify logic completeness before deletion
   - Use diff tools to compare original speckit vs. merged triad content
   - Checklist: every validation, every script call, every error message preserved

2. **Reference Updates**: Comprehensive search-and-replace across codebase
   - Pattern: `/speckit.(specify|plan|tasks|implement)` → `/triad.$1`
   - Pattern: `speckit.` → `triad.` in prose references
   - Files to check: `docs/`, `.claude/`, `CLAUDE.md`, `.claude/rules/`

3. **Backward Compatibility**: Consider deprecation path
   - **Recommendation**: Create stub speckit commands that redirect to triad commands for one version
   - Example: `speckit.specify.md` contains: "⚠️ DEPRECATED: Use /triad.specify instead"
   - Allows graceful transition if users have muscle memory or scripts

---

## Architecture Decision Records (ADRs)

### ADR-1: Single Command Layer vs. Layered Architecture

**Decision**: Consolidate to single-layer triad commands

**Rationale**:
- Simplifies architecture (fewer files, clearer responsibility)
- Eliminates Skill tool invocation overhead
- Reduces maintenance burden (one file per workflow stage instead of two)

**Trade-offs**:
- Longer individual files (harder to scan)
- Loss of clear governance/execution separation
- Future modularization requires splitting files again

**Reversibility**: MEDIUM (can split files again, but cross-references would need updating)

### ADR-2: Speckit-Only Commands → New Triad Commands

**Decision**: Create triad.clarify, triad.analyze, triad.checklist, triad.constitution

**Rationale**:
- These utilities have no governance layer today
- Bringing them into triad namespace provides consistency
- Future-proofs for potential governance integration

**Trade-offs**:
- These commands won't have sign-off workflows initially (no governance change)
- Namespace suggests governance that doesn't exist for these commands

**Alternative Considered**: Keep as `speckit.*` utilities
**Why Rejected**: Creates inconsistent command namespace post-migration

---

## Technical Debt Assessment

### Debt Being Removed

✅ **Command layer complexity**: Eliminates wrapper pattern that added cognitive overhead
✅ **Cross-file synchronization**: No more keeping governance + logic files in sync
✅ **Skill tool dependency**: Reduces reliance on indirect command invocation

### Debt Being Introduced

⚠️ **File length**: Commands now contain more logic per file (manageable but warrants monitoring)
⚠️ **Modularity loss**: Can't reuse core logic without governance layer in edge cases

**Net Debt Impact**: POSITIVE (debt reduction outweighs new debt)

---

## Implementation Concerns

### FR-1: Inline Speckit Logic into Triad Commands

**Concern**: Manual merge process is error-prone

**Recommendations**:
1. Create merge checklist template for each command pair
2. Use diff tools to validate completeness
3. Preserve all comments, validation checks, and error messages
4. Test each merged command before proceeding to next

**Validation Criteria**:
- [ ] All script invocations preserved
- [ ] All validation gates intact
- [ ] All error messages retained
- [ ] Governance frontmatter injection preserved
- [ ] Cross-references updated

### FR-2: Create 4 New Triad Commands

**Concern**: Clarify, analyze, checklist, constitution have no governance counterparts

**Recommendation**:
- Migrate content AS-IS with minimal changes
- Add frontmatter for consistency: `compatible_with_speckit`, `last_tested_with_speckit`
- Document in command description: "This command has no governance layer (no sign-offs)"

### FR-3: Delete Speckit Files

**Concern**: Irreversible deletion of working code

**Recommendations**:
1. Create archive branch before deletion: `archive/speckit-commands`
2. Tag final speckit version: `v2.0-speckit-final`
3. Only delete after all validation tests pass
4. Consider deprecation warnings first (see backward compatibility above)

### FR-4: Update Documentation

**Concern**: Documentation references scattered across many files

**Recommendations**:
1. Use comprehensive grep patterns:
   ```bash
   grep -r "/speckit\." docs/ .claude/ CLAUDE.md .claude/rules/
   grep -ri "speckit command" docs/
   grep -r "vanilla command" docs/
   ```
2. Update in priority order:
   - CLAUDE.md (highest visibility)
   - docs/SPEC_KIT_TRIAD.md (core reference)
   - .claude/rules/*.md (governance rules)
   - Other docs/* files
3. Validate all links/references after updates

### FR-5: Update Command Registration

**Concern**: Command discovery relies on file presence

**Recommendations**:
- Verify command loading mechanism (likely automatic file discovery)
- Test command autocomplete after migration
- Update any command index/registry files if they exist
- Verify help text/command listings reflect new structure

---

## Quality Gates

### Pre-Implementation Validation

- [ ] All speckit command content mapped to target triad commands
- [ ] All 4 new triad commands (clarify, analyze, checklist, constitution) designed
- [ ] Documentation update plan with file list created
- [ ] Test scenarios defined for each merged command

### During Implementation

- [ ] Each command merge validated with diff comparison
- [ ] Cross-references updated incrementally
- [ ] Archive branch created with original speckit commands
- [ ] Version tag applied before deletion

### Post-Implementation Validation

- [ ] All 10 triad commands tested end-to-end
- [ ] No broken links in documentation (automated link checker)
- [ ] No remaining `/speckit.` references (grep validation)
- [ ] Command autocomplete/help reflects new structure
- [ ] Governance workflows still function correctly

---

## Recommendations

### MUST Address Before Implementation

1. **Create comprehensive merge validation checklist** for each command pair
2. **Archive original speckit commands** before deletion (branch + tag)
3. **Define test scenarios** for each merged command to validate logic preservation
4. **Document clear section boundaries** within merged files for maintainability

### SHOULD Consider

1. **Deprecation warnings** in speckit commands for one version before deletion
2. **Migration guide** for users with local modifications or custom workflows
3. **Automated link checker** to validate documentation references post-update
4. **Version bump** to v3.0.0 (breaking change: command namespace removal)

### COULD Enhance

1. **Modularization strategy** if command files exceed 500 lines in future
2. **Command alias system** if users have muscle memory for speckit commands
3. **Rollback plan** documenting how to revert if issues discovered post-migration

---

## Final Verdict

**STATUS**: APPROVED_WITH_CONCERNS

**Summary**: This PRD is technically sound and feasible. The architectural consolidation simplifies the system and reduces technical debt. However, the manual merge process carries execution risk that must be mitigated through careful validation and testing.

**Conditions for Approval**:
1. ✅ Create archive branch and version tag before deletion
2. ✅ Implement comprehensive validation checklist for merges
3. ✅ Test each merged command before proceeding
4. ✅ Use automated tools to validate cross-reference updates

**Blocking Issues**: NONE

**Timeline Impact**: The manual merge and validation process will be time-intensive. Estimate 1-2 hours per command pair (8 total) + 2-4 hours for documentation updates. Total: 12-20 hours of careful, methodical work.

**Next Steps**: Proceed to `/triad.specify` to create detailed specification with these concerns addressed.

---

**Architect Sign-off**: APPROVED_WITH_CONCERNS
**Review Date**: 2026-02-07
**Follow-up Required**: Implementation plan must address validation strategy and archive creation
