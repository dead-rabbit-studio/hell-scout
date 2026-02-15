extends GdUnitTestSuite

var _controller: AiController
var _signal_tracker: Array


func before_test() -> void:
	_signal_tracker = []
	_controller = auto_free(AiController.new())
	_controller.is_enabled = true


# --- attack ---

func test_attack_action_emits_attacked_signal() -> void:
	_controller.attacked.connect(func(v): _signal_tracker.append({"attacked": v}))
	_controller._on_neural_network_action_required(R.player_actions.attack)
	assert_array(_signal_tracker).contains([{"attacked": true}])


# --- interact ---

func test_interact_action_emits_interact_signal() -> void:
	_controller.interact.connect(func(): _signal_tracker.append("interact"))
	_controller._on_neural_network_action_required(R.player_actions.interact)
	assert_array(_signal_tracker).contains(["interact"])


# --- dash ---

func test_dash_action_emits_dash_signal() -> void:
	_controller.dash.connect(func(): _signal_tracker.append("dash"))
	_controller._on_neural_network_action_required(R.player_actions.dash)
	assert_array(_signal_tracker).contains(["dash"])


# --- move ---

func test_move_action_emits_moved_signal() -> void:
	_controller.moved.connect(func(_dir): _signal_tracker.append("moved"))
	_controller._on_neural_network_action_required(R.player_actions.move_left)
	assert_array(_signal_tracker).contains(["moved"])


func test_move_right_emits_moved_signal() -> void:
	_controller.moved.connect(func(_dir): _signal_tracker.append("moved"))
	_controller._on_neural_network_action_required(R.player_actions.move_right)
	assert_array(_signal_tracker).contains(["moved"])


# --- unknown action ---

func test_unknown_action_does_not_crash() -> void:
	_controller._on_neural_network_action_required("unknown_action")
	assert_array(_signal_tracker).is_empty()


# --- disabled ---

func test_disabled_controller_emits_no_signals() -> void:
	_controller.is_enabled = false
	_controller.attacked.connect(func(v): _signal_tracker.append("attacked"))
	_controller.interact.connect(func(): _signal_tracker.append("interact"))
	_controller.dash.connect(func(): _signal_tracker.append("dash"))
	_controller.moved.connect(func(_dir): _signal_tracker.append("moved"))

	_controller._on_neural_network_action_required(R.player_actions.attack)
	_controller._on_neural_network_action_required(R.player_actions.interact)
	_controller._on_neural_network_action_required(R.player_actions.dash)
	_controller._on_neural_network_action_required(R.player_actions.move_left)

	assert_array(_signal_tracker).is_empty()
