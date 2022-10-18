extends CSGBox

var itemID = 2
export(Color) var Colour
export(String) var Colour_Name

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var material = $".".get_material()
	material.albedo_color = Colour


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

