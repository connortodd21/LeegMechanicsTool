# Ability documentation

## How abilites work
Each character has 4 main abilities:
- q
- w
- e
- r

Whenever those buttons are pressed, the character's associated ability should fire. The ability can be a damage ability, a buffing ability (heal/shield/cdr/etc), a passive ability, a movement ability (dash, blink, teleport, speed up, etc), or a defensive ability (damage reduction, invulerability, etc). 

### Ability scenes
Each ability for each character should be contained within its own scene. For example, for the character "Ezreal", there should be 4 associated scenes:
- ezreal_q.tscn
- ezreal_w.tscn
- ezreal_e.tscn
- ezreal_q.tscn

The ability scene should contain the node structure with the root being an Node2d. The root should have an attached script which handles initialization, movement, character interaction, and deletion of the ability.

### Ability resources
There are two main resources for definining and referencing abilities

#### AbilitiesLoadoutResource
This resource contains pointers/references to each character's AbilitiesResource. This resource is dynamically loaded in `player.gd` once the character has been selected. The resource definition can be found in `abilities_loadout_resource.gd`

```
var character_resource_path = "res://resources/ability_loadouts/%s/loadout.tres" % character_name
ability_loadout = load(character_resource_path)
```

Once loaded, you can access a character's ability resource by using
```
# example for loading a character's q resource
ability_loadout.q
```

#### AbilitiesResource
This resource contains ability metadata and a pointer to the abilitie's associated scene. All information like damage, mana cost, cooldown, heal amount, shield amount, etc should be located in this resource.

Any new types of metadata can be added here.

Additionally, this resource contains a pointer to the scene
```
@export var scene: PackedScene
```

When casting an ability, we must ensure to load the scene and add it to the tree
```
func cast(ability: AbilityResource, pos: Vector2, dir: Vector2):
	var instance = ability.scene.instantiate()
	add_child(instance)
	
	instance.initialize(pos, dir)
```

### Ability scripts
Each ability scene should have a script attached at the root node. This script should handle initialization, any custom logic, movement, collision, and ultimately deletion of the scene.

Each scene must implement an initalize function. This function is called when an ability is cast to setup location and scene variables. If an ability does not implement this function, it will not be cast.
```
func _initialize(_position: Vector2, _direction: Vector2) -> void:
    pass # initialize scene variables
```

## Adding new abilities

To add a new ability:

### Step 1: Create the scene
First create a new scene named:
`character_name_ability_name.tscn` (example: `ezreal_q.tscn`) and add ensure the root is a Node2d

Save this scene in `scenes/abilities/character_name/` (example: `scenes/abilties/ezreal/`). If it is a new character, you must create the character_name folder when saving.

### Step 2: Create the resources

#### New character
If the character is new, first create a new AbilityLoadoutResource resource called `loadout.tres` under `resources/ability_loadouts/character_name/`. You must create the character_name folder as well. 

#### AbilityResource
Next, create a new Ability resource in the same folder called `ability_name.tres` (example: `q.tres`). 

Define any ability metadata you want.

Link the scene by loading the scene we made in step 1 into the `Scene` field in the inspector (either drag and drop or load from file system)

#### AbilityLoadoutResource
In the `loadout.tres` resource for this character, link the ability resource created in the previous step to the correct ability. For example, if we created `q.tres` in the previous step, we would link this into the `Q` field in this AbilityLoadoutResource. You can link in the inspector similar to the previous step.

### Step 3: Script
Go back to the ability scene created in step 1 and add a script to the root node.

In this script, add the following method
```
func _initialize(_position: Vector2, _direction: Vector2) -> void:
    pass # initialize scene variables
``` 
and setup and variables required when loading in the ability.

Add whatever business logic you need here (connecting signals, emitting signals, movement, etc)
