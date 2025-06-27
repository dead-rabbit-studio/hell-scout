class_name HurtBox
extends Area2D

@export var health: Health

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: Area2D) -> void:
	if hitbox == null:
		return

	if hitbox is HitBox:
		health.damage(hitbox.damage)
