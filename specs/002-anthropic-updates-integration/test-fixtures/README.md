# Test Fixtures: Anthropic Claude Code Updates Integration

This directory contains test fixtures for validating feature 002 implementation.

## Test Files

| Test File | Purpose | Phase |
|-----------|---------|-------|
| `version-detection-test.sh` | Validates version detection logic | Wave 2 |
| `fork-test.sh` | Validates context forking isolation | Wave 3A |
| `dependency-test.sh` | Validates dependency tracking | Wave 3B |
| `parallel-test.sh` | Validates parallel execution | Wave 4 |
| `degradation-test.sh` | Validates graceful degradation | Wave 5 |

## Running Tests

```bash
# Run individual test
bash specs/002-anthropic-updates-integration/test-fixtures/version-detection-test.sh

# Run all tests
for f in specs/002-anthropic-updates-integration/test-fixtures/*-test.sh; do
  echo "Running $f..."
  bash "$f"
done
```

## Test Conventions

- Each test file is self-contained
- Tests output PASS/FAIL with clear messages
- Tests use exit codes: 0 = pass, 1 = fail
- Tests can be run in any order (no shared state)
