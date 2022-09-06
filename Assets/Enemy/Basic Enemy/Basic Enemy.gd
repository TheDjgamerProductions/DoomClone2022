extends RigidBody

onready var navAgent = $"NavigationAgent"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var player : Spatial = $"../Player/Position3D"
	#navAgent.set_target_location(player.global_transform.origin)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass
	# var currentPos = global_transform.origin
	# var target = navAgent.get_next_location()
	# #print(target)
	# var velocity = Vector3()
	# velocity = target - currentPos * 5
	# navAgent.set_velocity(velocity)


func _on_NavigationAgent_velocity_computed(safe_velocity):
	set_linear_velocity(safe_velocity)
