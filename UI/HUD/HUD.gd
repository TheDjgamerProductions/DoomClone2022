extends Control



# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player = $"../"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Inventory.clear()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.inventory != []:
		$Inventory.select(player.selectedItem)
	$CenterContainer/InteractTip.text = player.tooltipText
	$ScoreLabel.text = ("Score: " + str(Global.score))
	$Hart.value = player.currentHealth
	$HealthLabel.text = str(player.currentHealth)
	
func updateHud():
	print("updiang HUD")
	$Inventory.clear()
	for i in player.inventory:
		print(i)
		var itemID = i.ID
		var item = Global.itemDB[itemID]
		var itemName = item.Name
		var itemIcon = load(item.Icon)
		$Inventory.add_item(itemName,itemIcon, true)
