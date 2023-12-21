extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_nice_pressed():
	$anim.play("close")
	


func _on_anim_animation_finished(anim_name):
	if anim_name == "close":
		get_parent().remove_child(self)
