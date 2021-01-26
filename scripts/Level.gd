extends Spatial

var next_pos = 0.0
var room_offset = 0.0
var segments = []

func _ready():
	var s = $MeshInstance
	s.create_trimesh_collision()
	
	var mesh = MeshInstance.new()
	mesh.mesh = CubeMesh.new()
	
	mesh.mesh.size = Vector3(1, 1, 1)
	mesh.translation = Vector3(0, 0, -8)
	
	for i in range(10):
		self.load_segment("test")

func _physics_process(delta):
	pass

func load_room(name : String):
	pass

func load_segment(name : String):
	var seg = XMLParser.new()
	var components = []
	var seg_size : float = 0.0
	
	seg.open("res://assets/segments/" + name + ".xml")
	
	while (!seg.read()):
		if (seg.get_node_name() == "segment"):
			var length = seg.get_named_attribute_value_safe("size")
			if (!length):
				continue
			
			length = Array(length.split_floats(" "))
			seg_size += length[2]
		
		if (seg.get_node_name() == "box"):
			var size = Array(seg.get_named_attribute_value_safe("size").split_floats(" "))
			var pos  = Array(seg.get_named_attribute_value_safe("pos").split_floats(" "))
			
			if (!size or !pos):
				continue
			
			var mesh = MeshInstance.new()
			mesh.mesh = CubeMesh.new()
			
			mesh.mesh.size = Vector3(size[0], size[1], size[2])
			mesh.translation = Vector3(pos[0], pos[1], pos[2] - next_pos + room_offset)
			
			mesh.create_trimesh_collision()
			self.add_child(mesh)
			segments.append(components)
	
	next_pos += seg_size
	segments.append(components)
