extends CharacterBody2D

# important to make a class_name to
# be able to reference this in other scripts

class_name Baconawa
@export var SPEED: int = 100
@export var game: Game

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
var moons_collected: int = 0
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

func _physics_process(_delta: float) -> void:
	# refer to the game.game_ended signal
	if game_finished:
		return

	if Input.is_action_pressed("b_down"):
		last_input = "down"
		if not down_colliding:
			move()
	if Input.is_action_pressed("b_up"):
		last_input = "up"
		if not top_colliding:
			move()
	if Input.is_action_pressed("b_left"):
		last_input = "left"
		if not left_colliding:
			move()
	if Input.is_action_pressed("b_right"):
		last_input = "right"
		if not right_colliding:
			move()
	move_and_slide()

func colliding(_body, collider: Area2D, isColliding):
	match collider.name:
		"Top":
			top_colliding = isColliding
		"Down":
			down_colliding = isColliding
		"Left":
			left_colliding = isColliding
		"Right":
			right_colliding = isColliding
	if not isColliding:
		move()


func _on_main_area_entered(area: Area2D) -> void:
	print(typeof(area.get_parent()))
	if area.get_parent() is Moon:
		var moon : Moon = area.get_parent()
		print("Moon")
		buff_id = randi_range(1, 3)

func move():
	match last_input:
		"up":
			velocity = Vector2(0, -SPEED)
			anim.play("move_up")
		"down":
			velocity = Vector2(0, SPEED)
			anim.play("move_down")
		"left":
			velocity = Vector2(-SPEED, 0)
			anim.play("move_left")
		"right":
				velocity = Vector2(SPEED, 0)
				anim.play("move_right")

