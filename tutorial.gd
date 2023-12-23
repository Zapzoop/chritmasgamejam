extends Control

@onready var sfx = $/root/Level/sounds

func _ready():
	sfx.paper("show")

func _on_nice_pressed():
	$anim.play("close")
	sfx.paper("hide")

func _on_anim_animation_finished(anim_name):
	if anim_name == "close":
		get_parent().get_parent().generatechild()
		get_parent().remove_child(self)
		
