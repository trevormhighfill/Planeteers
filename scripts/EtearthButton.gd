extends Button

signal selected(currentworkers : Array[Workers])

@onready var currentworkers : Array[Workers] = self.get_parent().current_workers

func _ready():
	var button = self#get_node("Hire Hunter")
	button.pressed.connect(self._button_pressed.bind())
	
func _button_pressed():
	emit_signal("selected",currentworkers)
