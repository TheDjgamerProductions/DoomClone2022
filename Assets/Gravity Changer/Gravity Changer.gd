extends CSGBox


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



var itemID = 1
var is_Active = false



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input (event):
	if is_Active:
		if event.is_action_released("ui_up"):
			Global.playerNode.jumpStrength -= 1
		if event.is_action_released("ui_down"):
			Global.playerNode.jumpStrength += 1
