# sandboxVR

This is a project for a hackathon, to build a sort of Gary's mod but for VR. The idea is this stands as a framework for building loadable mods. 
The major goals of this project is to offer a engine of VR dev that skips the need to worry about movement, and interaction with objects. This project as mentioned in the section below takes advantage of the Godot OpenVR module as the primary engine to allow for cross platform capeabilities. 

## So Far

We have worked out the basics of movement and teleportation in VR. We have added some basic examples of scenes that could be added in. We have implemented a simple drawing mod as well as a sword that has collision on.

## Known Issues

The primary issue is dealing with dynamic loading in the world. We wanted to have a gui typer interface that loads on your left hand and you can select some mod to load in. There are some technical challenges when doing so. It has been scrapped while we need to learn more about how to make dynamic loading.

## Painter

The painter modules use the immerdiategemotry of godot to build an array of v3 points and then draw them as a single line. 

## Goals

The painter could use new textures instead of the base texture, as well as the ability to select color and thickness.

## Known Issues

No way to undo what you have drawn, cant stop once you start drawing.

## Sword

The sword scene is based on a free sword skin and has collision features added to it. 

## Goals

The sword needs to have a better grab point

## Contributing
Anyone is welcome to contribute only request is you use godot 3.2 and openVR

## Tested On

This was tested on a windows mixed reality and a valve index.

## Godot OpenVR GDNative module
This module is provided as is, all files are contained within the addons/godot-openvr-asset folder

This module requires **Godot 3.1 or newer** to run, **Godot 3.2** is highly recommended.

The scenes subfolder contains a number of godot scenes that help you set up your project. 
For basic functionality start with adding ovr_first_person.tcn to your project.
Also make sure that vsync is turned off in your project settings.

Source code for this module can be found here:
https://github.com/GodotVR/godot_openvr

Also note that we have a support asset containing a number of useful scenes to get you going building VR applications in Godot:
https://github.com/GodotVR/godot-vr-common

Documentation on using this asset can be found here:
https://github.com/GodotVR/godot-openvr-asset/wiki

HDR support
-----------
HDR support was added to OpenVR but requires the keep_3d_linear flag added to Godot 3.2. This will ensure rendering inside of the headset is correct. The preview on screen will look darker. You can solve this by using a separate viewport.

When using Godot 3.1 you need to either use the GLES2 renderer or turn HDR off on the viewport used to render to the HMD.

Licensing
---------
The Godot OpenVR module and the godot scenes in this add on are all supplied under an MIT License.

The dynamic libraries supplier by Valve fall under Valve's own license.
For more information about this license please visit https://github.com/ValveSoftware/openvr

About this repository
---------------------
This repository was created by and is maintained by Bastiaan Olij a.k.a. Mux213

You can follow me on twitter for regular updates here:
https://twitter.com/mux213

Videos about my work with Godot including tutorials on working with VR in Godot can by found on my youtube page:
https://www.youtube.com/BastiaanOlij
