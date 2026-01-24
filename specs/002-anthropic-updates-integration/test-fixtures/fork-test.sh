#!/usr/bin/env bash
# Context Forking Validation Test
# Feature: 002-anthropic-updates-integration
# Created: 2026-01-24
#
# Tests context forking skill files and result merging logic.

set -euo pipefail

# Test configuration
readonly TEST_NAME="Context Forking"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${SCRIPT_DIR}/../../.."
readonly SKILLS_DIR="${PROJECT_ROOT}/.claude/skills/triad"
readonly LIB_DIR="${PROJECT_ROOT}/.claude/lib/triad"

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# ============================================================================
# Test Utilities
# ============================================================================

pass() {
    local test_name="$1"
    ((TESTS_PASSED++))
    ((TESTS_RUN++))
    echo "  ✅ PASS: $test_name"
}

fail() {
    local test_name="$1"
    local message="${2:-}"
    ((TESTS_FAILED++))
    ((TESTS_RUN++))
    echo "  ❌ FAIL: $test_name"
    if [[ -n "$message" ]]; then
        echo "     Reason: $message"
    fi
}

section() {
    echo ""
    echo "=== $1 ==="
}

# ============================================================================
# Skill File Tests
# ============================================================================

test_pm_review_skill_exists() {
    if [[ -f "${SKILLS_DIR}/pm-review.md" ]]; then
        pass "pm-review.md exists"
    else
        fail "pm-review.md exists" "File not found"
    fi
}

test_architect_review_skill_exists() {
    if [[ -f "${SKILLS_DIR}/architect-review.md" ]]; then
        pass "architect-review.md exists"
    else
        fail "architect-review.md exists" "File not found"
    fi
}

test_teamlead_review_skill_exists() {
    if [[ -f "${SKILLS_DIR}/teamlead-review.md" ]]; then
        pass "teamlead-review.md exists"
    else
        fail "teamlead-review.md exists" "File not found"
    fi
}

test_pm_review_has_fork_context() {
    if grep -q "context: fork" "${SKILLS_DIR}/pm-review.md"; then
        pass "pm-review.md has context: fork"
    else
        fail "pm-review.md has context: fork" "Missing frontmatter"
    fi
}

test_architect_review_has_fork_context() {
    if grep -q "context: fork" "${SKILLS_DIR}/architect-review.md"; then
        pass "architect-review.md has context: fork"
    else
        fail "architect-review.md has context: fork" "Missing frontmatter"
    fi
}

test_teamlead_review_has_fork_context() {
    if grep -q "context: fork" "${SKILLS_DIR}/teamlead-review.md"; then
        pass "teamlead-review.md has context: fork"
    else
        fail "teamlead-review.md has context: fork" "Missing frontmatter"
    fi
}

test_skills_have_agent_type() {
    local all_have_agent=true

    for skill in pm-review architect-review teamlead-review; do
        if ! grep -q "agent:" "${SKILLS_DIR}/${skill}.md"; then
            all_have_agent=false
            fail "${skill}.md has agent type" "Missing agent: frontmatter"
        fi
    done

    if [[ "$all_have_agent" == "true" ]]; then
        pass "All skills have agent type defined"
    fi
}

# ============================================================================
# Merge Logic Tests
# ============================================================================

test_merge_results_script_exists() {
    if [[ -f "${LIB_DIR}/merge-results.sh" ]]; then
        pass "merge-results.sh exists"
    else
        fail "merge-results.sh exists" "File not found"
    fi
}

test_merge_results_syntax() {
    if bash -n "${LIB_DIR}/merge-results.sh" 2>/dev/null; then
        pass "merge-results.sh has valid syntax"
    else
        fail "merge-results.sh has valid syntax" "Syntax errors"
    fi
}

test_status_severity_ranking() {
    source "${LIB_DIR}/merge-results.sh"

    local sev_approved sev_concerns sev_changes sev_blocked

    sev_approved=$(get_status_severity "APPROVED")
    sev_concerns=$(get_status_severity "APPROVED_WITH_CONCERNS")
    sev_changes=$(get_status_severity "CHANGES_REQUESTED")
    sev_blocked=$(get_status_severity "BLOCKED")

    if (( sev_approved < sev_concerns && sev_concerns < sev_changes && sev_changes < sev_blocked )); then
        pass "Status severity ranking correct"
    else
        fail "Status severity ranking correct" "Ranking: $sev_approved < $sev_concerns < $sev_changes < $sev_blocked"
    fi
}

