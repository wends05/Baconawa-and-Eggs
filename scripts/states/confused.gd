extends State

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg = {}):
	owner.velocity = Vector2(0, 0)
	owner.controls.shuffle()
	state_machine.transition_to("Idle")
	owner.get_node("InternalTimer").start(3)
	await owner.get_node("InternalTimer").timeout
	owner.controls = ["b_up", "b_down", "b_left", "b_right"
	#, "placeholder"
	]
