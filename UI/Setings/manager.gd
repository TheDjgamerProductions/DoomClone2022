extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_FOV_value_changed(value):
	Global.settings.FOV = $"../FOV".value
	$"../fovAmount".text = str($"../FOV".value)


func _on_CheckButton_toggled(button_pressed):
	Global.settings.DrunkMode = button_pressed
