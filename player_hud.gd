class_name PlayerHUD
extends MarginContainer

@export var hp_label: Label


func update_hp(current_hp: int):
    hp_label.text = _format_hp(current_hp) 

func _format_hp(current_hp: int) -> String:
    var hp_marks = ""
    if current_hp <= 0:
        return ""
    for i in current_hp:
        hp_marks += "o "
        
    return "HP: " + hp_marks 
