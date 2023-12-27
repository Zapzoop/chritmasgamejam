extends Control

func _on_start_pressed():
	Global.emit_signal("change_scene",self,"level")


func _on_option_pressed():
	Global.emit_signal("change_scene",self,"options")

func _on_exit_pressed():
	get_tree().quit()

func _on_credits_pressed():
	Global.emit_signal("change_scene",self,"credits")

func _ready():
	if not self.is_in_group("loose"):
		$sfx.enter()
	else:
		var hight_score = int(loads())
		if hight_score < Global.score:
			save(Global.score)
		

func _on_theme_finished():
	$theme.play()

func loads():
	var file = FileAccess.open("res://global/hight.txt", FileAccess.READ)
	var content = file.get_as_text()
	return content
	
func save(content):
	var file = FileAccess.open("hight_Score.txt.txt", FileAccess.WRITE)
	file.store_string(str(content))


