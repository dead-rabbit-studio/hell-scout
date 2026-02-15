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
- Type hints on function params and returns: `func dash() -> void:`
- Input actions referenced through `R.player_actions` dictionary, never hardcoded strings

## Input Actions

move_up/down/left/right (WASD + arrows + left stick), attack (Space), interact (E), dash (J)

## Autoloads

- `Animations` → `res://player/scouter/animations.gd` (animation state constants: "Idle", "Running")
