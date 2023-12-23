extends CharacterBody2D

var draggable = false
var can_drag = false

var can_move = false
var is_moving = false


var is_inside_dropable = false
var can_drop = false

var inside

var body_ref

var initialPos : Vector2

var child_score = 0

var verdictdone = false

var offset

@onready var report = $ReportFile
@onready var anim = $ReportFile/Animation

func _ready():
	report.parent = self
	report.create_child()

func _physics_process(delta):
	#print("Can move "+ str(can_move))
	#print("is_inside_dropable " + str(is_inside_dropable))
	#print("can_drop " + str(can_drop))
	if Input.is_action_just_pressed("click") and can_move:
		initialPos = self.global_position
		is_moving = true
		print("pickedup")
	elif Input.is_action_pressed("click") and is_moving:
		global_position = lerp(global_position, get_global_mouse_position(),25*delta)
	elif Input.is_action_just_released("click") and is_moving:
		print("released")
		if is_inside_dropable:
			if self.is_in_group("anvil"):
					if (self.global_position.x < $/root/Level/center.global_position.x):
						Global.emit_signal("playkillanvil")
						self.free()
						#print("right")
						Global.score += 5
						Global.emit_signal("moveforward")
					else:
						self.free()
						Global.emit_signal("gameover")
			else:
					if ((self.child_score > 0) and (self.global_position.x > $/root/Level/center.global_position.x)) or ((self.child_score < 0) and (self.global_position.x < $/root/Level/center.global_position.x)):
						#print("First Layer")
						if self.global_position.x < $/root/Level/center.global_position.x:
							put_on_anvil_child()
							Global.emit_signal("playkillchild")
						if self.global_position.x > $/root/Level/center.global_position.x:
							put_on_presents_child()
						#print("right") 
						Global.score += 5
						Global.emit_signal("moveforward")
						print("done")
						self.queue_free()
					else:
						Global.emit_signal("gameover")
		#	global_position = lerp(global_position,body_ref.global_position,10*delta)
		else:
			reset()
		is_moving = false

	#elif is_inside_dropable and can_move and can_drop:
	#	global_position = lerp(global_position,body_ref.position,10*delta)
	#elif can_drop:
	#	global_position = lerp(global_position,initialPos,10*delta)
func put_on_anvil_child():
	pass

func put_on_presents_child():
	pass

func reset():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position",Vector2(512,320),0.2).set_ease(Tween.EASE_OUT)
	#global_position = lerp(global_position,,10*delta)

#func _input(event):
#	if event is InputEventMouseButton:
#		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
#			can_move = false
#			can_drop = true

func _process(_delta):
	#if Input.is_action_just_pressed("click") and !verdictdone and can_show:
	#	anim.play("open")
	#	report.visible = true
	#if can_drag:
		
	#	if Input.is_action_just_pressed("click"):
	#		initialPos = global_position
	#		offset = get_global_mouse_position() - global_position
	#	elif Input.is_action_pressed("click"):
	#		global_position = get_global_mouse_position() - offset
	#	elif Input.is_action_just_released("click"):
	#		print("clicked to drag")
			#var tween = get_tree().create_tween()
	#		if is_inside_dropable:
	#			if self.is_in_group("anvil"):
	#				if (self.global_position.x < $/root/Level/center.global_position.x):
	#					Global.emit_signal("playkillanvil")
	#					self.free()
	#					print("right")
	#					Global.score += 5
	#					Global.emit_signal("moveforward")
	#				else:
	#					self.free()
	#					Global.emit_signal("gameover")
	#			else:
	#				if ((self.child_score > 0) and (self.global_position.x > $/root/Level/center.global_position.x)) or ((self.child_score < 0) and (self.global_position.x < $/root/Level/center.global_position.x)):
	#					print("First Layer")
	#					if self.global_position.x < $/root/Level/center.global_position.x:
	#						Global.emit_signal("playkillchild")
	#					self.free()
	#					print("right") 
	#					Global.score += 5
	#					Global.emit_signal("moveforward")
	#				else:
	#					self.free()
	#					Global.emit_signal("gameover")
			#else:
			#	tween.tween_property(self,"global_position",initialPos,0.2).set_ease(Tween.EASE_OUT)
			pass

func _on_area_2d_mouse_entered():
	can_move = true
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D,"scale",Vector2(0.5,0.5),0.2).set_ease(Tween.EASE_IN)

func _on_area_2d_mouse_exited():
	can_move = false
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D,"scale",Vector2(0.3,0.3),0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_body_entered(body):
	#print("entered")
	if body.is_in_group("dropable"):
		is_inside_dropable = true
		if body.is_in_group("gullotine"):
			Global.emit_signal("modulatepresents")
		if body.is_in_group("presents"):
			Global.emit_signal("modulategullotine")
		body.modulate = Color(Color.DARK_GOLDENROD,1)
		body_ref = body

func _on_area_2d_body_exited(body):
	#print("exited")
	if body.is_in_group("dropable"):
		is_inside_dropable = false
		if body.is_in_group("gullotine"):
			Global.emit_signal("modulatebackpresents")
		if body.is_in_group("presents"):
			Global.emit_signal("modulatebackgullotine")
		body.modulate = Color(Color.WHITE,1)
		body_ref = body
