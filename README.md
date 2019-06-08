# Godot Alpha Outline Test

This is a small project I put together to see if there was an easy way to create "invisible" outlines around sprites (that is, to allow them to be distinct from one another via an outline while retaining the background color). I came up with 2 ways of doing it, which are shown in the result below:

![Result of the Alpha Outline Shaders](https://github.com/skison/Godot-Alpha-Outline-Test/blob/master/Result.PNG)

Both of these methods utilize shaders to draw pixels from the background onto/around the sprites. Both take advantage of the 'SCREEN_TEXTURE' (see: [Screen-Reading Shaders](https://docs.godotengine.org/en/3.1/tutorials/shading/screen-reading_shaders.html))
