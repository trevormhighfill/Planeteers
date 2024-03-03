extends Button

signal _newly_added_worker(worker:Workers)

@export var hireable_worker : Workers

func _ready():
	var button = self#get_node("Hire Hunter")
	button.button_down.connect(self._button_pressed.bind(hireable_worker))
	
func _button_pressed(worker:Workers):
	emit_signal("_newly_added_worker",worker)
