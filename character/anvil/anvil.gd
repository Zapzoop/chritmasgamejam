extends CharacterBody2D

var draggable = false
var can_drag = false
var can_show = false
var is_first = false

var body_ref
var is_inside_dropable = false
var initialPos : Vector2

var verdictdone = false

var offset

@onready var report = $paper

func _ready():
	report.parent = self

func _process(delta):
	if Input.is_action_just_pressed("click") and !verdictdone and can_show and is_first:
		report.visible = true
		report.makerestinvisible()
	if can_drag and draggable:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			Global.is_dragging = true
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			Global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_dropable:
				tween.tween_property(self,"global_position",body_ref.position,0.2).set_ease(Tween.EASE_OUT)
				self.free()
				Global.emit_signal("moveforward")
			else:
				tween.tween_property(self,"global_position",initialPos,0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_mouse_entered():
	can_show = true
	if not Global.is_dragging:
		draggable = true
		if is_first:
			var tween = get_tree().create_tween()
			tween.tween_property($Sprite2D,"scale",Vector2(0.5,0.5),0.2).set_ease(Tween.EASE_IN)

func _on_area_2d_mouse_exited():
	can_show = false
	if not Global.is_dragging:
		draggable = false
		if is_first:
			var tween = get_tree().create_tween()
			tween.tween_property($Sprite2D,"scale",Vector2(0.3,0.3),0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_body_entered(body:StaticBody2D):
	if body.is_in_group("dropable"):
		is_inside_dropable = true
		body.modulate = Color(Color.DARK_GOLDENROD,1)
		body_ref = body

func _on_area_2d_body_exited(body):
	if body.is_in_group("dropable"):
		is_inside_dropable = false
		body.modulate = Color(Color.DARK_GOLDENROD,0.4)
		body_ref = body
