---
title: "Quick Tip: .gitignore for a Godot Game"
date: "2018-02-14"
image: placeholder-blog-image-3.png
series: werewolf-style-game
series_weight: 3
weight: 3
---

Use the currently proposed Godot .gitignore from GitHub. However, this could lead to issues if you develop a game across multiple machines.<!--more-->

## What should go into my Godot game's .gitignore?
Something that I've been having trouble finding an answer for is what to include in my `.gitignore`. Searching leads to more questions than answers such as [this gist](https://gist.github.com/marcosbitetti/6168a1490ded08197721a474dd9dd9e7), [this Reddit post](https://www.reddit.com/r/godot/comments/4efptm/which_files_should_be_included_in_the_gitignore/), and [this Q&A](https://godotengine.org/qa/22993/3-0-gitignore). The official template is currently being decided, with [this pull request](https://github.com/github/gitignore/pull/2546) as the current candidate, after [beating out this older one](https://github.com/github/gitignore/pull/2408).

Let's take a look at that [current candidate](https://github.com/henriiquecampos/gitignore/blob/2c2e8f42477279727c551a558dc21614043a0a98/Godot.gitignore):

```
.import/
.mono/
export_presets.cfg
```

A seemingly straightforward three lines, but there's a gotcha with that last line, `export_presets.cfg`.

## Should I ignore my export_presets.cfg?
The short answer is that for a public facing repo, yes, as it can contain computer/environment specific information, and it looks like it may house some sensitive information.

This does lead to an issue: your game's information, such as its name, app icons, even files required for play, will be gitignored. If you work on your game across multiple computers, then you have to make sure to grab the completed `export_presets.cfg` from another machine first. I'm sure there are solutions for this problem, so it's a minor annoyance.
