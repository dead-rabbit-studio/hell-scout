# NPCs

Contains all non-player character implementations and assets.

## Structure

### Creeper NPC
- `creeper.gd` - Creeper enemy implementation
- `creeper.tscn` - Creeper scene configuration

## Features

### AI System
The NPCs use a modular AI system implemented through the core controller system:

- AI behaviors defined in `ai_controller.gd`
- Customizable behavior patterns
- State-based decision making

### Combat Integration
NPCs integrate with the game's combat systems:
- Health system integration
- Hit detection
- Attack patterns
- Damage handling

### Movement System
- Path finding
- Target tracking
- Collision avoidance
- Animation integration

## Adding New NPCs

To create a new NPC:

1. Create a new directory under `npcs/`
2. Create the NPC script extending the appropriate base class
3. Set up the NPC scene
4. Configure AI controller behaviors
5. Integrate with health and combat systems
