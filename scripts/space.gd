extends Node2D

class_name SpaceScript


var selected_planet : PlanetResource
@export var planets: Array[PlanetResource] = []
var resource_count = {
	EnumHolder.natural_resources.Iron: 0,
	EnumHolder.natural_resources.Meat: 0,
	EnumHolder.natural_resources.Stone: 0,
	EnumHolder.natural_resources.Water: 0,
	EnumHolder.natural_resources.Lava: 0,
	EnumHolder.natural_resources.Wood: 0
	}

func _on_infobutton_toggled(button_pressed):
	var popup = $Infobutton/ItemList
	if button_pressed == true:
		popup.visible = true
	else:
		popup.visible = false

func update_planet_info(currentworkers):
	var popup = $Infobutton/ItemList
	#for i in popup.item_count:
			#popup.remove_item(i)
	popup.clear()
	if selected_planet != null and currentworkers != null:  
		popup.add_item(selected_planet.planet_name)
		for i in currentworkers.size():
			popup.add_item(currentworkers[i].name)
	else:
		popup.add_item("Info")
#func _on_etearth_button_button_down(currentworkers:Array[Workers]):
	#selected_planet = planets[0]
	#update_planet_info(currentworkers)
	


func _on_etearth_add_to_resource(amount,resource):
	var resource_type : EnumHolder.natural_resources = resource.natural_resource_type
	resource_count[resource_type] += amount
	print(resource_count[resource_type]," ",resource.natural_resource_name," gathered")


func _on_etearth_button_selected(currentworkers):
	selected_planet = planets[0]
	update_planet_info(currentworkers)


func button_deselected(currentworkers):
	selected_planet = null
	var empty = [null]
	update_planet_info(null)
