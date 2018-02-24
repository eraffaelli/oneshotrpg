---
title: "NPCs and the NPC Generator"
date: "2018-02-22"
placeholder_image: placeholder-blog-image-5.png
series: werewolf-style-game
series_weight: 5
weight: 5
---

This lesson covers the nodes related to NPCs and their functionality. The parent NPC node, generator, UI, portrait, and personality are discussed.<!--more-->

_This lesson covers the game up to commit [0dc7fc0](https://github.com/oneshotrpg/office-party/tree/0dc7fc0b69eb6c300be311ce9ea49ee7e4108f47)._

## Starting Out Small with NPCs
Instead of starting the tutorial with how to set up a project, or even with the main scene, I’m going to start out with the NPC. Remember that this [tutorial is not for those completely new to Godot](/tutorial/werewolf-style-game/introduction/#who-s-this-tutorial-for) so I won't start with the basics. NPCs are the building blocks of the game and have the most functionality attached. The player can interact with them, gain relationship with them, [create their own stories about them](/tutorial/werewolf-style-game/design-doc/#what-s-fun), and vote to kill them. It makes sense, then, to start developing the NPC node before other areas of the project.

According to our [main screen wireframe](/tutorial/werewolf-style-game/wireframes-game-ui/#the-main-screen-and-end-round-button), NPCs looked like this:

{{< figure-single-size src="npc-from-wireframe.png" alt="Detail view of an NPC from the wireframes." >}}

Translated to our game, they look like this:

{{< figure-single-size src="npcs-from-game.png" alt="Screenshot of the NPCs in the game." >}}

To start with something basic, an NPC is a node that can be clicked on and placed into a grid.

## NPC Node
{{< figure-single-size src="screenshot-of-npc-node.png" alt="Screenshot of the NPC node in the Godot editor." >}}

Here's the NPC node in the editor. It's ugly for now, but it has the necessary parts, including the button that handles clicks and taps.

{{< figure-single-size src="npc-node-tree.png" alt="Screenshot of the NPC node tree in the Godot editor." >}}

The node contains a script and two children: the UI and the action button.

### NPC Script
The [NPC script](https://github.com/oneshotrpg/office-party/tree/0dc7fc0b69eb6c300be311ce9ea49ee7e4108f47/game/npc/Npc.gd) focuses on two areas: the NPC as a [character in the setting](/blog/creating-the-characters/) and the NPC as an object in the game. It also emits a signal when the button is pressed, which the main scene will hook into.

```gdscript
# npc/Npc.gd

# Variables related to the NPC as a character
var npc_name = ''
var personality = null

# Variables related to the NPC in the game
var is_dead = false
# The NPC's relationship towards the player
var relationship = 0

```

So far we store the NPC’s name and personality (more on that later); whether the NPC is alive or dead; and their relationship towards the player.

### NpcUI Node
I chose to develop the UI of the NPC---how it looks on the screen---separately from how the NPC as a whole functions.

{{< figure-single-size src="npc-on-interaction-screen.png" alt="The NPC interface exists on the interaction screen." >}}

I went the route of a separate node because the [interaction screen wireframe](/tutorial/werewolf-style-game/wireframes-game-ui/#the-interaction-screen) shows that the NPC’s UI can exist in multiple places and contexts. I wouldn’t want the player to be able to tap on this instance or have it change from alive to dead, so I’ve separated it out from the main NPC node.

```gdscript
# npc/NpcUI.gd

# Child Nodes
onready var Portrait = $VBoxContainer/CenterContainer/Portrait
onready var DeadIcon = $VBoxContainer/CenterContainer/DeadIcon
onready var NameLabel = $VBoxContainer/LabelHolder/NameLabel

func _ready():
	DeadIcon.visible = false
	pass

func set_name(name):
  NameLabel.text = name

```

The [NpcUI script](https://github.com/oneshotrpg/office-party/tree/0dc7fc0b69eb6c300be311ce9ea49ee7e4108f47/game/npc/NpcUI.gd) controls the display, such as hiding and showing the dead icon and changing the name label. It doesn’t know about the parent NPC properties, such as the personality or relationship, it only cares about displaying something on the screen.

### NPC Portrait Node
{{< figure-single-size src="npc-portrait-in-log-screen.png" alt="An NPC portrait in the log screen." >}}

Similar to the NpcUI, the [log screen wireframe](/tutorial/werewolf-style-game/wireframes-game-ui/#log-screen) implies that an NPC’s portrait can exist on different screens. The log screen wireframe shows a list of portraits on their own, next to text. This means that the portrait should also exist separately from the main NPC node.

### Action Button
The entire NPC is tappable, which can be accomplished using a [button node](http://docs.godotengine.org/en/3.0/classes/class_button.html) with the `flat` property set to `On`. The `flat` property will make the button invisible, but still fully intractable. The button is set to fill and expand the entire area of the NPC node.

```gdscript
# npc/Npc.gd

# Signals
# Signal when the NPC was tapped
signal npc_pressed(npc)

# ...

func _on_ActionButton_pressed():
  emit_signal("npc_pressed", self)

```

When pressed, the action button emits a signal that other nodes will act on. The signal sends which NPC was clicked on (`self`) so each NPC can be handled separately. The use of a signal means that the NPC node only has to care about the act of being pressed, not what happens afterwards.

## NPC Generator
The [NPC Generator script](https://github.com/oneshotrpg/office-party/tree/0dc7fc0b69eb6c300be311ce9ea49ee7e4108f47/game/npc/NpcGenerator.gd) is what actually makes the NPCs. It instantiates the NPC node, gives them a name, and assigns a random personality. Later on it’ll also give them a random portrait and gender.

```gdscript
# npc/NpcGenerator.gd

func generate_npcs(amount):
  var npcs = []

  # Shuffle the personalities
  available_personalities = ArrayLibrary.shuffle(available_personalities)

  for i in range(amount):
  	var npc = Npc.instance()
  	npc.npc_name = "Npc %s" %i
  	npc.personality = available_personalities[i]
  	npcs.append(npc)

  # Shuffle the list of npcs
  npcs = ArrayLibrary.shuffle(npcs)

  return npcs

```

The strategy behind the generator is to create the NPCs, assign their attributes, and then return them as an array. Some other node---the NPC grid discussed below---will handle the actual placement of them in game.

### NPC Grid and UI
{{< figure-single-size src="full-game-screenshot.png" href="full-game-screenshot.png" alt="Screenshot of the NPCs in the grid." width="280" >}}

The game’s UI will control the display and placement of the NPCs, among other things.

```gdscript
# ui/UI.gd

# Child Nodes
onready var NpcGrid = $SplitGameScreens/ #...

# ...

func add_npcs(npcs):
  for npc in npcs:
    NpcGrid.add_child(npc)

```

The NPCs are added through the script’s `add_npcs` function. The function loops through the NPC nodes generated from the NPC generator and adds them to a [grid container node](http://docs.godotengine.org/en/3.0/classes/class_gridcontainer.html).

## Personality
An NPC’s personality is controlled through the [personality script](https://github.com/oneshotrpg/office-party/tree/0dc7fc0b69eb6c300be311ce9ea49ee7e4108f47/game/npc/Personality.gd).

```gdscript
# npc/Personality.gd

enum Personalities {
	PERSONALITY_LONER,
	PERSONALITY_KEEN,
	PERSONALITY_CRAZY,
	PERSONALITY_HOTHEAD,
	PERSONALITY_FOLLOWER
}

```

The personality is stored as a [named enum](http://docs.godotengine.org/en/3.0/getting_started/scripting/gdscript/gdscript_basics.html#enums), meaning personalities will resolve to an integer.

```gdscript
# Potential code

var Personality = preload("res://npc/Personality.gd")

npc.personality = Personality.PERSONALITY_KEEN

if(personality == Personality.PERSONALITY_LONER):

```

The use of a named enum means that I can have readable code that looks like `npc.personality = Personality.PERSONALITY_KEEN` and `if(personality == Personality.PERSONALITY_LONER)`.

```gdscript
# npc/NpcGenerator.gd

# The possible personalities for each NPC
var available_personalities = [
  Personality.PERSONALITY_LONER,
  Personality.PERSONALITY_LONER,
  Personality.PERSONALITY_LONER,
  Personality.PERSONALITY_LONER,
  Personality.PERSONALITY_KEEN,
  # ...

# ...

func generate_npcs(amount):
  # ...

  # Shuffle the personalities
  available_personalities = ArrayLibrary.shuffle(available_personalities)

  # ...

  for i in range(amount):
    # ...
    npc.personality = available_personalities[i]

```

The NPC generator has an array that stores the different personality options. This array is randomized before creating the NPCs, then is assigned after the name is generated. I went with the hard-coded array style of defining the available personalities because I feel like it’s easier to see the different probability weights, and I know that there’ll always be 4 of each personality. Maybe further along in development I’ll refactor the code.
