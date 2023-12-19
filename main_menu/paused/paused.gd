extends CanvasLayer

var ispaused = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("escape") and !ispaused:
		self.visible = true
		get_tree().paused = true
		ispaused=true
	elif Input.is_action_just_pressed("escape") and ispaused:

		self.visible = false
		ispaused=false
		get_tree().paused = false
