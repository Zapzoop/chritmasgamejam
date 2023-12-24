extends Node

var score = 0
var volume = 0
var options = "res://main_menu/option/option.tscn"
var credits = "res://main_menu/credits/credits.tscn"
var level = "res://mainlevel/level.tscn"

signal change_scene(caller,callee)
signal callback(callee)
signal moveforward()

signal playkillchild()
signal playkillanvil()
signal gameover()

signal modulatepresents()
signal modulategullotine()
signal modulatebackgullotine()
signal modulatebackpresents()

signal anvilchild()
signal presentschild()
signal anvilanvil()
signal presentsanvil()

var levelins
var remember
var current
# Called when the node enters the scene tree for the first time.
func _ready():
	change_scene.connect(_on_change_scene)
	callback.connect(_on_callback)
	moveforward.connect(_on_moveforward)
	playkillchild.connect(_on_playkillchild)
	playkillanvil.connect(_on_playkillanvil)
	gameover.connect(_on_gameover)
	
	modulatepresents.connect(_on_modulatepresents)
	modulategullotine.connect(_on_modulategullotine)
	modulatebackgullotine.connect(_on_modulatebackgullotine)
	modulatebackpresents.connect(_on_modulatebackpresents)
	
	anvilchild.connect(_on_anvilchild)
	presentschild.connect(_on_presentschild)
	anvilanvil.connect(_on_anvilanvil)
	presentsanvil.connect(_on_presentsanvil)
	
func _on_anvilchild():
	pass

func _on_presentschild():
	pass

func _on_anvilanvil():
	levelins.anvilplayer.play("anvilkill")

func _on_presentsanvil():
	pass
	
func _on_modulatepresents():
	levelins.presents.modulate = Color(Color.DARK_GOLDENROD,0.4)
	
func _on_modulategullotine():
	levelins.gullotine.modulate = Color(Color.DARK_GOLDENROD,0.4)

func _on_modulatebackgullotine():
	levelins.gullotine.modulate = Color(Color.WHITE,1)
	
func _on_modulatebackpresents():
	levelins.presents.modulate = Color(Color.WHITE,1)

func _on_playkillanvil():
	#DO playkill animation of anvil
	pass

func _on_playkillchild():
	levelins.anvilplayer.play("kill")

func _on_gameover():
	levelins.gameover()

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
	levelins.generatechild()
	

