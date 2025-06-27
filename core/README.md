# Core Systems

This directory contains the core game systems and mechanics that form the foundation of Hell Scout.

## Directory Structure

- `r.gd` - Global resource constants and configuration
- `controller/` - Input and AI controller implementations
- `health/` - Health and damage system
- `hit_detection/` - Combat hit detection system
- `interaction/` - Object interaction system
- `warpzone/` - Level transition and teleportation system

## Key Components

### Controller System
The controller system (`controller/`) provides a unified interface for both player input and AI behavior, allowing for easy switching between different control methods.

### Health System
The health system (`health/`) implements damage tracking, death handling, and health management for all entities in the game.

### Hit Detection
The hit detection system (`hit_detection/`) manages combat collision detection with separate HitBox and HurtBox components.

### Interaction System
The interaction system (`interaction/`) handles player interactions with objects in the game world, including collectibles and interactive elements.

### Warp Zone System
The warp zone system (`warpzone/`) manages level transitions and teleportation mechanics.
