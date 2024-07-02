extends Label

@export var baconawa: Baconawa

func _process(delta: float) -> void:
	text = "top:%s\ndown:%s\nleft:%s\nright:%s" % [baconawa.top_colliding, baconawa.down_colliding, baconawa.left_colliding, baconawa.right_colliding]
