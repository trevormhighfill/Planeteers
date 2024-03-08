extends Sprite2D
class_name Etearth


#var unlocked_resources : Array[EnumHolder.natural_resources] = []
@export var planet : PlanetResource
@export var current_workers : Array[Workers] = []
var worker_save = preload("res://worker_save.tscn")
#@onready var main = $SpaceScript
#@export var resource_time : Array[float] = []
signal add_to_resource(amount : int,resource : EnumHolder.natural_resources)
signal update_planet_info(current_workers:Array[Workers])
signal unlock_resource_check(worker : Workers,sender:Node)


func resource_gathering(resource:NaturalResource):
	await wait(resource.base_extraction_rate*planet.natural_resource_yield[0])
	emit_signal("add_to_resource",resource.base_extraction_amount,resource)
	resource_gathering(resource)
	pass

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _newly_added_worker(worker_name,worker,skin_color,eye_color):
	
	emit_signal("unlock_resource_check",worker,self)
	current_workers.append(worker)
	emit_signal("update_planet_info",current_workers)
	var instance = worker_save.instantiate()
	print(get_parent().get_node("Infobutton").get_child(0).get_child(0).get_child(0).name)
	get_parent().get_node("Infobutton").get_child(0).get_child(0).get_child(0).add_child(instance)
	get_tree().call_group("worker_save","begin",worker_name,worker,skin_color,eye_color)
	#worker_save.begin(worker_name,worker,skin_color,eye_color)


func incoming_worker(selected_planet_type,worker_name,worker,skin_color,eye_color):
	if selected_planet_type == planet.planet_type:
		_newly_added_worker(worker_name,worker,skin_color,eye_color)
	
