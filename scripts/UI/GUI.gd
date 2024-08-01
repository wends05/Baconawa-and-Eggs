extends Control

var state = "default"
@onready var portrait = $Baconawa/Portrait
@onready var baconawa_buff = $Baconawa/Buff/Buff_Icon
@onready var baconawa_nextbuff = $Baconawa/Buff_n/TextureRect
var buff_icons = [
	"res://assets/main_sprites/ui/spr_speed.png",
	"res://assets/main_sprites/ui/spr_instakill.png",
	"res://assets/main_sprites/ui/spr_ghost.png",
	"res://assets/main_sprites/ui/spr_invincible.png"
]


func _ready():
	pass
	#%Baconawa.eat.connect(eat)
	


func _process(delta):
	
	buff_identify()
	nextbuff_identify()
	
	if Input.is_action_pressed("action_2"):
		icon_states()
	
	if Input.is_action_pressed("action_2"):
		eat()




#power up icon
func buff_identify ():
	if %Baconawa.moons_collected >= 1:
		match %Baconawa.buffs[0]:
				1: #Speed
					baconawa_buff.texture = load(buff_icons[0])
				2: #instakill
					baconawa_buff.texture = load(buff_icons[1])
				3: #ghost
					baconawa_buff.texture = load(buff_icons[2])
				4: #invincibility
					baconawa_buff.texture = load(buff_icons[3])
				0:
					pass
					

func nextbuff_identify ():
	if %Baconawa.moons_collected >= 2:
		match %Baconawa.buffs[1]:
				1: #Speed
					baconawa_nextbuff.texture = load(buff_icons[0])
				2: #instakill
					baconawa_nextbuff.texture = load(buff_icons[1])
				3: #ghost
					baconawa_nextbuff.texture = load(buff_icons[2])
				4: #invincibility
					baconawa_nextbuff.texture = load(buff_icons[3])
				0:
					pass



#stunned1

#stunned2

#fast

#ghost

#invincible
func icon_states():
	portrait.current_animation = "%s_idle" % state
	portrait.default_anim = "%s_idle" % state
	
#eating animation
func eat():
	portrait.play_once("%s_eat" % state)
