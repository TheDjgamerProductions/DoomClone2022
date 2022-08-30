extends Spatial

var playerNear = false
onready var collider = get_node("Keycard Door/StaticBody/CollisionShape")
export(String) var keycard_colour
onready var tween = get_node("Tween")
onready var closedPosition = self.global_transform.origin
export(int) var openHight


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print(closedPosition)
	hasKeycard("red")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if playerNear && Input.is_action_just_pressed("p_interact"): #Checks if the player is near and has pressed the interact key
		#if hasKeycard(Colour):
			#open()
		open()
		
	

#Checks if the body entered is a player
func _on_Area_body_entered(body:Node):
	if (body.name) == "Player":
		print("Player Near")
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


func hasKeycard(Colour):
	print(Colour)
	#for i in Player Inventory:
		#If Is a key card
			#if is same colour
				#return true and break


