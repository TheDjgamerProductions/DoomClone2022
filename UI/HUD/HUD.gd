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
	$ScoreLabel.text = ("Score: " + str(Global.score))
	$Inventory.clear()
	for i in player.inventory:
		var itemID = i.ID
		var item = Global.itemDB[itemID]
		var itemName = item.Name
		var itemIcon = load(item.Icon)
		$Inventory.add_item(itemName,itemIcon, true)
	$Hart.value = player.currentHealth
	$HealthLabel.text = str(player.currentHealth)
