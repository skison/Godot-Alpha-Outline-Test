# Godot Alpha Outline Test

This is a small project I put together to see if there was an easy way to create "invisible" outlines around sprites (that is, to allow them to be distinct from one another via an outline while retaining the background color). I came up with 2 ways of doing it, which are shown in the result below:

![Result of the Alpha Outline Shaders](https://github.com/skison/Godot-Alpha-Outline-Test/blob/master/Result.PNG)

Both of these methods utilize shaders to draw pixels from the background onto/around the sprites. Both take advantage of the 'SCREEN_TEXTURE' (see: [Screen-Reading Shaders](https://docs.godotengine.org/en/3.1/tutorials/shading/screen-reading_shaders.html)) built-in texture for shaders. According to the docs, when used, this texture takes whatever is drawn behind the current node and saves it to a back-buffer, which will then be used for any subsequent calls to SCREEN_TEXTURE. In some cases like the example given in the docs, this can lead to unexpected side-effects of images ignoring previously drawn images, but in this case that's exactly what I needed.

