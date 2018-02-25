---
title: "Initial Game UI Management"
date: "2018-02-25"
placeholder_image: placeholder-blog-image-3.png
series: werewolf-style-game
series_weight: 8
weight: 8
---

Game UI management is a tricky topic. Screens have to be populated, shown, and hidden at the right time, based on user input. This lesson goes over Office Party’s initial implementation of UI state and screen management.<!--more-->

{{< commit-up-to hash="371090ddd83581af9885a01edea473f11b9aa29d" link="https://github.com/oneshotrpg/office-party/tree/371090ddd83581af9885a01edea473f11b9aa29d" >}}

## Initial UI Management
[Office Party](/tutorial/werewolf-style-game/design-doc/#introducing-office-party) has user interface needs beyond the simple “start game” and “game over” screens. Different sections of the game need to be activated and deactivated based on player actions---a player taps on the view log button and the NPC grid is replaced with the log screen. In addition, some screens must react to the player, such as when tapping on an NPC and the interaction screen fills in the portrait and NPC’s name. This mixture of contextual actions and screen navigation means that the game must have some sort of UI state management. This lesson discusses the initial implementation.

## Overview of the Screen Types

{{< figure-single-size src="ui-scene-node-tree.png" alt="Screenshot of the UI scene node tree in the Godot editor." >}}

The UI node manages two different types of game screens, which I’m calling “split screens” and “full screens”.

{{< figure-single-size src="splitgamescreen-scene-node-tree.png" alt="Screenshot of the SplitGameScreen scene node tree in the Godot editor." >}}

Split screens are divided into the top part and the bottom part.

{{< figure-single-size src="splitgamescreenbottom-scene-node-tree.png" alt="Screenshot of the SplitGameScreenBottom scene node tree in the Godot editor." >}}

{{< figure-single-size src="splitgamescreenbottom-scene-in-godot-editor.png" alt="Screenshot of the SplitGameScreenBottom scene in the Godot editor." >}}

Split screens always show the bottom portion, which remains constant between screens. The scene contains the status area, the view log button, and the round indicator bar. The top portion of the `SplitGameScreen` is what changes.

{{< figure-single-size src="screeninteraction-scene-node-tree.png" alt="Screenshot of the ScreenInteraction scene node tree in the Godot editor." >}}

Above is a screenshot of the interaction screen node tree in the Godot editor. Each split screen can have lots of child nodes, so I’ve placed each into their own scene. If I didn’t place each screen into its own scene, then the main UI node would have hundreds of children and scripts, which would make it a mess.

{{< figure-single-size src="empty-containers-for-full-screens.png" alt="Screenshot of the empty containers in the Godot editor." >}}

The other type of screen is the “full screen”---which as the name implies take up the entire viewport. The start and end game screens will be full screens. They aren’t developed yet, so they’re empty hidden [Containers](http://docs.godotengine.org/en/3.0/classes/class_container.html) for now.

## UI Script
The strategy behind the UI is to have a single [UI script](https://github.com/oneshotrpg/office-party/blob/371090ddd83581af9885a01edea473f11b9aa29d/game/ui/UI.gd) that manages all of the state, prepares the screens for display, and emits the proper signals. That makes the script quite long, and means that there are complex nested selectors like `SplitGameScreen.SplitGameScreenBottom.ViewLogButton`. However, development will be easier if all UI functionality is located in one spot. As discussed in the last article, [early UI should be loose but functional](/tutorial/werewolf-style-game/placeholder-ui/). The script may need refactored later, but for now it works.

## Defining the Screens
```gdscript
# ui/UI.gd

# Screens
# All of the screens
enum Screens {
	SCREEN_MAIN,
	SCREEN_INTERACTION,
	SCREEN_LOG
}
# A map of the screens to their nodes
onready var screen_map = {
	SCREEN_MAIN: SplitGameScreen.ScreenNpcGrid,
	SCREEN_INTERACTION: SplitGameScreen.ScreenInteraction,
	SCREEN_LOG: SplitGameScreen.ScreenLog
}
# The currently active screen
var active_screen = null
```

In code, all of the game’s screens are represented by the `Screens` [enum](http://docs.godotengine.org/en/3.0/getting_started/scripting/gdscript/gdscript_basics.html#enums). Each entry in the enum is then mapped to a node through the `screen_map` [dictionary](http://docs.godotengine.org/en/3.0/getting_started/scripting/gdscript/gdscript_basics.html#dictionary). Finally, the active screen is stored as the `active_screen` variable.

Using the `Screens` enum and the `active_screen` variable means that I can have code that looks like this:

```gdscript
# Potential code

if(active_screen == SCREEN_LOG):
  foo = bar
```

## Switching Screens
Switching screens is handled through the `switch_screen()` method. The method, combined with the `Screens` enum from above, means that scripts can call `UI.switch_screen(UI.SCREEN_INTERACTION)`, which makes for readable code.

Here’s the entire `switch_screen()` method:

```gdscript
# ui/UI.gd

func switch_screen(to_screen):
	# Only switch screens if they're different
	if(to_screen == active_screen):
		return

	# Store the screen we're switching from
	var from_screen = active_screen

	# If we aren't on the null screen, use a transition
	if(from_screen != null):
		# Start the screen transition
		emit_signal("screen_switch_transition_start", to_screen, from_screen)
		# @todo actual transition
	# For now, use visibility
	if(from_screen != null):
		screen_map[from_screen].visible = false
	screen_map[to_screen].visible = true

	# Run tasks needed during screen switches
	prepare_screen_before_showing(to_screen, from_screen)

	# Set the active_screen to the new screen
	active_screen = to_screen
	emit_signal("screen_switched", to_screen, from_screen)

```

Even this early in development, the `switch_screen()` method is complicated. But, if you think about it, managing a game’s UI state is a complicated subject. The method must prepare a screen for display; transition (which isn’t implemented yet) the old screen out; transition the new screen in; all while timing other functionality to each step and when the entire process is complete. Let’s break the method down.

### Changing the Screen State
```gdscript
# ui/UI.gd

func switch_screen(to_screen):
  # Only switch screens if they're different
	if(to_screen == active_screen):
		return

  # Store the screen we're switching from
	var from_screen = active_screen

  # ...

  # Set the active_screen to the new screen
	active_screen = to_screen

```

Part of the process is updating the screen state---saving the `active_screen`. This process doesn’t actually hide or show anything, which is handled elsewhere. At the beginning of the method, there’s a check if the screen actually needs to be switched, which allows for repeated calls to `switch_screen()` without messing up the game.

### Showing and Hiding the Screens
```gdscript
# ui/UI.gd

func switch_screen(to_screen):
  # ...
  # If we aren't on the null screen, use a transition
  if(from_screen != null):
  	# Start the screen transition
  	emit_signal("screen_switch_transition_start", to_screen, from_screen)
  	# @todo actual transition
  # For now, use visibility
  if(from_screen != null):
  	screen_map[from_screen].visible = false
  screen_map[to_screen].visible = true

```

The code for showing and hiding the actual nodes is kind of messy. It’s written in a way to remind myself to account for transitions and timing animations, which I’ve yet to implement.

```gdscript
# ui/UI.gd

func switch_screen(to_screen):
  # ...
  # For now, use visibility
  if(from_screen != null):
    screen_map[from_screen].visible = false
  screen_map[to_screen].visible = true

```

Right now, the hiding/showing is accomplished through the use of `.visible = true/false`. Later this will have to wait until an animation is complete. The method knows which node to show/hide based on the entry in the `screen_map` dictionary.

### Internals
```gdscript
# ui/UI.gd

func switch_screen(to_screen):
  # ...
  # Run tasks needed during screen switches
  prepare_screen_before_showing(to_screen, from_screen)
  # ...

func prepare_screen_before_showing(to_screen, from_screen):
  match to_screen:
  	SCREEN_MAIN:
  		set_view_log_button_text(VIEW_LOG_BUTTON_STRING_VIEW)
  	SCREEN_INTERACTION:
  		set_view_log_button_text(VIEW_LOG_BUTTON_STRING_CLOSE)
  	SCREEN_LOG:
  		set_view_log_button_text(VIEW_LOG_BUTTON_STRING_CLOSE)

```

```gdscript
# ui/UI.gd

var selected_npc = null setget set_selected_npc

func set_selected_npc(new_npc):
  # Update the NPC's name
  ScreenInteraction.NpcGUI.set_name(new_npc.npc_name)
  selected_npc = new_npc

```

A screen needs to be prepared---filled out---before it can be shown. Examples include changing a button’s text or updating a portrait. I'm not sure if I should put this functionality in one spot, or split it between the  `prepare_screen_before_showing()` method and [`setgets`](http://docs.godotengine.org/en/3.0/getting_started/scripting/gdscript/gdscript_basics.html#setters-getters) such as the `set_selected_npc()` method.

### Letting the Game Know about Screen Switches
Timing functionality to happen before/during/after animations is a tough thing to do. You wouldn’t want the interaction screen to change the portrait and icons of the selected NPC _after_ the screen has been shown. The web development community has many words for this type of behavior, including [FOUC](https://css-tricks.com/fout-foit-foft/) (flash of unstyled content). The content needs to be updated _before_ the screen is shown to avoid FUOC. I’ll control the timing of things using a couple of signals that the UI script emits.

```gdscript
# ui/UI.gd

signal screen_switch_transition_start(to_screen, from_screen)
signal screen_switched(to_screen, from_screen)

func switch_screen(to_screen):
  # ...
  # Start the screen transition
  emit_signal("screen_switch_transition_start", to_screen, from_screen)
  # ...
  emit_signal("screen_switched", to_screen, from_screen)

```

In this commit, the signals are called instantly, instead of waiting for a transition to finish. They’re placeholder, to remind myself to account for them later. They’ll eventually need to be split into  `screen_transition_out_started`, `screen_transition_out_finished`, `screen_transition_in_started`, and `screen_transition_in_ended`.

```gdscript
# Main.gd

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

```

The [main script](https://github.com/oneshotrpg/office-party/blob/371090ddd83581af9885a01edea473f11b9aa29d/game/Main.gd) connects these signals to print out some helpful information about which screen is being shown and which one is being hidden.

## Hiding the Screens and Setting the First One
```gdscript
# ui/UI.gd

func _ready():
  # ...
  # Hide all of the game screens
  for screen in screen_map.values():
  	screen.visible = false
  # Switch to the main screen for now
  switch_screen(SCREEN_MAIN)

```

When working on a screen in the editor, you may forget to turn the right one on and the rest of them off. You shouldn’t have to worry about this, so when the game starts, the UI’s initial state should be set. I first loop through all screens in the `screen_map` and hide them, then show the first screen using a `switch_screen()` call. No matter the state of the nodes in the Godot editor, I know that when the game is played, the right game screen will show up.
