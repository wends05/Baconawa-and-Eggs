extends Control
@onready var bgmsc = $BG_music
@onready var sfx = $sfx

func _ready():
	bgmsc.play()

func _on_play_button_up() -> void:
		sfx.stream = load("res://assets/sfx/sfx_select.wav")
		sfx.play()
		await sfx.finished
		bgmsc.stop()
		get_tree().change_scene_to_file("res://scenes/screens/instructions_start.tscn")

func _on_instructions_button_up() -> void:
	sfx.stream = load("res://assets/sfx/sfx_select.wav")
	sfx.play()
	await sfx.finished
	bgmsc.stop()
	get_tree().change_scene_to_file("res://scenes/screens/credits.tscn")


func _on_quit_button_up():
	sfx.stream = load("res://assets/sfx/sfx_select.wav")
	sfx.play()
	await sfx.finished
	get_tree().quit()

func _on_play_mouse_entered():
	sfx.play()
