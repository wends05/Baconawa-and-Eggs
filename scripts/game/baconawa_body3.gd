extends CharacterBody2D

class_name BaconawaBodyTres
@export var SPEED: int = 100
@export var head: Baconawa
@export var follow: BaconawaBodyDos
@onready var anim = $AnimatedSprite2D

var positionarr = []

func _ready():

	%Baconawa.fst.connect(clr_speed)
	%Baconawa.gld.connect(clr_gold)
	%Baconawa.ghst.connect(clr_ghost)
	%Baconawa.nrml.connect(clr_normal)
	clr_normal()
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
	else:
		print("KYS")


func clr_normal():
	anim.material.set_shader_parameter("red1B", head.bacon_color[0][0])
	anim.material.set_shader_parameter("red2B", head.bacon_color[0][1])
	anim.material.set_shader_parameter("red3B", head.bacon_color[0][2])
	anim.material.set_shader_parameter("fat1B", head.bacon_color[0][3])
	anim.material.set_shader_parameter("fat2B", head.bacon_color[0][4])

func clr_speed():
	anim.material.set_shader_parameter("fat1B", head.bacon_color[1][0])
	anim.material.set_shader_parameter("fat2B", head.bacon_color[1][1])

func clr_ghost():
	anim.material.set_shader_parameter("red1B", head.bacon_color[2][0])
	anim.material.set_shader_parameter("red2B", head.bacon_color[2][1])
	anim.material.set_shader_parameter("red3B", head.bacon_color[2][2])
	anim.material.set_shader_parameter("fat1B", head.bacon_color[2][3])
	anim.material.set_shader_parameter("fat2B", head.bacon_color[2][4])

func clr_gold():
	anim.material.set_shader_parameter("red1B", head.bacon_color[3][0])
	anim.material.set_shader_parameter("red2B", head.bacon_color[3][1])
	anim.material.set_shader_parameter("red3B", head.bacon_color[3][2])
	anim.material.set_shader_parameter("fat1B", head.bacon_color[3][3])
	anim.material.set_shader_parameter("fat2B", head.bacon_color[3][4])
