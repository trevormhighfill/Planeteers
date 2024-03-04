extends Label
@export var amount : float
@export var resource : NaturalResource 
var backup_image = load("res://icon.svg")
func _ready():
	if resource.natural_resource_image == null:
		get_node("TextureRect").texture = backup_image
	get_node("TextureRect").texture = resource.natural_resource_image
	self.text = resource.natural_resource_name
	get_node("Label").text = str(0)

func resource_update(resource_count):
	amount = resource_count[resource.natural_resource_type]
	get_node("Label").text = str(amount)
	
func newly_unlocked_resource(unlocked_resource):
	if visible:
		return null
	elif unlocked_resource == resource.natural_resource_type:
		self.visible = true
