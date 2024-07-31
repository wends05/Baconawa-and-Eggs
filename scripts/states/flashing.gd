extends State

@onready var internal_timer = owner.get_node("InternalTimer")
@onready var flashlight = owner.get_node("FlashlightAnchor")

func enter(_msg := {}) -> void:
	var direction = owner.last_input
	
	match direction:
		"up":
			flashlight.set_rotation_degrees(-90)
		"left":
			flashlight.set_rotation_degrees(180)
		"right":
			flashlight.set_rotation_degrees(00)
		"down":
			flashlight.set_rotation_degrees(90)
	
	owner.velocity = Vector2(0, 0)
	owner.last_input = ""
	var flash_instance = preload("res://scenes/characters/flashlight.tscn").instantiate()
	flashlight.add_child(flash_instance)
	internal_timer.start(3)
	await internal_timer.timeout
	flash_instance.queue_free()
	state_machine.transition_to("Idle")
