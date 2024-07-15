extends Node2D

class_name Game

var game_finished = false

signal game_ended
@export var baconawa : Baconawa
@export var timer: Timer
@export var ui : UI
@onready var transition = ui.transition

# since i made a slight delay for the fade in transition
# can_check_timer will be true after the fade transition
# can be used in another transition if prefer niyoo
var can_check_timer = false

func _ready() -> void:
	transition.visible = true
	var tween = create_tween()
	tween.tween_property(transition, "color", Color(0, 0), 1).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	timer.start(180)
	transition.visible = false
	can_check_timer = true

# only checks for end game, and emit the game_ended signal to other Nodes

func _process(_delta: float) -> void:
	if ((can_check_timer and timer.is_stopped()) or baconawa.moons_collected == 7) and not game_finished:
		game_ended.emit()
		game_finished = true
		timer.paused = true
		transition.visible = true
		var tween = create_tween()
		tween.tween_property(transition, "color", Color(0, 1), 1).set_ease(Tween.EASE_IN_OUT).set_delay(1)
		await tween.finished
		G.set_results.emit(timer.time_left, baconawa.moons_collected)
		print("game finished")
		get_tree().change_scene_to_file("res://scenes/screens/end_game.tscn")



# debug code

func _on_button_button_up() -> void:
	baconawa.moons_collected = 7

func _on_button_2_button_up() -> void:
	timer.stop()
