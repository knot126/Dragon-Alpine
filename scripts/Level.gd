extends Spatial

var next_pos : float = 0.0
var room_offset : float = 0.0
var loaded_segments = []
var rooms = []
var next_room : int = 0
var player_pos : float = 0.0

func _ready():
	if (!g_GameConfig.debug_level):
		rooms = self.load_level(g_GameConfig.levels[g_GameConfig.level])
	else:
		rooms = self.load_level(g_GameConfig.debug_level)

func _physics_process(delta):
	if (player_pos > next_pos - 16):
		if (not len(rooms) < next_room):
			self.load_room(rooms[next_room])
			next_room += 1
		else:
			g_GameConfig.inc_level()
			rooms = self.load_level(g_GameConfig.levels[g_GameConfig.level])
			next_room = 0

func load_level(name : String):
	var level = XMLParser.new()
	var rooms = []
	
	level.open("res://assets/levels/" + name + ".xml")
	
	while(!level.read()):
		if (level.get_node_name() == "room"):
			var rn = level.get_named_attribute_value_safe("name")
			print("Queued room '", rn, "'.")
			rooms.append(rn)
	
	return rooms

func load_room(name : String, smashhit : bool = false):
	var segments = []
	var target_length : int = 0
	var room = XMLParser.new()
	
	room.open("res://assets/rooms/" + name + ".xml")
	
	while (!room.read()):
		if (room.get_node_name() == "segment"):
			segments.append(room.get_named_attribute_value_safe("name"))
		
		elif (room.get_node_name() == "room"):
			if (!target_length):
				target_length = float(room.get_named_attribute_value_safe("length"))
	
	while (target_length > 0.0):
		target_length -= self.load_segment(segments[randi() % len(segments)], smashhit)

func load_segment(name : String, smashhit_compat : bool = false):
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
		
		elif (seg.get_node_name() == "box"):
			var size = Array(seg.get_named_attribute_value_safe("size").split_floats(" "))
			var pos  = Array(seg.get_named_attribute_value_safe("pos").split_floats(" "))
			
			if (!size or !pos):
				continue
			
			var mesh = MeshInstance.new()
			mesh.mesh = CubeMesh.new()
			
			mesh.mesh.size = Vector3(size[0], size[1], size[2])
			if (smashhit_compat): mesh.mesh.size = Vector3(size[0]*2, size[1]*2, size[2]*2)
			mesh.translation = Vector3(pos[0], pos[1], pos[2] - next_pos + room_offset)
			
			mesh.create_trimesh_collision()
			self.add_child(mesh)
			components.append(mesh)
		
		elif (seg.get_node_name() == "script"):
			print("Script triggers are not supported in godot. In seg ", name)
		
		elif (seg.get_node_name() == "obstacle"):
			print("ScriptedObstacle is not supported in godot. In seg ", name)
	
	next_pos += seg_size
	loaded_segments.append(components)
	return seg_size
