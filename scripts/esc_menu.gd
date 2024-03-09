extends Panel



var esc_held_down : bool = false

func _process(delta):
	if Input.is_action_pressed("escape" ) && !esc_held_down:
		visible = !visible
		esc_held_down = true
		#get_tree().paused = !get_tree().paused
	elif Input.is_action_just_pressed("escape"):
		esc_held_down = false


func to_menu():
	#get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")


func to_desktop():
	#get_tree().paused = false
	get_tree().quit()

	
func resume():
	get_tree().paused = false
	visible = !visible
