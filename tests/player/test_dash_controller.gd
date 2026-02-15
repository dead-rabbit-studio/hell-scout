extends GdUnitTestSuite

var _dash: DashController
var _duration_timer: Timer
var _cooldown_timer: Timer
var _signal_tracker: Array


func before_test() -> void:
	_signal_tracker = []

	_duration_timer = auto_free(Timer.new())
	_duration_timer.one_shot = true
	_cooldown_timer = auto_free(Timer.new())
	_cooldown_timer.one_shot = true

	_dash = auto_free(DashController.new())
	_dash.dash_duration = 0.14
	_dash.cooldown = 0.6
	_dash.dash_speed = 1200.0
	_dash.dash_duration_timer = _duration_timer
	_dash.dash_cooldown_timer = _cooldown_timer

	add_child(_duration_timer)
	add_child(_cooldown_timer)
	add_child(_dash)


# --- dash activation ---

func test_dash_sets_is_dashing_true() -> void:
	_dash.dash()
	assert_bool(_dash.is_dashing).is_true()


func test_dash_emits_state_changed_true() -> void:
	_dash.dash_state_changed.connect(func(v): _signal_tracker.append(v))
	_dash.dash()
	assert_array(_signal_tracker).contains([true])


# --- dash blocked during cooldown ---

func test_dash_blocked_during_cooldown() -> void:
	_dash.dash()
	_dash.dash()
	assert_bool(_dash.is_dashing).is_true()


func test_dash_blocked_emits_blocked_signal() -> void:
	_dash.dash_attempt_blocked.connect(func(): _signal_tracker.append("blocked"))
	_dash.dash()
	_dash.dash()
	assert_array(_signal_tracker).contains(["blocked"])


# --- dash duration ends ---

func test_dash_ends_after_duration_timer() -> void:
	_dash.dash()
	assert_bool(_dash.is_dashing).is_true()
	_duration_timer.timeout.emit()
	assert_bool(_dash.is_dashing).is_false()


func test_dash_end_emits_state_changed_false() -> void:
	_dash.dash_state_changed.connect(func(v): _signal_tracker.append(v))
	_dash.dash()
	_duration_timer.timeout.emit()
	assert_array(_signal_tracker).contains([true, false])


# --- cooldown expires ---

func test_cooldown_expires_allows_dash_again() -> void:
	_dash.dash()
	_duration_timer.timeout.emit()
	assert_bool(_dash.is_dashing).is_false()
	# Still on cooldown, second dash should be blocked
	_dash.dash()
	assert_bool(_dash.is_dashing).is_false()
	# Cooldown expires
	_cooldown_timer.timeout.emit()
	_dash.dash()
	assert_bool(_dash.is_dashing).is_true()
