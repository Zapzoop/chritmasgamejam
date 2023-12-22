extends Control

@onready var sfx = $/root/Level/sounds

func _ready():
	sfx.paper("")

func _on_nice_pressed():
	$anim.play("close")

func _on_anim_animation_finished(anim_name):
	if anim_name == "close":
		get_parent().remove_child(self)
	sfx.paper("hide")
