extends Node2D

var volume = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for x in get_children():
		if x.playing == false:
			x.play()
			
func play():
	for x in get_children():
		if x.playing == false:
			x.play()
