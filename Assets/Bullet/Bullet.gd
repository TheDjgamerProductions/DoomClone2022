extends Area

export(float) var speed
var damage : int = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translation -= global_transform.basis.z * speed * delta


func _on_Area_body_entered(body):
	#print(body)
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()


func _on_Delete_Timer_timeout():
	queue_free()
