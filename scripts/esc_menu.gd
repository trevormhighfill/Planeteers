extends Panel






func to_menu():
	get_tree().change_scene_to_file("res://menu.tscn")


func to_desktop():
	get_tree().quit()
