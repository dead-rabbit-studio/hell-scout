class_name AiController
extends Controller

func _random_direction() -> Vector2:
	return Vector2(randi_range(-1, 1), randi_range(-1, 1))

func _on_neural_network_action_required(action:String) -> void:
	if is_enabled:
			print("AI Controller choosed action: " + str(action))
			match action:
				R.player_actions.attack:
					print("AI Controller attack")
					attacked.emit(true)
				R.player_actions.interact:
					print("AI Controller interact")
					interact.emit()
				action when action.contains("move"):
					print("AI Controller moved")
					moved.emit(_random_direction())
				_:
					print(action)