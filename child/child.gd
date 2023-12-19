extends CharacterBody2D

var ID

var draggable = false
var can_drag = false
var can_show = false

var verdictdone = false

var offset

@onready var report = $paper

func _ready():
	report.parent = self


func _process(delta):
	if Input.is_action_just_pressed("click") and !verdictdone and can_show:
		report.visible = true
		report.makerestinvisible()
	if can_drag: 
		if draggable:
			if Input.is_action_just_pressed("click"):
				offset = get_global_mouse_position() - global_position
				Global.is_dragging = true
			if Input.is_action_pressed("click"):
				global_position = get_global_mouse_position() - offset
			elif Input.is_action_just_released("click"):
				var final_location = get_global_mouse_position()
				Global.is_dragging = false
				var tween = get_tree().create_tween()
				tween.tween_property(self,"position",final_location,0.2).set_ease(Tween.EASE_OUT)
			

func _on_mouse_entered():
	#if not Global.is_dragging:
	#	draggable = true
	#	var tween = get_tree().create_tween()
	#	tween.tween_property($Sprite2D,"scale",Vector2(0.5,0.5),0.2).set_ease(Tween.EASE_IN)
		#$Sprite2D.scale = Vector2(0.5,0.5) 
	pass


func _on_mouse_exited():
	#if not Global.is_dragging:
	#	draggable = false
	#	var tween = get_tree().create_tween()
	#	tween.tween_property($Sprite2D,"scale",Vector2(0.2,0.2),0.2).set_ease(Tween.EASE_OUT)
		#$Sprite2D.scale = Vector2(0.2,0.2) # Replace with function body.
	pass


func _on_area_2d_mouse_entered():
	can_show = true
	if not Global.is_dragging:
		draggable = true
		var tween = get_tree().create_tween()
		tween.tween_property($Sprite2D,"scale",Vector2(0.5,0.5),0.2).set_ease(Tween.EASE_IN)


func _on_area_2d_mouse_exited():
	can_show = false
	if not Global.is_dragging:
		draggable = false
		var tween = get_tree().create_tween()
		tween.tween_property($Sprite2D,"scale",Vector2(0.3,0.3),0.2).set_ease(Tween.EASE_OUT)


func _on_input_event(viewport, event, shape_idx):
	pass
