extends Node2D

@export var level: LevelController
@export var player_hud: PlayerHUD

var dash_blocked_warning_cooldown_timer: float = 0.1
var dash_blocked_warning_cooldown: float = 0.0

@onready var gameOverLabel:Label = $GUI/GameOverScreen/GameOverLabel

func _process(delta: float) -> void:
	dash_blocked_warning_cooldown -= delta

func _enter_tree() -> void:
	level.player_health_changed.connect(_on_player_health_changed)
	level.dash_state_changed.connect(_on_dash_state_changed)
	level.dash_attempt_blocked.connect(_on_dash_attempt_blocked)

func on_game_over(): 
	gameOverLabel.visible = true


func _on_gun_gun_was_fired(bullet: Node2D) -> void:
	add_child(bullet)


func _on_level_level_status_change(levelStatus: int) -> void:
	if(levelStatus == LevelStatus.LOST):
		on_game_over()


func _on_player_health_changed(current_hp: int) -> void:
	player_hud.update_hp(current_hp)


func _on_dash_state_changed(is_dashing: bool):
	player_hud.dash_state_changed(is_dashing)


func _on_dash_attempt_blocked(): 
	player_hud.dash_attempt_blocked()
