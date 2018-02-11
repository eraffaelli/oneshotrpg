---
title: "Introduction"
date: "2018-02-10"
image: placeholder-blog-image-1.png
series: werewolf-style-game
series_weight: 1
weight: 1
---

The first Godot game tutorial will focus on creating a Werewolf style game set in the One Shot RPG universe. The game will leverage Godot’s existing UI elements to keep the focus on mechanics.<!--more-->

## Werewolf and Mafia
[Werewolf](https://www.playwerewolf.co/rules/) (also called [Mafia](https://en.wikipedia.org/wiki/Mafia_(party_game))) casts players as villagers struggling with a dark secret. Some of them are lycanthropes who work together at night to kill an unsuspecting victim. The rest of the villagers don’t wait around to be picked off, however, and take justice into their own hands. When morning comes they vote to kill who they suspect to be the monsters. The werewolves must hide their identities while manipulating the group to vote in their favor. The game ends when the werewolves have killed the rest of the villagers or they’ve been wiped out. Either way, the game leads to tense situations where the only person you know is innocent or guilty is yourself.

## Why this style of game?
Why choose this style of game to start out with? It’ll be easy to program.

[Godot](https://godotengine.org) comes with interface elements out of the box such as [buttons](http://docs.godotengine.org/en/3.0/classes/class_button.html), [labels](http://docs.godotengine.org/en/3.0/classes/class_label.html), [rich text areas](http://docs.godotengine.org/en/3.0/classes/class_richtextlabel.html), [progress bars](http://docs.godotengine.org/en/3.0/classes/class_progressbar.html), and [modals](http://docs.godotengine.org/en/3.0/classes/class_popup.html), all of which will come in handy during development. The villagers can be a button that the player taps on, while holding down on them can display a modal with more options. The player can see how much time they have left with a progress bar and tap on a button to go to the next round. Villager’s names and dialogue can be displayed as formatted text.

This style of game also has little moving parts. There’s no physics, no sprite animations, no worlds or levels, no raycasting or vector math. We’ll let Godot handle all of the input and focus our time on developing mechanics.

A final reason to make a Werewolf or Mafia style game is that the theme fits the world. One Shot RPG is about everyday people who [suddenly become monsters](/blog/creating-the-setting/expanding-upon-scum-and-horror/#example-of-a-scummed-individual) and attack unsuspecting folk. Part of the appeal is finding out who the scummed is and then [planning on how to confront them](/blog/creating-an-adventure/rpg-encounter-flow/#final-confrontation). Finding and battling a scummed mimics the villager’s struggle against the unknown adversary. This game could be used as a background story for a scum fighter, detailing their first encounter with the twisted monsters.

## Who’s this tutorial for?
This game development tutorial is not for newbies---but not for pros either. I assume the participant is comfortable with programming and open to learning new languages and syntaxes. I also assume the user isn’t a complete newbie to Godot or its nodes. Watching the “[Know Your Nodes](https://www.youtube.com/watch?v=LBK5GgMB988&list=PLsk-HSGFjnaE4k-X3l6dZAPIoB2QB4eYg)” series and other videos from Kids Can Code is a great way to start learning the engine.

## No Dogmatism
I am not a professional game developer or designer---I’m a hobbyist. This tutorial covers how I approach specific problems, and it may not follow best practices. I'm learning as I go along. I hope that the reader understands _why_ I did something a certain way. Don’t take what I do as the be-all and end-all, and I’ll keep the dogmatism to a minimum.

## The First Step
The first step is to create the game's design document. The design document lays out the high level goals and features for the game, and even details some mechanics. The document is living, meaning that it’ll change as the game is developed. While an entire game can theoretically be designed beforehand on paper, playtesting always leads to early ideas being scrapped. Starting with a design doc gives the project a clear direction and organization structure, so it’s still worth the time investment.
