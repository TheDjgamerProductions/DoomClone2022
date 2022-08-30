extends CSGCylinder

var playerIn = false
export(String) var targetScene
export(String) var direction = "Up"
export(bool) var moveOnStart
export(int) var moveHight
onready var tween = get_node("Tween")



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
#func _process(delta):
#	pass


func _on_Area_body_entered(body:Node):
	if body.name == "Player":
		playerIn = true


func _on_Area_body_exited(body:Node):
	if body.name == "Player":
		playerIn = false


func move(startPos,endingPos,time):
	$Door.visible = false
	tween.interpolate_property($"Cab","translation",startPos,endingPos,time,tween.TRANS_LINEAR,tween.EASE_IN_OUT)
	tween.start() #Play the tween