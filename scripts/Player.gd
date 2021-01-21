extends KinematicBody

var speed : float = 0.0       # The player's current speed
var max_speed : float = 5.0   # The player's max speed
var min_speed : float = 2.25  # The player's minium speed
var jumpleft : float = 0.0    # The remaining percent of the jump left

func _ready():
	self.add_to_group("Player")

func _physics_process(delta):
	var vel : Vector3 = Vector3(0.0, 0.0, 0.0)
	var side_move : float = 0.0
	
	# Update speed
	
	# LEFT and RIGHT
	side_move += Input.get_action_strength("ui_right")
	side_move -= Input.get_action_strength("ui_left")
	
	# SPEED_UP and SPEED_DOWN
	speed += Input.get_action_strength("ui_up") * 0.06
	speed -= Input.get_action_strength("ui_down") * 0.06
	
	# TODO: SEMIDONE: Properly compute the jumping behaviour
	# Set if the player should be in the jumping state
	if (Input.get_action_strength("ui_select") and jumpleft <= -1.0):
		jumpleft = 1.0
	
	# Compute the current jump
	if (jumpleft > -1.0):
		var jump = (jumpleft * -jumpleft) + 1.0
		jumpleft -= 1.0 * delta
		vel.y = jumpleft
	
	var col = self.test_move(self.transform, Vector3(0,0.001,0))
	if (!col and jumpleft <= -1.0):
		var i = randf()
		var fall = (i * -i) + 1
		vel.y = -fall
	
	if (speed > max_speed):
		speed = max_speed
	if (speed < min_speed):
		speed = min_speed
	
	vel.x = side_move * speed
	vel.y = vel.y * speed * 0.8
	vel.z = -speed
	
	# Making sure everything is against the delta time
	vel *= delta
	
	self.move_and_collide(vel)

func set_speed_settings(minspd, maxspd, current):
	if (speed != null):
		speed = current
	max_speed = maxspd
	min_speed = minspd

func get_speed():
	return speed

func get_debug():
	return {"dcoli": self.test_move(self.transform, Vector3(0,0.001,0))}

func set_physics_state(fwd, dir):
	pass
