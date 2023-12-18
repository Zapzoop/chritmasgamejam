extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	pass # Replace with function body.


func _on_option_pressed():
	Global.emit_signal("change_scene",self,"options")
	#get_tree().change_scene_to_file("res://main_menu/option.tscn")


func _on_exit_pressed():
	get_tree().quit()


func _on_credits_pressed():
	Global.emit_signal("change_scene",self,"credits")
