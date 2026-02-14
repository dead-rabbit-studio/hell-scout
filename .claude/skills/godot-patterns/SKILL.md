---
name: godot-patterns
description: GDScript patterns and conventions for this Godot 4.6 project. Use when writing or reviewing GDScript code.
user-invocable: false
---

# GDScript Patterns for Hell Scout

## New Node/Component Checklist
When creating a new game entity (player, NPC, interactable):
1. Define `class_name` with PascalCase
2. Use `@export` for external node references (Health, Controller, etc.)
3. Connect signals in `_enter_tree()`, not `_ready()`
4. Name callbacks `_on_<source>_<signal_name>()`
5. Reference input actions via `R.player_actions`, never raw strings
6. Clean up dynamic nodes with `tree_exiting` signal

## Controller Integration
All controllable entities use the Controller pattern:
```gdscript
@export var controller: Controller

func _enter_tree() -> void:
    controller.attacked.connect(_on_controller_attacked)
    controller.moved.connect(_on_controller_moved)
    controller.dash.connect(_on_controller_dash)
```

## Combat Integration
Entities that deal damage: add a HitBox child with collision on layer 3.
Entities that take damage: add a HurtBox child with `@export var health: Health`, collision on layer 4.

## Action Priority
Always respect: Dash > Attack > Movement. Check `dash_controller.is_dashing` before allowing attack. Check `_current_melee_attack != null` before allowing movement direction changes.

## Scene Instantiation
Dynamic scenes (like MeleeAttack) are instantiated, added as children, and cleaned up on `tree_exiting`:
```gdscript
var instance = _scene.instantiate()
add_child(instance)
instance.connect("tree_exiting", func(): instance_ref = null)
```
