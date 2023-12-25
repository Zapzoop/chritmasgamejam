extends AudioStreamPlayer2D

var clicks = [preload("res://assets/sound/Click(release).wav"),
	preload("res://assets/sound/Click(release).wav")]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("click"):
		click(0)
	elif Input.is_action_just_released("click"):
		click(1)
		
func click(mode):
	stream = clicks[mode]
	play()
