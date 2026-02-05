# Character documentation

A character is a player in the game you can control by moving (clicking on a location). Characters can also cast abilities by pressing the q, w, e, or r buttons.

## How characters work
Each character is contained within its own scene and resource. 

### Character scenes

#### The Player scene
This is the base scene for all characters and handles physics, input detection, movement. This is the scene for all things character related, and is isntantiated in the main game node.

#### Character Animations
Each character has a set of animations it needs to show when moving, idle, attacking, or other actions. These animations exist in the character's scene - found in the `scenes/characters/animations` folder. 

Each character scene has a Node2d root with an AnimatedSprite2d child. This AnimatedSprite2d contains all the animations for this character.

Animations are named `action_direction`. For example, the animation for moving left would be `moving_left`. 

The supported actions so far are
- idle
- moving
- attack

The supported directions so far are
- front
- back
- side (this handles both left and right)

#### CharacterData
Each character must use a CharacterData resource, which defines default values for health, mana, move speed, etc. Additionally this resource contains references to the character scene (mentioned above) and the character's ability resource. See the ability docs for more on ability resources.

CharacterData resource can be found in `resources/characters/character_data.gd`

### Character scripts

#### player.gd
This script is linked to the root character node in the player scene

This script handles all player interactions (movement, ability clicks, summoners, etc).

This script also loads in all the relevant information, such as 
- abilities
```
ability_loadout = character_data.ability_loadout
```
- animations 
```
var animation_scene = character_data.animations_scene.instantiate()
character_animations.add_child(animation_scene)
animated_sprite_2d = animation_scene.get_node("AnimatedSprite2D")
```

Anything related to rendering, loading, node operations, or any gameplay actions are handled in this script

#### base_caracter.gd

This script is the base script for all character data. Things like increasing health, tracking current health, etc all happen here. No loading or game operations happen here. This is just a data class.


## Adding new characters

### Step 1: Add character enum
In `scripts/characters/characters.gd`, add the character's name to the CHARACTERS enum in all caps.

### Step 2: Create the character's scene
First, create a new scene with root node as Node2d named `player_name.tscn` and save it in `scenes/characters/animations`

Add an `AnimatedSprite2d` child node then import and create all the sprite frames/animations necessary. 

Note that the animation names must follow the naming described in the animations section above. Otherwise the system will not find them.

### Step 3: Create the character's resource
Create a new resource (type = CharacterData) in `resources/characters/character_loadouts` and name it `character_name.tscn`. 

Define all default values for the character here. Link the scene from step 1 in the `animations scene` field in the inspector. Also link the ability loadout resource for this character here. This ability loadout field is how the character connects to its abilities. 

The `Character` field should be the enum created in step 1

After connecting everything and finalizing values, save.
