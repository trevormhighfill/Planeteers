extends Node2D

class_name SpaceScript

signal resource_update(resource_count)

var unlocked_resources : Array[EnumHolder.natural_resources] = []

var selected_planet : PlanetResource
var selected_planet_node : Node
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
	var popup = $CanvasLayer/Infobutton/Panel
	if button_pressed == true:
		popup.visible = true
	else:
		popup.visible = false

func add_to_resource(amount,resource):
	var resource_type : EnumHolder.natural_resources = resource.natural_resource_type
	resource_count[resource_type] += amount
	get_tree().call_group("resource_panels","resource_update",resource_count)
	#emit_signal("resource_update",resource_count)

func button_selected(planet,worker_saves : Array[Node],planet_node):
	var container = $CanvasLayer/Infobutton/Panel/ScrollContainer/GridContainer
	selected_planet = planet
	selected_planet_node = planet_node
	get_tree().call_group("Planets","new_selected_planet",selected_planet.planet_type)
	for i in worker_saves.size():
		worker_saves[i].get_parent().remove_child(worker_saves[i])
		container.add_child(worker_saves[i])
		worker_saves[i].visible = true

func button_deselected():
	var container = $CanvasLayer/Infobutton/Panel/ScrollContainer/GridContainer
	for i in container.get_children().size():
		var free_roaming_child = container.get_child(0)
		container.remove_child(free_roaming_child)
		selected_planet_node.add_child(free_roaming_child)
		free_roaming_child.visible = false
	selected_planet = null
	get_tree().call_group("Planets","new_selected_planet",null)
	selected_planet_node = null

func unlock_resource_check(worker,sender):
	for a in worker.proficient_resources.size():
		var found : bool = false
		for b in unlocked_resources.size():
			if unlocked_resources[b] == worker.proficient_resources[a].natural_resource_type:
				found = true
		if found == false:
			get_tree().call_group("resource_panels","newly_unlocked_resource",worker.proficient_resources[a].natural_resource_type)
			unlocked_resources.append(worker.proficient_resources[a].natural_resource_type)
		sender.resource_gathering(worker.proficient_resources[a],worker)

func _newly_added_worker(worker_name,worker,skin_color,eye_color):
	if selected_planet:
		get_tree().call_group("Planets","incoming_worker",selected_planet.planet_type,worker_name,worker,skin_color,eye_color)
