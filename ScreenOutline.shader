shader_type canvas_item;
render_mode blend_mix;

uniform vec3 modulate_color = vec3(1.0, 1.0, 1.0);
uniform float modulate_alpha = 1.0;

uniform bool outline_diagonals = false; //true to extend the outline to diagonal pixels

void fragment()
{
    vec4 col = texture(TEXTURE, UV); //original color
    
    if (col.a == 0.0) //might be part of where the outline should be
    {
		bool isOutline = false;
		
		if (texture(TEXTURE, UV + vec2(0.0, TEXTURE_PIXEL_SIZE.y)).a    != 0.0 ||
			texture(TEXTURE, UV + vec2(0.0, -TEXTURE_PIXEL_SIZE.y)).a   != 0.0 ||
			texture(TEXTURE, UV + vec2(TEXTURE_PIXEL_SIZE.x, 0.0)).a    != 0.0 ||
			texture(TEXTURE, UV + vec2(-TEXTURE_PIXEL_SIZE.x, 0.0)).a   != 0.0){
			isOutline = true;
		}
		if (outline_diagonals){
			if (texture(TEXTURE, UV + vec2(-TEXTURE_PIXEL_SIZE.x, TEXTURE_PIXEL_SIZE.y)).a    != 0.0 ||
				texture(TEXTURE, UV + vec2(-TEXTURE_PIXEL_SIZE.x, -TEXTURE_PIXEL_SIZE.y)).a   != 0.0 ||
				texture(TEXTURE, UV + vec2(TEXTURE_PIXEL_SIZE.x, TEXTURE_PIXEL_SIZE.y)).a     != 0.0 ||
				texture(TEXTURE, UV + vec2(TEXTURE_PIXEL_SIZE.x, -TEXTURE_PIXEL_SIZE.y)).a    != 0.0){
				isOutline = true;
			}
		}
		if (isOutline){
			col = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).rgba; //set to background screen texture
		}	
    }else{ //part of the original image
		col = col*vec4(modulate_color, modulate_alpha) //modulate by a given amount if any
	}
    
    COLOR = col;
}