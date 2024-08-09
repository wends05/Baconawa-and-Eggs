extends Control

class_name UI
@onready var pause_screen = $"Pause Screen"
@export var baconawa : Baconawa
@onready var moons_collected_label = $"HBoxContainer/Moon Info"
@export var timer: Timer
@onready var debugTexts = $"debug stuff"
@onready var transition = $Transition
# Pause screen functions

func _ready() -> void:
	transition.visible = true
	var tween = create_tween()
	tween.tween_property(transition, "color", Color(0,0,0,0), 1).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	transition.visible = false
func _on_resume_button_up() -> void:
	pause_game(false)

func _on_quit_button_up() -> void:
	pause_game(false)
	get_tree().change_scene_to_file("res://scenes/screens/start.tscn")

func _on_pause_button_up() -> void:
	pause_game(true)

func pause_game(isPaused: bool) -> void:
	pause_screen.visible = isPaused
	get_tree().paused = isPaused

# G.display_time is a custom function i made in scripts/g.gd
# all these are just for display of moons collected and time remaining
# also checks if nag pause ang players
func _process(_delta: float) -> void:
	$Time.text = "%s" % G.display_time(ceili(timer.time_left))
	moons_collected_label.text = "%s" % baconawa.moons_collected

	debugTexts.text = "top:%s
	down:%s
	left:%s
	right:%s
	last input:%s
	%s
	%s
	buff cd:%s

	moving_throughwall:%s
	i_t:%s
	buff_t:%s
	ฟbaconawa state:%s
	" % [
		baconawa.top_colliding,
		baconawa.down_colliding,
		baconawa.left_colliding,
		baconawa.right_colliding,
		baconawa.last_input,
		baconawa.buffs,
		baconawa.SPEED,
		baconawa.buff_cooldown,
		baconawa.moving_through_wall,
		baconawa.internal_timer.time_left,
		baconawa.buff_timer.time_left,
		baconawa.state_machine.state.name
		]


func _on_b_win_button_up() -> void:
	baconawa.moons_collected = 7


func _on_r_win_button_up() -> void:
	timer.stop()
