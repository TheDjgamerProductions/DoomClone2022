extends KinematicBody

export(int) var ID 


var path = []
var path_node = 0


var speed
var DmgMin
var DmgMax 
var Health
var DetectionRadius
var moving = false
var rng = RandomNumberGenerator.new()


onready var nav = get_parent()
onready var player = $"../../Player"
onready var area = $Area

# Called when the node enters the scene tree for the first time.
func _ready():
	var stats = Global.enemyDB[ID]
	speed = stats.Speed
	DmgMin = stats.DmgMin
	DmgMax = stats.DmgMax
	Health = stats.Health
	DetectionRadius = stats.DetectionRadius



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if Health <=0:
		queue_free()
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		if direction.length() < 1:
			path_node += 1
		else:
			move_and_slide(direction.normalized() * speed, Vector3.UP)


func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, Vector3(target_pos.x,target_pos.y+5,target_pos.z))
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
		rng.randomize()
		player.currentHealth -= rng.randi_range(DmgMin,DmgMax)
		
func take_damage(damage):
	print("tesr")
	Health -= damage
