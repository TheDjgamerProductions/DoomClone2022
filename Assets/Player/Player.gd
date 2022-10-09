extends KinematicBody


# Stats
export(int) var MaxHelth
var inventory = []
var ammo : int = 15
var currentHealth
var tooltipText = ""



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
onready var holdPosition = $Camera/HoldPosition
var held_object: Object
var isHoldng = false
onready var bulletScene = preload("res://Assets/Bullet/Bullet.tscn")
onready var bulletPOS = $bulletSpawn






# Called when the node enters the scene tree for the first time.
func _ready():
	currentHealth = MaxHelth
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process (delta):
	if currentHealth == 0:
		get_tree().change_scene("res://UI/Death Screen/Death Screen.tscn")
	# rotate camera along X axis
	camera.rotation_degrees -= Vector3(rad2deg(mouseDelta.y), 0, 0) * lookSensitivity * delta
	# clamp the vertical camera rotation
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minCamVerticalAngle, maxCamVerticalAngle)
  
	# rotate player along Y axis
	rotation_degrees -= Vector3(0, rad2deg(mouseDelta.x), 0) * lookSensitivity * delta
  
	# reset the mouse delta vector
	mouseDelta = Vector2()


func _input (event):
	if Input.is_action_just_pressed("p_shoot"):
		shoot()
	
	if event.is_action_pressed("p_interact"):
		print("Interact")
		if $Camera/RayCast.is_colliding():
			var raycastObject = $Camera/RayCast.get_collider()
			print(raycastObject.name)
			if canPickup(raycastObject):
				pickupItem(raycastObject)
				raycastObject.queue_free()
			elif canMove(raycastObject):
				if isHoldng:
					isHoldng = false
					reparent(raycastObject, get_tree().current_scene)
					raycastObject.global_transform.origin = holdPosition.global_transform.origin
				else:
					isHoldng = true
					reparent(raycastObject, holdPosition)
					raycastObject.global_transform.origin = holdPosition.global_transform.origin
					
					
				
				
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

func canPickup(item):
	if "Item" in item.name:
		return(true)
	else:
		return(false)

func pickupItem(item):
	if item.itemID == 2:
		inventory.append({"ID":2,"quantity": 1,"Color": item.Colour})
		print(inventory)
		return
	for i in inventory:
		if i.ID == item.itemID:
			i.quantity += 1
			print(inventory)
			return
	inventory.append({"ID":item.itemID,"quantity": 1})
	print(inventory)

func canMove(item):
	if ("moveable" in item.name):
		return(true)
	else:
		return(false)

func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)
	
	
	
func shoot():
	var bullet = bulletScene.instance()
	get_tree().get_current_scene().add_child(bullet)
