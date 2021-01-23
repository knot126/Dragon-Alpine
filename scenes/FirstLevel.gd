extends Spatial

var next_pos = 0.0

func _ready():
	var s = $MeshInstance
	s.create_trimesh_collision()

func _physics_process(delta):
	pass

func load_segment(name : String):
	var seg = XMLParser.new()
	
	
