extends Control

#baconawa deets
var b_state = "default"
@onready var b_portrait = $Baconawa/Portrait
@onready var baconawa_buff = $Baconawa/Buff/Buff_Icon
@onready var baconawa_nextbuff = $Baconawa/Buff_n/TextureRect
var buff_icons = [
	"res://assets/main_sprites/ui/spr_speed.png",
	"res://assets/main_sprites/ui/spr_instakill.png",
	"res://assets/main_sprites/ui/spr_ghost.png",
	"res://assets/main_sprites/ui/spr_shield.png"
]


#rice deets
@export var rice1 : Rice
@export var rice2 : Rice
@export var rice3 : Rice
@onready var r_portrait = [
	$Rice/Rice1/Portrait,
	$Rice/Rice2/Portrait,
	$Rice/Rice3/Portrait
]
@onready var rice_item = [
	$Rice/Rice1/Item/TextureRect,
	$Rice/Rice2/Item/TextureRect,
	$Rice/Rice3/Item/TextureRect
]



func _ready():
	pass
	%Baconawa.eat.connect(eat)
	%Baconawa.fst.connect(speed_icon)
	%Baconawa.gld.connect(gold_icon)
	%Baconawa.ghst.connect(ghost_icon)
	%Baconawa.nrml.connect(normal_icon)
	%Baconawa.bff.connect(buff_identify)
	%Baconawa.bff_act.connect(buff_icon_remove)


func _process(_delta):
	pass



#power up icon
func buff_identify ():
	if %Baconawa.moons_collected >= 1 and %Baconawa.buffs.size() > 0:
		match %Baconawa.buffs[0]:
				1: #Speed
					baconawa_buff.texture = load(buff_icons[0])
				2: #instakill
					baconawa_buff.texture = load(buff_icons[1])
				3: #ghost
					baconawa_buff.texture = load(buff_icons[2])
				4: #invincibility
					baconawa_buff.texture = load(buff_icons[3])
				_:
					baconawa_buff.texture = null


	if %Baconawa.moons_collected >= 2 and %Baconawa.buffs.size() > 1:
			match %Baconawa.buffs[1]:
				1: #Speed
					baconawa_nextbuff.texture = load(buff_icons[0])
				2: #instakill
					baconawa_nextbuff.texture = load(buff_icons[1])
				3: #ghost
					baconawa_nextbuff.texture = load(buff_icons[2])
				4: #invincibility
					baconawa_nextbuff.texture = load(buff_icons[3])
				_:
					baconawa_nextbuff.texture = null



func buff_icon_remove():
	var current_t = baconawa_nextbuff.texture

	if %Baconawa.buffs.size() == 1:
		baconawa_buff.texture = null
	elif %Baconawa.buffs.size() == 2:
		baconawa_nextbuff.texture = null
		baconawa_buff.texture = current_t



#stunned1

#stunned2

func normal_icon():
	b_state = "default"
	icon_states()

#stunned1

#stunned2

#fast
func speed_icon():
	b_state = "speed"
	icon_states()

#ghost
func ghost_icon():
	b_state = "ghost"
	icon_states()

#invincible
func gold_icon():
	b_state = "gold"
	icon_states()

func icon_states():
	b_portrait.current_animation = "%s_idle" % b_state
	b_portrait.default_anim = "%s_idle" % b_state

#eating animation
func eat():
	b_portrait.play_once("%s_eat" % b_state, "%s_idle" % b_state)
