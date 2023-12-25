extends AudioStreamPlayer2D

var enters = [preload("res://assets/sound/MenuEnterSublevel1.wav"),
	preload("res://assets/sound/MenuEnterSublevel2.wav"),
	preload("res://assets/sound/MenuEnterSublevel3.wav")]
	
var exists = [preload("res://assets/sound/MenuExitSublevel1.wav"),
	preload("res://assets/sound/MenuExitSublevel2.wav"),
	preload("res://assets/sound/MenuExitSublevel3.wav")]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func enter():
	stream = enters.pick_random()
	play()
	
func exit():
	stream = exists.pick_random()
	play()
