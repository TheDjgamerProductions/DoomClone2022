extends Camera
var rng = RandomNumberGenerator.new()
var x = 0
var y = 0
var z = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.set_rotation_degrees(Vector3(x,y,z))
	x += rng.randf_range(0.1,0.9)
	y += rng.randf_range(0.1,0.9)
	z += rng.randf_range(0.1,0.9)
