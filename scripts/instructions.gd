extends Control


func _on_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/char_select.tscn")
