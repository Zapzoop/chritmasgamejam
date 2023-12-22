extends RichTextLabel

var score 

func _ready():
	score = Global.score
	self.text = str(score)
