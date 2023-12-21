extends CharacterBody2D

var draggable = false
var can_drag = false
var can_show = false

var body_ref
var is_inside_dropable = false
var initialPos : Vector2

var child_score = 0

var verdictdone = false

var offset

@onready var report = $ReportFile
@onready var anim = $ReportFile/Animation

func _ready():
	report.parent = self
	report.create_child()

func _process(delta):
	if Input.is_action_just_pressed("click") and !verdictdone and can_show:
		anim.play("open")
		report.visible = true
	if can_drag:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			var tween = get_tree().create_tween()
			if is_inside_dropable:
				tween.tween_property(self,"global_position",body_ref.position,0.2).set_ease(Tween.EASE_OUT)
				if self.is_in_group("anvil"):
					if (self.global_position.x < $/root/Level/center.global_position.x):
						Global.emit_signal("playkillanvil")
						self.free()
						print("right")
						Global.score += 5
						Global.emit_signal("moveforward")
					else:
						Global.emit_signal("gameover")
				else:
					if ((self.child_score > 0) and (self.global_position.x > $/root/Level/center.global_position.x)) or ((self.child_score < 0) and (self.global_position.x < $/root/Level/center.global_position.x)):
						if self.global_position.x < $/root/Level/center.global_position.x:
							Global.emit_signal("playkillchild")
						self.free()
						print("right") 
						Global.score += 5
						Global.emit_signal("moveforward")
					else:
						Global.emit_signal("gameover")
			else:
				tween.tween_property(self,"global_position",initialPos,0.2).set_ease(Tween.EASE_OUT)
			

func _on_area_2d_mouse_entered():
	can_show = true
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D,"scale",Vector2(0.5,0.5),0.2).set_ease(Tween.EASE_IN)

func _on_area_2d_mouse_exited():
	can_show = false
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D,"scale",Vector2(0.3,0.3),0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_body_entered(body:StaticBody2D):
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




