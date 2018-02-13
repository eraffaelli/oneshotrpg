---
title: "Office Party Design Doc"
date: "2018-02-13"
image: placeholder-blog-image-2.png
series: werewolf-style-game
series_weight: 2
weight: 2
---

The design doc for Office Party outlines the flow, mechanics, and the game’s thematics. The Werewolf style Godot game is designed to be played entirely on a phone’s touchscreen.<!--more-->

## Introducing Office Party
The first game will be titled “Office Party.” It’s like [Werewolf](/tutorial/werewolf-style-game/introduction/) but set in the [world of One Shot RPG](/blog/creating-the-setting/).

## Premise
As an employee of Space Vehicles Incorporated, you’re required to attend an annual office party at the regional HQ. After making an appearance, you decide to leave. But before you can reach the lift, the lights suddenly flicker off. When they come back on, there’s a body laying on the ground. There’s a scummed among the guests---a killer in disguise. Find out who the monster is, establish yourself as the leader, and convince the guests to agree with your accusations. Act fast, though, the scummed will kill again and the guests won’t wait around to be picked off.

## Initial Playtesting
Designing something fun takes time. Even something as simple as this game---one that is already based on a proven concept---takes multiple attempts to find something that works. This is my fifth attempt at making Office Party fun. As alluded to in the previous article, past playtests of Office Party have caused many of my initial plans to be scrapped in favor of something better.

## What’s fun?
- Assigning motives, guilt, and stories to faces, whether it’s true or not
- Accusing NPCs and finding out if you were right or wrong
- Trying to figure out who did it based on the clues, whether right or wrong
- Convincing others to agree with you

## What’s not fun?
- “I feel like I’m not smart enough.”
- “I feel like if I was writing down the information or paying attention...”

## That Means
- There isn’t a set scummed. Players have their own idea of who the scummed is, so let them be right
- The game winds down when players convince the majority of NPCs to follow them (“gaining leadership”)
- Once you have leadership, the person you blame has a chance of being the scummed, with increasing probability after each round
- Can lose with 0 survivors if you fail to gain enough followers in time

The player thinks they’re playing a game in which they must read clues and analyze behavior to figure out who the scummed is. In actuality, the game waits until a certain threshold is met (gaining leadership) and lets the player win. The player is still able to lose if they don’t convince NPCs to follow them---which requires figuring out their personality---so there’s some strategy involved. I decided to go this route because I noticed that players were doubting their abilities, saying things like “I’m not smart enough to figure it out,” and other negative thoughts. Players should not feel stupid when playing this game. I also noticed that instead of trying to figure out the killer based on behavior, players would assign culpability and backstory to the partygoers based on their character portraits and names. To me, creating these stories is the most rewarding part of the game and should be embraced.

## Game Flow and Mechanics
1. **Start of Game**
1. Start with 20 NPCs
1. Talk to the NPCs, they complain about how the party is boring
1. You must talk to at least 1 NPC
1. To start the game, try to make an exit from the party
1. The lights flicker off and back on
1. The first person you talked to has died
1. Each additional NPC talked to gains a relationship point
1. **Interaction Phase**
1. Interact with the NPCs
   - Each interaction costs time (a point value)
   - Reveals information about the NPC
   - Alters their relationship points toward you
1. NPCs have different personalities
   - Affects how interactions work
   - Decides who they blame
   - Decides their specific dialogue. Players can infer the personality from the dialogue
1. Each action taken is recorded to a log. Log keeps the past ~20 events
1. After time is up (points are met), everyone takes a vote
1. **Voting Phase**
1. If you have influence over someone (enough relationship points), they will change their vote to who you vote
1. Else, they vote based on their personalities
   - Voting the same as another person will increase their relationship with you
1. One of the interactions reveals who the NPC plans on voting for so players can plan ahead
1. When the player has leadership (has influence over the majority of NPCs) then the chances of accusing the scummed increase with each round until 100%
1. Once you gain leadership, you don’t lose it (such as if your influenced NPCs die and you no longer have majority)
1. The NPCs who voted in the majority kill the accused
1. **Scummed Killing Phase**
1. If the scummed is now dead, end the game, display the results. Else:
1. Lights flicker off and on
1. NPC is killed. See killing order
1. Restart interaction phase

## Killing Order
Randomly kills Keen->Loner->Crazy->Follower->Hothead  
Deprioritize player’s followers

## NPC Interactions
1. Talk
   - Costs few points
   - Cycles through dialogue, based on their personality
   - Raises relationship small amount, unless loner, which lowers it
   - First statement costs points and affects relationship. Once spent, can be freely cycled through.
1. Ask who they’ll blame
   - Costs few points
   - Find out who they blame and why
   - Raises relationship small amount, unless keen, which lowers it. Crazy will not follow what they say they’ll do
1. Ask about dead NPC
   - Reveal personality of the person who just died
   - Costs moderate points
   - Relationship neutral
   - Hothead won’t reveal the personality correctly unless they were keen
1. Flatter them
   - Costs moderate points
   - Moderately increases relationship
   - Slightly decreases relationship of those not influenced by the player
   - Lowers relationship of hotheads
1. Command attention
   - Costs many points
   - Highly increases relationship
   - If follower, moderately increases relationship with other followers

## Personalities
### Loner
Blames those that the player has influence over. Talking to them lowers their relationship.

### Keen
Blames those who are likely to get the most votes. Asking them who they’ll blame lowers relationship

### Crazy
Blames randomly. Player never know beforehand who they’ll blame. With influence, there’s a 25% chance they’ll vote out of line with the player

### Hothead
Blames those blaming them. Do not like to be flattered. When asking about a dead person, they only reveal keens

### Follower
Each round an NPC leader is chosen. If uninfluenced, copies that leader’s blame

## Interface Elements
1. Start screen - tap to start
1. End screen - identifies the scummed, lists the amount of survivors, restart button
1. NPC grid
1. Tap on an NPC to switch to a screen which presents the interaction options and shows the dialogue
1. Round bar - time left
1. End round button - Goes to voting phase
1. Tap on an NPC to accuse them during voting phase
1. Log button to view log
1. Log screen, shows ~20 of the last actions. Can scroll through them. Close the log to return to NPC grid
1. Status area - Gives messages such as, “Tap an npc to talk to them”, “Tap on an npc to accuse them”, and “Tally the votes”

## Form Factor and Interaction
The game should be playable on a phone. The only interaction is tapping and holding on buttons.
