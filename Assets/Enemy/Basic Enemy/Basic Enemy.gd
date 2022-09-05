extends KinematicBody

onready var path = $"../NavigationAgent"
onready var player = $"../Player"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	path.set_target_location(player.global_transform.origin)
	path.get_target_location()
	var route = path.get_nav_path() 
	print(route)
