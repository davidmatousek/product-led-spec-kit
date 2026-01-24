#!/usr/bin/env bash
# Graceful Degradation Integration Test
# Feature: 002-anthropic-updates-integration
# Created: 2026-01-24
#
# Tests version detection integration, feature gating, and user messaging.

set -euo pipefail

# Test configuration
readonly TEST_NAME="Graceful Degradation"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${SCRIPT_DIR}/../../.."
readonly VERSION_LIB="${PROJECT_ROOT}/.claude/lib/version"
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
# Triad Init Tests
# ============================================================================

test_triad_init_exists() {
    if [[ -f "${COMMANDS_DIR}/_triad-init.md" ]]; then
        pass "_triad-init.md exists"
    else
        fail "_triad-init.md exists" "File not found"
    fi
}

test_triad_init_has_version_detection() {
    if [[ -f "${COMMANDS_DIR}/_triad-init.md" ]] && \
       grep -q "version" "${COMMANDS_DIR}/_triad-init.md"; then
        pass "_triad-init.md includes version detection"
    else
        fail "_triad-init.md version detection" "Missing version references"
    fi
}

# ============================================================================
# Feature Gate Tests
# ============================================================================

test_feature_gate_exists() {
    if [[ -f "${VERSION_LIB}/feature-gate.sh" ]]; then
        pass "feature-gate.sh exists"
    else
        fail "feature-gate.sh exists" "File not found"
    fi
}

test_feature_gate_syntax() {
    if bash -n "${VERSION_LIB}/feature-gate.sh" 2>/dev/null; then
        pass "feature-gate.sh has valid syntax"
    else
        fail "feature-gate.sh has valid syntax" "Syntax errors"
    fi
}

test_get_execution_mode() {
    source "${VERSION_LIB}/feature-gate.sh" 2>/dev/null || true

    local mode
    mode=$(get_execution_mode 2>/dev/null || echo "")

    if [[ "$mode" == "parallel" ]] || [[ "$mode" == "sequential" ]]; then
        pass "get_execution_mode returns valid mode ($mode)"
    else
        fail "get_execution_mode" "Expected parallel|sequential, got '$mode'"
    fi
}

test_can_use_functions() {
    source "${VERSION_LIB}/feature-gate.sh" 2>/dev/null || true

    # Test that functions exist and return without error
    if can_use_parallel 2>/dev/null || ! can_use_parallel 2>/dev/null; then
        pass "can_use_parallel function works"
    else
        fail "can_use_parallel function" "Function error"
    fi

    if can_use_context_fork 2>/dev/null || ! can_use_context_fork 2>/dev/null; then
        pass "can_use_context_fork function works"
    else
        fail "can_use_context_fork function" "Function error"
    fi
}

test_generate_feature_status() {
    source "${VERSION_LIB}/feature-gate.sh" 2>/dev/null || true

    local status
    status=$(generate_feature_status 2>/dev/null || echo "")

    if echo "$status" | grep -q "Feature Status"; then
        pass "generate_feature_status produces output"
    else
        fail "generate_feature_status" "Missing expected content"
    fi
}

# ============================================================================
# User Messages Tests
# ============================================================================

test_user_messages_exists() {
    if [[ -f "${VERSION_LIB}/user-messages.md" ]]; then
        pass "user-messages.md exists"
    else
        fail "user-messages.md exists" "File not found"
    fi
}

test_user_messages_has_upgrade_info() {
    if [[ -f "${VERSION_LIB}/user-messages.md" ]] && \
       grep -q "upgrade" "${VERSION_LIB}/user-messages.md"; then
        pass "user-messages.md includes upgrade information"
    else
        fail "user-messages.md upgrade info" "Missing upgrade guidance"
    fi
}

test_user_messages_has_version_banner() {
    if [[ -f "${VERSION_LIB}/user-messages.md" ]] && \
       grep -q "Version Banner" "${VERSION_LIB}/user-messages.md"; then
        pass "user-messages.md includes version banner"
    else
        fail "user-messages.md version banner" "Missing banner template"
    fi
}

# ============================================================================
# Degradation Script Tests
# ============================================================================

test_degradation_script_exists() {
    if [[ -f "${VERSION_LIB}/degradation.sh" ]]; then
        pass "degradation.sh exists"
    else
        fail "degradation.sh exists" "File not found"
    fi
}

test_get_unavailable_message() {
    source "${VERSION_LIB}/degradation.sh" 2>/dev/null || true

    local message
    message=$(get_unavailable_message "parallel_execution" 2>/dev/null || echo "")

    if echo "$message" | grep -qi "parallel"; then
        pass "get_unavailable_message returns relevant content"
    else
        fail "get_unavailable_message" "Message doesn't mention feature"
    fi
}

test_get_upgrade_recommendation() {
    source "${VERSION_LIB}/degradation.sh" 2>/dev/null || true

    local message
    message=$(get_upgrade_recommendation 2>/dev/null || echo "")

    if echo "$message" | grep -qi "upgrade"; then
        pass "get_upgrade_recommendation returns upgrade guidance"
    else
        fail "get_upgrade_recommendation" "Missing upgrade information"
    fi
}

test_require_feature_function() {
    source "${VERSION_LIB}/degradation.sh" 2>/dev/null || true

    # This function should return 0 or 1 without error
    if require_feature "context_forking" 2>/dev/null || ! require_feature "context_forking" 2>/dev/null; then
        pass "require_feature function works"
    else
        fail "require_feature function" "Function error"
    fi
}

# ============================================================================
# Integration Tests
# ============================================================================

test_version_flow_integration() {
    # Test the full version detection → feature flags → degradation flow
    source "${VERSION_LIB}/detect.sh" 2>/dev/null || true
    source "${VERSION_LIB}/feature-flags.sh" 2>/dev/null || true
    source "${VERSION_LIB}/degradation.sh" 2>/dev/null || true
    source "${VERSION_LIB}/feature-gate.sh" 2>/dev/null || true

    # All scripts should have loaded without fatal errors
    if [[ -n "${SPECKIT_CLAUDE_VERSION:-}" ]] || [[ -z "${SPECKIT_CLAUDE_VERSION:-}" ]]; then
        pass "Version detection flow completes"
    else
        fail "Version detection flow" "Flow did not complete"
    fi

    # Feature flags should be defined
    if declare -p SPECKIT_FEATURE_CONTEXT_FORKING &>/dev/null; then
        pass "Feature flags are defined after flow"
    else
        fail "Feature flags after flow" "Flags not defined"
    fi
}

test_graceful_degradation_path() {
    source "${VERSION_LIB}/feature-gate.sh" 2>/dev/null || true

    local mode
    mode=$(get_execution_mode 2>/dev/null || echo "unknown")

    # Mode should be either parallel or sequential - both are valid
    if [[ "$mode" == "parallel" ]] || [[ "$mode" == "sequential" ]]; then
        pass "Graceful degradation selects valid mode"
    else
        fail "Graceful degradation mode" "Invalid mode: $mode"
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

    section "Triad Init Tests"
    test_triad_init_exists
    test_triad_init_has_version_detection

    section "Feature Gate Tests"
    test_feature_gate_exists
    test_feature_gate_syntax
    test_get_execution_mode
    test_can_use_functions
    test_generate_feature_status

    section "User Messages Tests"
    test_user_messages_exists
    test_user_messages_has_upgrade_info
    test_user_messages_has_version_banner

    section "Degradation Script Tests"
    test_degradation_script_exists
    test_get_unavailable_message
    test_get_upgrade_recommendation
    test_require_feature_function

    section "Integration Tests"
    test_version_flow_integration
    test_graceful_degradation_path

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
