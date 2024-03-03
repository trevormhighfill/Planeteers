extends Sprite2D
class_name Etearth

signal add_to_resource(amount : int,resource : EnumHolder.natural_resources)

@export var planet : PlanetResource
@export var current_workers : Array[Workers] = []
#@onready var main = $SpaceScript
#@export var resource_time : Array[float] = []

func _process(delta):
	pass
	
func _ready():
	resource_gathering(planet.planet_natural_resources[0])

func on_newly_added_worker(worker : Workers):
	
	pass
	
func resource_gathering(resource:NaturalResource):
	await wait(resource.base_extraction_rate*planet.natural_resource_yield[0])
	emit_signal("add_to_resource",resource.base_extraction_amount,resource.natural_resource_type)
	print("donee")
	resource_gathering(planet.planet_natural_resources[0])
	pass

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


#func _on_hire_hunter_button_down():
	#current_workers.append()


func _on_hire_hunter__newly_added_worker(worker):
	current_workers.append(worker)
	print(current_workers[0].name)
	pass # Replace with function body.