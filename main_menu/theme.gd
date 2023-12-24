extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	volume_db = Global.volume -10
	if playing == false:
		play()

