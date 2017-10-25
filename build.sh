#!/bin/bash

# Compiles the site
~/hugo.exe

# Does my own compilation of sass, straight to the public folder
npm run deploy
