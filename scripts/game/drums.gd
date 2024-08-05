extends AnimatedSprite2D

class_name Drums

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Baconawa:
		if body.invincible: return
		body.state_machine.transition_to("Confused")
