extends Node

var options = "res://main_menu/option/option.tscn"
var credits = "res://main_menu/credits/credits.tscn"
var level = "res://mainlevel/level.tscn"

signal change_scene(caller,callee)
signal callback(callee)
signal moveforward()

var is_dragging = false

var levelins
var remember
# Called when the node enters the scene tree for the first time.
func _ready():
	change_scene.connect(_on_change_scene)
	callback.connect(_on_callback)
	moveforward.connect(_on_moveforward)

func _on_change_scene(caller,callee):
	remember = caller.duplicate()
	if callee == "options":
		get_tree().change_scene_to_file(options)
	if callee == "credits":
		get_tree().change_scene_to_file(credits)
	if callee == "level":
		get_tree().change_scene_to_file(level)
	
func _on_callback(calleename,calleeobj):
	if calleename == "options":
		calleeobj.queue_free()
		get_tree().get_root().add_child(remember)
		get_tree().set_current_scene(remember)
	if calleename == "credits":
		calleeobj.queue_free()
		get_tree().get_root().add_child(remember)
		get_tree().set_current_scene(remember)
	if calleename == "level":
		calleeobj.queue_free()
		get_tree().get_root().add_child(remember)
		get_tree().set_current_scene(remember)
	remember = null
	
func _on_moveforward():
	levelins.move()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
