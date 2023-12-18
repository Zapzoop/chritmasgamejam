extends Node

var options = "res://main_menu/option/option.tscn"
var credits = "res://main_menu/credits/credits.tscn"
signal change_scene(caller,callee)
signal callback(callee)

var is_dragging = false

var remember
# Called when the node enters the scene tree for the first time.
func _ready():
	change_scene.connect(_on_change_scene)
	callback.connect(_on_callback)

func _on_change_scene(caller,callee):
	remember = caller.duplicate()
	if callee == "options":
		get_tree().change_scene_to_file(options)
	if callee == "credits":
		get_tree().change_scene_to_file(credits)
	
func _on_callback(calleename,calleeobj):
	if calleename == "options":
		calleeobj.queue_free()
		get_tree().get_root().add_child(remember)
		get_tree().set_current_scene(remember)
	if calleename == "credits":
		calleeobj.queue_free()
		get_tree().get_root().add_child(remember)
		get_tree().set_current_scene(remember)
	remember = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
