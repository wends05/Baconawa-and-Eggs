extends CharacterBody2D

class_name BaconawaBody
@export var SPEED: int = 100
@onready var anim = $AnimatedSprite2D

func _ready():
	var shader = load("res://scripts/shaders/baconawa.gdshader")
	var shader_mat = ShaderMaterial.new()
	shader_mat.shader = shader
	anim.material = shader_mat
	var head_node = get_parent()
	head_node.fst.connect(clr_speed)
	head_node.gld.connect(clr_gold)
	head_node.ghst.connect(clr_ghost)
	head_node.nrml.connect(clr_normal)
	clr_normal()

func _physics_process(_delta) -> void:
	var head_parent = get_parent()

	var i = get_index()
	global_position = head_parent.position_array[-10*(i-7)]
	match head_parent.input_array[-10*(i-7)]:
		"up":
			anim.play("body_up")
			anim.flip_h = false
		"down":
			anim.play("body_down")
			anim.flip_h = false
		"left":
			anim.play("body_side")
			anim.flip_h = false
		"right":
			anim.play("body_side")
			anim.flip_h = true
		"":
			anim.play("body_side")
			anim.flip_h = false
	

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
