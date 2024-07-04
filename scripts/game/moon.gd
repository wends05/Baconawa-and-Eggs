extends Sprite2D

class_name Moon
var hello_world = "Hello World"
var is_collected = false
@onready var delay = $Timer
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Baconawa:

		if is_collected:
			return

		body.moons_collected += 1
		position.y -= 10
		scale = Vector2(0.5, 0.5)
		is_collected = true
		delay.start()
		await delay.timeout
		get_parent().remove_child(self)

