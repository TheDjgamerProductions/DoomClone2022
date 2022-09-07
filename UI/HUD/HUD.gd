extends Control



# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Inventory.clear()
	for i in player.inventory:
		var itemID = i.ID
		print(Global.itemID)
		$Inventory.add_item("Item: " + str(itemID),null, true)
