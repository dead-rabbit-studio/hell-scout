# Hell Scout

2D action game in Godot 4.6 / GDScript.

## Run & Build

- Open in Godot 4.6, run `main_game.tscn`
- Viewport: 320x240 scaled to 1920x1090 (pixel art, stretch mode: viewport)

## Architecture

Controller pattern: both Player and NPCs use `Controller` base class. `InputController` handles keyboard/gamepad, `AiController` handles NPC behavior via `NeuralNetwork`. Controllers emit signals (`attacked`, `moved`, `dash`, `interact`) — the character listens and acts.

Action priority: **Dash > Attack > Movement**. Dash blocks everything, attack blocks movement. Dash cancels active attack and grants damage immunity.

Combat uses HitBox/HurtBox pattern (both extend Area2D). `MeleeAttack extends HitBox`. HurtBox requires a `Health` export to receive damage.

Collision layers: 1=Player, 2=Enemy, 3=HitArea, 4=HurtArea, 5=World.

## Code Style

- `snake_case` for files, functions, variables, signals
- `PascalCase` for `class_name` declarations
- Underscore prefix for private members: `_current_direction_vector`
- `@export` for node references and config: `@export var health: Health`
- `@onready` for child node caching: `@onready var player: Player = get_owner()`
- Type hints on function params and returns: `func dash() -> void:`
- Input actions referenced through `R.player_actions` dictionary, never hardcoded strings
- Signal callbacks named `_on_<source>_<signal>`: `_on_controller_attacked()`
- Early signal connection in `_enter_tree()`, not `_ready()`
- Guard clauses for invalid state: `if _attack_vfx.is_playing(): return`
- Lifetime cleanup via lambda: `node.connect("tree_exiting", func(): ref = null)`

## Input Actions

move_up/down/left/right (WASD + arrows + left stick), attack (Space), interact (E), dash (J)

## Autoloads

- `Animations` → `res://player/scouter/animations.gd` (animation state constants: "Idle", "Running")

## Key Classes

- `Player` (CharacterBody2D) — main character, wires controller signals to actions
- `Controller` (Node2D) — base class with `attacked`, `moved`, `dash`, `interact` signals
- `InputController` / `AiController` — concrete controllers
- `DashController` (Node) — dash state, cooldown timers, immunity toggle
- `Health` (Node) — damage/heal/kill with `depleted` signal
- `HitBox` (Area2D) — deals damage, has `@export var damage`
- `HurtBox` (Area2D) — receives damage, needs `@export var health: Health`
- `MeleeAttack` (HitBox) — direction-based melee with VFX sprite
- `Interactor` / `Interactable` — interaction system with enable/disable flow
- `Creeper` (CharacterBody2D) — enemy with raycast LOS and personal space
- `R` — resource constants (player_actions dict, scene paths, strings)

## Known Gotchas

- `health.gd` has inverted logic: `if ignore_damage:` should be `if not ignore_damage:` — damage only applies when it shouldn't
- `heal()` adds health twice when exceeding max
- `is_mortal` flag is backwards: character dies only when `!is_mortal`
- Typo: `is_imortal` (missing 'm')
- Player max_health is 110 in script but overridden to 3 in scene
- animator.gd has debug prints on lines 29-30 that spam console
- Animation tree paths are hardcoded strings — fragile if tree structure changes
- `move_right` input action missing joypad binding (other directions have it)
