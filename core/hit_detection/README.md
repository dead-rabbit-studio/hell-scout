# Hit Detection System

Implements combat hit detection through HitBox and HurtBox components.

## Components

### HitBox
- `HitBox.gd` - Offensive collision area
- Manages damage dealing
- Configurable damage values
- Hit detection signals

### HurtBox
- `HurtBox.gd` - Vulnerable collision area
- Manages damage receiving
- Invincibility frame support
- Damage type handling

## Features

### Hit Detection
- Area2D-based collision detection
- Layer-based filtering
- Hit validation
- Multiple hit handling

### Integration
- Health system integration
- Combat system support
- Visual effect triggers
- Sound effect triggers

## Usage

### Setting Up Hit Detection

1. Add HitBox to attacking entities
2. Add HurtBox to vulnerable entities
3. Configure collision layers
4. Connect signals for custom behavior
5. Set up damage values and types
