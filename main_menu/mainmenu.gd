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


func _on_start_mouse_entered():
	$VBoxContainer/start.modulate = Color(2,1,1,1)

func _on_option_mouse_entered():
	$VBoxContainer/option.modulate = Color(1,2,1,1)

func _on_credits_mouse_entered():
	$VBoxContainer/credits.modulate = Color(1,2,1,1)

func _on_exit_mouse_entered():
	$VBoxContainer/exit.modulate = Color(1,2,1,1)

func _on_exit_mouse_exited():
	$VBoxContainer/exit.modulate = Color(1,1,1,1)

func _on_option_mouse_exited():
	$VBoxContainer/option.modulate = Color(1,1,1,1)

func _on_start_mouse_exited():
	$VBoxContainer/start.modulate = Color(1,1,1,1)

func _on_credits_mouse_exited():
	$VBoxContainer/credits.modulate = Color(1,1,1,1)
