extends CharacterBody2D


var dragged = false

var can_move = false
var is_moving = false

var is_inside_dropable = false

var body_ref

var initialPos : Vector2

var child_score = 0

var clicked = false

var currentanim

var anvildown = false

var offset

@onready var sprite = $Sprite2D
@onready var report = $ReportFile
@onready var anim = $ReportFile/Animation
@onready var sfx = $/root/Level/sounds
@onready var anvilspri = $AnvilSprite

func _ready():
	report.parent = self
	report.create_child()

func _physics_process(delta):
	if Input.is_action_just_pressed("click") and can_move and !clicked:
		Global.levelins.sfx.paper("show")
		Global.levelins.sfx.santa_file()
		report.visible = true
		anim.play("open")
	if Input.is_action_just_pressed("click") and can_move and clicked:
		initialPos = self.global_position
		is_moving = true
		offset = Vector2(76,-46) - position 
		if self.is_in_group("anvil"):
			offset = Vector2(76,-46) - position 
		sfx.pick_up()
	elif Input.is_action_pressed("click") and is_moving:
		dragged = true
		scaledown()
		if self.is_in_group("anvil"):
			var string = Global.current +  "Dragged"
			anvilspri.position = Vector2(-192,156)
			anvilspri.play(string)
			currentanim = string
		else:
			var string = Global.current + "Dragged"
			sprite.position = Vector2(-192,136)
			sprite.play(string)
			currentanim = string
		global_position = lerp(global_position - Vector2(56,-26), get_global_mouse_position(),25*delta)
	elif Input.is_action_just_released("click") and is_moving:
		dragged = false
		if self.is_in_group("anvil"):
			var string = Global.current +  "Idle"
			anvilspri.position = Vector2(0,0)
			anvilspri.play(string)
			currentanim = string
		else:
			var string = Global.current + "Idle"
			sprite.position = Vector2(0,0)
			sprite.play(string)
			currentanim = string
		if is_inside_dropable:
			sfx.laugh_judge()
			if self.is_in_group("anvil"):
				if (self.global_position.x < $/root/Level/center.global_position.x):
					anvil_on_anvil()
					Global.emit_signal("playkillanvil")
					sfx.childDeath("anvill")
					Global.score += 5
					self.queue_free()
				else:
					sfx.present("anvill")
					anvildown = true
					scaledown()
					presents_on_anvil()
					
			else:
				if ((self.child_score > 0) and (self.global_position.x > $/root/Level/center.global_position.x)) or ((self.child_score < 0) and (self.global_position.x < $/root/Level/center.global_position.x)):
					if self.global_position.x < $/root/Level/center.global_position.x:
						put_on_anvil_child()
						sfx.childDeath("child")
						Global.emit_signal("playkillchild")
					if self.global_position.x > $/root/Level/center.global_position.x:
						put_on_presents_child()
						sfx.present("child")
					Global.score += 5
				else:
					Global.emit_signal("gameover")
					if self.global_position.x < $/root/Level/center.global_position.x:
						put_on_anvil_child()
					if self.global_position.x > $/root/Level/center.global_position.x:
						put_on_presents_child()
		else:
			reset()
		is_moving = false
	
func put_on_anvil_child():
	sprite.global_position = Vector2(512,344)
	Global.emit_signal("anvilchild")
	var string = Global.current + "Anvil"
	currentanim = string
	sprite.play(string)

func put_on_presents_child():
	sprite.global_position = Vector2(488,376)
	Global.emit_signal("presentschild")
	var string = Global.current + "Presents"
	currentanim = string
	sprite.play(string)

func anvil_on_anvil():
	Global.emit_signal("anvilanvil")

func presents_on_anvil():
	anvilspri.global_position = Vector2(576,320)
	anvilspri.global_scale = Vector2(5,5)
	#anvilspri.set_scale(Vector2(1.605,1.605))
	Global.emit_signal("presentsanvil")
	var string = Global.current + "PAresents"
	currentanim = string
	anvilspri.play(string)

func reset():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position",Vector2(488,440),0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_mouse_entered():
	can_move = true
	if !dragged:
		scaleup()

