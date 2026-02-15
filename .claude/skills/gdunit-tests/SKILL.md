---
name: gdunit-tests
description: GdUnit4 testing patterns and conventions. Use when writing, reviewing, or debugging tests.
user-invocable: false
---

# GdUnit4 Testing Conventions

## Structure
- Framework: GdUnit4 (`addons/gdUnit4/`)
- Tests live in `tests/` mirroring source structure: `tests/core/`, `tests/player/`, `tests/hud/`
- File naming: `test_<class_under_test>.gd`
- All test suites `extends GdUnitTestSuite`

## Setup & Teardown
- Use `before_test()` for per-test setup (runs before each test)
- Always `auto_free()` instantiated nodes to prevent leaks
- Nodes that need the scene tree: call `add_child()` after `auto_free()`

```gdscript
func before_test() -> void:
    _health = auto_free(Health.new())
    _health.max_health = 100
```

## Test Naming & Organization
- Test naming: `func test_<what>_<expected_outcome>() -> void:`
- Group related tests with `# --- section name ---` comments
- One assertion focus per test, keep tests small

## Signal Testing
- Track signals with `_signal_tracker: Array` and a lambda connection:

```gdscript
var _signal_tracker: Array

func before_test() -> void:
    _signal_tracker = []

func test_dash_emits_state_changed() -> void:
    _dash.dash_state_changed.connect(func(v): _signal_tracker.append(v))
    _dash.dash()
    assert_array(_signal_tracker).contains([true])
```

## Timer Simulation
- Simulate timer completion by emitting `timeout` directly instead of waiting:

```gdscript
_duration_timer.timeout.emit()
```

## Assertions
- Use typed assertions: `assert_float()`, `assert_bool()`, `assert_str()`, `assert_array()`
- Prefer `.is_equal()`, `.is_true()`, `.is_false()`, `.contains()`
