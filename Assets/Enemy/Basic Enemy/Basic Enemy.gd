extends KinematicBody

var path = []
var path_node = 0

var speed = 15
var moving = false
var maxHealth = 10
var health

onready var nav = get_parent()
onready var player = $"../../Player"
onready var area = $Area

# Called when the node enters the scene tree for the first time.
func _ready():
	health = maxHealth


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if health == 0:
		queue_free()
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		if direction.length() < 1:
			path_node += 1
		else:
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
		move_to(player.global_transform.origin)


func canAttack():
	var overlapingBodies = $HurtArea.get_overlapping_bodies()
	for i in overlapingBodies:
		if i.name == "Player":
			return(true)
	return(false)

func _on_Hurt_Timer_timeout():
	if canAttack():
		player.currentHealth -= 5
		

