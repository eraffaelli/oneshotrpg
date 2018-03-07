---
title: "Creating Turns and Rounds"
date: "2018-03-06"
placeholder_image: placeholder-blog-image-1.png
series: werewolf-style-game
series_weight: 11
weight: 11
---

The game’s round is based off of a points system, but it's up to the player to decide when it's over. The script notifies the game when a new round begins and when the points are updated.<!--more-->

{{< commit-up-to hash="d7158e29d55325bc4a58978f4607d41bc45c1a6f" link="https://github.com/oneshotrpg/office-party/tree/d7158e29d55325bc4a58978f4607d41bc45c1a6f" >}}

## Modeling a Round

```gdscript
# round/RoundManager.gd

# The amount of points in a round
# It is a large number (instead of 10 or 100) so it can be tweened
const points_per_round = 1000

# The current round number
var round_num = 0 setget set_round
# The current amount of points in the round
var current_round_points = 0 setget set_points

```

A round---turn---in Office Party is [based on a point system](/tutorial/werewolf-style-game/design-doc/#game-flow-and-mechanics). The game doesn’t progress automatically, it waits for specific player actions to take place. This means that the player has as much time as they need to make their decisions. The [`RoundManager` script](https://github.com/oneshotrpg/office-party/blob/d7158e29d55325bc4a58978f4607d41bc45c1a6f/game/round/RoundManager.gd) defines how many points are in a round, and keeps track of how many points are used up so far. Of note here, is the use of the `setget set_round` and `setget set_points` [setters](http://docs.godotengine.org/en/3.0/getting_started/scripting/gdscript/gdscript_basics.html#setters-getters) attached to the variables. Using the setters means that every time these variables are changed, a specific function is run.

Also of small note is that the `points_per_round` is set to a large number, in this case 1000. I could have gone with a small number, such as 10 or 100, but this large number will make it easier to [tween](http://docs.godotengine.org/en/3.0/classes/class_tween.html) the round progress bar.

## Setting the Round
```gdscript
# round/RoundManager.gd

# Signal when a new round begins
signal round_began(round_num_beginning)

# Setter of round_num
func set_round(new_round_num):
	round_num = new_round_num
	# Reset the points to 0
	set_points(0)

	# Emit a signal that the new round began
	emit_signal("round_began", new_round_num)

```

The current round number is managed by the `set_round()` method, called whenever another script changes the `round_num` class variable. The method resets the points to 0 and then emits the `round_began` [signal](http://docs.godotengine.org/en/3.0/getting_started/scripting/gdscript/gdscript_basics.html#signals), passing the new round number. The signal is handled in [the main scene](/tutorial/werewolf-style-game/main-scene/#connecting-game-functionality) `_on_RoundManager_round_began()` method.

```gdscript
# Main.gd

# Round cleanup tasks
func _on_RoundManager_round_began(round_num_beginning):
	print("Began round %d" % round_num_beginning)

	for npc in Component_NpcManager.npcs_alive:
		npc.has_been_talked_to_this_round = false

	Component_NpcManager.update_slices()

```

The signal handler is designed for “cleanup tasks,” or preparing the game for a new round. It updates the  [NPC slices](/tutorial/werewolf-style-game/npc-management/) and each [NPC’s](/tutorial/werewolf-style-game/npc-nodes/) `has_been_talked_to_this_round`.

## Setting the Points
```gdscript
# round/RoundManager.gd

# Signals
# Signal when the points were updated
signal points_updated(current_round_points)
# Signal when the round points are met
signal round_points_met(round_num_ending)

# Setter of current_round_points
func set_points(new_points):
	# Update the current round's points, but don't let it get any higher than the max points
	current_round_points = clamp(new_points, 0, points_per_round)

	# Emit a signal with the new points
	emit_signal("points_updated", current_round_points)

	# Check if the round is over
	if(!has_points_left()):
		emit_signal("round_points_met", round_num)

```

The `set_points()` method is called when the round’s `current_round_points` is updated. It makes sure that the current point total can’t increase past the `points_per_round` by using Godot’s [clamp](http://docs.godotengine.org/en/3.0/classes/class_@gdscript.html#class-gdscript-clamp) function.

```gdscript
# round/RoundManager.gd

func set_points(new_points):
  # ...
  # Check if the round is over
	if(!has_points_left()):
		emit_signal("round_points_met", round_num)

```

After the points are updated, the method checks if the round’s points have been met. Note, that having the points maxed out is not the same as ending the round. We want the player to decide when to end the round by hitting the end round button, not automatically when the points are met.

```gdscript
# round/RoundManager.gd

func set_points(new_points):
  # ...
  # Emit a signal with the new points
	emit_signal("points_updated", current_round_points)
```

`set_points()` emits the `points_updated` signal when points are updated. The signal is connected to the `_on_RoundManager_points_updated()` method in [`Main.gd`](https://github.com/oneshotrpg/office-party/blob/d7158e29d55325bc4a58978f4607d41bc45c1a6f/game/Main.gd).

```gdscript
# Main.gd

func _on_RoundManager_points_updated(current_round_points):
	print("Points updated to %d / %d" % [
		current_round_points,
		Component_RoundManager.points_per_round
	])
	UI.update_round_progress(current_round_points)
```

The hook updates the UI’s `RoundProgressBar` with the new point value, and later can be tweened instead of an instant update.
