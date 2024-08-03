extends CharacterBody2D

class_name BaconawaBody
@export var SPEED: int = 100
@export var head: Baconawa
@export var next: BaconawaBodyDos

var positionarr = []

func _ready():
	positionarr.append(head.position)

func position_change():
	if positionarr[0] == positionarr[1]:
		positionarr.pop_front()
	position = positionarr[0]

func _physics_process(_delta) -> void:
	if head:
		if head.velocity == Vector2(0, 0):
			velocity = Vector2(0, 0)
		else:
			position_change()

		next.positionarr.append(position)
		if next.positionarr.size() > 10:
			next.positionarr.pop_front()
	else:
		print("KYS")
