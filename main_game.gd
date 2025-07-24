extends Node2D

@export var level: LevelController
@export var player_hud: PlayerHUD

@onready var gameOverLabel:Label = $GUI/GameOverScreen/GameOverLabel

func _enter_tree() -> void:
    level.player_health_changed.connect(_on_player_health_changed)

func on_game_over(): 
    gameOverLabel.visible = true


func _on_gun_gun_was_fired(bullet: Node2D) -> void:
    add_child(bullet)


func _on_level_level_status_change(levelStatus: int) -> void:
    if(levelStatus == LevelStatus.LOST):
        on_game_over()

func _on_player_health_changed(current_hp: int) -> void:
    player_hud.update_hp(current_hp)
