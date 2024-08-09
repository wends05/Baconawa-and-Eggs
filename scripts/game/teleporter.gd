extends Node2D

@onready var from = $From
@onready var to = $To


func _on_from_body_entered(body: Node2D) -> void:
	print(body)
	print(typeof(body))
	if body is Baconawa or body is Rice:
		body.global_position = to.global_position
