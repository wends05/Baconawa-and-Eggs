extends State
# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg = {}):
	#if not owner is Baconawa:
		#return
	owner.sfx.confused.play()
	owner.confused.show()
	owner.cnfsd.emit()
	owner.velocity = Vector2(0, 0)
	owner.controls.shuffle()
	state_machine.transition_to("Idle")
	owner.debuffed = false
	owner.get_node("InternalTimer").start(5)
	await owner.get_node("InternalTimer").timeout
	owner.confused.hide()
	owner.nrml.emit()
	owner.controls = Controlcontainer.control_contain[0].duplicate(true)
	print(owner.controls)
