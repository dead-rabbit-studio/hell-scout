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
		var bodyWidth = body.playerArea.shape.size.x
		var bodyHeight = body.playerArea.shape.size.y
		var padding = 8
		
		if exit_zone != null:
			print_debug("WARP: " + str(exit_zone.position) + " " + str(body.playerArea.shape.size))
			print_debug("WARP AFTERSUM: " + str(exit_zone.position + Vector2(bodyHeight, 0)))
			
			match exit_zone_direction:
				WARP_DIRECTION.WARPABLE_DIRECTION:
					var direction = body.get_current_direction()
					match direction:
						Player.PLAYER_DIRECTION.LEFT:
							_warp_left(body, bodyWidth + padding)
						Player.PLAYER_DIRECTION.TOP:
							_warp_top(body, bodyWidth + padding)
						Player.PLAYER_DIRECTION.RIGHT:
							_warp_right(body, bodyWidth + padding)
						Player.PLAYER_DIRECTION.BOTTOM:
							_warp_bottom(body, bodyWidth + padding)																					
				WARP_DIRECTION.TOP:
					if body._currentDirectionVector.y >= 0:
						_warp_top(body,  bodyHeight + padding)
				WARP_DIRECTION.RIGHT:
					if body._currentDirectionVector.x <= 0:
						_warp_right(body,  bodyWidth + padding)
				WARP_DIRECTION.BOTTOM:
					if body._currentDirectionVector.y <= 0:
						_warp_bottom(body,  bodyHeight + padding)
				WARP_DIRECTION.LEFT:
					if body._currentDirectionVector.x >= 0:
						_warp_left(body, bodyWidth + padding)
						
						
func _warp_top(body: Player, distance: float) -> void:
	body.animated_sprite.flip_v = false
	body.position = exit_zone.position - Vector2(0, distance) 
	
func _warp_right(body: Player, distance: float) -> void:
	body.animated_sprite.flip_h = false
	body.position = exit_zone.position + Vector2(distance, 0) 

func _warp_bottom(body: Player, distance: float) -> void:
	body.animated_sprite.flip_v = true
	body.position = exit_zone.position + Vector2(0, distance) 

func _warp_left(body: Player, distance: float) -> void:
	body.animated_sprite.flip_h = true
	body.position = exit_zone.position - Vector2(distance, 0) 
	
	
	
