extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D: 
		print_debug("player_entered")
		var playerPosition:Vector2 = body.position
		move_and_collide(playerPosition)
