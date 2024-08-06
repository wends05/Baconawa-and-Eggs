extends State
var control_temp
# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg = {}):
	#if not owner is Baconawa:
		#return
	owner.sfx.confused.play()
	owner.cnfsd.emit()
	owner.velocity = Vector2(0, 0)
	control_temp = owner.controls.duplicate(true)
	print(control_temp)
	owner.controls.shuffle()
	state_machine.transition_to("Idle")
	owner.debuffed = false
	owner.get_node("InternalTimer").start(5)
	await owner.get_node("InternalTimer").timeout
	owner.nrml.emit()
	owner.controls = control_temp
	print(owner.controls)
