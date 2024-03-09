extends Sprite2D
#class_name Etearth


#var unlocked_resources : Array[EnumHolder.natural_resources] = []
@export var planet : PlanetResource
@export var current_workers : Array[Workers] = []
var current_workers_save : Array[Node] = []
var worker_save = preload("res://worker_save.tscn")
var selected_planet : EnumHolder.planets = -1
#@onready var main = $SpaceScript
#@export var resource_time : Array[float] = []
#signal add_to_resource(amount : int,resource : EnumHolder.natural_resources)
#signal update_planet_info(current_workers:Array[Workers])
#signal unlock_resource_check(worker : Workers,sender:Node)
#signal planet_selected()
#signal planet_deselected()


func resource_gathering(resource:NaturalResource,worker : Workers):
	while current_workers.has(worker):
		await wait(resource.base_extraction_rate/planet.natural_resource_yield[planet.planet_natural_resources.find(resource)])
		if current_workers.has(worker):
			get_tree().call_group("Main","add_to_resource",resource.base_extraction_amount,resource)
	#resource_gathering(resource,worker)

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _newly_added_worker(worker_name,worker,skin_color,eye_color):
	current_workers.append(worker)
	get_tree().call_group("Main","unlock_resource_check",worker,self)
	var instance = worker_save.instantiate()
	get_parent().get_node("CanvasLayer").get_node("Infobutton").get_child(0).get_child(0).get_child(0).add_child(instance)
	get_tree().call_group("worker_save","begin",worker_name,worker,skin_color,eye_color,planet.planet_type)
	current_workers_save.append(instance)
	#worker_save.begin(worker_name,worker,skin_color,eye_color)


func incoming_worker(selected_planet_type,worker_name,worker,skin_color,eye_color):
	if selected_planet_type == planet.planet_type:
		_newly_added_worker(worker_name,worker,skin_color,eye_color)
		
func fire_worker(fired_worker,worker,func_planet):
	if func_planet == planet.planet_type: 
		current_workers_save[current_workers_save.find(fired_worker)].queue_free()
		current_workers.remove_at(current_workers.find(worker))
		current_workers_save.remove_at(current_workers_save.find(fired_worker))




func new_selected_planet(planet_type):
	if planet_type == null:
		selected_planet = -1
	else:
		selected_planet = planet_type


func button_down():
	if selected_planet == -1:
		get_tree().call_group("Main","button_deselected")
		get_tree().call_group("Main","button_selected",planet,current_workers_save,self)
		return
	if selected_planet == planet.planet_type:
		get_tree().call_group("Main","button_deselected")
	else:
		get_tree().call_group("Main","button_deselected")
		get_tree().call_group("Main","button_selected",planet,current_workers_save,self)
