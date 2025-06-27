# Player

Contains all player-related implementations and assets.

## Directory Structure

### Scouter
The main player character implementation.

- `player.gd` - Main player character logic
- `player.tscn` - Player scene configuration
- `animator.gd` - Player animation controller
- `animations.gd` - Animation state definitions
- `neural_network.gd` - AI assistance system for player

## Key Features

### Movement System
- Vector2-based movement system
- Smooth acceleration and deceleration
- Direction-based animation handling

### Combat Integration
- Melee attack system
- Ranged weapon support
- Hit detection integration

### Interaction System
- Object interaction handling
- Collectible item processing
- Environment interaction support

### Animation System
The animation system uses Godot's AnimationTree for smooth blending between different states:
- Idle animations
- Running animations
- Combat animations
