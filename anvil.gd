extends Control

var anvil_things = ["destroyed a game jam",
	"was voted 'Worst Object Ever' this year",
	"ruined everyone's plans",
	"was just awful for people's imaginations",
	"brought down Christmas",
	"removed happiness",
	"created several teams to squabble"]
var all = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(5):
		var anv = anvil_things.pick_random()
		while all.has(anv):
			anv = anvil_things.pick_random()
		all.append(anv)
			
	$"paper/just untile we get the texture/Control/story".text +="has "+ "[color=red][url]"+ all[0]+ "[/url][/color]" + " and " + "[color=red][url]"+ all[1]+ "[/url][/color]" + ". Furthermore, the list goes on stating that this kid "
	for x in range(2,5):
		$"paper/just untile we get the texture/Control/story".text += ",[color=red] [url]"  + all[x] + "[/url][/color]"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_nice_pressed():
	pass # Replace with function body.


func _on_close_pressed():
	pass # Replace with function body.
