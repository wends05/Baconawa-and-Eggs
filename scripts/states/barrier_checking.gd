extends State

@onready var anim = owner.get_node("Animations")
@onready var controls
var barrier_check_instance
var wall_anchor

func enter(_msg := {}) -> void:
	wall_anchor = owner.get_node("WallAnchor")
	barrier_check_instance = preload("res://scenes/characters/barrier_check.tscn").instantiate()
	wall_anchor.add_child(barrier_check_instance)

func physics_update(_delta: float) -> void:
	controls = owner.controls
	if Input.is_action_pressed(controls[0]):
		owner.last_input = "up"
		owner.get_node("WallAnchor").set_rotation_degrees(-90)
		if not owner.top_colliding:
			move()
	if Input.is_action_pressed(controls[1]):
		owner.last_input = "down"
		if not owner.down_colliding:
			move()
	if Input.is_action_pressed(controls[2]):
		owner.last_input = "left"
		if not owner.left_colliding:
			move()
	if Input.is_action_pressed(controls[3]):
		owner.last_input = "right"
		if not owner.right_colliding:
			move()
	if Input.is_action_just_pressed(controls[4]):
		barrier_check_instance.queue_free()
		state_machine.transition_to("Idle")
		owner.sfx.bamboo.play()
		var barrier_instance = preload("res://scenes/characters/wall.tscn").instantiate()
		owner.owner.add_child(barrier_instance)
		barrier_instance.global_position = barrier_check_instance.global_position
		owner.internal_timer.start(5)
		await owner.internal_timer.timeout
		barrier_instance.queue_free()

func move():
	var SPEED = owner.SPEED
	match owner.last_input:
		"up":
			owner.velocity = Vector2(0, -SPEED)
			anim.play("move_up")
			owner.direction = "up"
			anim.flip_h = false
		"down":
			owner.velocity = Vector2(0, SPEED)
			anim.play("move_down")
			owner.direction = "down"
			anim.flip_h = false
			wall_anchor.set_rotation_degrees(90)
		"left":
			owner.velocity = Vector2(-SPEED, 0)
			anim.play("move_side")
			owner.direction = "left"
			anim.flip_h = false
			wall_anchor.set_rotation_degrees(180)
		"right":
			owner.velocity = Vector2(SPEED, 0)
			anim.play("move_side")
			owner.direction = "right"
			anim.flip_h = true
			wall_anchor.set_rotation_degrees(00)
