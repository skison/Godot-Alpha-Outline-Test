shader_type canvas_item;

void fragment(){
	vec4 col = texture(TEXTURE,UV).rgba;
	
	if (col.a > 0.0) { //only modify non-transparent parts of the image
		col = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).rgba;
	}
	COLOR=col;
	
}