extends Label

@export var baconawa: Baconawa

func _process(_delta: float) -> void:
	text = "top:%s
	down:%s
	left:%s
	right:%s

	last input:%s
	%s
	%s" % [
		baconawa.top_colliding,
		baconawa.down_colliding,
		baconawa.left_colliding,
		baconawa.right_colliding,
		baconawa.last_input,
		baconawa.BUFFS[baconawa.buff_id],
		baconawa.SPEED
		]
