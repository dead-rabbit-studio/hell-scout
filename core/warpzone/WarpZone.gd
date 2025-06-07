class_name WarpZone
extends Area2D

enum WARP_DIRECTION { WARPABLE_DIRECTION, TOP, RIGHT, BOTTOM, LEFT}

@onready var area = $CollisionShape2D

@export var exit_zone: WarpZone 
@export var exit_zone_direction: WARP_DIRECTION

func _on_body_entered(body: Player) -> void:
	if exit_zone != null:
		body.position = exit_zone.position
	
	_handle_exit_direction(body)

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
				var direction = body.get_current_direction()
				match direction:
					R.Directions.LEFT:
						warp_player(body, Vector2.LEFT, body_width + padding)
					R.Directions.UP:
						warp_player(body, Vector2.UP, body_height + padding)
					R.Directions.RIGHT:
						warp_player(body, Vector2.RIGHT, body_width + padding)
					R.Directions.DOWN:
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

	if direction.x != 0:
		body.scale.x = abs(body.scale.x) * sign(direction.x)

	if direction.y != 0:
		body.scale.y = abs(body.scale.y) * sign(direction.y)

	body.position = exit_zone.position + direction * distance
