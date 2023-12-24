extends Control

@onready var sfx = $/root/Level/sounds

func _ready():
	sfx.paper("show")
	$paper/Sprite/Control/story.text = "Good morning, Mr Claus! We are happy to have you working with us!
As this is your first day on the job, here are some guidelines:

Children all around the world have been both naughty and nice,
and it's your job to judge them
Each child has their own file [color=red][click on the child to open it][/color],
this file will contain:
-general information about the child
-good and bad actions the child has done in the past year [color=red][click on the action to get details][/color]
-the child's letter to you [color=red][click letter to open][/color]

After examining a child's file, click [color=red][Judge][/color],
then drag the child to the right if you consider them [color=red][Nice][/color],
or drag the child to the left if you consider them [color=red][Naughty][/color].

PS: Error in judgement will result in [color=red]Immediate Termination[/color] of your contract."
func _on_nice_pressed():
	$anim.play("close")
	sfx.paper("hide")

func _on_anim_animation_finished(anim_name):
	if anim_name == "close":
		get_parent().get_parent().generatechild() ##generate child
		get_parent().remove_child(self)
		
