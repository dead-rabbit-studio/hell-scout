extends Controller


func _process(_delta):
	var action = _choose_action()

	match action:
		R.player_actions.attack:
			attacked.emit(true)
		R.player_actions.interact:
			interact.emit()
		action when action.contains("move"):
			moved.emit(action)

func _choose_action() -> String:
	var size: int = R.player_actions.keys().size()
	var index: int = randi_range(0, size - 1)
	var key: String = R.player_actions.keys()[index]
	return R.player_actions[key] 
