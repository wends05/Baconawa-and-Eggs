extends CharacterBody2D

class_name BaconawaBody
@export var SPEED: int = 100
@export var head: PackedScene
@onready var anim = $AnimatedSprite2D

func _ready():
	pass
	#Controlcontainer.fst.connect(clr_speed)
	#Controlcontainer.gld.connect(clr_gold)
	#Controlcontainer.ghst.connect(clr_ghost)
	#Controlcontainer.nrml.connect(clr_normal)
	#clr_normal()

func _physics_process(_delta) -> void:
	var head_parent = get_parent()
	for i in head_parent.get_child_count():
		if i > 6:
			var x = get_parent().get_child(i)
			x.global_position = head_parent.position_array[-10*(i-6)]


func clr_normal():
	anim.material.set_shader_parameter("red1B", Controlcontainer.bacon_color[0][0])
	anim.material.set_shader_parameter("red2B", Controlcontainer.bacon_color[0][1])
	anim.material.set_shader_parameter("red3B", Controlcontainer.bacon_color[0][2])
	anim.material.set_shader_parameter("fat1B", Controlcontainer.bacon_color[0][3])
	anim.material.set_shader_parameter("fat2B", Controlcontainer.bacon_color[0][4])

func clr_speed():
	anim.material.set_shader_parameter("fat1B", Controlcontainer.bacon_color[1][0])
	anim.material.set_shader_parameter("fat2B", Controlcontainer.bacon_color[1][1])

func clr_ghost():
	anim.material.set_shader_parameter("red1B", Controlcontainer.bacon_color[2][0])
	anim.material.set_shader_parameter("red2B", Controlcontainer.bacon_color[2][1])
	anim.material.set_shader_parameter("red3B", Controlcontainer.bacon_color[2][2])
	anim.material.set_shader_parameter("fat1B", Controlcontainer.bacon_color[2][3])
	anim.material.set_shader_parameter("fat2B", Controlcontainer.bacon_color[2][4])

func clr_gold():
	anim.material.set_shader_parameter("red1B", Controlcontainer.bacon_color[3][0])
	anim.material.set_shader_parameter("red2B", Controlcontainer.bacon_color[3][1])
	anim.material.set_shader_parameter("red3B", Controlcontainer.bacon_color[3][2])
	anim.material.set_shader_parameter("fat1B", Controlcontainer.bacon_color[3][3])
	anim.material.set_shader_parameter("fat2B", Controlcontainer.bacon_color[3][4])
