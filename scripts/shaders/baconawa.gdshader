shader_type canvas_item;

//take colors from the default
uniform vec4 red1: source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform vec4 red2: source_color = vec4(1.0, 1.0, 0.0, 1.0);
uniform vec4 red3: source_color = vec4(0.0, 1.0, 0.0, 1.0);
uniform vec4 fat1: source_color = vec4(0.0, 1.0, 1.0, 1.0);
uniform vec4 fat2: source_color = vec4(0.0, 0.0, 1.0, 1.0);
uniform vec4 eye1: source_color = vec4(1.0, 0.0, 1.0, 1.0);
uniform vec4 eye2: source_color = vec4(0.0, 0.0, 0.0, 1.0);

//blue
uniform vec4 red1B: source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform vec4 red2B: source_color = vec4(1.0, 1.0, 0.0, 1.0);
uniform vec4 red3B: source_color = vec4(0.0, 1.0, 0.0, 1.0);
uniform vec4 fat1B: source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform vec4 fat2B: source_color = vec4(1.0, 1.0, 0.0, 1.0);
uniform vec4 eye1B: source_color = vec4(0.0, 1.0, 0.0, 1.0);
uniform vec4 eye2B: source_color = vec4(0.0, 1.0, 0.0, 1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	// Get the current texture color at this fragment
    vec4 spr_color = texture(TEXTURE, UV);

	//depending on player number, the headband color changes
	if (spr_color == red1) {
		COLOR = red1B;
	}
	if (spr_color == red2) {
		COLOR = red2B;
	}
	if (spr_color == red3) {
		COLOR = red3B;
	}
	if (spr_color == fat1) {
		COLOR = fat1B;
	}
	if (spr_color == fat2) {
		COLOR = fat2B;
	}
	if (spr_color == eye1) {
		COLOR = eye1B;
	}
	if (spr_color == eye2) {
		COLOR = eye2B;
	}
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
