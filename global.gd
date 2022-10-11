extends Node

var itemDB = [
	{"ID": 0, "Name": "Test Item", "Type": "Weapon", "DmgMin": 0, "DmgMax": 10,"Icon": "res://icon.png", "Model": ""},
	{"ID": 1, "Name": "Test Item 1", "Type": "Gadget", "Script": "" ,"Icon": "res://icon.png", "Model": ""},
	{"ID": 2, "Name": "Keycard", "Type": "Keycard","Icon": "res://icon.png", "Model": ""}
 ]

var enemyDB = [
	{"ID": 0, "Name": "Basic","DmgMin":5,"DmgMax":10,"Speed":1,"Health":10,"DetectionRadius":5}


]

var score = 0

var playerNode : Node
 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_tree().get_nodes_in_group("Player")
	if player:
		
		playerNode = player[0]
		set_process(false)
	else:
		print("sad")
