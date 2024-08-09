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
		var lightning_scene = preload("res://scenes/effects/lightning.tscn")
		var lightning_instance = lightning_scene.instantiate()
		add_child(lightning_instance)
		lightning_instance.position = chosen.global_position
		var light_anim = lightning_instance.get_node("AnimatedSprite2D")
		await light_anim.animation_finished
		lightning_instance.queue_free()
		chosen.state_machine.transition_to("Respawning")


