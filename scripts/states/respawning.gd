extends State

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.

func enter(_msg = {}):
	if owner is Rice:
		var internal_timer = owner.get_node("InternalTimer")
		owner.die.emit()
		owner.velocity = Vector2(0, 0)
		owner.last_input = ""
		owner.visible = false
		owner.anim.play("idle")
		owner.set_collision_layer_value(4, false)
		owner.set_collision_mask_value(8, false)
		owner.global_position = owner.spawn_position
		internal_timer.start(3)
		await internal_timer.timeout
		owner.invincible = false
		owner.alive.emit()
		owner.sfx.live.play()
		owner.visible = true
		state_machine.transition_to("Idle")
		owner.set_collision_layer_value(4, true)
		owner.set_collision_mask_value(8, true)




