# sandboxVR 
## Update
This project is currently no longer being maintained as of 10/19/2020. The use of Godot engine for VR proved to be underwhelming and may be revisited at a later date.

This is a project for a hackathon, to build a sort of Gary's mod but for VR. The idea is this stands as a framework for building loadable mods. 
The major goals of this project were to offer an engine for VR dev that skips the need to worry about movement, and interaction with objects. This project as mentioned in the section below takes advantage of the Godot OpenVR module as the primary engine to allow for cross-platform capabilities. 

## So Far

We have worked out the basics of movement and teleportation in VR. We have added some basic examples of scenes that could be added in. We have implemented a simple drawing mod as well as a sword that has collision on.

## Known Issues

The primary issue is dealing with dynamic loading in the world. We wanted to have a GUI typer interface that loads on your left hand and you can select some mod to load in. There are some technical challenges when doing so. It has been scrapped while we need to learn more about how to make dynamic loading.

## Painter

The painter modules use the Immediate Geometry of Godot to build an array of v3 points and then draw them as a single line. 

## Goals

The painter could use new textures instead of the base texture, as well as the ability to select color and thickness.

## Known Issues

No way to undo what you have drawn, can't stop once you start drawing.

## Sword

The sword scene is based on a free sword skin and has collision features added to it. 

## Goals

The sword needs to have a better grab point so it is not in the middle of the sword
