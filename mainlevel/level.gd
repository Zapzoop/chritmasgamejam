extends Node2D

var child = preload("res://child/child.tscn")
@onready var pos1 = $Pos1
@onready var pos2 = $Pos2
@onready var pos3 = $Pos3
@onready var pos4 = $Pos4
@onready var pos5 = $Pos5
# Called when the node enters the scene tree for the first time.
func _ready():
	fill_pos()

func fill_pos():
	for i in range(self.get_child_count()):
		var pos = self.get_child(i)
		var child_ins = child.instantiate()
		pos.add_child(child_ins)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
