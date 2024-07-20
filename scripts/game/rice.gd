extends CharacterBody2D

#variables

class_name Rice
@export var player_number = 2
@export var SPEED: int = 90
@export var game: Game
@onready var anim = $Animations


#collider checks
@onready var top_collider = $Colliders/Top
@onready var down_collider = $Colliders/Down
@onready var left_collider = $Colliders/Left
@onready var right_collider = $Colliders/Right

# will be used for delays
@onready var internal_timer = $InternalTimer

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
	for collider: Area2D in [top_collider, down_collider, left_collider, right_collider]:
		collider.connect("body_entered", colliding.bind(collider, true))
		collider.connect("body_exited", colliding.bind(collider, false))
	#controls for multiplayer
	#array contains name for input map depending on player number
	r_controls = [
		"r%d_up" % player_number,
		"r%d_down" % player_number,
		"r%d_left" % player_number,
		"r%d_right" % player_number,
	]
	#up-0, down-1, left-2, right-3
	
	
	var material = anim.material #presumably stores the material in animations node
	if material is ShaderMaterial: #check
		# presumably the shader parameter to the player number
		material.set("shader_parameter/playernum", player_number)
	else:
		print("Material is not a ShaderMaterial.")
	
# loop event
func _physics_process(_delta: float) -> void:
	# refer to the game.game_ended signal
	if game_finished:
		return

	if Input.is_action_pressed(r_controls[1]):
		if not down_colliding:
			velocity = Vector2(0, SPEED)
			anim.play("move_down")
			anim.flip_h = false
		last_input = "down"
	if Input.is_action_pressed(r_controls[0]):
		if not top_colliding:
			velocity = Vector2(0, -SPEED)
			anim.play("move_up")
			anim.flip_h = false
		last_input = "up"
	if Input.is_action_pressed(r_controls[2]):
		if not left_colliding:
			velocity = Vector2( - SPEED, 0)
			anim.play("move_side")
			anim.flip_h = false
		last_input = "left"
	if Input.is_action_pressed(r_controls[3]):
		if not right_colliding:
			velocity = Vector2(SPEED, 0)
			anim.play("move_side")
			anim.flip_h = true
		last_input = "right"
	move_and_slide()

#if colliding with wall
func colliding(_body, collider: Area2D, isColliding):
	match collider.name:
		"Top":
			top_colliding = isColliding
			if not isColliding and last_input == "up":
				velocity = Vector2(0, -SPEED)
				anim.play("move_up")
				anim.flip_h = false
		"Down":
			down_colliding = isColliding
			if not isColliding and last_input == "down":
				velocity = Vector2(0, SPEED)
				anim.play("move_down")
				anim.flip_h = false
		"Right":
			right_colliding = isColliding
			if not isColliding and last_input == "right":
				velocity = Vector2(SPEED, 0)
				anim.play("move_side")
				anim.flip_h = true
		"Left":
			left_colliding = isColliding
			if not isColliding and last_input == "left":
				velocity = Vector2( - SPEED, 0)
				anim.play("move_side")
				anim.flip_h = false

# Used by the Rice Players nga Node2Ds
func respawn():
	visible = false
	internal_timer.start(2)
	await internal_timer.timeout
	visible = true
