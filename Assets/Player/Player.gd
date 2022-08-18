extends KinematicBody


# Stats
export(int) var MaxHelth
var inventory = {}

# Physics
export(int) var movementSpeed		# How fast the player can move.
export(int) var jumpStrength	# How much force used to make player jump
export(int) var gravity		# Gravity's strength.
export(int) var minCamVerticalAngle		# Limit camera view to straight down.
export(int) var maxCamVerticalAngle	# Limit camera view to straight up.
export(float) var lookSensitivity			# How fast camera moves. 'mouse sensitivity'. 

# vectors
var playerVelocity : Vector3 = Vector3() 	# Players Velocity
var mouseDelta : Vector2 = Vector2()			# How much the mouse has moved since last frame refresh.

# player components
onready var camera = get_node("Camera")		# "attach" the camera to access from script.

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process (delta):
	# rotate camera along X axis
	camera.rotation_degrees -= Vector3(rad2deg(mouseDelta.y), 0, 0) * lookSensitivity * delta
	# clamp the vertical camera rotation
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minCamVerticalAngle, maxCamVerticalAngle)
  
	# rotate player along Y axis
	rotation_degrees -= Vector3(0, rad2deg(mouseDelta.x), 0) * lookSensitivity * delta
  
	# reset the mouse delta vector
	mouseDelta = Vector2()


func _input (event):
	if event.is_action_pressed("p_shoot"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# did the mouse move?
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			mouseDelta = event.relative
		

func _physics_process(delta):
		# reset the x and z velocity
		playerVelocity.x = 0
		playerVelocity.z = 0
		var input = Vector2()
		# movement inputs
		if Input.is_action_pressed("p_foward"):
			input.y -= 1
		if Input.is_action_pressed("p_back"):
			input.y += 1
		if Input.is_action_pressed("p_left"):
			input.x -= 1
		if Input.is_action_pressed("p_right"):
			input.x += 1
		# normalize the input so we can't move faster diagonally
		input = input.normalized()
		# get our forward and right directions
		var forward = global_transform.basis.z
		var right = global_transform.basis.x
		# set the velocity
		playerVelocity.z = (forward * input.y + right * input.x).z * movementSpeed
		playerVelocity.x = (forward * input.y + right * input.x).x * movementSpeed
		# apply gravity
		playerVelocity.y -= gravity * delta
	#	print(playerVelocity.y)
		# move the player
		playerVelocity = move_and_slide(playerVelocity, Vector3.UP)
		# jump if we press the jump button and are standing on the floor
		if Input.is_action_pressed("p_jump") and is_on_floor():
			playerVelocity.y = jumpStrength
