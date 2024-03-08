extends Node2D

class_name SpaceScript

signal resource_update(resource_count)

var unlocked_resources : Array[EnumHolder.natural_resources] = []

var selected_planet : PlanetResource
#@export var planets: Array[PlanetResource] = []
var resource_count = {
	EnumHolder.natural_resources.Iron: 0,
	EnumHolder.natural_resources.Meat: 0,
	EnumHolder.natural_resources.Stone: 0,
	EnumHolder.natural_resources.Water: 0,
	EnumHolder.natural_resources.Lava: 0,
	EnumHolder.natural_resources.Wood: 0
	}

func _on_infobutton_toggled(button_pressed):
	var popup = $Infobutton/Panel
	if button_pressed == true:
		popup.visible = true
	else:
		popup.visible = false

func update_planet_info(currentworkers):
	var popup = $Infobutton/Panel
	#for i in popup.item_count:
			#popup.remove_item(i)
#	popup.clear()
#	if selected_planet != null and currentworkers != null:  
#		popup.add_item(selected_planet.planet_name)
#		for i in currentworkers.size():
#			popup.add_item(currentworkers[i].name)
#	else:
#		popup.add_item("Info")


func add_to_resource(amount,resource):
	var resource_type : EnumHolder.natural_resources = resource.natural_resource_type
	resource_count[resource_type] += amount
	get_tree().call_group("resource_panels","resource_update",resource_count)
	#emit_signal("resource_update",resource_count)
	#print(resource_count[resource_type]," ",resource.natural_resource_name," gathered")

func button_selected(currentworkers,planet):
	selected_planet = planet
	update_planet_info(currentworkers)

func button_deselected(currentworkers):
	selected_planet = null
	var empty = [null]
	update_planet_info(null)

func unlock_resource_check(worker,sender):
	for a in worker.proficient_resources.size():
		var found : bool = false
		for b in unlocked_resources.size():
			#print(unlocked_resources[b])
			if unlocked_resources[b] == worker.proficient_resources[a].natural_resource_type:
				found = true
		if found == false:
			get_tree().call_group("resource_panels","newly_unlocked_resource",worker.proficient_resources[a].natural_resource_type)
			unlocked_resources.append(worker.proficient_resources[a].natural_resource_type)
		sender.resource_gathering(worker.proficient_resources[a])

func _newly_added_worker(worker_name,worker,skin_color,eye_color):
	if selected_planet:
		get_tree().call_group("Planets","incoming_worker",selected_planet.planet_type,worker_name,worker,skin_color,eye_color)
