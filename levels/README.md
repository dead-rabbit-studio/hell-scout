# Levels

Contains all level-related content and environment assets.

## Structure

### Environment
- `tree.gd` - Interactive tree object implementation
- `spritessheet/` - Character and object sprites
- `tilemap/` - Level tilemap assets
  - House floors and walls
  - House props and decorations

### Core Files
- `level.gd` - Base level implementation
- `level_status.gd` - Level state management

## Features

### Level Management
- Scene transitions
- Level state persistence
- Environment interaction

### Environment Objects
- Interactive objects (trees, etc.)
- Collectible items
- Warp zones

### Visual Assets
- Tilemap-based level design
- Environment sprites
- Decoration elements

## Creating New Levels

To create a new level:

1. Create a new scene with a root node inheriting from `level.gd`
2. Set up the tilemap using assets from `tilemap/`
3. Add interactive objects and collectibles
4. Configure level transitions using warp zones
5. Set up the level status using `level_status.gd`
