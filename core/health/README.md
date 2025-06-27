# Health System

The health system manages entity health, damage, and death mechanics.

## Components

- `health.gd` - Core health system implementation
- `health.tscn` - Health component scene

## Features

### Health Management
- Maximum health configuration
- Current health tracking
- Health recovery support
- Death handling

### Damage System
- Damage calculation
- Damage type support
- Invincibility frames
- Death threshold handling

### Signals
- `health_changed` - Emitted when health value changes
- `health_depleted` - Emitted when health reaches 0

## Usage

1. Add the health scene as a child node
2. Configure max health and mortality settings
3. Connect to health signals for custom behavior
4. Use `damage()` method to apply damage
5. Use `heal()` method to restore health
