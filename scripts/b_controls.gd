extends CharacterBody2D

@export var SPEED: int = 100
@onready var anim = $AnimatedSprite2D

@onready var top_collider = $Colliders/Top
@onready var down_collider = $Colliders/Down
@onready var left_collider = $Colliders/Left
@onready var right_collider = $Colliders/Right

@export var info: Baconawa

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
	if Input.is_action_pressed("b_down") and not info.down_colliding:
		velocity = Vector2(0, SPEED)
		anim.play("move_down")
	if Input.is_action_pressed("b_up") and not info.top_colliding:
		velocity = Vector2(0, -SPEED)
		anim.play("move_up")
	if Input.is_action_pressed("b_left") and not info.left_colliding:
		velocity = Vector2(-SPEED, 0)
		anim.play("move_left")
	if Input.is_action_pressed("b_right") and not info.right_colliding:
		velocity = Vector2(SPEED, 0)
		anim.play("move_right")

	move_and_slide()

func colliding(_body, collider: Area2D, isColliding):
	print_debug(collider.name, isColliding)
	match collider.name:
		"Top":
			info.top_colliding = isColliding
		"Down":
			info.down_colliding = isColliding
		"Right":
			info.right_colliding = isColliding
		"Left":
			info.left_colliding = isColliding
