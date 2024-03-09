extends Label

signal _newly_added_worker(worker)

@export var worker : Workers
@onready var type = get_node("type")
@onready var level = get_node("level")
var worker_name : String
var start_name_combinations = [
	"Ja",
	"Ko",
	"Mo",
	"Te",
	"Ye",
	"Me",
	"Po",
	"No",
	"So",
	"Se",
	"Fa",
	"Re"
]
var name_combinations = [
	"ja",
	"ta",
	"te",
	"be",
	"ga",
	"ro",
	"na",
	"re",
	"ge",
	"be",
	"re"
]
# Called when the node enters the scene tree for the first time.
func _ready():
	
	level.text = str("Level:",worker.resource_level)
	type.text = worker.job
	worker_name = random_name()
	text = worker_name
	pass # Replace with function body.

func random_name():
	return str(
		start_name_combinations[randi_range(0,start_name_combinations.size()-1)],
		name_combinations[randi_range(0,name_combinations.size()-1)],
		name_combinations[randi_range(0,name_combinations.size()-1)],
		name_combinations[randi_range(0,name_combinations.size()-1)]
		)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func button_down():
	get_tree().call_group("Main","_newly_added_worker",worker_name,worker,get_node("worker_icon").skin_color,get_node("worker_icon").eye_color)
	pass # Replace with function body.
