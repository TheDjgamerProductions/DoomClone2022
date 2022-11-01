extends CSGBox


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body.name == "Player":
		if body.currentHealth == 100:
			pass
		elif body.currentHealth + 10 >=100:
			body.currentHealth = 100
			queue_free()
		else:
			body.currentHealth += 10
			queue_free()
