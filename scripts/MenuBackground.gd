extends Spatial

var cubes = []

func _ready():
	pass

func _process(delta):
	$Camera.translation += Vector3(0.0, 0.0, -2.0 * delta)
	$Camera.rotation_degrees += Vector3(0.0, 0.0, 5.0 * delta)
