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

func fill_pos():
	for i in range(self.get_child_count()-3): #reducing number of childern
		var pos = self.get_child(i+1) #adding appropiate index
		if i == 2:
			var child_ins = anvil.instantiate()
			pos.add_child(child_ins)
			continue
		var child_ins = child.instantiate()
		pos.add_child(child_ins)
		var child_ins_file = child_ins.report
		child_ins_file.reparent($report,true)
		child_ins_file.newparent = $report
		child_ins_file.position = Vector2(0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