test_merge_two_equal() {
    source "${LIB_DIR}/merge-results.sh"

    local result
    result=$(merge_two_statuses "APPROVED" "APPROVED")

    if [[ "$result" == "APPROVED" ]]; then
        pass "Merge equal statuses"
    else
        fail "Merge equal statuses" "Expected APPROVED, got $result"
    fi
}

test_merge_two_different() {
    source "${LIB_DIR}/merge-results.sh"

    local result
    result=$(merge_two_statuses "APPROVED" "APPROVED_WITH_CONCERNS")

    if [[ "$result" == "APPROVED_WITH_CONCERNS" ]]; then
        pass "Merge different statuses (more severe wins)"
    else
        fail "Merge different statuses" "Expected APPROVED_WITH_CONCERNS, got $result"
    fi
}

test_merge_with_blocked() {
    source "${LIB_DIR}/merge-results.sh"

    local result
    result=$(merge_review_statuses "APPROVED" "APPROVED" "BLOCKED")

    if [[ "$result" == "BLOCKED" ]]; then
        pass "Merge with BLOCKED (blocked wins)"
    else
        fail "Merge with BLOCKED" "Expected BLOCKED, got $result"
    fi
}

test_is_approved_function() {
    source "${LIB_DIR}/merge-results.sh"

    if is_approved "APPROVED" && is_approved "APPROVED_WITH_CONCERNS"; then
        pass "is_approved returns true for approvable statuses"
    else
        fail "is_approved function" "Should return true for APPROVED variants"
    fi

    if ! is_approved "BLOCKED"; then
        pass "is_approved returns false for BLOCKED"
    else
        fail "is_approved for BLOCKED" "Should return false for BLOCKED"
    fi
}

test_is_blocked_function() {
    source "${LIB_DIR}/merge-results.sh"

    if is_blocked "BLOCKED" && is_blocked "NOT_FEASIBLE"; then
        pass "is_blocked returns true for blocking statuses"
    else
        fail "is_blocked function" "Should return true for BLOCKED/NOT_FEASIBLE"
    fi

    if ! is_blocked "APPROVED"; then
        pass "is_blocked returns false for APPROVED"
    else
        fail "is_blocked for APPROVED" "Should return false for APPROVED"
    fi
}

test_create_merged_result() {
    source "${LIB_DIR}/merge-results.sh"

    local result
    result=$(create_merged_result "APPROVED_WITH_CONCERNS" "APPROVED" "APPROVED_WITH_CONCERNS" 2>/dev/null || true)

    if echo "$result" | grep -q "APPROVED_WITH_CONCERNS"; then
        pass "create_merged_result includes final status"
    else
        fail "create_merged_result" "Missing final status in output"
    fi

    if echo "$result" | grep -q "PM"; then
        pass "create_merged_result includes reviewer table"
    else
        fail "create_merged_result reviewer table" "Missing reviewer info"
    fi
}

# ============================================================================
# Main Test Runner
# ============================================================================

main() {
    echo "========================================"
    echo "  ${TEST_NAME} Integration Tests"
    echo "========================================"
    echo "Project Root: ${PROJECT_ROOT}"
    echo ""

    section "Skill File Existence Tests"
    test_pm_review_skill_exists
    test_architect_review_skill_exists
    test_teamlead_review_skill_exists

    section "Skill Frontmatter Tests"
    test_pm_review_has_fork_context
    test_architect_review_has_fork_context
    test_teamlead_review_has_fork_context
    test_skills_have_agent_type

    section "Merge Results Script Tests"
    test_merge_results_script_exists
    test_merge_results_syntax

    section "Status Merging Logic Tests"
    test_status_severity_ranking
    test_merge_two_equal
    test_merge_two_different
    test_merge_with_blocked

    section "Helper Function Tests"
    test_is_approved_function
    test_is_blocked_function
    test_create_merged_result

    # Summary
    echo ""
    echo "========================================"
    echo "  Test Summary"
    echo "========================================"
    echo "  Tests Run:    ${TESTS_RUN}"
    echo "  Tests Passed: ${TESTS_PASSED}"
    echo "  Tests Failed: ${TESTS_FAILED}"
    echo ""

    if [[ ${TESTS_FAILED} -eq 0 ]]; then
        echo "✅ All tests passed!"
        exit 0
    else
        echo "❌ Some tests failed!"
        exit 1
    fi
}

# Run tests
main "$@"
