extends Node2D

const NUMBER_OF_CHILDREN = 3

var child = preload("res://character/child/child.tscn")
var anvil = preload("res://character/anvil/anvil.tscn")
var loose = preload("res://assets/scenes&scripts/loose.tscn")
var lost = false
@onready var animplayer = $YoureFired/AnimationPlayer
@onready var presents = $presents
@onready var gullotine = $gullotine
@onready var anvilplayer = $gullotine/anvill
@onready var sfx = $sounds

func _ready():
	Global.levelins = self

func generatechild():
	var decided = decider()
	if lost == false:
		print(decided)
		if decided == "anvil":
			var child_ins = anvil.instantiate()
			$child.add_child(child_ins)
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
	sfx.lost()

func killanim():
	#Playkillanimation
	pass

func _on_an_animation_finished(anim_name):
	if anim_name == "death":
		lost = true
		get_tree().change_scene_to_packed(loose)

func _on_anvill_animation_finished():
	$gullotine/anvill.play("idle",0.7)
