extends Control

func _ready():
	LoadMusic.play_music()

func _on_yes_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/instructions.tscn")


func _on_no_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/character_select.tscn")
