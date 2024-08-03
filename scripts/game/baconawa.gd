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
		match buffs[0]:
			1: #Speed
				SPEED = 120
				internal_timer.start(3)
				buffs.pop_front()
				#this needs to be moved
				state_machine.get_node("Moving").move()
				await internal_timer.timeout
				SPEED = 75
			2: #Kill someone
				buffs.pop_front()
				kill_someone.emit()
			3: #Move to a wall
				print("Collision mask 2 set to false")
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
		if len(buffs) != 2: buffs.append(randi_range(1,3))

# If exited a wall, add the collision mask value again
func _on_collector_body_exited(_body: Node2D) -> void:
	set_collision_mask_value(2, true)
