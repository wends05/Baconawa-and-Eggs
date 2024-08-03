extends Node2D

var controller
var playercont = []
@export var player = 1

@onready var anim = $AnimatedSprite2D

#from scene variables
@onready var button_timer = $ButtonTimer
@onready var selectscreen = get_parent() as CharacterSelect

#array for controls
var controls = [
	["up_1", "down_1", "left_1", "right_1", "action_1"],
	["up_2", "down_2", "left_2", "right_2", "action_2"],
	["up_3", "down_3", "left_3", "right_3", "action_3"],
	["up_4", "down_4", "left_4", "right_4", "action_4"],
	["up_5", "down_5", "left_5", "right_5", "action_5"],
	["up_6", "down_6", "left_6", "right_6", "action_6"],
	["up_7", "down_7", "left_7", "right_7", "action_7"],
	["up_8", "down_8", "left_8", "right_8", "action_8"]
]


func toggleselect():
	
	for i in range(8):
		if Input.is_action_pressed("action_" + str(i + 1)) and selectscreen.contconfirm[i] == false:
			controller = i
			selectscreen.contconfirm[i] = true
			playercont = controls[controller]
			selectscreen.index += 1
			print("selected " + str(controller) + " for " + str(player))
			anim.play("selected")
			break
	
	#if Input.is_action_pressed("action_1") && selectscreen.contconfirm[0] == false:
		#controller = 0
		#selectscreen.contconfirm[0] = true
		#playercont = controls[controller]
		#selectscreen.index += 1
		#print("selected " + str(controller) + " for " + str(player))
		#anim.play("selected")
	#elif Input.is_action_pressed("action_2") && selectscreen.contconfirm[1] == false:
		#controller = 1
		#selectscreen.contconfirm[0] = true
		#playercont = controls[controller]
		#selectscreen.index += 1
		#anim.play("selected")
	#elif Input.is_action_pressed("action_3") && selectscreen.contconfirm[2] == false:
		#controller = 2
		#selectscreen.contconfirm[0] = true
		#playercont = controls[controller]
		#anim.play("selected")
	#elif Input.is_action_pressed("action_4") && selectscreen.contconfirm[3] == false:
		#controller = 3
		#selectscreen.contconfirm[0] = true
		#playercont = controls[controller]
		#anim.play("selected")
	#elif Input.is_action_pressed("action_5") && selectscreen.contconfirm[4] == false:
		#controller = 4
		#selectscreen.contconfirm[0] = true
		#playercont = controls[controller]
		#anim.play("selected")
	#elif Input.is_action_pressed("action_6") && selectscreen.contconfirm[5] == false:
		#controller = 5
		#selectscreen.contconfirm[0] = true
		#playercont = controls[controller]
		#anim.play("selected")
	#elif Input.is_action_pressed("action_7") && selectscreen.contconfirm[6] == false:
		#controller = 6
		#selectscreen.contconfirm[0] = true
		#playercont = controls[controller]
		#anim.play("selected")
	#elif Input.is_action_pressed("action_8") && selectscreen.contconfirm[7] == false:
		#controller = 7
		#selectscreen.contconfirm[0] = true
		#playercont = controls[controller]
		#anim.play("selected")

# Called when the node enters the scene tree for the first time.
func _ready():
	if selectscreen.index == player:
		anim.play("active")
	else:
		anim.play("waiting")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if selectscreen.index == player:
		anim.play("active")
		toggleselect()
