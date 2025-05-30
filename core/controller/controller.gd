class_name Controller extends Node2D

@warning_ignore("unused_signal")
signal attacked(is_attacking: bool)
@warning_ignore("unused_signal")
signal interact
@warning_ignore("unused_signal")
signal moved(direction: Vector2)

var is_attacking = false
var is_enabled = true

