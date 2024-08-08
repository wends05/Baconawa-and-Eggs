extends Control
var index = 1
@onready var prevbut = $Prev
@onready var nextbut = $Next
@onready var instruct = $TextureRect


func _on_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/character_select.tscn")


func _on_next_button_up():
	match index:
		1:
			prevbut.show()
			instruct.texture = load("res://assets/main_sprites/instructions/spr_riceinstruct.png")
			index += 1
		
		2:
			nextbut.hide()
			instruct.texture = load("res://assets/main_sprites/instructions/spr_controlinstruct.png")
			index += 1
		


func _on_prev_button_up():
	match index:
		2:
			prevbut.hide()
			instruct.texture = load("res://assets/main_sprites/instructions/spr_baconawainstruct.png")
			index -= 1
		
		3:
			nextbut.show()
			instruct.texture = load("res://assets/main_sprites/instructions/spr_riceinstruct.png")
			index -= 1
