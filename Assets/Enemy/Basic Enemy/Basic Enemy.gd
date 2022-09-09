extends KinematicBody

var path = []
var path_node = 0

var speed = 15
var moving = false


onready var nav = get_parent()
onready var player = $"../../Player"
onready var area = $Area

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		if direction.length() < 1:
			path_node += 1
		else:
			print("Movin")
			move_and_slide(direction.normalized() * speed, Vector3.UP)


func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0


func canMove():
	var overlapingBodies = area.get_overlapping_bodies()
	for i in overlapingBodies:
		if i.name == "Player":
			return(true)
	return(false)




func _on_Timer_timeout():
	if canMove():
		print("I see you!!@!")
		move_to(player.global_transform.origin)
	else:
		print("Where are you?")
