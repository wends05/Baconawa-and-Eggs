extends State

@onready var internal_timer = owner.get_node("InternalTimer")
@onready var flashlight = owner.get_node("FlAnchor")

func enter(_msg := {}) -> void:

	# for type safety lang
	if not owner is Rice:
		return
	owner.anim.play("idle")
	var direction = owner.direction
	match direction:
		"up":
			flashlight.set_rotation_degrees(-90)
		"left":
			flashlight.set_rotation_degrees(180)
		"right":
			flashlight.set_rotation_degrees(00)
		"down":
			flashlight.set_rotation_degrees(90)

	owner.item_cooldown = true
	owner.velocity = Vector2(0, 0)
	owner.last_input = ""
	var flash_instance = preload("res://scenes/characters/flashlight.tscn").instantiate()
	flashlight.add_child(flash_instance)
	internal_timer.start(3)
	await internal_timer.timeout
	owner.item_cooldown = false
	owner.item = null
	flash_instance.queue_free()
	state_machine.transition_to("Idle")
