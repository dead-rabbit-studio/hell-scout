class_name InputController extends Controller

func _process(_delta):
    if Input.is_action_pressed(R.player_actions.attack):
        attacked.emit(true)
	   
    if Input.is_action_just_released(R.player_actions.attack):
        attacked.emit(false)
	
    if Input.is_action_just_pressed(R.player_actions.interact):
        interact.emit()
