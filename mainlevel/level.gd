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

func _ready():
	fill_pos()
	Global.levelins = self

func fill_pos():
	for i in range(NUMBER_OF_CHILDREN): #Reducing number of childern
		var pos = self.get_child(i+1) #Adding appropiate index
		if i == 2:
			var anvil_ins = anvil.instantiate()
			pos.add_child(anvil_ins)
			continue
		var child_ins = child.instantiate()
		pos.add_child(child_ins)
		
func move():
	reparentall()
	var childtomove = self.get_children()
	for i in range(NUMBER_OF_CHILDREN):
		var tween = get_tree().create_tween()
		var characters = childtomove[i+1].get_child(0)
		tween.tween_property(characters,"position",Vector2(0,0),0.5).set_ease(Tween.EASE_IN)

func reparentall():
	var pos2child = $Pos2.get_child(0)
	var pos3child = $Pos3.get_child(0)
	
	pos2child.reparent($Pos1,true)
	pos3child.reparent($Pos2,true)
	generatechild()

func generatechild():
	var decided = decider()
	if lost == false:
		if decided == "anvil":
			var child_ins = anvil.instantiate()
			$Pos3.add_child(child_ins)
			return
		else:
			var child_ins = child.instantiate()
			$Pos3.add_child(child_ins)
			return

func decider():
	var probab = ["","","","","","","","","","anvil"]
	var rand = randi_range(0,9)
	return probab[rand]

func gameover():
	$YoureFired.show()
	animplayer.play("death")

func killanim():
	#Playkillanimation
	pass

func _on_an_animation_finished(anim_name):
	if anim_name == "death":
		lost = true
		get_tree().change_scene_to_packed(loose)

func _on_anvill_animation_finished():
	$gullotine/anvill.play("idle",0.7)
