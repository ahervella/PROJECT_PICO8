# PROJECT_PICO8
This is a PICO-8 game project in progress on and off. I chose this very loose, lightweight, assembly-like engine to challenge myself with building systems and features of a game engine from scratch including collision detection and filtering, object class inheritance and flexibility, sprite parsing and animation systems, and OOP management.

For more info on this work, please feel free to message me at ahervella@me.com!

## Game Concept
The game concept is a top down 2D shooter with the goal of being a sweaty and intense fire fight, arcade-like experience. But unlike most top down 2D shooters, the goal is by no means to make a bullet hell, but instead make shooting every shot be powerful and impactful, give the player and enemies weight and strength, but allow the player to maneuver easily in short bursts. Much of this was inspired by the way enemy fights work in The Last of Us, in which the player is focused on positioning, ammo management, and making every shot count!

## Project Goal
At the time of inception, I was very interested in learning and understanding how games were made prior to the concept of game engines. I wanted to take a step back from diving into giant complex engines like Unity and Unreal, and learn more about how NES, SNES, ATARI, and other early 2D era games were created in assembly and other low-level languages designed around unique chip series (65c816 for SNES for instance).

PICO-8 was the perfect answer to this endeavor by providing the "fantasy console" environment, a great stepping stone and intro into the world of assembley and low level game development without the need for memorizing and working with unique addresses while providing a foundational library of tools to build off, not too unlike my [C++ Galaga remake project](https://github.com/ahervella/GALAGA_CPP_REMAKE_2020) that was made with the SDL2 library. Only this time, using LUA takes this a step further by having the programmer establish OOP flows, contracts, and systems.

## Programmging with LUA
Lua is a lose scripting language with powerful and unique features from other languages I've used. It's interesting nature of tables, meta tables, and their linked list style architecture allows for a programmer to be able to create concepts of inheritance and OOP. This I learned by reading the LUA manual and through lots of trial and error using very basic debugging tools offered by the PICO-8 engine.

As the project stands, a few systems have been created and proven working:

1. Nomenclature semantics:
   - Since LUA uses duck typing, I decided to establish a nomenclature system to make working with variables easier by using abbreviated prefixes like n_, b_, or v2_ for things like number, bool, or vector 2.
   - I also was sure to make functions have a __ (double underscore) prefix to further clarify code use and intentions.
   - Parameters of functions start with a single _ (underscore)
   - Constants are all caps! All of these are very similar to habits adopted in C++ and C# programming

2. Basic class system:
   - Using the LUA manual, I devised a series of ZObject classes that build off each other with inheritance
   - Designing the classes and where things live, what variables are shared, what variables are overridden, is very difficult to determine as the project evolves and new requirements come up (despite thought-out planning). I try to lean on computer science concepts, namely encapsulation and the one responsibility principle per function.

3. Object Manager:
  - I created an object manager to be able to start divide objects into different groups for different purposes (static objects, player object, enemies, etc.) This would be essential for collision filtering and detection
  - Since the object manager is responsible for the life cycles of objects, it dictates when to tell objects to update and redraw
  - I made sure to have global interfaces for adding or removing objects, getting the player object, or getting the player object position

4. Collision detection:
- PICO-8 is nice enough to include basic but helpful libraries for rendering, math, arrays, bit shifting, and things of the like, but nothing directly associated with collision detection.
- The game is simple enough and being played on a very small resolution that AABB collisions would suffice just fine.
- Filtering was necessary to save computation on checking every single spawned object with a virtual hit box against every other object. Only designated layers with designated rules are eligible for being checked for collision. For example, enemies don't need to worry about themselves, only about collided against a player's bullet or the player itself. This saves lots of compute time as objects grow from having to do "n choose 2"!

5. Sprite Animation System
- PICO-8 provides interfaces for being able to draw a section of the defined sprite sheet, draw pixels by hand, and do other color shifting techniques. Using these I created a sprite system that would be able to define animations sets (spriteAnims), made up of smaller loops (spriteLoops), made up of frames (spriteFrames).
- Having two degrees of actual animation layers allows to build full character sprites using smaller pieces of sprite data that may be shared or used for multiple purposes such as sharing arms, legs, weapons, etc. The easiest example I always like to point out is how the original Super Mario Bros. for NES used the same sprite tinted green and white for bushes and clouds, respectively.
- Since animation data would be needed to define frame pacing, coordinates for sprite extraction, whether an animation loops, etc., I separated that into a static animation file defining these in their own classes via animData.lua.
