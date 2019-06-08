# Godot Alpha Outline Test

This is a small project I put together to see if there was an easy way to create "invisible" outlines around sprites (that is, to allow them to be distinct from one another via an outline while retaining the background color). I came up with 2 ways of doing it, which are shown in the result below:

![Result of the Alpha Outline Shaders](https://github.com/skison/Godot-Alpha-Outline-Test/blob/master/Result.PNG)

Both of these methods utilize shaders to draw pixels from the background onto/around the sprites. Both take advantage of the 'SCREEN_TEXTURE' (see: [Screen-Reading Shaders](https://docs.godotengine.org/en/3.1/tutorials/shading/screen-reading_shaders.html)) built-in texture for shaders. According to the docs, when used, this texture takes whatever is drawn behind the current node and saves it to a back-buffer, which will then be used for any subsequent calls to SCREEN_TEXTURE. In some cases like the example given in the docs, this can lead to unexpected side-effects of images ignoring previously drawn images, but in this case that's exactly what I needed.

To take advantage of this property of SCREEN_TEXTURE, I created a small shader called [Screen.shader](https://github.com/skison/Godot-Alpha-Outline-Test/blob/master/Screen.shader). This shader simply takes any non-transparent pixels and changes them to the sorresponding SCREEN_TEXURE pixel color. I created a simple [background texture](https://github.com/skison/Godot-Alpha-Outline-Test/blob/master/Background.png) to act as the base, then added a ColorRect named "BackgroundShaderBuffer" as a child of it and set it to take the full space of the background. 

I then added the Screen.shader to a ScreenShader.tres material of the BackgroundShaderBuffer. The result is that you only see background and not the ColorRect. This is important because as long as the background is in frame, Screen.shader is forced to run, which will 'lock-in' the background texture for all other calls to SCREEN_TEXTURE. This is how the circles shown in the result image are able to draw outlines that match the background color.


