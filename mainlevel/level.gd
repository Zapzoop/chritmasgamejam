extends Node2D

const NUMBER_OF_CHILDREN = 3

var count = 0

var child = preload("res://character/child/child.tscn")
var anvil = preload("res://character/anvil/anvil.tscn")
var loose = preload("res://assets/scenes&scripts/loose.tscn")
var lost = false
@onready var animplayer = $YoureFired/AnimationPlayer
@onready var presents = $presents
@onready var gullotine = $gullotine
@onready var anvilplayer = $gullotine/anvill
@onready var sfx = $sounds
@onready var pausemenu = $CanvasLayer
@onready var santaplayer = $Santa

func _ready():
	santaplayer.play("default")
	Global.levelins = self

func generatechild():
	count += 1
	var decided = decider()
	if count == 3:
		decided = "anvil"
	if lost == false:
		print(decided)
		if decided == "anvil":
			var child_ins = anvil.instantiate()
			$child.add_child(child_ins)
			child_ins.anvil_ins()
			animplayer.play("moveChild")
			return
			
		elif decided == "child1":
			var child_ins = child.instantiate()
			var decidecolored = decidecolor()
			$child.add_child(child_ins)
			child_ins.child1(decidecolored)
			animplayer.play("moveChild")
			return
			
		elif decided == "child2":
			var child_ins = child.instantiate()
			var decidecolored = decidecolor()
			$child.add_child(child_ins)
			child_ins.child2(decidecolored)
			animplayer.play("moveChild")
			return
			
		elif decided == "child3":
			var child_ins = child.instantiate()
			var decidecolored = decidecolor()
			$child.add_child(child_ins)
			child_ins.child3(decidecolored)
			animplayer.play("moveChild")
			return
			
		elif decided == "child4":
			var child_ins = child.instantiate()
			var decidecolored = decidecolor()
			$child.add_child(child_ins)
			child_ins.child4(decidecolored)
			animplayer.play("moveChild")
			return

func decidecolor():
	var probab = ["blue","green","pink"]
	var rand = probab.pick_random()
	return rand

func decider():
	var probab = ["child1","child2","child3","child4","child1","child2","child3","child4","anvil"]
	var rand = randi_range(0,8)
	return probab[rand]

func gameover():
	$YoureFired.show()
	animplayer.play("death")
	lost = true
	sfx.lost()

func killanim():
	#Playkillanimation
	pass

func _on_an_animation_finished(anim_name):
	if anim_name == "death":
		get_tree().change_scene_to_packed(loose)

func _on_anvill_animation_finished():
	$gullotine/anvill.play("idle",0.7)
	if Global.current == "Anvil" and Global.currentanimplaying == "anvilanvil":
		generatechild()

func _on_anvill_sprite_frames_changed():
	pass # Replace with function body.




func _on_santa_animation_finished():
	santaplayer.play("default")
