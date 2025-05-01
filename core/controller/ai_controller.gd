extends Controller

func _process(_delta):
	if is_enabled:
		var action = _choose_action()

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

func _choose_action() -> String:
	var size: int = R.player_actions.keys().size()
	var index: int = randi_range(0, size - 1)
	var key: String = R.player_actions.keys()[index]
	return R.player_actions[key] 

func _random_direction() -> Vector2:
	return Vector2(randi_range(-1, 1), randi_range(-1, 1))