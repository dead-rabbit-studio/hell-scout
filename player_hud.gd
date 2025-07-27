class_name PlayerHUD
extends MarginContainer

const hp_label_text: String = "HP: "
const dash_label_text: String = "DASH: "

const DEFAULT_DASH_COLOR: Color = Color(1, 1, 1)
const WARNING_DASH_COLOR: Color = Color(1, 0, 0)

@export var hp_label: Label
@export var dash_label: Label
@export var warning_cooldown_timer: Timer

var dash_blocked_warning_cooldown_timer: float = .1
var current_dash_color: Color = DEFAULT_DASH_COLOR


func _enter_tree() -> void:
    warning_cooldown_timer.timeout.connect(_on_warning_cooldown_timer_timeout)


func update_hp(current_hp: int):
    hp_label.text = _format_hp(current_hp) 


func dash_state_changed(is_dashing: bool):
    if is_dashing:
        dash_label.text = dash_label_text
    else :
        dash_label.text = dash_label_text + "!"


func dash_attempt_blocked():
    warning_cooldown_timer.start(dash_blocked_warning_cooldown_timer)
    _update_dash_warning_color(WARNING_DASH_COLOR)


func _format_hp(current_hp: int) -> String:
    var hp_marks = ""
    if current_hp <= 0:
        return hp_label_text
    for i in current_hp:
        hp_marks += "o "
        
    return  hp_label_text + hp_marks 


func _update_dash_warning_color(color: Color) -> void:
    current_dash_color = color
    dash_label.add_theme_color_override("font_color", current_dash_color)


func _on_warning_cooldown_timer_timeout() -> void:
    _update_dash_warning_color(DEFAULT_DASH_COLOR)
