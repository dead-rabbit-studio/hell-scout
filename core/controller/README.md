# Controller System

Provides a unified interface for handling both player input and AI behavior.

## Components

### Base Controller
- `controller.gd` - Base controller class
- Common interface for all controllers
- Signal definitions
- Core functionality

### Input Controller
- `input_controller.gd` - Player input handling
- Keyboard/gamepad support
- Action mapping
- Input state management

### AI Controller
- `ai_controller.gd` - NPC behavior control
- `ai_controller.tscn` - AI controller scene
- Behavior patterns
- Decision making

## Features

### Action System
- Movement control
- Attack actions
- Interaction handling
- State management

### Input Mapping
- Configurable key bindings
- Action definitions
- Input validation

### AI Behaviors
- State-based decisions
- Target tracking
- Path finding
- Combat behaviors

## Usage

### Player Control
1. Add input controller to player
2. Configure action mappings
3. Connect to action signals

### AI Control
1. Add AI controller to NPC
2. Configure behavior patterns
3. Set up decision making
4. Connect to action signals
