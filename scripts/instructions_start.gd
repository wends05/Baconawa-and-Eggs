extends Control


func _on_yes_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/instructions.tscn")


func _on_no_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/main_game.tscn")
