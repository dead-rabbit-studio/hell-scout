class_name InputController extends Controller

func _unhandled_input(event: InputEvent) -> void:
	if is_enabled:
		if event.is_action_pressed(R.player_actions.attack):
			attacked.emit(true)
		if event.is_action_released(R.player_actions.attack):
			attacked.emit(false)
		if event.is_action_released(R.player_actions.interact):
			interact.emit()
		if event.is_action_released(R.player_actions.dash):
			dash.emit()

func _process(_delta):
	if is_enabled:
		var _current_direction_vector = Input.get_vector(
			R.player_actions.move_left,
			R.player_actions.move_right,
			R.player_actions.move_up,
			R.player_actions.move_down
		)
		moved.emit(_current_direction_vector)
