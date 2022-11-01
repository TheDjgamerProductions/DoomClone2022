extends Node

var itemDB = [
	{"ID": 0, "Name": "Test Item", "Type": "Weapon", "DmgMin": 0, "DmgMax": 10,"Icon": "res://icon.png", "Model": ""},
	{"ID": 1, "Name": "Gravity Changer", "Type": "Gadget", "Script": "res://Assets/Gravity Changer/Gravity Changer.gd" ,"Icon": "res://icon.png", "Model": preload("res://Assets/Gravity Changer/Gravity Changer.tscn")},
	{"ID": 2, "Name": "Keycard", "Type": "Keycard","Icon": "res://icon.png", "Model": ""}
 ]

var enemyDB = [
	{"ID": 0, "Name": "Basic","Dmg_Min":5,"Dmg_Max":10,"Speed":50,"Health":10,"Detection_Radius":5}


]

var score = 0

var playerNode : Node

var settings = {
	"FOV": 90.0,
	"DrunkMode": false
	
	
}
 

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
