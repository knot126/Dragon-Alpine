extends Spatial

func _ready():
	self.add_to_group("Gem")

func _physics_process(delta):
	self.rotation_degrees += (Vector3(0.0, 100.0, 0.0) * delta)
