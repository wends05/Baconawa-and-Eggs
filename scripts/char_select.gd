extends Control

@onready var sfx = $AudioStreamPlayer

var index = 0
@onready var characters = [
	$Bacon_char,
	$R1_char,
	$R2_char,
	$R3_char
]
@onready var labels = [
	$Bacon_char/Panel,
	$R1_char/Panel,
	$R2_char/Panel,
	$R3_char/Panel
]
@onready var character_ctrls = [
	$Bacon_char/ctrl,
	$R1_char/ctrl,
	$R2_char/ctrl,
	$R3_char/ctrl
]

var stored_controls = []

var contconfirm = [
	false, false, false ,false ,false ,false ,false ,false
]
var control_list = [
	["up_1", "down_1", "left_1", "right_1", "action_1"],
	["up_2", "down_2", "left_2", "right_2", "action_2"],
	["up_3", "down_3", "left_3", "right_3", "action_3"],
	["up_4", "down_4", "left_4", "right_4", "action_4"],
	["up_5", "down_5", "left_5", "right_5", "action_5"],
	["up_6", "down_6", "left_6", "right_6", "action_6"],
	["up_7", "down_7", "left_7", "right_7", "action_7"],
	["up_8", "down_8", "left_8", "right_8", "action_8"]
]

var contnum = []
@onready var play_button = $Button
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if index != 4:
		toggleselect()
		
	
	if Input.is_action_just_released("esc"):
		if index != 0:
			back_select()
		else:
			get_tree().change_scene_to_file("res://scenes/screens/main _menu.tscn")
	
func toggleselect():
	for i in range(8):
		if Input.is_action_pressed("action_" + str(i + 1)) and contconfirm[i] == false: 
			sfx.play()
			contnum.append(i)
			contconfirm[i] = true
			stored_controls.append(control_list[i])
			labels[index].hide()
			character_ctrls[index].texture = load("res://assets/main_sprites/char_select/controls/spr_controlselect%d.png" % (i+1))
			if index != 4:
				index += 1
				if index != 4:
					characters[index].modulate = Color(1, 1, 1, 1)
			if contnum.size() == 4:
				play_button.show()
			break


func back_select():
	sfx.play()
	if index == 4:
		play_button.hide()
	else:
		characters[index].modulate = Color(0.5, 0.5, 0.5, 1.0)
	character_ctrls[index-1].texture = null
	labels[index-1].show()
	stored_controls.pop_back()
	contconfirm[contnum[index-1]] = false
	contnum.pop_back()
	index -= 1
	

func _on_button_button_up() -> void:
	sfx.play()
	await sfx.finished
	Controlcontainer.control_contain = stored_controls
	get_tree().change_scene_to_file("res://scenes/screens/main_game.tscn")
