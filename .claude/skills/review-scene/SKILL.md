---
name: review-scene
description: Review a Godot scene file for issues
disable-model-invocation: true
argument-hint: <scene-file-path>
---

Review the specified scene file for common issues:

Target: $ARGUMENTS

## Check for:
1. **Collision layers** — Player=1, Enemy=2, HitArea=3, HurtArea=4, World=5. Are they correct for this entity?
2. **Signal connections** — Are all signals wired in the .tscn? Any missing connections?
3. **Export overrides** — Do scene-level overrides match what the script expects? (e.g. max_health mismatch)
4. **Node references** — Do @export node paths point to nodes that exist in the tree?
5. **HitBox/HurtBox setup** — Does HurtBox have a Health export? Does HitBox have damage set?
6. **Controller wiring** — If entity has a Controller, are attacked/moved/dash/interact signals connected?
7. **Timer configuration** — Are one_shot timers actually one_shot? Are autostart timers intended?

Report issues found with line numbers from the .tscn file.
