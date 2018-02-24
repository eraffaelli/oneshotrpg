---
title: "Quick Tip: $ vs get_node in Godot"
date: "2018-02-23"
placeholder_image: placeholder-blog-image-1.png
series: werewolf-style-game
series_weight: 6
weight: 6
---

It doesn’t matter if you use `get_node()` or `$` in your code. What does matter is that you don’t repeat yourself. Store the path to a child node as a variable to make your code more maintainable.<!--more-->

## Getting A Node In Godot
There’s two ways to get a node in Godot: using `get_node()` and `$`. The code looks like this:

```gdscript
# These are functionally equivalent
$C/Gamma/One
get_node("C/Gamma/One")
```

Both methods have fuzzy autocompletion. This means that to select the node `C/Gamma/One`, you only need to type `get_node("One` or `$One` and then press enter. This can be seen in the below screenshots:

{{< figure-single-size src="fuzzy-get-node.png" alt="Screenshot of get_node() fuzzy autocompletion in the Godot editor." >}}
{{< figure-single-size src="fuzzy-dollar-sign.png" alt="Screenshot of $ fuzzy autocompletion in the Godot editor." >}}

## Which One Should I Use?
[It doesn’t matter!](/tutorial/werewolf-style-game/introduction/#no-dogmatism) But I’ve been using `$`, because it takes less typing to get the fuzzy autocompletion to appear. With `get_node()` you have to type `get_node("` before it tries to guess a node.

More important than arguing over which one to use is making sure that you’re not repeating yourself in code.

## What to Avoid
Whether `get_node()` or `$`, you want to avoid making repeated calls to the same node.

```gdscript
# This is bad
# Don't keep repeating yourself
$C/Gamma/One.text = "New Text"
$C/Gamma/One.property = true
$C/Gamma/One.another_property = 5
$C/Gamma/One.foo = bar
```

This flies in the face of [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) (don’t repeat yourself) principles.

## Use `onready var`

Instead of repeating calls to the same node, use an `onready var` to store the path to the node once, then use that throughout your code.

```gdscript
# Store the path to the node as an onready var
onready var ChildNode = $C/Gamma/One

# And then reuse it later in your code
ChildNode.text = "New Text"
ChildNode.property = true
ChildNode.another_property = 5
ChildNode.foo = bar
```

## Why `onready var`?

During development you tend to move nodes around. Both `$` and `get_node()` do not auto update when a node is moved in the tree. By saving the path and reusing it, you only have to update your code in one spot when you decide to make a change to your game.
