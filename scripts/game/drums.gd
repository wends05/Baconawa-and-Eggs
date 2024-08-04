extends Sprite2D

class_name Drums

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Baconawa:
		if body.invincible: return
		body.debuffed = true
		if body.state_machine.state.name == "Confused":
			return
		print("Reached this code")
		body.state_machine.transition_to("Confused")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Baconawa:
		if not body.invincible:
			body.state_machine.transition_to("Confused")
