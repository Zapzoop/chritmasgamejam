extends CharacterBody2D

var draggable = false
var offset

func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			offset = get_global_mouse_position() - global_position
			Global.is_dragging = true
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_pressed("click"):
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
	if not Global.is_dragging:
		draggable = true
		var tween = get_tree().create_tween()
		tween.tween_property($Sprite2D,"scale",Vector2(0.5,0.5),0.2).set_ease(Tween.EASE_IN)


func _on_area_2d_mouse_exited():
	if not Global.is_dragging:
		draggable = false
		var tween = get_tree().create_tween()
		tween.tween_property($Sprite2D,"scale",Vector2(0.2,0.2),0.2).set_ease(Tween.EASE_OUT)
