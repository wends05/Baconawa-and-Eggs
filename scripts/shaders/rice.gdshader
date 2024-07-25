shader_type canvas_item;

//color is dependent on player number
uniform int playernum;

//take colors from the default
uniform vec4 head: source_color = vec4(1.0, 0.0, 0.0, 1.0); // RGBA
uniform vec4 tail_up: source_color = vec4(1.0, 0.0, 0.0, 1.0); // RGBA
uniform vec4 tail_down: source_color = vec4(1.0, 0.0, 0.0, 1.0); // RGBA

//blue
uniform vec4 headB: source_color = vec4(0.0, 2.0, 2.0, 1.0);
uniform vec4 tail_upB: source_color = vec4(1.0, 0.0, 0.0, 1.0); // RGBA
uniform vec4 tail_downB: source_color = vec4(1.0, 0.0, 0.0, 1.0); // RGBA

//yellow
uniform vec4 headY: source_color = vec4(0.0, 2.0, 2.0, 1.0);
uniform vec4 tail_upY: source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform vec4 tail_downY: source_color = vec4(1.0, 0.0, 0.0, 1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	// Get the current texture color at this fragment
    vec4 spr_color = texture(TEXTURE, UV);

	//depending on player number, the headband color changes
	if (playernum == 2) {
		if (spr_color == head) {
			COLOR = headB;
		} else {
			COLOR = spr_color;
		}
		if (spr_color == tail_up) {
			COLOR = tail_upB;
		} else {
			COLOR = spr_color;
		}
		if (spr_color == tail_down) {
			COLOR = tail_downB;
		} else {
			COLOR = spr_color;
		}
	}
	else if (playernum == 3) {
		if (spr_color == head) {
			COLOR = headY;
		} else {
			COLOR = spr_color;
		}
		if (spr_color == tail_up) {
			COLOR = tail_upY;
		} else {
			COLOR = spr_color;
		}
		if (spr_color == tail_down) {
			COLOR = tail_downY;
		} else {
			COLOR = spr_color;
		}
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
