# Weapons

Contains all weapon-related implementations and assets.

## Components

### Melee Attack System
- `melee_attack.gd` - Melee attack implementation
- `melee_attack.tscn` - Melee attack scene
- `melee-attack-vfx.png` - Visual effects for melee attacks

### Ranged Weapon System
- `gun.gd` - Ranged weapon implementation
- `gun.tscn` - Gun scene configuration
- `bullet.gd` - Projectile implementation
- `bullet.tscn` - Bullet scene configuration

## Features

### Melee Combat
- Direction-based attack system
- Hit detection integration
- Visual effects system
- Damage calculation

### Ranged Combat
- Projectile-based system
- Direction-based shooting
- Bullet physics integration
- Range and damage configuration

## Usage

Weapons can be attached to both player and NPC entities through their respective scene trees. Each weapon type implements the following key features:

- Damage calculation
- Hit detection
- Visual effects
- Sound effects (where applicable)
