extends State

@onready var anim = owner.get_node("Animations")
@onready var controls

func physics_update(_delta: float) -> void:
	controls = owner.controls
	if Input.is_action_pressed(controls[0]):
		owner.last_input = "up"
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

func move():
	var SPEED = owner.SPEED
	match owner.last_input:
		"up":
			owner.velocity = Vector2(0, -SPEED)
			anim.play("move_up")
			anim.flip_h = false
		"down":
			owner.velocity = Vector2(0, SPEED)
			anim.play("move_down")
			anim.flip_h = false
		"left":
			owner.velocity = Vector2(-SPEED, 0)
			anim.play("move_side")
			anim.flip_h = false
		"right":
			owner.velocity = Vector2(SPEED, 0)
			anim.play("move_side")
			anim.flip_h = true
