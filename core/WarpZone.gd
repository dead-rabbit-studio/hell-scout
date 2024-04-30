class_name WarpZone
extends Area2D

enum WARP_DIRECTION { WARPABLE_DIRECTION, TOP, RIGHT, BOTTOM, LEFT}

@export var exit_zone: WarpZone 
@export var exit_zone_direction: WARP_DIRECTION

func _on_body_entered(body: Player) -> void:
	if exit_zone != null:
		body.position = exit_zone.position
	
	_handle_exit_direction(body)

func _handle_exit_direction(body: Player):
		if exit_zone != null:
			match exit_zone_direction:
				WARP_DIRECTION.WARPABLE_DIRECTION:
					pass #do nothing because it keeps the object direction
				WARP_DIRECTION.TOP:
					if body._currentDirectionVector.y >= 0:
						body.animated_sprite.flip_v = false
				WARP_DIRECTION.RIGHT:
					if body._currentDirectionVector.x <= 0:
						body.animated_sprite.flip_h = false
				WARP_DIRECTION.BOTTOM:
					body.animated_sprite.flip_v = true
				WARP_DIRECTION.LEFT:
					if body._currentDirectionVector.x >= 0:
						body.animated_sprite.flip_h = true
