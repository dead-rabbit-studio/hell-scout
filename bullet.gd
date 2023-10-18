extends RigidBody2D

@export var still_alive_time_secs: float = 0.01

func _ready() -> void:
	var timer: Timer = Timer.new()
	timer.autostart = true
	timer.start(still_alive_time_secs)
	timer.connect("timeout", _on_timer_timeout)
	add_child(timer)
	
func _on_timer_timeout() -> void:
	queue_free()
