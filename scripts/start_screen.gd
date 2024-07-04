extends Control



func _on_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/instructions_start.tscn")


func _on_instructions_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/instructions.tscn")
