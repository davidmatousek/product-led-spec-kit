#!/usr/bin/env bash
# Version Detection Integration Test
# Feature: 002-anthropic-updates-integration
# Created: 2026-01-24
#
# Tests version detection, feature flags, and degradation messaging.

set -euo pipefail

# Test configuration
readonly TEST_NAME="Version Detection"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="${SCRIPT_DIR}/../../.."
readonly LIB_DIR="${PROJECT_ROOT}/.claude/lib/version"

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
# Test Cases
# ============================================================================

test_detect_script_exists() {
    if [[ -f "${LIB_DIR}/detect.sh" ]]; then
        pass "detect.sh exists"
    else
        fail "detect.sh exists" "File not found at ${LIB_DIR}/detect.sh"
    fi
}

test_feature_flags_script_exists() {
    if [[ -f "${LIB_DIR}/feature-flags.sh" ]]; then
        pass "feature-flags.sh exists"
    else
        fail "feature-flags.sh exists" "File not found at ${LIB_DIR}/feature-flags.sh"
    fi
}

test_degradation_script_exists() {
    if [[ -f "${LIB_DIR}/degradation.sh" ]]; then
        pass "degradation.sh exists"
    else
        fail "degradation.sh exists" "File not found at ${LIB_DIR}/degradation.sh"
    fi
}

test_config_file_exists() {
    local config_file="${PROJECT_ROOT}/.claude/config/feature-flags.json"
    if [[ -f "$config_file" ]]; then
        pass "feature-flags.json exists"
    else
        fail "feature-flags.json exists" "File not found at $config_file"
    fi
}

test_detect_script_syntax() {
    if bash -n "${LIB_DIR}/detect.sh" 2>/dev/null; then
        pass "detect.sh has valid bash syntax"
    else
        fail "detect.sh has valid bash syntax" "Syntax errors detected"
    fi
}

test_feature_flags_script_syntax() {
    if bash -n "${LIB_DIR}/feature-flags.sh" 2>/dev/null; then
        pass "feature-flags.sh has valid bash syntax"
    else
        fail "feature-flags.sh has valid bash syntax" "Syntax errors detected"
    fi
}

test_degradation_script_syntax() {
    if bash -n "${LIB_DIR}/degradation.sh" 2>/dev/null; then
        pass "degradation.sh has valid bash syntax"
    else
        fail "degradation.sh has valid bash syntax" "Syntax errors detected"
    fi
}

test_version_compare_function() {
    # Source the detect script
    source "${LIB_DIR}/detect.sh"

    local result

    # Test: equal versions
    result=$(version_compare "2.1.16" "2.1.16")
    if [[ "$result" == "0" ]]; then
        pass "version_compare: equal versions"
    else
        fail "version_compare: equal versions" "Expected 0, got $result"
    fi

    # Test: v1 > v2
    result=$(version_compare "2.1.16" "2.1.15")
    if [[ "$result" == "1" ]]; then
        pass "version_compare: v1 > v2"
    else
        fail "version_compare: v1 > v2" "Expected 1, got $result"
    fi

    # Test: v1 < v2
    result=$(version_compare "2.1.15" "2.1.16")
    if [[ "$result" == "-1" ]]; then
        pass "version_compare: v1 < v2"
    else
        fail "version_compare: v1 < v2" "Expected -1, got $result"
    fi

    # Test: major version difference
    result=$(version_compare "3.0.0" "2.1.16")
    if [[ "$result" == "1" ]]; then
        pass "version_compare: major version"
    else
        fail "version_compare: major version" "Expected 1, got $result"
    fi
}

test_version_at_least_function() {
    # Source the detect script
    source "${LIB_DIR}/detect.sh"

    # Test: meets requirement
    if version_at_least "2.1.16" "2.1.16"; then
        pass "version_at_least: equal"
    else
        fail "version_at_least: equal" "2.1.16 should meet 2.1.16 requirement"
    fi

    # Test: exceeds requirement
    if version_at_least "2.1.17" "2.1.16"; then
        pass "version_at_least: exceeds"
    else
        fail "version_at_least: exceeds" "2.1.17 should exceed 2.1.16 requirement"
    fi

    # Test: below requirement
    if ! version_at_least "2.1.15" "2.1.16"; then
        pass "version_at_least: below"
    else
        fail "version_at_least: below" "2.1.15 should not meet 2.1.16 requirement"
    fi
}

