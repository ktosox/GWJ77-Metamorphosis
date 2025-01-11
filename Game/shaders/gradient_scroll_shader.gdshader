shader_type canvas_item;

uniform vec2 scrollSpeed = vec2(0.0,0.0);
uniform sampler2D scroll_texture: repeat_enable;
uniform sampler2D gradient;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float color = texture(scroll_texture, UV + scrollSpeed * TIME).r;
	COLOR = texture(gradient, vec2(color));
	// Called for every pixel the material is visible on.
}