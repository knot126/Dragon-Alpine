extends KinematicBody

var speed : float = 0.0   # Unused
var maxSpeed : float = 8.0  # The player's max speed
var minSpeed : float = 1.0  # The player's minium speed
var jumpleft : float = 0.0  # The remaining percent of the jump left

var vel : Vector3 = Vector3(0.0, 0.0, 0.0)

func _ready():
	self.add_to_group("Player")

func _physics_process(delta):
	var veltmp2 : Vector2 = Vector2(0.0, 0.0)
	
	# LEFT and RIGHT
	veltmp2.x += Input.get_action_strength("ui_right")
	veltmp2.x -= Input.get_action_strength("ui_left")
	
	# SPEED_UP and SPEED_DOWN
	veltmp2.y += Input.get_action_strength("ui_up")
	veltmp2.y -= Input.get_action_strength("ui_down")
	
	# Gravity (placeholder)
	if (!self.is_on_floor()):
		vel.y = -6.0
	
	# TODO: Properly compute the jumping behaviours
	# Jumping (placeholder)
	if (Input.get_action_strength("ui_select") and jumpleft <= 0.0):
		jumpleft = 1.0
	
	if (jumpleft > 0.0):
		# vel.y = 0.0 # cancelling gravity
		var jump = (jumpleft * -jumpleft) + 1.0
		jumpleft -= 1.0 * delta
		vel.y = jumpleft
	
	vel.x = 3.0 * veltmp2.x
	vel.y = vel.y * 3.0
	vel.z = -3.0 * veltmp2.y
	
	vel *= delta
	
	self.move_and_collide(vel)

func set_speed_settings(minspd, maxspd, current):
	speed = current
	maxSpeed = maxspd
	minSpeed = minspd

func reset_velocity():
	vel = Vector3(0.0, 0.0, 0.0)

func get_speed():
	return speed

func set_physics_state(fwd, dir):
	pass
