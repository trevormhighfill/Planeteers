extends Button

signal deselected(currentworkers : Array[Workers])
signal selected(currentworkers : Array[Workers])

@onready var currentworkers : Array[Workers] = self.get_parent().current_workers


#func _button_pressed(presseddown : bool):
	#if presseddown:
		#emit_signal("selected",currentworkers)


func _on_toggled(button_pressed):
	if button_pressed:#.connect(self._button_pressed.bind(button.button_pressed))
		emit_signal("selected",currentworkers)
		print("toggled")
	else:
		emit_signal("deselected",currentworkers)
		print("not toggled")
