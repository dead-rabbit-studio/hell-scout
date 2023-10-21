extends RigidBody2D

@export var still_alive_time_secs: float = 0.2

func _ready() -> void:
	var timer: Timer = Timer.new()
	timer.autostart = true
	timer.connect("timeout", _on_timer_timeout)
	add_child(timer)
	timer.start(still_alive_time_secs)

func _on_timer_timeout() -> void:
	queue_free()
