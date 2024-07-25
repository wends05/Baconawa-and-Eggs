shader_type canvas_item;

//take colors from the default
uniform vec4 head: source_color = vec4(1.0, 0.0, 0.0, 1.0); 
uniform vec4 tail_up: source_color = vec4(1.0, 1.0, 0.0, 1.0); 
uniform vec4 tail_down: source_color = vec4(0.0, 1.0, 0.0, 1.0); 

//blue
uniform vec4 headB: source_color = vec4(0.8, 2.0, 2.0, 1.0);
uniform vec4 tail_upB: source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform vec4 tail_downB: source_color = vec4(1.0, 0.0, 0.0, 1.0); 

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	// Get the current texture color at this fragment
    vec4 spr_color = texture(TEXTURE, UV);

	//depending on player number, the headband color changes
	if (spr_color == head) {
		COLOR = headB;
	}
	if (spr_color == tail_up) {
		COLOR = tail_upB;
	}
	if (spr_color == tail_down) {
		COLOR = tail_downB;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
