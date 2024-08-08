extends Node

#@onready var bacon: Baconawa

var control_contain =[
	["up_1", "down_1", "left_1", "right_1", "action_1"],
	["up_2", "down_2", "left_2", "right_2", "action_2"],
	["up_3", "down_3", "left_3", "right_3", "action_3"],
	["up_4", "down_4", "left_4", "right_4", "action_4"],
]

var bacon_color = [

	[	#normal
		Vector4(0.486,0.137,0.102,1.0),
		Vector4(0.588,0.235,0.196, 1.0),
		Vector4(0.396,0.157,0.157, 1.0),
		Vector4(0.827,0.631,0.463, 1.0),
		Vector4(0.835,0.514,0.286, 1.0),
		Vector4(0.914,0.718,0.549, 1.0),
		Vector4(0.294,0.106,0.075, 1.0)
	],
	[	#speed
		Vector4(0.514,0.961,0.906,1.0),
		Vector4(0.102,0.886,0.886, 1.0),
	],
	[	#ghost
		Vector4(0.486,0.137,0.102,0.3),
		Vector4(0.588,0.235,0.196, 0.3),
		Vector4(0.396,0.157,0.157, 0.3),
		Vector4(0.827,0.631,0.463, 0.3),
		Vector4(0.835,0.514,0.286, 0.3),
		Vector4(0.914,0.718,0.549, 0.3),
		Vector4(0.294,0.106,0.075, 0.3)
	],
	[	#gold
		Vector4(0.796,0.537,0.318,1.0),
		Vector4(0.871,0.631,0.396, 1.0),
		Vector4(0.631,0.369,0.176, 1.0),
		Vector4(0.976,0.824,0.557, 1.0),
		Vector4(0.525,0.357,0.196, 1.0),
		Vector4(0.992,0.902,0.737, 1.0),
		Vector4(1.0,1.0,1.0, 1.0)
	],
]

#signal nrml
#signal ghst
#signal fst
#signal gld
#
#func _ready():
	#bacon.fst.connect(fst_sig)
	#bacon.gld.connect(gld_sig)
	#bacon.ghst.connect(ghst_sig)
	#bacon.nrml.connect(nrml_sig)
	#
#func nrml_sig():
	#nrml.emit()
	#
#func ghst_sig():
	#ghst.emit()
	#
#func fst_sig():
	#fst.emit()
	#
#func gld_sig():
	#gld.emit()
