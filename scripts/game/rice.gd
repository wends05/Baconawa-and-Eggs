extends CharacterBody2D

#variables

class_name Rice
@export var player_number = 1
@export var SPEED: int = 70
@export var game: Game
@onready var anim = $Animations


#collider checks
@onready var top_collider = $Colliders/Top
@onready var down_collider = $Colliders/Down
@onready var left_collider = $Colliders/Left
@onready var right_collider = $Colliders/Right

# will be used for delays
@onready var internal_timer = $InternalTimer

@onready var spawn_position = global_position
@onready var state_machine = $StateMachine

#collider check
var down_colliding = false
var top_colliding = false
var left_colliding = false
var right_colliding = false

var last_input = ""

#from bakunawa : var moons_collected : int = 0
var game_finished = false

#multi controls
var controls = []

#shader colors
var bandcolors = [
	[Vector4(0.839, 0.024, 0.024, 1.0), Vector4(0.714, 0.012, 0.071, 1.0), Vector4(0.447,0., 0.114, 1.0)], #red
	[Vector4(0.067, 0.129, 0.675, 1.0), Vector4(0.047, 0.106, 0.62, 1.0), Vector4(0.114, 0.012, 0.42, 1.0)], #blue
	[Vector4(0.941, 0.827, 0.149, 1.0), Vector4(0.894, 0.784, 0.129, 1.0), Vector4(0.576, 0.592, 0.114, 1.0)], #yellow
]

var item : Item = null
var item_cooldown = false

func _ready() -> void:
	#colliders
	anim.play("idle")
	for collider: Area2D in [top_collider, down_collider, left_collider, right_collider]:
		collider.connect("body_entered", colliding.bind(collider, true))
		collider.connect("body_exited", colliding.bind(collider, false))

	#DEBUG AND TESTING ONLY, DELETE WHEN FINAL
	var controller_num = player_number + 1

	#controls for multiplayer
	#array contains name for input map depending on player number
	controls = [
		"up_%d" % controller_num,
		"down_%d" % controller_num,
		"left_%d" % controller_num,
		"right_%d" % controller_num,
		"action_%d" % controller_num, #change this for testings..cuz items are pickups
	]
	#up-0, down-1, left-2, right-3

	#shader
	anim.material.set_shader_parameter("headB", bandcolors[player_number-1][0])
	anim.material.set_shader_parameter("tail_upB", bandcolors[player_number-1][1])
	anim.material.set_shader_parameter("tail_downB", bandcolors[player_number-1][2])

# loop event
func _physics_process(_delta: float) -> void:
	# refer to the game.game_ended signal
	if game_finished:
		return
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

func _on_collector_area_entered(area: Area2D) -> void:
	#var node = area.get_parent()
	var node = area.owner
	if node is Item:
		item = node

func _on_baconawa_area_entered(area: Area2D) -> void:
	var node = area.owner
	if node is Baconawa:
		state_machine.transition_to("Respawning")
