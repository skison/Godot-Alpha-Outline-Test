# Godot Alpha Outline Test

This is a small project I put together to see if there was an easy way to create "invisible" outlines around sprites (that is, to allow them to be distinct from one another via an outline while retaining the background color). I came up with 2 ways of doing it, which are shown in the result below:

![Result of the Alpha Outline Shaders](https://github.com/skison/Godot-Alpha-Outline-Test/blob/master/Result.PNG)

Both of these methods utilize shaders to draw pixels from the background onto/around the sprites. Both take advantage of the 'SCREEN_TEXTURE' (see: [Screen-Reading Shaders](https://docs.godotengine.org/en/3.1/tutorials/shading/screen-reading_shaders.html)) built-in texture for shaders. According to the docs, when used, this texture takes whatever is drawn behind the current node and saves it to a back-buffer, which will then be used for any subsequent calls to SCREEN_TEXTURE. In some cases like the example given in the docs, this can lead to unexpected side-effects of images ignoring previously drawn images, but in this case that's exactly what I needed.

To take advantage of this property of SCREEN_TEXTURE, I created a small shader called [Screen.shader](https://github.com/skison/Godot-Alpha-Outline-Test/blob/master/Screen.shader). This shader simply takes any non-transparent pixels and changes them to the sorresponding SCREEN_TEXURE pixel color. I created a simple [background texture](https://github.com/skison/Godot-Alpha-Outline-Test/blob/master/Background.png) to act as the base, then added a ColorRect named "BackgroundShaderBuffer" as a child of it and set it to take the full space of the background. 

I then added the Screen.shader to a ScreenShader.tres material of the BackgroundShaderBuffer. The result is that you only see the intended background texture and not the ColorRect. This is important because as long as the background is in frame, Screen.shader is forced to run, which will 'lock-in' the background texture for all other calls to SCREEN_TEXTURE. This is how the circles shown in the result image are able to draw outlines that match the background color.


## Outline Method 1: Images as outlines (a bit simpler)

The top-right portion of the result image showcases the first method of drawing alpha outlines. There are 3 Node2Ds without any scripts, and each one contains 2 sprites: a solid circle, and a white hollow circle outline. Screen.shader is applied directly to the outline sprite so that it renders the background texture where it normally would be.

This method works well, but from a design standpoint it can be a bit tedious to work with since you'd need to create an outline sprite for every other sprite in the game that you'd want an outline for. One benefit of this method is that you can easily modify the inner sprite (ex: modulate) without having to worry about changing the outline too.


## Outline Method 2: Outlines via shaders (more complex)

The bottom-left portion of the result image shows the result of using the [ScreenOutline shader](https://github.com/skison/Godot-Alpha-Outline-Test/blob/master/ScreenOutline.shader) to create the outline. There are 3 Node2Ds, each with just 1 sprite: a white hollow circle. This shader checks the surrounding 4 pixels (or 8 if diagonals are enabled) of all transparent pixels within the sprite to see if it neighbors any solid pixels, and if so, it becomes part of the outline and draws the SCREEN_TEXTURE color. 

The problem with this approach (at least for the game concept I'm working with) is that you can't use the built-in modulate functions on the sprites that use this script, because it affects pixels after the shader runs. That means if you try to modulate a white sprite to make it blue, its outline will become visible and blue-tinted rather than 'invisible'.

To fix this issue, I added a uniform vec3 modulate_color variable to the shader(as well as a modulate_alpha variable if needed). This way you can modulate its color without affecting the outline. There's still a problem though, and that's that these variables are shared between instances of the ScreenOutlineShader resource. So you can't easily modulate the colors of 2 sprites independently because the last variable overridden will affect both sprites.

To overcome this hurdle, I added a shared script to the 3 Node2Ds called [ExampleOutlineObject.gd](https://github.com/skison/Godot-Alpha-Outline-Test/blob/master/ExampleOutlineObject.gd). This script has 3 export vars for RGB channels so you can set them in the editor. 
