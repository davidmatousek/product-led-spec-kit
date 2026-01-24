#!/usr/bin/env bash
# Parallel Execution Validation Test
# Feature: 002-anthropic-updates-integration
# Created: 2026-01-24
#
# Tests parallel execution support including timing metrics and skill files.

set -euo pipefail

# Test configuration
readonly TEST_NAME="Parallel Execution"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${SCRIPT_DIR}/../../.."
readonly LIB_DIR="${PROJECT_ROOT}/.claude/lib/triad"
readonly SKILLS_DIR="${PROJECT_ROOT}/.claude/skills/triad"
readonly COMMANDS_DIR="${PROJECT_ROOT}/.claude/commands"

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
# Timing Metrics Tests
# ============================================================================

test_timing_script_exists() {
    if [[ -f "${LIB_DIR}/timing-metrics.sh" ]]; then
        pass "timing-metrics.sh exists"
    else
        fail "timing-metrics.sh exists" "File not found"
    fi
}

test_timing_script_syntax() {
    if bash -n "${LIB_DIR}/timing-metrics.sh" 2>/dev/null; then
        pass "timing-metrics.sh has valid syntax"
    else
        fail "timing-metrics.sh has valid syntax" "Syntax errors"
    fi
}

test_start_stop_timer() {
    source "${LIB_DIR}/timing-metrics.sh" 2>/dev/null || true

    # Start timer
    start_timer "test_operation" "parallel" 2>/dev/null

    # Brief pause
    sleep 0.1

    # Stop timer
    local duration
    duration=$(stop_timer 2>/dev/null)

    # Check that we got a duration
    if [[ -n "$duration" ]] && [[ "$duration" != "0" ]]; then
        pass "Timer start/stop works"
    else
        fail "Timer start/stop" "Duration was empty or zero"
    fi
}

test_calculate_time_savings() {
    source "${LIB_DIR}/timing-metrics.sh" 2>/dev/null || true

    local savings
    savings=$(calculate_time_savings "100" "60" 2>/dev/null || echo "")

    # Should calculate ~40% savings (100 - 60) / 100 * 100 = 40
    if [[ -n "$savings" ]]; then
        # Check if savings is reasonable (should be around 40)
        local int_savings=${savings%.*}
        if (( int_savings >= 35 && int_savings <= 45 )); then
            pass "Time savings calculation (40% expected)"
        else
            fail "Time savings calculation" "Expected ~40%, got $savings%"
        fi
    else
        fail "Time savings calculation" "Function returned empty"
    fi
}

test_generate_timing_summary() {
    source "${LIB_DIR}/timing-metrics.sh" 2>/dev/null || true

    local summary
    summary=$(generate_timing_summary "triad.plan" "parallel" "45.2" 2>/dev/null || echo "")

    if echo "$summary" | grep -q "Timing Summary"; then
        pass "generate_timing_summary produces output"
    else
        fail "generate_timing_summary" "Missing expected content"
    fi
}

# ============================================================================
# Forked Skills Tests
# ============================================================================

test_pm_review_skill_has_fork_context() {
    if [[ -f "${SKILLS_DIR}/pm-review.md" ]] && grep -q "context: fork" "${SKILLS_DIR}/pm-review.md"; then
        pass "PM review skill has context: fork"
    else
        fail "PM review skill has context: fork" "Missing or wrong frontmatter"
    fi
}

test_architect_review_skill_has_fork_context() {
    if [[ -f "${SKILLS_DIR}/architect-review.md" ]] && grep -q "context: fork" "${SKILLS_DIR}/architect-review.md"; then
        pass "Architect review skill has context: fork"
    else
        fail "Architect review skill has context: fork" "Missing or wrong frontmatter"
    fi
}

test_skills_have_agent_explore() {
    local all_have_agent=true

    for skill in pm-review architect-review teamlead-review; do
        if [[ -f "${SKILLS_DIR}/${skill}.md" ]] && grep -q "agent: Explore" "${SKILLS_DIR}/${skill}.md"; then
            : # OK
        else
            all_have_agent=false
        fi
    done

    if [[ "$all_have_agent" == "true" ]]; then
        pass "All skills have agent: Explore"
    else
        fail "Skills have agent: Explore" "Some skills missing agent type"
    fi
}

# ============================================================================
# Command Integration Tests
# ============================================================================

test_triad_plan_has_parallel_instructions() {
    if [[ -f "${COMMANDS_DIR}/triad.plan.md" ]] && \
       grep -q "parallel" "${COMMANDS_DIR}/triad.plan.md"; then
        pass "triad.plan has parallel execution instructions"
    else
        fail "triad.plan parallel instructions" "Missing parallel guidance"
    fi
}

test_triad_tasks_has_parallel_instructions() {
    if [[ -f "${COMMANDS_DIR}/triad.tasks.md" ]] && \
       grep -qi "parallel" "${COMMANDS_DIR}/triad.tasks.md"; then
        pass "triad.tasks has parallel execution instructions"
    else
        fail "triad.tasks parallel instructions" "Missing parallel guidance"
    fi
}

test_merge_results_exists() {
    if [[ -f "${LIB_DIR}/merge-results.sh" ]]; then
        pass "merge-results.sh exists for result aggregation"
    else
        fail "merge-results.sh exists" "File not found"
    fi
}

test_merge_results_handles_parallel() {
    source "${LIB_DIR}/merge-results.sh" 2>/dev/null || true

    # Test merging two parallel review results
    local merged
    merged=$(merge_review_statuses "APPROVED" "APPROVED_WITH_CONCERNS" 2>/dev/null || echo "")

    if [[ "$merged" == "APPROVED_WITH_CONCERNS" ]]; then
        pass "merge_results handles parallel verdicts"
    else
        fail "merge_results parallel verdicts" "Expected APPROVED_WITH_CONCERNS, got $merged"
    fi
}

# ============================================================================
# Version Detection Integration Tests
# ============================================================================

test_version_detection_exists() {
    if [[ -f "${PROJECT_ROOT}/.claude/lib/version/detect.sh" ]]; then
        pass "Version detection script exists"
    else
        fail "Version detection script exists" "File not found"
    fi
}

test_feature_flags_exist() {
    if [[ -f "${PROJECT_ROOT}/.claude/lib/version/feature-flags.sh" ]]; then
        pass "Feature flags script exists"
    else
        fail "Feature flags script exists" "File not found"
    fi
}

test_parallel_execution_flag() {
    source "${PROJECT_ROOT}/.claude/lib/version/feature-flags.sh" 2>/dev/null || true

    # Check that the parallel execution flag is defined
    if declare -p SPECKIT_FEATURE_PARALLEL_EXECUTION &>/dev/null; then
        pass "SPECKIT_FEATURE_PARALLEL_EXECUTION flag defined"
    else
        fail "SPECKIT_FEATURE_PARALLEL_EXECUTION" "Flag not defined"
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

    section "Timing Metrics Tests"
    test_timing_script_exists
    test_timing_script_syntax
    test_start_stop_timer
    test_calculate_time_savings
    test_generate_timing_summary

    section "Forked Skills Tests"
    test_pm_review_skill_has_fork_context
    test_architect_review_skill_has_fork_context
    test_skills_have_agent_explore

    section "Command Integration Tests"
    test_triad_plan_has_parallel_instructions
    test_triad_tasks_has_parallel_instructions
    test_merge_results_exists
    test_merge_results_handles_parallel

    section "Version Detection Integration"
    test_version_detection_exists
    test_feature_flags_exist
    test_parallel_execution_flag

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
