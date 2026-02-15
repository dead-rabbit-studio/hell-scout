class_name AiController
extends Controller

func _random_direction() -> Vector2:
	return Vector2(randi_range(-1, 1), randi_range(-1, 1))

func _on_neural_network_action_required(action:String) -> void:
	if is_enabled:
			match action:
				R.player_actions.attack:
					attacked.emit(true)
				R.player_actions.interact:
					interact.emit()
				R.player_actions.dash:
					dash.emit()
				action when action.contains("move"):
					moved.emit(_random_direction())
				_:
					pass