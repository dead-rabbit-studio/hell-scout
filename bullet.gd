extends RigidBody2D

@export var still_alive_time_secs: int = 1

func _ready() -> void:
	var timer: Timer = Timer.new()
	timer.start(still_alive_time_secs)
	timer.connect("Timeout", _on_timer_timeout)
	
func _on_timer_timeout() -> void:
	queue_free()
