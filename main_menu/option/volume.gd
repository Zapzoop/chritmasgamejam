extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = Global.volume



func _on_minus_pressed():
	Global.volume -= 5


func _on_plus_pressed():
	Global.volume += 5


func _on_button_pressed():
	pass # Replace with function body.
