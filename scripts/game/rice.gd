extends CharacterBody2D

#variables

class_name Rice
@export var player_number = 1
@export var SPEED: int = 70
@export var game: Game
@onready var anim = $Animations
@onready var sfx = $rice_sfx

#collider checks
@onready var top_collider = $Colliders/Top
@onready var down_collider = $Colliders/Down
@onready var left_collider = $Colliders/Left
@onready var right_collider = $Colliders/Right
@onready var baconawa : Area2D = $Colliders/Baconawa

# will be used for delays
@onready var internal_timer = $InternalTimer
@onready var spawn_position = global_position
@onready var state_machine : StateMachine = $StateMachine

#collider check
var down_colliding = false
var top_colliding = false
var left_colliding = false
var right_colliding = false

var last_input = ""
var direction = "left"

#from bakunawa : var moons_collected : int = 0
var game_finished = false

#multi controls
var controls = Controlcontainer.control_contain[player_number]

#shader colors
var bandcolors = [
	[Vector4(0.839, 0.024, 0.024, 1.0), Vector4(0.714, 0.012, 0.071, 1.0), Vector4(0.447,0., 0.114, 1.0)], #red
	[Vector4(0.216,0.275,0.78, 1.0), Vector4(0.188,0.196,0.733, 1.0), Vector4(0.235,0.11,0.553, 1.0)], #blue
	[Vector4(1.0,0.737,0.251, 1.0), Vector4(0.965,0.816,0.239, 1.0), Vector4(0.78,0.737,0.192, 1.0)], #yellow
]

#ui
signal die
signal alive
signal pickup
signal use

var item : Item = null
var item_cooldown = false
var invincible = false

func _ready() -> void:
	#colliders
	anim.play("idle")
	for collider: Area2D in [top_collider, down_collider, left_collider, right_collider]:
		collider.connect("body_entered", colliding.bind(collider, true))
		collider.connect("body_exited", colliding.bind(collider, false))


	var b = preload("res://scenes/collectibles/barrier.tscn")
	var d = preload("res://scenes/collectibles/drum.tscn")
	var l = preload("res://scenes/collectibles/lantern.tscn")

	item = [b,d,l].pick_random().instantiate()
	item.visible = false
	add_child(item)
	pickup.emit()

	#controls for multiplayer
	#controls are taken from Controlcontainer.gd
	controls = Controlcontainer.control_contain[player_number]

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
		pickup.emit()

func _on_baconawa_area_entered(area: Area2D) -> void:

	var node = area.owner
	if node is Baconawa and not invincible:
		invincible = true
		sfx.die.play()
		state_machine.transition_to("Respawning")
