class_name MeleeAttack extends HitBox
var is_attacking = false

@export var _attack_vfx: AnimatedSprite2D
@export var attack_direction: Vector2 = Vector2.RIGHT

@onready var _melee_area_shape: RectangleShape2D = $CollisionShape2D.shape as RectangleShape2D

func attack(attacking) -> void:
	if _attack_vfx.is_playing():
		return
		
	is_attacking = attacking
	if is_attacking:
		const melee_attack_vertical_size = Vector2(64, 32)
		const melee_attack_horizontal_size = Vector2(32, 64)
		var flip_h = false
		var flip_v = false
		
		if attack_direction == Vector2.LEFT:
			_set_attack_position(Vector2(-melee_attack_horizontal_size.x, 0))
			_set_attack_shape(melee_attack_horizontal_size)
			_attack_vfx.rotation = 0
			flip_h = true
		elif attack_direction == Vector2.UP:
			_set_attack_position(Vector2(0, -melee_attack_vertical_size.y))
			_set_attack_shape(melee_attack_vertical_size)
			_attack_vfx.rotation = -90
			flip_v = true
		elif attack_direction == Vector2.RIGHT:
			_set_attack_position(Vector2(melee_attack_horizontal_size.x, 0))
			_set_attack_shape(melee_attack_horizontal_size)
			_attack_vfx.rotation = 0
			flip_h = false
		elif attack_direction == Vector2.DOWN:
			_set_attack_position(Vector2(0, melee_attack_vertical_size.y))
			_set_attack_shape(melee_attack_vertical_size)
			_attack_vfx.rotation = 90
			flip_v = true
		
		_attack_vfx.flip_h = flip_h
		_attack_vfx.flip_v = flip_v
		_attack_vfx.play("attack")


func _set_attack_position(new_position: Vector2) -> void:
	var player = get_parent()
	if player is Player:
		global_position = player.global_position + new_position


func _set_attack_shape(size: Vector2) -> void:
	_melee_area_shape.size = size


func _on_player_changed_direction(direction: Vector2):
	attack_direction = direction


func _on_attack_vfx_animation_finished() -> void:
	_attack_vfx.pause()
	_attack_vfx.frame_progress = 0
	queue_free()
