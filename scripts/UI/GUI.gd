extends Control

@export var baconawa: Baconawa
@onready var portrait = $Baconawa/Portrait
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("action_2"):
		eat()

func eat():
	portrait.play_once("eat", "default")


func _on_timer_timeout():
	portrait.play("default")
