---
title: "NPC Management"
date: "2018-03-02"
placeholder_image: placeholder-blog-image-5.png
series: werewolf-style-game
series_weight: 10
weight: 10
---

Office Party requires looping through specific groups of NPCs and performing an action on them. Instead of repeating filtering logic throughout the game’s scripts, the slices are created once and reused.<!--more-->

{{< commit-up-to hash="e1ba0dfbd0b0fd2b069350cd8bfcc6f394156e33" link="https://github.com/oneshotrpg/office-party/tree/e1ba0dfbd0b0fd2b069350cd8bfcc6f394156e33" >}}

## The Concept of Slices

A slice is a subset---grouping---of [NPCs](/tutorial/werewolf-style-game/npc-nodes/). Throughout the game I’ll need to get a group of NPCs and iterate over them. For example, for each NPCs that are alive, reset their `has_been_talked_to_this_round`; when the player [flatters an NPC](/tutorial/werewolf-style-game/design-doc/#npc-interactions), loop through all non-influenced NPCs and decrease their relationship; in the voting phase, for each influenced NPC, change their vote to yours.

Instead of repeating the logic of looping over all of the NPCs and filtering them based on certain criteria:

```gdscript

# Hypothetical code to avoid

for npc in npcs:
  if(!npc.is_dead):
    # Do something

# In another function
for npc in npcs:
  if(!npc.is_dead):
    # Do something

# In another function
for npc in npcs:
  if(!npc.is_dead):
    # Do something

```

I can have one spot where these slices are defined, and then reuse them in my code:

```gdscript
# npc/InteractionManager.gd

func do_interaction_on(interaction, npc):
  # ...
  for other_npc in Component_NpcManager.npcs_uninfluenced:
  # ...
  for other_npc in Component_NpcManager.npcs_alive:

```

Slices are defined in the [NPC Manager script](https://github.com/oneshotrpg/office-party/blob/e1ba0dfbd0b0fd2b069350cd8bfcc6f394156e33/game/npc/NpcManager.gd), which is added as a child node of the [main scene](/tutorial/werewolf-style-game/main-scene/).

## Creating Slices

```gdscript
# npc/NpcManager.gd

# All of the NPCs
var all_npcs = []
# All of the alive NPCs
var npcs_alive = []
# All of the NPCs the player has influence over
var npcs_influenced = []
# The opposite, NPCs not influenced
var npcs_uninfluenced = []

func update_slices():
	# Reset all of the slices to empty arrays
	npcs_alive = []
	npcs_influenced = []
	npcs_uninfluenced = []

	for npc in all_npcs:
		if(!npc.is_dead):
			npcs_alive.append(npc)

		if(npc.is_influenced):
			npcs_influenced.append(npc)
		else:
			npcs_uninfluenced.append(npc)

```

Slices are created by first resetting all of them to an empty [Array](http://docs.godotengine.org/en/3.0/getting_started/scripting/gdscript/gdscript_basics.html#array). The `update_slices()` method then loops through all NPCs and assigns them to a slice based on different logic.

## Updating Slices

The downside to creating groups of NPCs once and then reusing them is that the groups can become out of date. I could mitigate this problem by running the `update_slices()` on each frame, but that could become resource intensive. Instead, I’ve opted to manually call `update_slices()` whenever something important changes about an NPC.

```gdscript
# Main.gd

func _on_Npc_has_been_influenced(npc):
	# ...
	# Update the slices
	Component_NpcManager.update_slices()

```

The slices are regenerated when an NPC is influenced or the round begins. Later they’ll also need to be updated when an NPC is killed.
