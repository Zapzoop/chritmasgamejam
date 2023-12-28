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
		$Score.text = "Score: " + str(Global.score)
	elif Input.is_action_just_pressed("pause") and ispaused:
		self.visible = false
		ispaused=false
		get_tree().paused = false
func _on_button_2_pressed():
	Global.emit_signal("change_scene",self,"options")


func _on_button_pressed():
	if OS.has_feature("web"):
		get_tree()->call_deferred("quit")
	else:
		get_tree().quit()


func _on_button_3_pressed():
	self.visible = false
	ispaused=false
	get_tree().paused = false
