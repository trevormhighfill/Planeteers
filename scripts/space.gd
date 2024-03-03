extends Node2D

class_name SpaceScript

@onready var popup = $Infobutton/ItemList
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
	if button_pressed == true:
		popup.visible = true
	else:
		popup.visible = false

func update_planet_info():
	popup.set_item_text(0,selected_planet.planet_name)

func _on_etearth_button_button_down():
	selected_planet = planets[0]
	update_planet_info()
	


func _on_etearth_add_to_resource(amount,resource):
	resource_count[resource] += amount
	print(resource_count[resource])
