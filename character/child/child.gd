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

var offset

@onready var sprite = $Sprite2D
@onready var report = $ReportFile
@onready var anim = $ReportFile/Animation
@onready var sfx = $/root/Level/sounds

func _ready():
	report.parent = self
	report.create_child()

func _physics_process(delta):
	if Input.is_action_just_pressed("click") and can_move and !clicked:
		report.visible = true
		anim.play("open")
	if Input.is_action_just_pressed("click") and can_move and clicked:
		initialPos = self.global_position
		is_moving = true
		offset = Vector2(76,-46) - position 
		sfx.pick_up()
	elif Input.is_action_pressed("click") and is_moving:
		dragged = true
		scaledown()
		var string = Global.current + "Dragged"
		sprite.position = Vector2(-192,136)
		sprite.play(string)
		currentanim = string
		global_position = lerp(global_position - Vector2(56,-26), get_global_mouse_position(),25*delta)
	elif Input.is_action_just_released("click") and is_moving:
		dragged = false
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
					Global.emit_signal("moveforward")
					self.queue_free()
				else:
					presents_on_anvil()
					Global.emit_signal("gameover")
			else:
				if ((self.child_score > 0) and (self.global_position.x > $/root/Level/center.global_position.x)) or ((self.child_score < 0) and (self.global_position.x < $/root/Level/center.global_position.x)):
					if self.global_position.x < $/root/Level/center.global_position.x:
						put_on_anvil_child()
						sfx.childDeath("child")
						Global.emit_signal("playkillchild")
					if self.global_position.x > $/root/Level/center.global_position.x:
						put_on_presents_child()
						sfx.present()
					Global.score += 5
					
					
				else:
					if self.global_position.x < $/root/Level/center.global_position.x:
						put_on_anvil_child()
					if self.global_position.x > $/root/Level/center.global_position.x:
						put_on_presents_child()
					Global.emit_signal("gameover")
		else:
			reset()
		is_moving = false
	
func put_on_anvil_child():
	print("done")
	Global.emit_signal("anvilchild")
	sprite.global_position = Vector2(512,344)
	var string = Global.current + "Anvil"
	sprite.play(string)

func put_on_presents_child():
	Global.emit_signal("presentschild")

func anvil_on_anvil():
	Global.emit_signal("anvilanvil")

func presents_on_anvil():
	Global.emit_signal("presentsanvil")

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
	tween.tween_property($Sprite2D,"scale",Vector2(0.55,0.55),0.2).set_ease(Tween.EASE_IN)

func scaledown():
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D,"scale",Vector2(0.5,0.5),0.2).set_ease(Tween.EASE_OUT)

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

func child1(color):
	print(color)
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
	print(color)
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
	print(color)
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
	print(color)
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
		Global.emit_signal("moveforward")
