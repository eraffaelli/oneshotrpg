---
title: "Main Scene and Its Connections"
date: "2018-02-27"
placeholder_image: placeholder-blog-image-4.png
series: werewolf-style-game
series_weight: 9
weight: 9
---

The main scene is the brains of the operation. It responds to the game’s different events, allows (or denies) a player to take specific actions, and sets everything into motion.<!--more-->

{{< commit-up-to hash="545db314174f68c5c4deb425ed4c6e7c5779d883" link="https://github.com/oneshotrpg/office-party/tree/545db314174f68c5c4deb425ed4c6e7c5779d883" >}}

## Main Scene Goals
The goal of the main scene and the [Main.gd](https://github.com/oneshotrpg/office-party/blob/545db314174f68c5c4deb425ed4c6e7c5779d883/game/Main.gd) script is to set up the game, manage the game’s state, and connect all of the things together.

{{< figure-single-size src="main-scene-node-tree.png" alt="Screenshot of the Main scene node tree in the Godot editor." >}}

The node tree is sparse, because most of the current functionality lies within the [UI child node](/tutorial/werewolf-style-game/placeholder-ui/). As more features are developed, such as the round management and NPC voting, they’ll need a place to “live” within the editor. They’ll be added as a child of the `Components` node, of which the [`NpcGenerator`](/tutorial/werewolf-style-game/npc-nodes/#npc-generator) is. I’ll go over the concept of using the "child nodes as components" pattern for Godot games in a later article.

## Setting Up The Game
```gdscript
# Main.gd

func _ready():

	# Create a random seed each time the game runs
	randomize()

	# Generate the NPCs
	var npcs = Component_NpcGenerator.generate_npcs()
	UI.add_npcs(npcs)
	for npc in npcs:
		# Connect the NPC's signal to this script
		npc.connect("npc_pressed", self, "_on_Npc_npc_pressed")

	# Start the game right away for now
	set_state(STATE_PHASE_PARTY)

```

The `_ready()` method is used to prepare the game for play. Think creating NPCs, setting the round to round 1, and showing the start screen.

```gdscript
# Main.gd

func _ready():
  # ...
  # Generate the NPCs
  var npcs = Component_NpcGenerator.generate_npcs()
  UI.add_npcs(npcs)
  for npc in npcs:
    # Connect the NPC's signal to this script
    npc.connect("npc_pressed", self, "_on_Npc_npc_pressed")

```

The method generates the NPCs and connects their `npc_pressed` signal to a method in this script.

```gdscript
# Main.gd

func _ready():
  # ...
  # Start the game right away for now
	set_state(STATE_PHASE_PARTY)
```

It also sets the initial game state, which will let the player actually do something. For now the game is started immediately, but later it'll open with the "start game" screen.

## Managing Game State
```gdscript
# Main.gd

# Finite state machine
enum States {
	# Game screens, such as the start game and end game screens
	STATE_SCREEN,
	# Talking to the first NPC, before someone has died
	STATE_PHASE_PARTY,
	# Interaction phase
	STATE_PHASE_INTERACTION,
	# Phase to vote
	STATE_PHASE_VOTING,
	# Phase where an NPC is killed
	STATE_PHASE_KILLING
}

func set_state(new_state):
	print("Changed state to %s" % States.keys()[new_state])
	state = new_state

```

The main script is in charge of managing the game’s state---waiting for player interaction, voting, [turning the lights off](/tutorial/werewolf-style-game/design-doc/#game-flow-and-mechanics), and showing game screens. The state management code looks similar to the [UI screen managing code](/tutorial/werewolf-style-game/ui-management/#defining-the-screens) because they both follow a finite state pattern, which I’ll discuss in a later lesson.

## Connecting Game Functionality
```gdscript
# Main.gd

func _on_Npc_npc_pressed(npc):
	print("Tapped on %s" % npc.npc_name)
	UI.selected_npc = npc
	UI.switch_screen(UI.SCREEN_INTERACTION)

func _on_UI_end_round_pressed():
	print("End round button pressed")

func _on_UI_view_log_pressed():
	print("View log button pressed")
	if(UI.active_screen == UI.SCREEN_MAIN):
		UI.switch_screen(UI.SCREEN_LOG)
	else:
		UI.switch_screen(UI.SCREEN_MAIN)

func _on_UI_screen_switch_transition_start( to_screen, from_screen ):
	print("Starting screen transition from %s to %s" % [
		UI.Screens.keys()[from_screen],
		UI.Screens.keys()[to_screen],
	])

func _on_UI_screen_switched( to_screen, from_screen ):
	if(from_screen != null) :
		print("Switched screen to %s from %s" % [
			UI.Screens.keys()[to_screen],
			UI.Screens.keys()[from_screen],
		])

func _on_UI_do_interaction( interaction, npc ):
	print("Doing interaction %s on %s" % [
		Interactions.Interactions.keys()[interaction],
		npc.npc_name
	])
```

Finally, the main script is tasked with connecting all of the game’s functionality together. Different game features talk to each other using [signals](http://docs.godotengine.org/en/3.0/getting_started/scripting/gdscript/gdscript_basics.html#signals), all of which are listened to by this script. When a button is pressed, an NPC tapped on, or when a screen is changed, this script is in charge of defining what happens next. Keeping all of the connections together in a single script means that I know where everything that makes the game work is located. I’m not sure that a single-script-for-connections pattern makes sense for a more complex game, but it works well for a smaller game such as Office Party.

The game has NPCs, screens and screen management, and something to connect it all together. Now to develop the actual features.
