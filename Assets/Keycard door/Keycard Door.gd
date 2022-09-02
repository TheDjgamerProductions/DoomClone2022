extends Spatial

var playerNear = false
onready var collider = get_node("Keycard Door/StaticBody/CollisionShape")
export(Color) var keycard_colour
export(bool) var needsKeycard
onready var tween = get_node("Tween")
onready var closedPosition = self.global_transform.origin
export(int) var openHight
var playerNode


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var material = $"Keycard Door".get_surface_material(0)
	material.albedo_color = keycard_colour
	print(closedPosition)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if playerNear && Input.is_action_just_pressed("p_interact"): #Checks if the player is near and has pressed the interact key
		if needsKeycard:
			print("Needs keycard")
			if hasKeycard(keycard_colour):
				open()
		else:
			open()
		
	

#Checks if the body entered is a player
func _on_Area_body_entered(body:Node):
	if (body.name) == "Player":
		playerNode = body
		playerNear = true



#Checks if the body exited was the player
func _on_Area_body_exited(body:Node):
	if (body.name) == "Player":
		playerNear = false



func open():
	print("Open")
	#Set up the tween
	tween.interpolate_property($".","translation",closedPosition,closedPosition + Vector3(0,openHight,0),0.5,tween.TRANS_LINEAR,tween.EASE_IN_OUT)
	tween.start() #Play the tween
	yield(get_tree().create_timer(5.0), "timeout") #Wait 5 secounds
	close() #Close the door

func close():
	print("Close")
	#Set up the tween
	tween.interpolate_property($".","translation",self.global_transform.origin,closedPosition,0.5,tween.TRANS_LINEAR,tween.EASE_IN_OUT)
	tween.start() #play the tween


func hasKeycard(DoorColour):
	print(playerNode.inventory)
	for i in playerNode.inventory:
		if i.ID == 2:
			if i.Color == DoorColour:
				return(true)
		else:
			print("AAAAAAAAAAAAAAAAAA")


