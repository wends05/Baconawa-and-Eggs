extends State
# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg = {}):
	if not owner is Baconawa:
		return

	var internal_timer = owner.get_node("InternalTimer")
	owner.sfx.stunned.play()
	owner.confused.show()
	owner.stn.emit()
	owner.velocity = Vector2(0, 0)
	owner.anim.play("idle")
	owner.clr_normal()
	owner.last_input = ""
	internal_timer.start(3)
	await internal_timer.timeout
	owner.debuffed = false
	owner.confused.hide()
	owner.nrml.emit()
	state_machine.transition_to("Idle")
