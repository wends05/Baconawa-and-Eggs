extends State

@onready var internal_timer = owner.get_node("InternalTimer")
@onready var flashlight = owner.get_node("FlAnchor")

func enter(_msg := {}) -> void:

	# for type safety lang
	if not owner is Rice:
		return
	var direction = owner.direction
	match direction:
		"up":
			flashlight.set_rotation_degrees(-90)
			owner.anim.play("move_up", 0)
		"left":
			flashlight.set_rotation_degrees(180)
			owner.anim.play("idle")
		"right":
			flashlight.set_rotation_degrees(00)
			owner.anim.play("idle")
		"down":
			flashlight.set_rotation_degrees(90)
			owner.anim.play("move_down", 0)

	owner.item_cooldown = true
	owner.velocity = Vector2(0, 0)
	owner.last_input = ""
	var flash_instance = preload("res://scenes/characters/flashlight.tscn").instantiate()
	owner.sfx.flashlight.play()
	flashlight.add_child(flash_instance)
	internal_timer.start(3)
	await internal_timer.timeout
	owner.item_cooldown = false
	owner.item = null
	flash_instance.queue_free()
	state_machine.transition_to("Idle")
