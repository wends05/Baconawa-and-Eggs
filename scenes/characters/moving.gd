extends State

@onready var anim = owner.get_node("Animations")
@onready var SPEED = owner.SPEED

func update(_delta: float) -> void:
	if Input.is_action_pressed("b_down"):
		owner.last_input = "down"
		if not owner.down_colliding:
			move()
	if Input.is_action_pressed("b_up"):
		owner.last_input = "up"
		if not owner.top_colliding:
			move()
	if Input.is_action_pressed("b_left"):
		owner.last_input = "left"
		if not owner.left_colliding:
			move()
	if Input.is_action_pressed("b_right"):
		owner.last_input = "right"
		if not owner.right_colliding:
			move()

func move():
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
			anim.flip_h = true
		"right":
			owner.velocity = Vector2(SPEED, 0)
			anim.play("move_side")
			anim.flip_h = false
