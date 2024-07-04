extends CharacterBody2D

class_name Baconawa
@export var SPEED: int = 100
@export var game : Game
@onready var anim = $Animations

@onready var top_collider = $Colliders/Top
@onready var down_collider = $Colliders/Down
@onready var left_collider = $Colliders/Left
@onready var right_collider = $Colliders/Right

@onready var internal_timer = $InternalTimer
var move = 0

var down_colliding = false
var top_colliding = false
var left_colliding = false
var right_colliding = false

var last_input = ""

var moons_collected : int = 0
var game_finished = false

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

	game.game_ended.connect(finish_game)

func finish_game():
	game_finished = true
	anim.play("idle")

func _physics_process(delta: float) -> void:
	if game_finished:
		return

	if Input.is_action_pressed("b_down"):
		if not down_colliding:
			velocity = Vector2(0, SPEED)
			anim.play("move_down")
		move = 0
		last_input = "down"
	if Input.is_action_pressed("b_up"):
		if not top_colliding:
			velocity = Vector2(0, -SPEED)
			anim.play("move_up")
		move = 1
		last_input = "up"
	if Input.is_action_pressed("b_left"):
		if not left_colliding:
			velocity = Vector2(-SPEED, 0)
			anim.play("move_left")
		move = 2
		last_input = "left"
	if Input.is_action_pressed("b_right"):
		if not right_colliding:
			velocity = Vector2(SPEED, 0)
			anim.play("move_right")
		move = 3
		last_input = "right"
	move_and_slide()

func colliding(_body, collider: Area2D, isColliding):
	match collider.name:
		"Top":
			top_colliding = isColliding
			if not isColliding and move == 1:
				#internal_timer.start(0.5)
				#await internal_timer
				velocity = Vector2(0, -SPEED)
				anim.play("move_up")
		"Down":
			down_colliding = isColliding
			if not isColliding and move == 0:
				#internal_timer.start(0.5)
				#await internal_timer
				velocity = Vector2(0, SPEED)
				anim.play("move_down")
		"Right":
			right_colliding = isColliding
			if not isColliding and move == 3:
				#internal_timer.start(0.5)
				#await internal_timer
				velocity = Vector2(SPEED, 0)
				anim.play("move_right")
		"Left":
			left_colliding = isColliding
			if not isColliding and move == 2:
				#internal_timer.start(0.5)
				#await internal_timer
				velocity = Vector2(-SPEED, 0)
				anim.play("move_left")
