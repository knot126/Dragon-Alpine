extends Spatial

func _ready():
	pass

func _physics_process(dt):
	$Camera.translation.z += Input.get_action_strength("ui_down") * dt * 10.0
	$Camera.translation.z -= Input.get_action_strength("ui_up") * dt * 10.0
	$Camera.translation.x += Input.get_action_strength("ui_right") * dt * 10.0
	$Camera.translation.x -= Input.get_action_strength("ui_left") * dt * 10.0
	$Camera.rotation_degrees.x += Input.get_action_strength("key_q") * dt * 30.0
	$Camera.rotation_degrees.x -= Input.get_action_strength("key_w") * dt * 30.0
	$Camera.rotation_degrees.y += Input.get_action_strength("key_a") * dt * 50.0
	$Camera.rotation_degrees.y -= Input.get_action_strength("key_s") * dt * 50.0
