extends CanvasLayer

var ispaused = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	if Input.is_action_just_pressed("pause") and !ispaused:
		self.visible = true
		get_tree().paused = true
		ispaused=true
	elif Input.is_action_just_pressed("pause") and ispaused:
		self.visible = false
		ispaused=false
		get_tree().paused = false
func _on_button_2_pressed():
	Global.emit_signal("change_scene",self,"options")


func _on_button_pressed():
	get_tree().quit()
