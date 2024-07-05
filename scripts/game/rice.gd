extends CharacterBody2D

#variables
class_name Rice
var player_number = 1
@export var SPEED: int = 90
@export var game : Game
@onready var anim = $Animations

#collider checks
@onready var top_collider = $Colliders/Top
@onready var down_collider = $Colliders/Down
@onready var left_collider = $Colliders/Left
@onready var right_collider = $Colliders/Right

#???
@onready var internal_timer = $InternalTimer
var move = 0

#collider check
var down_colliding = false
var top_colliding = false
var left_colliding = false
var right_colliding = false
var last_input = ""

#from bakunawa : var moons_collected : int = 0
var game_finished = false

#multi controls
var r_controls = []

#create evenet
func _ready() -> void:
	
	#colliders
	anim.play("idle")
	top_collider.connect("body_entered", colliding.bind(top_collider, true))
	down_collider.connect("body_entered", colliding.bind(down_collider, true))
	left_collider.connect("body_entered", colliding.bind(left_collider, true))
	right_collider.connect("body_entered", colliding.bind(right_collider, true))

	top_collider.connect("body_exited", colliding.bind(top_collider, false))
	down_collider.connect("body_exited", colliding.bind(down_collider, false))
	left_collider.connect("body_exited", colliding.bind(left_collider, false))
	right_collider.connect("body_exited", colliding.bind(right_collider, false))
	
	#controls for multiplayer
	#array contains name for input map depending on player number
	r_controls = [
		"r%d_up" % player_number,
		"r%d_down" % player_number,
		"r%d_left" % player_number,
		"r%d_right" % player_number,
	]
	#up-0, down-1, left-2, right-3


#loop event
func _physics_process(delta: float) -> void:
	if game_finished:
		return

	if Input.is_action_pressed(r_controls[0]):
		if not top_colliding:
			velocity = Vector2(0, -SPEED)
			anim.play("move_up")
		move = 1
		last_input = "up"
	if Input.is_action_pressed(r_controls[1]):
		if not down_colliding:
			velocity = Vector2(0, SPEED)
			anim.play("move_down")
		move = 0
		last_input = "down"
	if Input.is_action_pressed(r_controls[2]):
		if not left_colliding:
			velocity = Vector2(-SPEED, 0)
			anim.play("move_left")
		move = 2
		last_input = "left"
	if Input.is_action_pressed(r_controls[3]):
		if not right_colliding:
			velocity = Vector2(SPEED, 0)
			anim.play("move_right")
		move = 3
		last_input = "right"
	move_and_slide()

#if colliding with wall
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
