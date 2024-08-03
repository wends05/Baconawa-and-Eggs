extends CharacterBody2D

# important to make a class_name to
# be able to reference this in other scripts

class_name Baconawa
@export var SPEED: int = 75
@export var game: Game
@export var body: BaconawaBody

# Reference on children
@onready var anim = $Animations

@onready var top_collider = $Colliders/Top
@onready var down_collider = $Colliders/Down
@onready var left_collider = $Colliders/Left
@onready var right_collider = $Colliders/Right

@onready var internal_timer = $InternalTimer
@onready var move_timer = $MoveTimer
@onready var buff_timer = $BuffTimer
@onready var state_machine = $StateMachine

var controls = ["up_1", "down_1", "left_1", "right_1", "action_1"
#, "placeholder"
]

# information used if baconawa can change directions
var down_colliding = false
var top_colliding = false
var left_colliding = false
var right_colliding = false

# checks last input to identify where to go after finishing
# colliding to a wall
var last_input = ""
var turn_position

# Game proper variables
var moons_collected: int = 0
var game_finished = false

# Buffs and debuffs
var buffs : Array[int] = []
var buff_cooldown = false
const BUFFS = {
	0: "No Buff",
	1: "Speed",
	2: "Random Kill",
	3: "Move to a Wall"
}
signal kill_someone
var moving_through_wall = false
signal moon_collected

signal eat
signal nrml
signal ghst
signal fst
signal gld
signal bff
signal bff_act

var bacon_color = [
	
	[	#normal
		Vector4(0.486,0.137,0.102,1.0),
		Vector4(0.588,0.235,0.196, 1.0),
		Vector4(0.396,0.157,0.157, 1.0),
		Vector4(0.827,0.631,0.463, 1.0),
		Vector4(0.835,0.514,0.286, 1.0),
		Vector4(0.914,0.718,0.549, 1.0),
		Vector4(0.294,0.106,0.075, 1.0)
	],
	[	#speed
		Vector4(0.514,0.961,0.906,1.0),
		Vector4(0.102,0.886,0.886, 1.0),
	],
	[	#ghost
		Vector4(0.486,0.137,0.102,0.3),
		Vector4(0.588,0.235,0.196, 0.3),
		Vector4(0.396,0.157,0.157, 0.3),
		Vector4(0.827,0.631,0.463, 0.3),
		Vector4(0.835,0.514,0.286, 0.3),
		Vector4(0.914,0.718,0.549, 0.3),
		Vector4(0.294,0.106,0.075, 0.3)
	],
]
func _ready() -> void:
	
	clr_normal()
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

	# stops getting movement inputs from the player while on a wall
	if moving_through_wall:
		return

	move_and_slide()
	body.positionarr.append(position)
	if body.positionarr.size() > 10:
		body.positionarr.pop_front()

func colliding(_body, collider: Area2D, isColliding):
	match collider.name:
		"Top":
			top_colliding = isColliding
			if last_input == "up" and not isColliding:
				#this needs to be moved
				state_machine.get_node("Moving").move()
		"Down":
			down_colliding = isColliding
			if last_input == "down" and not isColliding:
				#this needs to be moved
				state_machine.get_node("Moving").move()
		"Left":
			left_colliding = isColliding
			if last_input == "left" and not isColliding:
				#this needs to be moved
				state_machine.get_node("Moving").move()
		"Right":
			right_colliding = isColliding
			if last_input == "right" and not isColliding:
				#this needs to be moved
				state_machine.get_node("Moving").move()

# checks for buffs if buff_id is not 0
func _input(event: InputEvent) -> void:
	if event.is_action_pressed(controls[4]) and not buff_cooldown and not buffs.size() == 0:
		buff_cooldown = true
		bff_act.emit()
		match buffs[0]:
			1: #Speed
				clr_speed()
				fst.emit()
				SPEED = 120
				internal_timer.start(3)
				buffs.pop_front()
				#this needs to be moved
				state_machine.get_node("Moving").move()
				await internal_timer.timeout
				clr_normal()
				nrml.emit()
				SPEED = 75
			2: #Kill someone
				buffs.pop_front()
				kill_someone.emit()
			3: #Move to a wall
				print("Collision mask 2 set to false")
				ghst.emit()
				clr_ghost()
				top_colliding = false
				down_colliding = false
				left_colliding = false
				right_colliding = false
				set_collision_mask_value(2, false)
				buffs.pop_front()
			_:
				print("No buffs yet")
				print(buffs[0])
		buff_timer.start(3)
		await buff_timer.timeout
		buff_cooldown = false


# Moon collector function
func _on_collector_area_entered(area: Area2D) -> void:
	var node = area.get_parent()
	if node is Moon and not node.is_collected:
		moons_collected += 1
		moon_collected.emit()
		eat.emit()
		if len(buffs) != 2:
			buffs.append(randi_range(1,3))
			bff.emit()

# If exited a wall, add the collision mask value again
func _on_collector_body_exited(_body: Node2D) -> void:
	set_collision_mask_value(2, true)
	nrml.emit()
	clr_normal()
	


func clr_normal():
	anim.material.set_shader_parameter("red1B", bacon_color[0][0])
	anim.material.set_shader_parameter("red2B", bacon_color[0][1])
	anim.material.set_shader_parameter("red3B", bacon_color[0][2])
	anim.material.set_shader_parameter("fat1B", bacon_color[0][3])
	anim.material.set_shader_parameter("fat2B", bacon_color[0][4])
	anim.material.set_shader_parameter("eye1B", bacon_color[0][5])
	anim.material.set_shader_parameter("eye2B", bacon_color[0][6])

func clr_speed():
	anim.material.set_shader_parameter("fat1B", bacon_color[1][0])
	anim.material.set_shader_parameter("fat2B", bacon_color[1][1])

func clr_ghost():
	anim.material.set_shader_parameter("red1B", bacon_color[2][0])
	anim.material.set_shader_parameter("red2B", bacon_color[2][1])
	anim.material.set_shader_parameter("red3B", bacon_color[2][2])
	anim.material.set_shader_parameter("fat1B", bacon_color[2][3])
	anim.material.set_shader_parameter("fat2B", bacon_color[2][4])
	anim.material.set_shader_parameter("eye1B", bacon_color[2][5])
	anim.material.set_shader_parameter("eye2B", bacon_color[2][6])
