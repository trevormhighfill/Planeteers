extends Control

var eye_color : Color
var skin_color : Color
@onready var body = get_node("body")
@onready var eyes = get_node("eyes")
@onready var head = get_node("head")
@onready var mouth = get_node("mouth")


func _ready():
	begin()

func begin():

	eye_color = random_color(0.0,100.0,100.0,359.0,100.0,100.0)
	skin_color = random_color(16.0,39.0,27.0,16.0,39.0,100.0)
	eyes.modulate = eye_color
	head.modulate  = skin_color

func random_color(h_min,s_min,v_min,h_max,s_max,v_max):
	var final_color : Array[float] = [1,2,3]
	final_color[0] = randf_range(h_min,h_max)/359
	final_color[1] = randf_range(s_min,s_max)/100
	final_color[2] = randf_range(v_min,v_max)/100
	var color = Color.from_hsv(final_color[0],final_color[1],final_color[2],1)
	return color
