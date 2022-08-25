extends MeshInstance

var playerNear = false
onready var collider = get_node("StaticBody/CollisionShape")
export(String) var keycard_colour


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if playerNear && Input.is_action_just_pressed("p_interact"):
		#Implment if player has keycard later
		open()
		#self.visible = false
		#collider.disabled = true
		
	


func _on_Area_body_entered(body:Node):
	if (body.name) == "Player":
		playerNear = true




func _on_Area_body_exited(body:Node):
	if (body.name) == "Player":
		playerNear = false

func open():
	var x = 0
	while (x != 1.5):
		print(x)
		translate(Vector3(0,0.1,0))
		x += 0.1
		yield(get_tree().create_timer(0.1), "timeout")
