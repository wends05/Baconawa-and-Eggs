extends Node2D

class_name RiceHandler

@export var baconawa : Baconawa
@onready var timer = $Timer

func _ready() -> void:
	baconawa.kill_someone.connect(kill_someone)

func kill_someone():
	var get_rice = get_children().filter(func(child): return child if child is Rice else null)
	var chosen : Rice = get_rice.pick_random()
	if chosen is Rice:
		chosen.state_machine.transition_to("Respawning")


