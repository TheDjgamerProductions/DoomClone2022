extends CSGCylinder

var playerIn = false
export(String) var targetScene
export(String) var direction = "Up"
export(bool) var moveOnStart
export(int) var moveHight
onready var tween = $"Tween"



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == "Down":
		moveHight = moveHight * -1
	if moveOnStart:
		move(self.global_transform.origin, self.global_transform.origin + Vector3(0,moveHight,0),5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if playerIn && Input.is_action_just_pressed("p_interact"):
		print("move")
		move($"Cab".global_transform.origin, $Cab.global_transform.origin + Vector3(0,moveHight,0),5)


func _on_Area_body_entered(body:Node):
	if body.name == "Player":
		print("player In")
		playerIn = true


func _on_Area_body_exited(body:Node):
	if body.name == "Player":
		playerIn = false


func move(startPos,endingPos,time):
	print(startPos.y)
	print(endingPos.y)
	$Door.visible = false
	tween.interpolate_property($"Cab","translation:y",startPos.y,endingPos.y,time,tween.TRANS_LINEAR,tween.EASE_IN_OUT)
	tween.start()
	yield(get_tree().create_timer(time), "timeout")
	$Door.visible = true
	print($"Cab".global_transform.origin)


	

