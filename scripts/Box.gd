extends StaticBody
class_name Box

export var x = -1.0
export var y = -1.0
export var z = -1.0

func _ready():
	if (x > 0.0 and y > 0.0 and z > 0.0):
		setp(x, y, z)

func setp(sx, sy, sz):
	$visible_mesh.mesh.size = Vector3(sx/2, sy/2, sz/2)
	$collision.shape.extents = Vector3(sx, sy, sz)
