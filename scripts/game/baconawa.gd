extends CharacterBody2D

# important to make a class_name to
# be able to reference this in other scripts

class_name Baconawa
@export var SPEED: int = 100
@export var game : Game

# Reference on children
@onready var anim = $Animations

@onready var top_collider = $Colliders/Top
@onready var down_collider = $Colliders/Down
@onready var left_collider = $Colliders/Left
@onready var right_collider = $Colliders/Right

@onready var internal_timer = $InternalTimer

# information used if baconawa can change directions
var down_colliding = false
var top_colliding = false
var left_colliding = false
var right_colliding = false

# checks last input to identify where to go after finishing
# colliding to a wall
var last_input = ""

# Game proper variables
var moons_collected : int = 0
var game_finished = false

func _ready() -> void:
	anim.play("idle")
	for collider: Area2D in [top_collider, down_collider, left_collider, right_collider]:
		collider.connect("body_entered", colliding.bind(collider, true))
		collider.connect("body_exited", colliding.bind(collider, false))

	# connect the game ended signal to disallow inputs from player
	# and play the idle animation
	game.game_ended.connect(finish_game)

func finish_game():
	game_finished = true
	anim.play("idle")

func _physics_process(delta: float) -> void:

	# refer to the game.game_ended signal
	if game_finished:
		return

	if Input.is_action_pressed("b_down"):
		if not down_colliding:
			velocity = Vector2(0, SPEED)
			anim.play("move_down")
		last_input = "down"
	if Input.is_action_pressed("b_up"):
		if not top_colliding:
			velocity = Vector2(0, -SPEED)
			anim.play("move_up")
		last_input = "up"
	if Input.is_action_pressed("b_left"):
		if not left_colliding:
			velocity = Vector2(-SPEED, 0)
			anim.play("move_left")
		last_input = "left"
	if Input.is_action_pressed("b_right"):
		if not right_colliding:
			velocity = Vector2(SPEED, 0)
			anim.play("move_right")
		last_input = "right"
	move_and_slide()

func colliding(_body, collider: Area2D, isColliding):
	match collider.name:
		"Top":
			top_colliding = isColliding
			if not isColliding and last_input == "up":
				velocity = Vector2(0, -SPEED)
				anim.play("move_up")
		"Down":
			down_colliding = isColliding
			if not isColliding and last_input == "down":
				velocity = Vector2(0, SPEED)
				anim.play("move_down")
		"Right":
			right_colliding = isColliding
			if not isColliding and last_input == "right":
				velocity = Vector2(SPEED, 0)
				anim.play("move_right")
		"Left":
			left_colliding = isColliding
			if not isColliding and last_input == "left":
				velocity = Vector2(-SPEED, 0)
				anim.play("move_left")
