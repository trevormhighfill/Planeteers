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

	eyes.modulate = random_color(0.0,100.0,100.0,359.0,100.0,100.0)
	head.modulate = random_color(16.0,39.0,27.0,16.0,39.0,100.0)
	print("skin color is ",head.modulate)
	print("eye color is ",eyes.modulate)
	pass

func random_color(h_min,s_min,v_min,h_max,s_max,v_max):
	var final_color : Array[float] = [1,2,3]
	final_color[0] = randf_range(h_min,h_max)/359
	final_color[1] = randf_range(s_min,s_max)/100
	final_color[2] = randf_range(v_min,v_max)/100
	var color = Color.from_hsv(final_color[0],final_color[1],final_color[2],1)
	print("-------------------------------------------")
	print(final_color[0]," ",final_color[1]," ",final_color[2]," ",1," "," should be same as offical color")
	print(" ")
	print(color," offical color")
	print("-------------------------------------------")
	return color

func hsv_to_rgb(h, s, v, a ):
	#based on code at
	#http://stackoverflow.com/questions/51203917/math-behind-hsv-to-rgb-conversion-of-colors
	var r
	var g
	var b

	var i = floor(h * 6)
	var f = h * 6 - i
	var p = v * (1 - s)
	var q = v * (1 - f * s)
	var t = v * (1 - (1 - f) * s)

	match (int(i) % 6):
		0:
			r = v
			g = t
			b = p
		1:
			r = q
			g = v
			b = p
		2:
			r = p
			g = v
			b = t
		3:
			r = p
			g = q
			b = v
		4:
			r = t
			g = p
			b = v
		5:
			r = v
			g = p
			b = q
	return Color(r, g, b, a)
