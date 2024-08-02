extends CharacterBody2D

class_name BaconawaBodyDos
@export var SPEED: int = 100
@export var head: Baconawa
@export var follow: BaconawaBody
@export var next: BaconawaBodyTres

var positionarr = []

func _ready():
	positionarr.append(follow.position)

func position_change():
	if positionarr[0] == positionarr[1]:
		positionarr.pop_front()
	position = positionarr[0]

func _physics_process(_delta) -> void:
	if follow:
		if head.velocity == Vector2(0, 0):
			velocity = Vector2(0, 0)
		else:
			position_change()

		next.positionarr.append(position)
		if next.positionarr.size() > 10:
			next.positionarr.pop_front()
	else:
		print("KYS")
