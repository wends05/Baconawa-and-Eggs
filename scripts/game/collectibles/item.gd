extends Sprite2D

class_name Item

var is_collected = false
@export var item_name: String


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Rice:
		if is_collected: return
		is_collected = true

		var tween = create_tween()
		tween.parallel().tween_property(self, "position:y", -20, 1).as_relative()
		tween.tween_property(self, "modulate:a", 0, 1)
		await tween.finished
		get_parent().remove_child(self)
