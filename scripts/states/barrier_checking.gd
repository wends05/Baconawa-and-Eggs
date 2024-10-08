extends State

@onready var anim = owner.get_node("Animations")
@onready var controls
var barrier_check_instance
var wall_anchor

func enter(_msg := {}) -> void:
	wall_anchor = owner.get_node("WallAnchor")
	barrier_check_instance = preload("res://scenes/characters/barrier_check.tscn").instantiate()
	wall_anchor.add_child(barrier_check_instance)
	controls = owner.controls

func physics_update(_delta: float) -> void:
	if Input.is_action_pressed(controls[0]):
		owner.last_input = "up"
	if Input.is_action_pressed(controls[1]):
		owner.last_input = "down"
	if Input.is_action_pressed(controls[2]):
		owner.last_input = "left"
	if Input.is_action_pressed(controls[3]):
		owner.last_input = "right"
	move()
	if Input.is_action_just_pressed(controls[4]):
		barrier_check_instance.queue_free()
		state_machine.transition_to("Idle")
		owner.sfx.bamboo.play()
		var barrier_instance = preload("res://scenes/characters/wall.tscn").instantiate()
		owner.owner.add_child(barrier_instance)
		barrier_instance.global_position = barrier_check_instance.global_position
		owner.internal_timer.start(10)
		await owner.internal_timer.timeout
		barrier_instance.queue_free()

func move():
	var SPEED = owner.SPEED
	match owner.last_input:
		"up":
			if not owner.top_colliding:
				owner.velocity = Vector2(0, -SPEED)
				anim.play("move_up")
				owner.direction = "up"
				wall_anchor.set_rotation_degrees(-90)
				anim.flip_h = false
		"down":
			if not owner.down_colliding:
				owner.velocity = Vector2(0, SPEED)
				anim.play("move_down")
				owner.direction = "down"
				anim.flip_h = false
				wall_anchor.set_rotation_degrees(90)
		"left":
			if not owner.left_colliding:
				owner.velocity = Vector2(-SPEED, 0)
				anim.play("move_side")
				owner.direction = "left"
				anim.flip_h = false
				wall_anchor.set_rotation_degrees(180)
		"right":
			if not owner.right_colliding:
				owner.velocity = Vector2(SPEED, 0)
				anim.play("move_side")
				owner.direction = "right"
				anim.flip_h = true
				wall_anchor.set_rotation_degrees(00)
