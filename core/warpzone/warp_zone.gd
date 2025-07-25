class_name WarpZone
extends Area2D

enum WARP_DIRECTION { WARPABLE_DIRECTION, TOP, RIGHT, BOTTOM, LEFT}

@onready var area = $CollisionShape2D

@export var exit_zone: WarpZone 
@export var exit_zone_direction: WARP_DIRECTION

func _on_body_entered(body: Node2D) -> void:
	var player = body as Player
	if player == null:
		return
		
	if exit_zone != null:
		player.position = exit_zone.position
	
	_handle_exit_direction(player)

func _handle_exit_direction(body: Player) -> void:
	var body_width = body.player_area.shape.size.x
	var body_height = body.player_area.shape.size.y
	var padding = 8
	print("body is: " + str(body))
	
	if exit_zone != null:
		print_debug("WARP: " + str(exit_zone.position) + " " + str(body.player_area.shape.size))
		print_debug("WARP AFTERSUM: " + str(exit_zone.position + Vector2(body_height, 0)))
		
		match exit_zone_direction:
			WARP_DIRECTION.WARPABLE_DIRECTION:
				var direction = body._current_direction_vector
				if direction == Vector2.LEFT:
					warp_player(body, Vector2.LEFT, body_width + padding)
				elif direction == Vector2.UP:
					warp_player(body, Vector2.UP, body_height + padding)
				elif direction == Vector2.RIGHT:
					warp_player(body, Vector2.RIGHT, body_width + padding)
				elif direction == Vector2.DOWN:
					warp_player(body, Vector2.DOWN, body_height + padding)
			WARP_DIRECTION.TOP:
				if body._current_direction_vector.y >= 0:
					warp_player(body, Vector2.UP, body_height + padding)
			WARP_DIRECTION.RIGHT:
				if body._current_direction_vector.x <= 0:
					warp_player(body, Vector2.RIGHT, body_width + padding)
			WARP_DIRECTION.BOTTOM:
				if body._current_direction_vector.y <= 0:
					warp_player(body, Vector2.DOWN, body_height + padding)
			WARP_DIRECTION.LEFT:
				if body._current_direction_vector.x >= 0:
					warp_player(body, Vector2.LEFT, body_width + padding)
						
func warp_player(body: Player, direction: Vector2, distance: float) -> void:
	direction = direction.normalized()
	body.position = exit_zone.position + direction * distance
