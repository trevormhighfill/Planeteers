extends Sprite2D
class_name Etearth


#var unlocked_resources : Array[EnumHolder.natural_resources] = []
@export var planet : PlanetResource
@export var current_workers : Array[Workers] = []
var current_workers_save : Array[Node] = []
var worker_save = preload("res://worker_save.tscn")
#@onready var main = $SpaceScript
#@export var resource_time : Array[float] = []
signal add_to_resource(amount : int,resource : EnumHolder.natural_resources)
signal update_planet_info(current_workers:Array[Workers])
signal unlock_resource_check(worker : Workers,sender:Node)


func resource_gathering(resource:NaturalResource,worker : Workers):
	while current_workers.has(worker):
		await wait(resource.base_extraction_rate*planet.natural_resource_yield[0])
		if current_workers.has(worker):
			emit_signal("add_to_resource",resource.base_extraction_amount,resource)
	#resource_gathering(resource,worker)

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _newly_added_worker(worker_name,worker,skin_color,eye_color):
	current_workers.append(worker)
	emit_signal("unlock_resource_check",worker,self)
	emit_signal("update_planet_info")
	var instance = worker_save.instantiate()
	get_parent().get_node("Infobutton").get_child(0).get_child(0).get_child(0).add_child(instance)
	get_tree().call_group("worker_save","begin",worker_name,worker,skin_color,eye_color,planet.planet_type)
	current_workers_save.append(instance)
	#worker_save.begin(worker_name,worker,skin_color,eye_color)


func incoming_worker(selected_planet_type,worker_name,worker,skin_color,eye_color):
	if selected_planet_type == planet.planet_type:
		_newly_added_worker(worker_name,worker,skin_color,eye_color)
		
func fire_worker(fired_worker,worker,func_planet):
	if func_planet == planet.planet_type: 
		print(current_workers_save.size()," before")
		current_workers_save[current_workers_save.find(fired_worker)].queue_free()
		current_workers.remove_at(current_workers.find(worker))
		current_workers_save.remove_at(current_workers_save.find(fired_worker))
		print(current_workers_save.size()," after")
	
	
