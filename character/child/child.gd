extends CharacterBody2D

var can_move = false
var is_moving = false

var is_inside_dropable = false

var body_ref

var initialPos : Vector2

var child_score = 0

var clicked = false

var offset

@onready var report = $ReportFile
@onready var anim = $ReportFile/Animation

func _ready():
	report.parent = self
	report.create_child()

func _physics_process(delta):
	if Input.is_action_just_pressed("click") and can_move and clicked:
		initialPos = self.global_position
		is_moving = true
	elif Input.is_action_pressed("click") and is_moving:
		global_position = lerp(global_position, get_global_mouse_position(),25*delta)
	elif Input.is_action_just_released("click") and is_moving:
		if is_inside_dropable:
			if self.is_in_group("anvil"):
				if (self.global_position.x < $/root/Level/center.global_position.x):
					Global.emit_signal("playkillanvil")
					Global.score += 5
					Global.emit_signal("moveforward")
					self.queue_free()
				else:
					Global.emit_signal("gameover")
			else:
				if ((self.child_score > 0) and (self.global_position.x > $/root/Level/center.global_position.x)) or ((self.child_score < 0) and (self.global_position.x < $/root/Level/center.global_position.x)):
					if self.global_position.x < $/root/Level/center.global_position.x:
						put_on_anvil_child()
						Global.emit_signal("playkillchild")
					if self.global_position.x > $/root/Level/center.global_position.x:
						put_on_presents_child()
					Global.score += 5
					Global.emit_signal("moveforward")
					self.queue_free()
				else:
					Global.emit_signal("gameover")
		else:
			reset()
		is_moving = false
	
func put_on_anvil_child():
	pass

func put_on_presents_child():
	pass

func reset():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position",Vector2(512,320),0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_mouse_entered():
	can_move = true
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D,"scale",Vector2(0.5,0.5),0.2).set_ease(Tween.EASE_IN)

func _on_area_2d_mouse_exited():
	can_move = false
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D,"scale",Vector2(0.3,0.3),0.2).set_ease(Tween.EASE_OUT)

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
