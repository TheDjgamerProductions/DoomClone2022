extends CSGCylinder

var playerIn = false
export(String) var target_Scene
export(String) var direction = "Up"
export(bool) var move_On_Start
export(int) var move_Hight
onready var tween = $"Tween"
onready var pTween = $"PlayerTween"
var player_Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"-


# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == "Down":
		move_Hight = move_Hight * -1
	if move_On_Start:
		move(self.global_transform.origin, self.global_transform.origin + Vector3(0,move_Hight,0),5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if playerIn && Input.is_action_just_pressed("p_interact"):
		print("move")
		move($"Cab".global_transform.origin + Vector3(0,4,0), $Cab.global_transform.origin + Vector3(0,move_Hight,0),3)


func _on_Area_body_entered(body:Node):
	if body.name == "Player":
		body.tooltipText = "Press E to Interact"
		player_Node = body
		playerIn = true


func _on_Area_body_exited(body:Node):
	if body.name == "Player":
		body.tooltipText = ""
		playerIn = false


func move(startPos,endingPos,time):
	$Door.visible = false #Close the door
	tween.interpolate_property($"Cab","translation:y",startPos.y,endingPos.y,time,tween.TRANS_LINEAR,tween.EASE_IN_OUT)
	tween.start() #Move the lift
	yield(get_tree().create_timer(time), "timeout") #Wait untill the lift has moved
	if target_Scene:
		get_tree().change_scene(target_Scene)


	

