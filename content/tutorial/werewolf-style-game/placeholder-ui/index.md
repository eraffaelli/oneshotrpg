---
title: "Placeholder UI: Loose But Functional"
date: "2018-02-24"
placeholder_image: placeholder-blog-image-2.png
series: werewolf-style-game
series_weight: 7
weight: 7
---

A game’s interface must be loose but functional during early development. The UI should have all of the required functionality, but still be able to be changed at a moment’s notice.<!--more-->

{{< commit-up-to hash="a8b8d1b30f17d607ce11ae95e96c362087aac063" link="https://github.com/oneshotrpg/office-party/tree/a8b8d1b30f17d607ce11ae95e96c362087aac063" >}}

## Start with a Loose UI

Office Party’s [main mechanics revolve around its interface](/tutorial/werewolf-style-game/introduction/#why-this-style-of-game). That means that a lot of development effort should go into perfecting it. But, at the same time, early development requires that things get moved around, features get added, and interface elements get removed. The UI has to be complete enough to work during the beginning stages of the game, but not so overly architected that it’s hard to change things later on.

I’ve started the interface with grayscale assets, like in the [wireframes](/tutorial/werewolf-style-game/wireframes-game-ui/), while all of the Godot control elements are in their default theme. Sidebar, why doesn’t the default ingame theme match the Godot 3 editor theme? I’m also not worrying about correct container sizes, correct alignment of elements, spacing, and words getting cut off of labels. All of these issues will be fixed when the final interface is designed---wireframes to mockups.

## Comparing Wireframes to Initial UI

This first attempt at an interface should match the _essence_ of the wireframes, not be exact. To illustrate this concept, we’ll compare the wireframes to ingame screenshots.

{{< figure-single-size src="wireframes.svg" href="wireframes.svg" alt="Wireframes of the game's main screens." width="1165" >}}

{{< figure-single-size src="all-screens-screenshot.png" href="all-screens-screenshot.png" alt="Screenshots of the game's main screens." width="1165" >}}

The first image is of the wireframes, the second is the ingame screenshot.

### NPC Grid
{{< figure-single-size src="main-screen.svg" href="main-screen.svg" alt="Screenshot of the game's main screen." width="280" >}}

{{< figure-single-size src="screenshot-main-screen.png" href="screenshot-main-screen.png" alt="Screenshot of the game's main screen." width="280" >}}

Above is the comparison between the wireframe and ingame screenshot.

{{< figure-single-size src="view-log-button-changes-size.gif" alt="Animation of the view log button changing sizes." >}}

The “View Log” button changes sizes when its text is changed. This is jarring and wouldn’t be acceptable in the final game, but it doesn’t matter in this placeholder UI.

### Interaction Screen
{{< figure-single-size src="interaction-screen.svg" href="interaction-screen.svg" alt="Wireframes of the game's interaction screen." width="280" >}}

{{< figure-single-size src="screenshot-interaction-screen.png" href="screenshot-interaction-screen.png" alt="Screenshot of the game's interaction screen." width="280" >}}

The ingame interaction screen is the most different from the wireframe. I’ve decided to move the close button to where the view log button is, and will probably iterate on that as the game is developed.

{{< figure-single-size src="interaction-buttons-screenshot.png" alt="Screenshot of the interaction buttons being messy." >}}

I haven’t made the interaction buttons fill the available space. I don’t even know if these will be the final interactions, so I’m not worried about it.

{{< figure-single-size src="portrait-jumping-animation.gif" alt="Animation of the portrait jumping." >}}

The portrait in the bottom corner jumps around, but at least the NPC’s name is filled in.

{{< figure-single-size src="icons-are-placeholder.png" alt="Screenshot of the icon node in the tree view." >}}

The icons are just an image ([TextureRect](http://docs.godotengine.org/en/3.0/classes/class_texturerect.html)) for now.

### Log Screen
{{< figure-single-size src="log-screen.svg" href="log-screen.svg" alt="Wireframes of the game's log screen." width="280" >}}

{{< figure-single-size src="screenshot-log-screen.png" href="screenshot-log-screen.png" alt="Screenshot of the game's log screen." width="280" >}}

The log screen wireframe and screenshot are pretty close...

{{< figure-single-size src="log-entry-node-not-respecting-height.png" alt="Screenshot showing the text label being shorter than the text." >}}

{{< figure-single-size src="log-entries-clashing.png" alt="Screenshot of the log entries overlapping." >}}

However, the log text can’t get any longer without getting cut off or overlapping with the entries below. I am still struggling with making it work.

## It Should be Functional

Nitpicking the interface at this stage is futile, since any of it can change. What matters is that the UI _functions_. The interface can transition between screens, buttons can be tapped, NPC names are filled in. With the foundation in place I can develop the rest of the game.

## Did I Accomplish the Goal?
Did I accomplish the goal of making the interface loose but functional? I don’t quite think so. As seen in a selector like `$VBoxContainer/InteractionScreenBottom/InteractionsBackground/MarginContainer/InteractionButtonsContainer/InteractionCommandAttentionButton` from the [interaction screen script](https://github.com/oneshotrpg/office-party/blob/a8b8d1b30f17d607ce11ae95e96c362087aac063/game/ui/split-game-screen/ScreenInteraction.gd), I’ve probably already over architected it. Developing game UI is hard.
