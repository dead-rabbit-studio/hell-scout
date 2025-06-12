# Hell Scout

A 2D action game built with Godot Engine where you control a scout character exploring mysterious environments while battling enemies and collecting resources.

## Features

- Smooth 2D movement and combat system
- Melee and ranged combat mechanics
- Interactive environment elements
- Health and damage system
- AI-controlled enemies
- Collectible items

## Project Structure

- `core/` - Core game systems and mechanics
- `levels/` - Game levels and environment
- `npcs/` - Non-player character implementations
- `player/` - Player character and related systems
- `weapons/` - Combat system implementations

## Getting Started

### Prerequisites

1. **Install Godot**  
   Download and install [Godot v4.4.1](https://godotengine.org/download/archive/4.4.1-stable/).

### Development Setup

1. Clone the repository
2. Open the project in Godot Engine
3. Open the main scene (`main_game.tscn`)

### Editor Setup

1. Open Godot
2. Go to **Editor** > **Editor Settings**
3. Under the **Mono** section, set **External Editor** to "Visual Studio Code"

## Architecture

The game is built using a component-based architecture with the following key systems:

- **Controller System**: Handles input and AI behavior
- **Health System**: Manages damage and health for entities
- **Interaction System**: Handles object interactions and collecting
- **Combat System**: Implements both melee and ranged combat

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

See the [LICENSE](LICENSE) file for details.
