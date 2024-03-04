extends Sprite2D
class_name Etearth


var unlocked_resources : Array[EnumHolder.natural_resources] = []
@export var planet : PlanetResource
@export var current_workers : Array[Workers] = []
#@onready var main = $SpaceScript
#@export var resource_time : Array[float] = []
signal add_to_resource(amount : int,resource : EnumHolder.natural_resources)
signal update_planet_info(current_workers:Array[Workers])


func resource_gathering(resource:NaturalResource):
	await wait(resource.base_extraction_rate*planet.natural_resource_yield[0])
	emit_signal("add_to_resource",resource.base_extraction_amount,resource)
	resource_gathering(resource)
	pass

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _newly_added_worker(worker : Workers):
	print(worker.proficient_resources.size())
	for a in worker.proficient_resources.size():
		var found : bool = false
		if unlocked_resources.size() == 0:
			unlocked_resources.append(worker.proficient_resources[a].natural_resource_type)
			resource_gathering(worker.proficient_resources[a])
			found = true
		for b in unlocked_resources.size():
			print(unlocked_resources[b])
			if unlocked_resources[b] == worker.proficient_resources[a].natural_resource_type:
				found = true
		if found == false:
			unlocked_resources.append(worker.proficient_resources[a].natural_resource_type)
			resource_gathering(worker.proficient_resources[a])
	
	current_workers.append(worker)
	emit_signal("update_planet_info",current_workers)
	print("Hired ",worker.name, " and the employment team is ", current_workers.size())
	pass # Replace with function body.

