extends Control

#baconawa deets
var b_state = "default"
@onready var cooldownbar = $Baconawa/Buff/ProgressBar
@onready var b_portrait = $Baconawa/Portrait
@onready var baconawa_buff = $Baconawa/Buff/Buff_Icon
@onready var baconawa_nextbuff = $Baconawa/Buff_n/TextureRect
@onready var cdcover = $Baconawa/Buff/cd_block
var buff_icons = [
	"res://assets/main_sprites/ui/spr_speed.png",
	"res://assets/main_sprites/ui/spr_instakill.png",
	"res://assets/main_sprites/ui/spr_ghost.png",
	"res://assets/main_sprites/ui/spr_shield.png"
]

var prog_val = 0
var is_cd = false
var cd_speed = 1 #/deduct that percent of overall

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
var item_icons = [
	"res://assets/main_sprites/item/spr_lantern.png",
	"res://assets/main_sprites/item/spr_drum.png"
]


func _ready():
	%Baconawa.eat.connect(eat)
	%Baconawa.fst.connect(speed_icon)
	%Baconawa.gld.connect(gold_icon)
	%Baconawa.ghst.connect(ghost_icon)
	%Baconawa.nrml.connect(normal_icon)
	%Baconawa.bff.connect(buff_identify)
	%Baconawa.bff_act.connect(buff_icon_remove)
	%Baconawa.stn.connect(stun_burn)
	%Baconawa.cnfsd.connect(stun_bird)
	
	rice1.alive.connect(rice1_respawn)
	rice2.alive.connect(rice2_respawn)
	rice3.alive.connect(rice3_respawn)
	rice1.die.connect(rice1_die)
	rice2.die.connect(rice2_die)
	rice3.die.connect(rice3_die)
	rice1.pickup.connect(r1_item_identify)
	rice2.pickup.connect(r2_item_identify)
	rice3.pickup.connect(r3_item_identify)
	rice1.use.connect(r1_item_use)
	rice2.use.connect(r2_item_use)
	rice3.use.connect(r3_item_use)

func _process(_delta):
	cooldownbar.value = prog_val
	if is_cd:
		prog_val -= cd_speed
		if prog_val <= 0:
			cdcover.hide()
			is_cd = false

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
		run_cd()
		
	elif %Baconawa.buffs.size() == 2:
		baconawa_nextbuff.texture = null
		baconawa_buff.texture = current_t
		run_cd()

func run_cd():
	cdcover.show()
	is_cd = true
	prog_val = 360

#stunned1
func stun_burn():
	b_portrait.play("burn_stunned")

#stunned2
func stun_bird():
	b_portrait.play("bird_stunned")

#normal
func normal_icon():
	b_state = "default"
	icon_states()

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
	






#rice respawn
func rice1_respawn():
	r_portrait[0].play_once("default_revive", "default_idle")
func rice2_respawn():
	r_portrait[1].play_once("default_revive", "default_idle")
func rice3_respawn():
	r_portrait[2].play_once("default_revive", "default_idle")

#rice items
func rice1_die():
	r_portrait[0].play_once("default_die", "default_dead")
func rice2_die():
	r_portrait[1].play_once("default_die", "default_dead")
func rice3_die():
	r_portrait[2].play_once("default_die", "default_dead")
	

func r1_item_identify ():
	if rice1.item != null:
		match rice1.item.item_name:
					"Drum":
						rice_item[0].texture = load(item_icons[1])
					#"Lantern":
					"Flashlight":
						rice_item[0].texture = load(item_icons[0])
					"Barrier":
						rice_item[0].texture = null
func r2_item_identify ():
	if rice2.item != null:
		match rice2.item.item_name:
					"Drum":
						rice_item[1].texture = load(item_icons[1])
					#"Lantern":
					"Flashlight":
						rice_item[1].texture = load(item_icons[0])
					"Barrier":
						rice_item[1].texture = null
func r3_item_identify ():
	if rice3.item != null:
		match rice3.item.item_name:
					"Drum":
						rice_item[2].texture = load(item_icons[1])
					#"Lantern":
					"Flashlight":
						rice_item[2].texture = load(item_icons[0])
					"Barrier":
						rice_item[2].texture = null

func r1_item_use ():
	rice_item[0].texture = null
func r2_item_use ():
	rice_item[1].texture = null
func r3_item_use ():
	rice_item[2].texture = null