func _on_area_2d_mouse_exited():
	can_move = false
	if !dragged:
		scaledown()

func scaleup():
	var tween = get_tree().create_tween()
	if self.is_in_group("anvil"):
		tween.tween_property(anvilspri,"scale",Vector2(0.55,0.55),0.2).set_ease(Tween.EASE_IN)
	else:
		tween.tween_property(sprite,"scale",Vector2(0.55,0.55),0.2).set_ease(Tween.EASE_IN)

func scaledown():
	var tween = get_tree().create_tween()
	if self.is_in_group("anvil"):
		if !anvildown:
			tween.tween_property(anvilspri,"scale",Vector2(0.5,0.5),0.2).set_ease(Tween.EASE_OUT)
		elif anvildown:
			tween.tween_property(anvilspri,"scale",Vector2(0.605,0.605),0.2).set_ease(Tween.EASE_OUT)
	else:
		tween.tween_property(sprite,"scale",Vector2(0.5,0.5),0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_body_entered(body):
	if body.is_in_group("dropable"):
		is_inside_dropable = true
		if body.is_in_group("gullotine"):
			Global.emit_signal("modulatepresents")
		if body.is_in_group("presents"):
			Global.emit_signal("modulategullotine")
		body.modulate = Color(Color.DARK_GOLDENROD,1)
		body_ref = body

func _on_area_2d_body_exited(body):
	if body.is_in_group("dropable"):
		is_inside_dropable = false
		if body.is_in_group("gullotine"):
			Global.emit_signal("modulatebackpresents")
		if body.is_in_group("presents"):
			Global.emit_signal("modulatebackgullotine")
		body.modulate = Color(Color.WHITE,1)
		body_ref = body

func anvil_ins():
	anvilspri.play("AnvilIdle")
	Global.current = "Anvil"

func child1(color):
	match color:
		"blue":
			sprite.play("Child1BlueIdle")
			currentanim = "Child1BlueIdle"
			Global.current = "Child1Blue"
		"green":
			sprite.play("Child1GreenIdle")
			currentanim = "Child1GreenIdle"
			Global.current = "Child1Green"
		"pink":
			sprite.play("Child1PinkIdle")
			currentanim = "Child1PinkIdle"
			Global.current = "Child1Pink"

func child2(color):
	match color:
		"blue":
			sprite.play("Child2BlueIdle")
			currentanim = "Child2BlueIdle"
			Global.current = "Child2Blue"
		"green":
			sprite.play("Child2GreenIdle")
			currentanim = "Child2GreenIdle"
			Global.current = "Child2Green"
		"pink":
			sprite.play("Child2PinkIdle")
			currentanim = "Child2PinkIdle"
			Global.current = "Child2Pink"

func child3(color):
	match color:
		"blue":
			sprite.play("Child3BlueIdle")
			currentanim = "Child3BlueIdle"
			Global.current = "Child3Blue"
		"green":
			sprite.play("Child3GreenIdle")
			currentanim = "Child3GreenIdle"
			Global.current = "Child3Green"
		"pink":
			sprite.play("Child3PinkIdle")
			currentanim = "Child3PinkIdle"
			Global.current = "Child3Pink"
	
func child4(color):
	match color:
		"blue":
			sprite.play("Child4BlueIdle")
			currentanim = "Child4BlueIdle"
			Global.current = "Child4Blue"
		"green":
			sprite.play("Child4GreenIdle")
			currentanim = "Child4GreenIdle"
			Global.current = "Child4Green"
		"pink":
			sprite.play("Child4PinkIdle")
			currentanim = "Child4PinkIdle"
			Global.current = "Child4Pink"


func _on_sprite_2d_animation_finished():
	if "Anvil" in currentanim:
		self.queue_free()
		if Global.levelins.lost == false:
			Global.emit_signal("moveforward")
	if "Presents" in currentanim:
		self.queue_free()
		if Global.levelins.lost == false:
			Global.emit_signal("moveforward")


func _on_anvil_sprite_animation_finished():
	if "PAresents" in currentanim:
		Global.emit_signal("gameover")
