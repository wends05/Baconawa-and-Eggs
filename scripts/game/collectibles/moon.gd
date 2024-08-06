extends Sprite2D

class_name Moon

# created this in case we use an animation
# and to make sure if the moon is collected already
# and if ever the animation makes the moon move, and
# the baconawa's collisions detects the moon again,
# this will stop another moon to be added to the baconawa.moons_collected

var is_collected = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Baconawa:
		if is_collected:
			return
		is_collected = true

		# animation...

		var tween = create_tween()
		tween.parallel().tween_property(self, "scale", Vector2(0.5, 0.5), 0.5)
		tween.parallel().tween_property(self, "position:y", -20, 1).as_relative()
		tween.tween_property(self, "modulate:a", 0, 1)
		await tween.finished
		get_parent().remove_child(self)
