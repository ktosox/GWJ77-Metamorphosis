shader_type canvas_item;

uniform vec2 scrollSpeed = vec2(0.0,0.0);
uniform sampler2D scroll_texture: repeat_enable;



void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 color = texture(scroll_texture, UV + scrollSpeed * TIME);
	COLOR = color;
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
