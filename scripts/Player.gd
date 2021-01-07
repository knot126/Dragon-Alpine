extends RigidBody

var forward = 0.0
var maxSpeed = 0.0
var minSpeed = 0.0
var direction = 0.0

func _ready():
	add_to_group("Player")

func _physics_process(delta):
	# Update speed
	forward -= (Input.get_action_strength("ui_down")) * 0.3
	forward += (Input.get_action_strength("ui_up")) * 0.3
	
	if (forward > maxSpeed):
		forward = maxSpeed
	if (forward < minSpeed):
		forward = minSpeed
	
	# Update left and right movement
	direction = (Input.get_action_strength("ui_right")) - (Input.get_action_strength("ui_left"))

func _integrate_forces(state):
	self.add_central_force(Vector3(0.0, 0.0, -3.0 * forward))
	self.add_central_force(Vector3(3.0 * direction, 0.0, 0.0))

func set_speed_settings(minspd, maxspd, current):
	forward = current
	maxSpeed = maxspd
	minSpeed = minspd

func get_speed():
	return forward

func set_physics_state(fwd, dir):
	pass
