class_name InputController extends Controller

func _process(_delta):
    if is_enabled:
        if Input.is_action_pressed(R.player_actions.attack):
            attacked.emit(true)
        
        if Input.is_action_just_released(R.player_actions.attack):
            attacked.emit(false)
        
        if Input.is_action_just_pressed(R.player_actions.interact):
            interact.emit()

        var _current_direction_vector = Input.get_vector(R.player_actions.move_left, R.player_actions.move_right, R.player_actions.move_up, R.player_actions.move_down)
        moved.emit(_current_direction_vector)