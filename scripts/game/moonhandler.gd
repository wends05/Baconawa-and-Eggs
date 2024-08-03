extends Node2D

@export var baconawa: Baconawa
@onready var cd= $Cooldown

var moons: Array[Moon] = []
func _ready() -> void:
	get_children().shuffle()
	baconawa.moon_collected.connect(add_moon)
	# tinak an akomag buhat spawners so...
	for moon in get_children():
		if not moon is Moon:
			continue
		moons.append(moon)
		remove_child(moon)
	moons.shuffle()
	add_child(moons.pop_front())

	while moons:
		reset_timer()
		await cd.timeout
		add_child(moons.pop_front())


func add_moon():
	if get_children().size() < 3:
		call_deferred("add_child", moons.pop_front())
	reset_timer()

func reset_timer():
	cd.start(randi_range(10,15))
