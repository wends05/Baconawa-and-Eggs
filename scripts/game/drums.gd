extends Sprite2D

func _ready():
	pass # Replace with function body.

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Baconawa:
		body.state_machine.transition_to("Confused")
