extends Spatial

var player_Near = false
onready var collider = get_node("Keycard Door/StaticBody/CollisionShape")
export(Color) var keycard_colour
export(bool) var needs_Keycard
onready var tween = get_node("Tween")
onready var closed_Position = self.global_transform.origin
export(int) var open_Hight
var playerNode


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var material = $"Keycard Door".get_surface_material(0)
	material.albedo_color = keycard_colour


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if player_Near && Input.is_action_just_pressed("p_interact"): #Checks if the player is near and has pressed the interact key
		if needs_Keycard:
			print("Needs keycard")
			if hasKeycard(keycard_colour):
				open()
			else:
				playerNode.tooltipText = "I need a keycard..."
				yield(get_tree().create_timer(1.0), "timeout")
				playerNode.tooltipText = "Press E to Interact"
		else:
			open()
		
	

#Checks if the body entered is a player
func _on_Area_body_entered(body:Node):
	if (body.name) == "Player":
		body.tooltipText = "Press E to Interact"
		playerNode = body
		player_Near = true



#Checks if the body exited was the player
func _on_Area_body_exited(body:Node):
	if (body.name) == "Player":
		body.tooltipText = ""
		player_Near = false



func open():
	print("Open")
	#Set up the tween
	tween.interpolate_property($".","translation",closed_Position,closed_Position + Vector3(0,open_Hight,0),0.5,tween.TRANS_LINEAR,tween.EASE_IN_OUT)
	tween.start() #Play the tween
	yield(get_tree().create_timer(5.0), "timeout") #Wait 5 secounds
	close() #Close the door

func close():
	print("Close")
	#Set up the tween
	tween.interpolate_property($".","translation",self.global_transform.origin,closed_Position,0.5,tween.TRANS_LINEAR,tween.EASE_IN_OUT)
	tween.start() #play the tween


func hasKeycard(DoorColour):
	print(playerNode.inventory)
	for i in playerNode.inventory:
		if i.ID == 2:
			if i.Color == DoorColour:
				return(true)
		else:
			print("AAAAAAAAAAAAAAAAAA")


