extends Resource
class_name PlanetResource

@export var planet_name : String
@export var planet_type : EnumHolder.planets
@export var planet_natural_resources : Array[NaturalResource]
##@export var planet_natural_resources : Dictionary{NaturalResource:int}
@export var natural_resource_yield : Array[float]


