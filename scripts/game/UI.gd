extends Control

@onready var pause_screen = $"Pause Screen"
@onready var baconawa : Baconawa = $"../Baconawa"
@onready var moons_collected_label = $"HBoxContainer/Moon Info"
@onready var timer = $"../Timer"

# Pause screen functions

func _on_resume_button_up() -> void:
	pause_game(false)

func _on_quit_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/start.tscn")

func _on_pause_button_up() -> void:
	pause_game(true)

func pause_game(isPaused: bool) -> void:
	pause_screen.visible = isPaused
	get_tree().paused = isPaused

# G.display_time is a custom function i made in scripts/g.gd
# all these are just for display of moons collected and time remaining
# also checks if nag pause ang players
func _process(delta: float) -> void:
	$Time.text = "%s" % G.display_time(ceili(timer.time_left))
	moons_collected_label.text = "%s" % baconawa.moons_collected
	if Input.is_action_just_released("esc"):
		pause_game(not get_tree().paused)

