extends Node2D

@export var baconawa: Baconawa
@onready var cd = $Cooldown
var moons_spawned = 0

var moons: Array[Moon] = []
func _ready() -> void:
	baconawa.moon_collected.connect(add_moon.bind(true))
	# tinak an akomag buhat spawners so...
	for moon in get_children():
		if not moon is Moon:
			continue
		moons.append(moon)
		remove_child(moon)
	moons.shuffle()
	add_child(moons.pop_front())
	while moons and G.baconawa_win == null and moons_spawned < 7:
		reset_timer()
		await cd.timeout
		add_moon()


func add_moon(isCollected = null):
	print(isCollected, get_child_count(), " ", get_children().size())
	if isCollected and get_child_count() > 2:
		return
	moons_spawned += 1
	if get_child_count() <= 3:
		call_deferred("add_child", moons.pop_front())
	reset_timer()

func reset_timer():
	cd.start(randi_range(27,33))
