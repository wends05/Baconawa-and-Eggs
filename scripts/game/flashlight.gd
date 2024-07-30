extends Sprite2D

class_name Flashlight

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Baconawa:
		body.state_machine.transition_to("Stunned")
