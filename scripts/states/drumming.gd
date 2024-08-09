extends State

@onready var internal_timer = owner.get_node("InternalTimer")

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.

func enter(_msg = {}):
	owner.item_cooldown = true
	owner.velocity = Vector2(0, 0)
	owner.last_input = ""
	owner.anim.play("idle")
	var drum_instance = preload("res://scenes/characters/drums.tscn").instantiate()
	owner.add_child(drum_instance)
	owner.sfx.drums.play()
	internal_timer.start(3)
	await internal_timer.timeout
	owner.item_cooldown = false
	owner.item = null
	drum_instance.queue_free()
	state_machine.transition_to("Idle")
