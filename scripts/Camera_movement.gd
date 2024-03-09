extends Camera2D

var can_change = false

func _process(delta):
	if Input.is_action_pressed("Move"):
		can_change = true
	else:
		can_change = false

func _input(event):
	if event is InputEventMouseMotion:
		pass

func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			position -= event.relative / zoom
			
