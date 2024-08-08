extends Sprite2D

var speed = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	speed = randi_range(15, 30)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * delta
	if position.x >= 599:
		position.x = -650
		position.y = randi_range(-248, 248)
		speed = randi_range(15, 30)
