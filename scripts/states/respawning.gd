extends State

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg = {}):
	var internal_timer = owner.get_node("InternalTimer")
	owner.velocity = Vector2(0, 0)
	owner.last_input = ""
	owner.visible = false
	owner.anim.play("idle")
	owner.global_position = owner.spawn_point
	internal_timer.start(3)
	await internal_timer.timeout
	owner.visible = true
	state_machine.transition_to("Idle")
