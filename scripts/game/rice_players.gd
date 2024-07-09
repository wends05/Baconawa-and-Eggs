extends Node2D

class_name RiceHandler

@export var baconawa : Baconawa
@onready var timer = $Timer
func _ready() -> void:
	if not baconawa: baconawa = $"../Baconawa"
	baconawa.kill_someone.connect(kill_someone)

func kill_someone():
	var get_rice = get_children().filter(func(child): return child if child is Rice else null)
	var chosen = get_rice.pick_random()
	if chosen is Rice:
		chosen.respawn()


