extends Node2D

var child = preload("res://character/child/child.tscn")
var anvil = preload("res://character/anvil/anvil.tscn")
@onready var pos1 = $Pos1
@onready var pos2 = $Pos2
@onready var pos3 = $Pos3
@onready var pos4 = $Pos4
@onready var pos5 = $Pos5
# Called when the node enters the scene tree for the first time.
func _ready():
	fill_pos()
	Global.levelins = self

func fill_pos():
	for i in range(self.get_child_count()-3): #reducing number of childern
		var pos = self.get_child(i+1) #adding appropiate index
		if i == 2:
			var child_ins = anvil.instantiate()
			pos.add_child(child_ins)
			var child_ins_file = child_ins.report
			child_ins_file.reparent($report,true)
			child_ins_file.newparent = $report
			child_ins_file.position = Vector2(0,0)
			continue
		var child_ins = child.instantiate()
		if i == 0:
			child_ins.is_first = true
		pos.add_child(child_ins)
		var child_ins_file = child_ins.report
		child_ins_file.reparent($report,true)
		child_ins_file.newparent = $report
		child_ins_file.position = Vector2(0,0)
		
func move():
	reparentall()
	var child = self.get_children()
	for i in range(5):
		var tween = get_tree().create_tween()
		var characters = child[i+1].get_child(0)
		tween.tween_property(characters,"position",Vector2(0,0),0.2).set_ease(Tween.EASE_OUT)

func reparentall():
	var pos2child = $Pos2.get_child(0)
	var pos3child = $Pos3.get_child(0)
	var pos4child = $Pos4.get_child(0)
	var pos5child = $Pos5.get_child(0)
	
	pos2child.is_first = true
	pos2child.reparent($Pos1,true)
	pos3child.reparent($Pos2,true)
	pos4child.reparent($Pos3,true)
	pos5child.reparent($Pos4,true)
	generatechild()
		

func generatechild():
	var decider = decider()
	if decider == "anvil":
		var child_ins = anvil.instantiate()
		$Pos5.add_child(child_ins)
		var child_ins_file = child_ins.report
		child_ins_file.reparent($report,true)
		child_ins_file.newparent = $report
		child_ins_file.position = Vector2(0,0)
		return
	var child_ins = child.instantiate()
	$Pos5.add_child(child_ins)
	var child_ins_file = child_ins.report
	child_ins_file.reparent($report,true)
	child_ins_file.newparent = $report
	child_ins_file.position = Vector2(0,0)
	return

func decider():
	var probab = ["","","","","","","","","","anvil"]
	var rand = randi_range(0,9)
	return probab[rand]
	
func _process(delta):
	pass
