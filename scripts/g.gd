extends Node

signal set_results(time: int, moons: int)

var time = 0
var moons = 0
var baconawa_win = null

func display_time(time_left: int):
	var minutes = floori(time_left / 60)
	var seconds = time_left % 60
	return "%s min %s sec" % [minutes, seconds]

func _ready() -> void:
	set_results.connect(final_results)

func final_results(time_ended: int, moons_collected: int):
	time = time_ended
	moons = moons_collected

func save_data():
	pass

func reset_stats():
	time = 0
	moons = 0
	baconawa_win = false
