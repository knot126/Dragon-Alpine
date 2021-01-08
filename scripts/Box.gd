extends RigidBody

class_name Box

func set_properties(sx, sy, sz):
	$visible_mesh.mesh.size = Vector3(sx/2, sy/2, sz/2)
	$collision.shape.extents = Vector3(sx, sy, sz)
