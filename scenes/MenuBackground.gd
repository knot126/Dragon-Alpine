extends Spatial

var cubes = []

func _ready():
	cubes = [$MeshInstance, $MeshInstance2, $MeshInstance3, $MeshInstance4, $MeshInstance5, $MeshInstance6, $MeshInstance7, 
			 $MeshInstance8, $MeshInstance9, $MeshInstance10, $MeshInstance11]

func _process(delta):
	for c in cubes:
		c.translation.y += ((randi() % 3) - 1) * delta
