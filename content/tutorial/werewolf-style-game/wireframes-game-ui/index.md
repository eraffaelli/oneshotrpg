---
title: "Designing Wireframes for Game UI"
date: "2018-02-19"
placeholder_image: placeholder-blog-image-4.png
series: werewolf-style-game
series_weight: 4
weight: 4
---

Starting off the game’s development with wireframes will help identify UX problems early in the process. The wireframe’s low-fidelity nature means that changes can be made with little effort.<!--more-->

## The Importance of Creating Wireframes
When developing a game, starting with low-fidelity wireframes allows you to [make decisions about how the game flows from screen to screen](https://alistapart.com/column/start-coding-with-wireframes), without worrying about how the game looks. Wireframes for [Office Party](https://github.com/oneshotrpg/office-party)---a game that’s so dependent on the user interface---is to the UI what the [design doc](/tutorial/werewolf-style-game/design-doc/) is to gameplay. Similar to how starting with the design doc informs gameplay, creating the wireframes early in the process gives insight into how the game should be structured. The wireframes don’t need to look pretty (in fact, they _shouldn’t_), but they do need to be readable. The viewer should be able to understand what each element is supposed to do.

In addition to laying out the game’s flow, you can also start evaluating the game’s user experience (UX) from the wireframes. Will the game’s interface be easy to use and understand? Will relevant mechanics be visible to the user? Questions such as those can be answered before a single line of code is written.

## The Game Screens
{{< figure-single-size src="wireframes.svg" href="wireframes.svg" alt="Wireframes of the game's main screens." width="1165" >}}

The first round of wireframes focus on the central game screens---the main screen, the interaction screen, and the log screen.

## The Main Screen and End Round Button
{{< figure-single-size src="main-screen.svg" href="main-screen.svg" alt="Wireframes of the game's main screen." width="280" >}}

The main screen’s focus is to allow the player to see which NPCs are alive or dead. The player is presented with a grid of NPCs, and by tapping on one of them they’re taken to the interaction screen. At the bottom of each screen sits a status area that gives the player a hint at what to do; a button to view the log; and a button that ends the round and shows the remaining time.

The decision to place these always available buttons at the bottom of the screen is intentional, it’s based on how we [hold our phones](https://alistapart.com/article/how-we-hold-our-gadgets). The thumb zone is the [physical space on our screens](https://www.smashingmagazine.com/2016/09/the-thumb-zone-designing-for-mobile-users/) that is the easiest to reach with our thumbs. These two diagrams from [Smashing Magazine](https://cloud.netlifyusercontent.com/assets/344dbf88-fdf9-42bb-adb4-46f01eedd629/496f7bc0-4c6c-4159-b731-ec3adcf91105/thumb-zone-mapping-opt.png) and [A List Apart](https://alistapart.com/d/432/1.4-thumb-zone-2x.jpg) illustrate the concept. Because the user will be using these buttons a lot, especially the end round button, they should be placed in a spot that’s most accessible to our thumbs.

## The Interaction Screen
{{< figure-single-size src="interaction-screen.svg" href="interaction-screen.svg" alt="Wireframes of the game's interaction screen." width="280" >}}

The interaction screen is designed to keep the user focused on the main mechanic of the game---interacting with NPCs. It provides an area to read the NPC’s dialogue and offers large buttons to perform the interactions. Notice how the buttons are stacked vertically on the left side of the screen. This is again due to the ease of access in the thumb zone from [this diagram](https://alistapart.com/d/432/1.4-thumb-zone-2x.jpg). The user will be spending most of their time using these buttons, so they should be easily accessible.

The decision to place the interaction options on the left side of the screen, instead of the right, is because when using devices, a user spends most of their time [looking at the left side of the screen](https://www.nngroup.com/articles/horizontal-attention-leans-left/) (in left to right languages such as English). Placing the buttons on the left side of the screen will mean that they will be more easily seen by the user.

### Popup or Screen?
When planning the game’s interface, I switched back and forth from having this screen be separate or having it being a popup when tapping on an NPC. I decided to make it a separate screen to reduce visual clutter, which reduced cognitive load, which [keeps the user focused](https://www.nngroup.com/articles/minimize-cognitive-load/) on the task of interacting with the NPC. I felt that displaying a popup over the rest of of the NPCs was too distracting and that the user would accidentally tap on another NPC when trying to tap on a button.

### Added Features
As stated before, the design document is living, meaning it’ll [change as the game is developed](/tutorial/werewolf-style-game/introduction/#the-first-step). Already during the wireframe stage I’ve added a new feature: showing icons above the NPC’s portrait. These icons will be automatically added when the player gains influence over the NPC and when they discover their personality. As an automatic process, it may not be noticed by newer players---but will be a valuable tool for experienced players.

I’ve also debated as to whether the icon acquisition should be automatic or not. Earlier versions of the game allowed players to voluntarily mark NPCs with generic icons, but the feature was hard to surface. My worry is that having the icons added automatically will take away some of the game’s strategy. Ultimately, I feel that because the [scummed isn’t set in stone](/tutorial/werewolf-style-game/design-doc/#that-means), that offering these icons for free won’t make the game any less fun.

## Log Screen
{{< figure-single-size src="log-screen.svg" href="log-screen.svg" alt="Wireframes of the game's main screen." width="280" >}}

The log screen is designed to show the information that the player learned, in order to make it feel like the clues matter. The log keeps ~20 of the latest interactions and allows the user to scroll through them. Notice here how the NPC portraits all line up on the left side of the screen. I could have alternated each row: portrait on the left, text on the right followed by portrait on the right, text on the left. However the decision to line them up was intentional---because [zigzagging the text and portrait makes it harder to scan](https://www.nngroup.com/articles/zigzag-page-layout/). I want this information easily scannable. The entire feature is a facade so the less time the player spends on this screen the better.

## Wireframe Tools
I used [Affinity Designer](https://affinity.serif.com/en-us/designer/) to create these wireframes. The tool seems to be popular with the Godot community, and is relatively inexpensive. In the past I’ve used Fireworks, Illustrator, XD, and other graphic design/web design related software to make wireframes. My word of advice is that for wireframing, *the tools really don’t matter*. What I look for in a good wireframing tool are the following:

1. Can resize rectangles
1. Can move things around easily
1. Can center text
1. Can save images

So there’s not a lot to a wireframing tool, use what you’re comfortable with.

## Why talk about UX?
This is supposed to be a tutorial about [designing a Werewolf style game in Godot 3](https://oneshotrpg.com/tutorial/werewolf-style-game/), but I’ve veered us in the direction of talking about user experience. What gives? My background is in web development and web design, and we always start the process of creating a site with wireframes. They help the entire team communicate on the same level and test out our ideas before hard-to-change aesthetics are decided and code is written. Sites have to be easy to use and navigate, and so do your games. Beyond mechanics, the game’s interface has to be fun and easy to use, otherwise a good game can get bogged down by poor user interface. Doing wireframes and backing up your decisions with research is one tool in your toolbox to prevent that from happening.
