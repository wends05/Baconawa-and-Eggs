extends Node2D

var drum = preload("res://scenes/collectibles/drum.tscn")
var lantern = preload("res://scenes/collectibles/lantern.tscn")
var barrier = preload("res://scenes/collectibles/barrier.tscn")
var current = 0
var spawners: Array[Node2D]

@onready var cd = $Cooldown


func _ready() -> void:

	for child in get_children():
		if child is Node2D:
			spawners.append(child)
			child.child_exiting_tree.connect(add_item.unbind(1))
	spawners.shuffle()
	while G.baconawa_win == null:
		add_item()
		reset_timer()
		await cd.timeout

func getRandom() -> PackedScene:
	return [
		drum, 
		lantern, 
		barrier
		].pick_random()

func add_item():
	var spawned = 0
	for spawner in get_children():
		if not spawner.get_child_count() == 0:
			spawned += 1

	if spawned > 2:
		return
	reset_timer()
	var random = getRandom().instantiate()
	if not random is Item:
		return
	spawners[current].add_child(random)
	current = (current + 1) % spawners.size()

func reset_timer():
	cd.start(randi_range(10, 15))
