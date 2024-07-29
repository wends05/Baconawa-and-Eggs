extends Node2D

var controller
var playercont = []
var player = 1
var controls = [
	[
		"up_1",
		"down_1",
		"left_1",
		"right_1",
		"action_1",
	],
	[
		"up_2",
		"down_2",
		"left_2",
		"right_2",
		"action_2",
	],
	[
		"up_3",
		"down_3",
		"left_3",
		"right_3",
		"action_3",
	],
	[
		"up_4",
		"down_4",
		"left_4",
		"right_4",
		"action_4",
	],
	[
		"up_5",
		"down_5",
		"left_5",
		"right_5",
		"action_5",
	],
	[
		"up_6",
		"down_6",
		"left_6",
		"right_6",
		"action_6",
	],
	[
		"up_7",
		"down_7",
		"left_7",
		"right_7",
		"action_7",
	],
	[
		"up_8",
		"down_8",
		"left_8",
		"right_8",
		"action_8"
	]
]


func toggleselect():
	if Input.is_action_pressed("action_1"):
		controller = 1 -1
	if Input.is_action_pressed("action_2"):
		controller = 2 -1
	if Input.is_action_pressed("action_3"):
		controller = 3 -1
	if Input.is_action_pressed("action_4"):
		controller = 4 -1
	if Input.is_action_pressed("action_5"):
		controller = 5 -1
	if Input.is_action_pressed("action_6"):
		controller = 6 -1
	if Input.is_action_pressed("action_7"):
		controller = 7 -1
	if Input.is_action_pressed("action_8"):
		controller = 8 -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	toggleselect()
	if controller >= 0 and controller < controls.size():
		playercont = controls[controller]
