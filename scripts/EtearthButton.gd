extends Button

signal deselected()
signal click()

#@onready var currentworkers : Array[Workers] = self.get_parent().current_workers
#@onready var planet : PlanetResource = self.get_parent().planet


#func _button_pressed(presseddown : bool):
	#if presseddown:
		#emit_signal("selected",currentworkers)


func _on_toggled(button_pressed):
	if button_pressed:#.connect(self._button_pressed.bind(button.button_pressed))
		emit_signal("click")
		
	else:
		emit_signal("click")
		
