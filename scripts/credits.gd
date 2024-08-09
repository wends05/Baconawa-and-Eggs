extends Control

@onready var bgm = $bg

# Called when the node enters the scene tree for the first time.
func _ready():
	bgm.play()


func _on_button_button_up():
	get_tree().change_scene_to_file("res://scenes/screens/main _menu.tscn")
