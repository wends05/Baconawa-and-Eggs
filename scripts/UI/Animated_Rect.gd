@tool
class_name Animated_Rect
extends TextureRect


@export var sprites : SpriteFrames
@export var default_anim = "default_idle"
@export var current_animation = default_anim
@export var frame_index = 0
@export_range(0.0, INF, 0.001) var speed_scale := 1.0
@export var auto_play := false
@export var playing := false
var refresh_rate = 1.0
var fps = 30.0
var frame_delta = 0
var one_play = false


# Called when the node enters the scene tree for the first time.
func _ready():
	fps = sprites.get_animation_speed(current_animation)
	refresh_rate = sprites.get_frame_duration(current_animation, frame_index)
	if auto_play:
		play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if sprites == null or playing == false:
		return
	
	if sprites.has_animation(current_animation) == false:
		playing = false
		assert(false,"Animation %s, Doesn't Exist" % current_animation)
		
	get_animation_data(current_animation)
	frame_delta += (speed_scale * delta)
	if frame_delta >= refresh_rate/fps:
		texture = get_next_frame()
		frame_delta = 0.0



#play
func play(animation_name :String= current_animation):
	frame_index = 0
	frame_delta = 0.0
	current_animation = animation_name
	get_animation_data(current_animation)
	playing = true
	

#play once then default
func play_once(animation :String, nextanimation :String):
	one_play = true
	default_anim = nextanimation
	play(animation)

#animdata
func get_animation_data(animation):
	fps = sprites.get_animation_speed(current_animation)
	refresh_rate = sprites.get_frame_duration(current_animation, frame_index)
	
#next frame
func get_next_frame():
	frame_index += 1
	var frame_count = sprites.get_frame_count(current_animation)
	if frame_index >= frame_count:
		if one_play:
			one_play = false
			play(default_anim)
		else:
			frame_index = 0
		if not sprites.get_animation_loop(current_animation):
			playing = false
	get_animation_data(current_animation)
	return sprites.get_frame_texture(current_animation, frame_index)
	

#continue
func resume():
	playing = true
	
#pause
func pause():
	playing = false
#stop
func stop():
	frame_index = 0
	playing = false
