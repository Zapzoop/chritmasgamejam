extends Node

var killing 

var child_before_death = [preload("res://assets/sound/ChildBeforeDeath1.wav"),
	preload("res://assets/sound/ChildBeforeDeath2.wav"),
	preload("res://assets/sound/ChildBeforeDeath3.wav"),
	preload("res://assets/sound/ChildBeforeDeath4.wav"),
	preload("res://assets/sound/ChildBeforeDeath5.wav")]

var child_pick_up = [preload("res://assets/sound/ChildPickup1.wav"),
	preload("res://assets/sound/ChildPickup2.wav"),
	preload("res://assets/sound/ChildPickup3.wav"),
	preload("res://assets/sound/ChildPickup4.wav"),
	preload("res://assets/sound/ChildPickup5.wav"),
	preload("res://assets/sound/ChildPickup6.wav")]

var child_quash = [preload("res://assets/sound/ChildSquashed1.wav"),
	preload("res://assets/sound/ChildSquashed2.wav"),
	preload("res://assets/sound/ChildSquashed3.wav")]

var click = [preload("res://assets/sound/Click(release).wav"),
	preload("res://assets/sound/Click(release).wav")]

var drawings_show = [preload("res://assets/sound/DrawingShow1.wav"),
	preload("res://assets/sound/DrawingShow2.wav"),
	preload("res://assets/sound/DrawingShow3.wav"),]

var laught_after_judge = [preload("res://assets/sound/LaughAfterJudgement1.wav"),
	preload("res://assets/sound/LaughAfterJudgement2.wav"),
	preload("res://assets/sound/LaughAfterJudgement3.wav"),]

var metals = [preload("res://assets/sound/MetalImpact1.wav"),
	preload("res://assets/sound/MetalImpact2.wav"),
	preload("res://assets/sound/MetalImpact3.wav"),
	preload("res://assets/sound/MetalImpact4.wav"),

	]

var paper_hides = [preload("res://assets/sound/PaperHide1.wav"),
	preload("res://assets/sound/PaperHide2.wav"),
	preload("res://assets/sound/PaperHide3.wav"),
	preload("res://assets/sound/PaperHide4.wav"),
	]

var paper_shows = [preload("res://assets/sound/PaperShow1.wav"),
	preload("res://assets/sound/PaperShow2.wav"),
	preload("res://assets/sound/PaperShow3.wav"),
	preload("res://assets/sound/PaperShow4.wav"),]

var presents = [preload("res://assets/sound/PileofPresents1.wav"),
	preload("res://assets/sound/PileofPresents2.wav"),
	preload("res://assets/sound/PileofPresents3.wav"),
	]

var santa_files = [preload("res://assets/sound/SantaOpeningFile1.wav"),
	preload("res://assets/sound/SantaOpeningFile2.wav"),
	preload("res://assets/sound/SantaOpeningFile3.wav"),
	preload("res://assets/sound/SantaOpeningFile4.wav"),]
	
var santa_drawings = [preload("res://assets/sound/SantaWhenLookingAtDrawing2.wav"),
	preload("res://assets/sound/SantaWhenLookingAtDrawing1.wav"),
	preload("res://assets/sound/SantaWhenLookingAtDrawing3.wav"),
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$theme.volume_db = Global.volume - 10
	

func _on_theme_finished():
	$theme.play()
	
	
	
func childDeath(what):
	killing = what
	$child_death.stream = child_before_death.pick_random()
	$child_death.play()
	squash()


	
func pick_up():
	$child_pick_up.stream = child_pick_up.pick_random()
	$child_pick_up.play()
	
	
#child squashing
func squash():
	$child_squashed/Timer.start()
	#$/root/Level/gullotine/anvill.play("kill")
func _on_timer_timeout():
	$child_squashed/Timer.stop()
	$child_squashed.stream = child_quash.pick_random()
	$child_squashed.play()
	squish()
	if killing == "anvill":
		metal_special()
	else:
		metal()
	
	
#TO DO!!!!
func drawing_show():
	$drawing_show.stream = drawings_show.pick_random()
	$drawing_show.play()
	

func laugh_judge():
	$laught_judgement.stream = laught_after_judge.pick_random()
	$laught_judgement.play()
	

func lost():
	$lost.play()
	

func metal():
	$metal.stream = metals.pick_random()
	$metal.play()
	

func metal_special():
	$metal2.play()
	

func paper(what):
	if what == "hide":
		$paper.stream = paper_hides.pick_random()
		$paper.play()
	else:
		$paper.stream = paper_hides.pick_random()
		$paper.play()
		$paper/Timer2.start()
		
func present(what):
	if what == "child":
		$presents.stream = presents.pick_random()
		$presents.play()
	else:
		$anvil_pre.play()
	
func squish():
	$squish.stream = presents.pick_random()
	$squish.play()
	
func santa_file():
	$santa_file.stream = santa_files.pick_random()
	$santa_file.play()
	

func _on_timer_2_timeout():
	santa_file()
	$paper/Timer2.stop()



func santa_drawing():
	$santa_drawing.stream = santa_drawings.pick_random()
	$santa_drawing.play()

func _on_ambience_finished():
	$ambience.play()

func rick():
	$rick.play()