test_feature_flag_exports() {
    # Source feature flags
    source "${LIB_DIR}/feature-flags.sh"

    # Check exports exist (using declare -p for portability)
    if declare -p SPECKIT_FEATURE_CONTEXT_FORKING &>/dev/null; then
        pass "SPECKIT_FEATURE_CONTEXT_FORKING exported"
    else
        fail "SPECKIT_FEATURE_CONTEXT_FORKING exported" "Variable not exported"
    fi

    if declare -p SPECKIT_FEATURE_PARALLEL_EXECUTION &>/dev/null; then
        pass "SPECKIT_FEATURE_PARALLEL_EXECUTION exported"
    else
        fail "SPECKIT_FEATURE_PARALLEL_EXECUTION exported" "Variable not exported"
    fi

    if declare -p SPECKIT_FEATURE_TASK_DEPENDENCIES &>/dev/null; then
        pass "SPECKIT_FEATURE_TASK_DEPENDENCIES exported"
    else
        fail "SPECKIT_FEATURE_TASK_DEPENDENCIES exported" "Variable not exported"
    fi

    if declare -p SPECKIT_FEATURE_GRACEFUL_DEGRADATION &>/dev/null; then
        pass "SPECKIT_FEATURE_GRACEFUL_DEGRADATION exported"
    else
        fail "SPECKIT_FEATURE_GRACEFUL_DEGRADATION exported" "Variable not exported"
    fi
}

test_degradation_messages() {
    # Source degradation
    source "${LIB_DIR}/degradation.sh"

    local message

    # Test: context_forking message
    message=$(get_unavailable_message "context_forking")
    if echo "$message" | grep -q "Context Forking"; then
        pass "degradation: context_forking message"
    else
        fail "degradation: context_forking message" "Message doesn't mention feature"
    fi

    # Test: upgrade recommendation
    message=$(get_upgrade_recommendation)
    if echo "$message" | grep -q "Upgrade Recommended"; then
        pass "degradation: upgrade recommendation"
    else
        fail "degradation: upgrade recommendation" "Message missing recommendation"
    fi

    # Test: version banner
    message=$(get_version_banner)
    if echo "$message" | grep -qE "(Claude Code|Unknown)"; then
        pass "degradation: version banner"
    else
        fail "degradation: version banner" "Banner format incorrect"
    fi
}

test_config_json_valid() {
    local config_file="${PROJECT_ROOT}/.claude/config/feature-flags.json"

    if command -v jq &>/dev/null; then
        if jq empty "$config_file" 2>/dev/null; then
            pass "feature-flags.json is valid JSON"
        else
            fail "feature-flags.json is valid JSON" "JSON parsing error"
        fi

        # Check required keys
        if jq -e '.features' "$config_file" >/dev/null 2>&1; then
            pass "feature-flags.json has 'features' key"
        else
            fail "feature-flags.json has 'features' key" "Missing features section"
        fi

        if jq -e '.version_thresholds' "$config_file" >/dev/null 2>&1; then
            pass "feature-flags.json has 'version_thresholds' key"
        else
            fail "feature-flags.json has 'version_thresholds' key" "Missing thresholds"
        fi
    else
        echo "  ⏭️ SKIP: jq not available for JSON validation"
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

    section "File Existence Tests"
    test_detect_script_exists
    test_feature_flags_script_exists
    test_degradation_script_exists
    test_config_file_exists

    section "Syntax Validation Tests"
    test_detect_script_syntax
    test_feature_flags_script_syntax
    test_degradation_script_syntax

    section "Version Comparison Tests"
    test_version_compare_function
    test_version_at_least_function

    section "Feature Flag Tests"
    test_feature_flag_exports

    section "Degradation Message Tests"
    test_degradation_messages

    section "Configuration Tests"
    test_config_json_valid

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
