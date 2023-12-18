extends Node

var options = "res://main_menu/option/option.tscn"
signal change_scene(caller,callee)
signal callback(callee)

var remember
# Called when the node enters the scene tree for the first time.
func _ready():
	change_scene.connect(_on_change_scene)
	callback.connect(_on_callback)

func _on_change_scene(caller,callee):
	print("emitted 2.0")
	remember = caller.duplicate()
	if callee == "options":
		get_tree().change_scene_to_file(options)
	
func _on_callback(calleename,calleeobj):
	if calleename == "options":
		print("received")
		print(remember)
		calleeobj.queue_free()
		get_tree().get_root().add_child(remember)
		get_tree().set_current_scene(remember)
	remember = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
