extends State

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
	owner.velocity = Vector2.ZERO
	owner.anim.play("idle")
	if owner is Rice:
		owner.item = null

func update(_delta: float) -> void:
	for input in range(4):
		if Input.is_action_pressed(owner.controls[input]):
			state_machine.transition_to("Moving")
			return
	# Bottom to be returned once input map is good
	#if owner is Rice:
		#if Input.is_action_pressed(owner.controls[4]):
			#state_machine.transition_to("Flashing")
			#return
		#if Input.is_action_pressed(owner.controls[5]):
			#state_machine.transition_to("Drumming")
			#return
