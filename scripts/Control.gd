extends Control

var worker_name : String
var worker : Workers
var skin_color : Color
var eye_color : Color 
var belonging_planet : EnumHolder.planets

@onready var ui_name = get_node("name")
@onready var ui_job = get_node("job")
@onready var ui_rating = get_node("rating")
@onready var ui_body = get_node("body")
@onready var ui_head = get_node("head")
@onready var ui_eyes = get_node("eyes")
@onready var ui_mouth = get_node("mouth")

func begin(func_worker_name : String,func_worker : Workers,func_skin_color : Color, func_eye_color : Color,func_belonging_planet : EnumHolder.planets):
	if worker == null:
		belonging_planet = func_belonging_planet
		worker_name = func_worker_name
		worker = func_worker
		skin_color = func_skin_color
		eye_color = func_eye_color
		
		ui_name.text = worker_name
		ui_job.text = worker.job
		ui_rating.text = str("Level: ",worker.resource_level)
		ui_head.modulate = skin_color
		ui_eyes.modulate = eye_color



func fire_worker():
	get_tree().call_group("Planets","fire_worker",self,worker,belonging_planet)
