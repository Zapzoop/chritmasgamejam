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

func _on_theme_finished():
	$theme.play()
