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
		if decided == "anvil":
			var child_ins = anvil.instantiate()
			$child.add_child(child_ins)
			animplayer.play("moveChild")
			return
		else:
			var child_ins = child.instantiate()
			$child.add_child(child_ins)
			animplayer.play("moveChild")
			return

func decider():
	var probab = ["","","","","","","","","","anvil"]
	var rand = randi_range(0,9)
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

func _on_file_pressed():
	if $child.get_child_count():
		sfx.paper("show")
		$child.get_child(0).report.visible = true
		$child.get_child(0).anim.play("open")
