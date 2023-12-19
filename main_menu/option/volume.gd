extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = $/root/base.volume_db + 80



func _on_minus_pressed():
	$/root/base.volume_db -= 5


func _on_plus_pressed():
	$/root/base.volume_db += 5
