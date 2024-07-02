extends CharacterBody2D

@export var SPEED: int = 100
@onready var anim = $AnimatedSprite2D

@onready var top_collider = $Colliders/Top
@onready var down_collider = $Colliders/Down
@onready var left_collider = $Colliders/Left
@onready var right_collider = $Colliders/Right

@export var info: Baconawa
var move = 0

@onready var internal_timer = $InternalTimer

func _ready() -> void:
	anim.play("idle")
	top_collider.connect("body_entered", colliding.bind(top_collider, true))
	down_collider.connect("body_entered", colliding.bind(down_collider, true))
	left_collider.connect("body_entered", colliding.bind(left_collider, true))
	right_collider.connect("body_entered", colliding.bind(right_collider, true))

	top_collider.connect("body_exited", colliding.bind(top_collider, false))
	down_collider.connect("body_exited", colliding.bind(down_collider, false))
	left_collider.connect("body_exited", colliding.bind(left_collider, false))
	right_collider.connect("body_exited", colliding.bind(right_collider, false))


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("b_down"):
		if not info.down_colliding:
			velocity = Vector2(0, SPEED)
			anim.play("move_down")
		move = 0
		info.last_input = "down"
	if Input.is_action_pressed("b_up"):
		if not info.top_colliding:
			velocity = Vector2(0, -SPEED)
			anim.play("move_up")
		move = 1
		info.last_input = "up"
	if Input.is_action_pressed("b_left"):
		if not info.left_colliding:
			velocity = Vector2(-SPEED, 0)
			anim.play("move_left")
		move = 2
		info.last_input = "left"
	if Input.is_action_pressed("b_right"):
		if not info.right_colliding:
			velocity = Vector2(SPEED, 0)
			anim.play("move_right")
		move = 3
		info.last_input = "right"
	move_and_slide()

func colliding(_body, collider: Area2D, isColliding):
	print_debug(collider.name, isColliding)
	print(isColliding, move)
	match collider.name:
		"Top":
			info.top_colliding = isColliding
			if not isColliding and move == 1:
				#internal_timer.start(0.5)
				#await internal_timer
				velocity = Vector2(0, -SPEED)
				anim.play("move_up")
		"Down":
			info.down_colliding = isColliding
			if not isColliding and move == 0:
				#internal_timer.start(0.5)
				#await internal_timer
				velocity = Vector2(0, SPEED)
				anim.play("move_down")
		"Right":
			info.right_colliding = isColliding
			if not isColliding and move == 3:
				#internal_timer.start(0.5)
				#await internal_timer
				velocity = Vector2(SPEED, 0)
				anim.play("move_right")
		"Left":
			info.left_colliding = isColliding
			if not isColliding and move == 2:
				#internal_timer.start(0.5)
				#await internal_timer
				velocity = Vector2(-SPEED, 0)
				anim.play("move_left")

	print(velocity.x, " ", velocity.y)
