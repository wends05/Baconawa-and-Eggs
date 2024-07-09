extends Control

@onready var transition = $Transition
@onready var label = $VBoxContainer/Label
@onready var stats = $VBoxContainer/HBoxContainer2/Stats

var transitioning = false

func _ready() -> void:
	transition.visible = true
	label.text = "Baconawa won!" if G.moons == 7 else "The Ghosts won!"
	stats.text = "%s moons collected\n%s time remaining" % [G.moons, G.display_time(G.time)]
	var tween = create_tween()
	tween.tween_property(transition, "color", Color(0,0), 1).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	transition.visible = false

func change_game_scene(path: String):
	if not transitioning:
		transition.visible = true
		var tween = create_tween()
		tween.tween_property(transition, "color", Color(0, 1), 1).set_ease(Tween.EASE_IN_OUT)
		await tween.finished
		print("HELUR")
		get_tree().change_scene_to_file(path)


func _on_retry_button_up() -> void:
	print("retrying")
	change_game_scene("res://scenes/screens/sample_scenes/sample_scene.tscn")

func _on_quit_button_up() -> void:
	change_game_scene("res://scenes/screens/start.tscn")
