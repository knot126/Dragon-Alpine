# Quick Run level and segment export
# Copyright (C) 2021 Decent Games

bl_info = {
    "name": "Quick Run Blender Builder",
    "description": "Stage exporter for quick run",
    "author": "Decent Games",
    "version": (2021, 2, 5),
    "blender": (2, 80, 0),
    "location": "",
    "warning": "", # used for warning icon and text in addons panel
    "wiki_url": "",
    "tracker_url": "",
    "category": "Development"
}

import bpy
import bpy_extras
import xml.etree.ElementTree as et

from bpy.props import (StringProperty, IntProperty, BoolProperty, FloatProperty, FloatVectorProperty, EnumProperty, PointerProperty)
from bpy.types import (Panel, Menu, Operator, PropertyGroup)

MAX_STRING_LENGTH = 500

# Get an XML segment root node
def make_root_node(scene):
	properties = {"size": scene.QuickRun.size}
	
	node = et.Element("segment", properties)
	node.text = "\n\t"
	
	return node

# Add an object to a root node
def add_object(root, obj, last):
	properties = {}
	
	properties["pos"] = str(obj.location[1]) + " " + str(obj.location[2]) + " " + str(obj.location[0])
	
	if (obj.QuickRun.kind == "BOX"):
		properties["size"] = str(obj.dimensions[1]) + " " + str(obj.dimensions[2]) + " " + str(obj.dimensions[0])
	elif (obj.QuickRun.kind == "SCRIPT"):
		properties["size"] = str(obj.dimensions[1]) + " " + str(obj.dimensions[2])
	
	if (obj.QuickRun.template and obj.QuickRun.template != "Change me!"):
		properties["template"] = obj.QuickRun.template
	
	if (obj.QuickRun.script and obj.QuickRun.script != "Change me!"):
		properties["script"] = obj.QuickRun.script
		
		if (obj.QuickRun.params and obj.QuickRun.params != "{}"):
			properties["params"] = obj.QuickRun.params
	
	kind = "null"
	if (obj.QuickRun.kind == "BOX"):
		kind = "box"
	elif (obj.QuickRun.kind == "ITEM"):
		kind = "item"
	elif (obj.QuickRun.kind == "OBSTACLE"):
		kind = "obstacle"
	elif (obj.QuickRun.kind == "SCRIPT"):
		kind = "script"
	
	node = et.SubElement(root, kind, properties)
	
	node.tail = "\n\t"
	if (last): # This hack is needed so the last line is not indented
		node.tail = "\n"

# Export the stage to file
def export_stage_to_file(path, context):
	tree = make_root_node(bpy.context.scene)
	
	for i in range(len(bpy.data.objects)):
		obj = bpy.data.objects[i]
		
		last = False
		if (i == len(bpy.data.objects) - 1): last = True
		
		add_object(tree, obj, last)
	
	# Write the segment
	
	file_header = "<!-- Exported with Quick Run Blender Creator ver " + str(bl_info["version"][0]) + "-" + str(bl_info["version"][1]) + "-" + str(bl_info["version"][2]) + " -->\n"
	contents = file_header + et.tostring(tree, encoding = "unicode")
	
	with open(path, "w") as f:
		f.write(contents)
	
	return {"FINISHED"}

# Export operation
class QuickRunExport(bpy.types.Operator, bpy_extras.io_utils.ExportHelper):
	bl_idname = "quick_run.export"
	bl_label = "Export Quick Run Segment"
	
	filename_ext = ".xml"
	filter_glob = StringProperty(
		default = '*.xml',
		options = {'HIDDEN'},
		maxlen = MAX_STRING_LENGTH,
		)
	
	def execute(self, context):
		return export_stage_to_file(self.filepath, context)

def draw_export(self, context):
	self.layout.operator("quick_run.export", text="Quick Run Stage (.xml)")

# Quick Run segment properties
class QuickRunObjectProperties(PropertyGroup):
	
	template: StringProperty(
		name = "Template",
		description = "The template for this object",
		default = "Change me!",
		maxlen = MAX_STRING_LENGTH,
		)
	
	script: StringProperty(
		name = "Script",
		description = "The name of the script in the obstacles or scripts directory",
		default = "Change me!",
		maxlen = MAX_STRING_LENGTH,
		)
	
	kind: EnumProperty(
		name = "Kind",
		description = "The kind of object that the currently selected object should be treated as. Data will be exported as an invalid entity.",
		items = [ ('BOX', "Box", "A simple box"),
				  ('ITEM', "Gem (Item)", "Collectable item or gem"),
				  ('OBSTACLE', "Scripted Obstacle", "Obstacle created by a script"),
				  ('SCRIPT', "Script Trigger", "Script trigger panel"),
				],
		default = "BOX"
		)
	
	params: StringProperty(
		name = "Script Paramaters",
		description = "Script or item paramater(s), as a JSON object",
		default = "{}",
		maxlen = MAX_STRING_LENGTH,
		)

class QuickRunSegmentProperties(PropertyGroup):
	
	size: StringProperty(
		name = "Size",
		description = "The size of this segment. The first two properties are not used",
		default = "12.0 10.0 16.0",
		maxlen = MAX_STRING_LENGTH,
		)

# The panel in the items menu
class QuickRunObjectPanel(Panel):
	bl_label = "Quick Run Object"
	bl_idname = "OBJECT_PT_quickrun_object_panel"
	bl_space_type = "VIEW_3D"   
	bl_region_type = "UI"
	bl_category = "Item"
	bl_context = "objectmode"
	
	@classmethod
	def poll(self, context):
		return context.object is not None
	
	def draw(self, context):
		layout = self.layout
		object = context.object
		QuickRunObjectProperties = object.QuickRun
		
		layout.prop(QuickRunObjectProperties, "kind")
		if (QuickRunObjectProperties.kind != "BOX"):
			if (QuickRunObjectProperties.kind != "ITEM"):
				layout.prop(QuickRunObjectProperties, "script")
			layout.prop(QuickRunObjectProperties, "params")
		layout.prop(QuickRunObjectProperties, "template")
		
		layout.separator()

class QuickRunSegmentPanel(Panel):
	bl_label = "Quick Run Segment"
	bl_idname = "OBJECT_PT_quickrun_segment_panel"
	bl_space_type = "VIEW_3D"
	bl_region_type = "UI"
	bl_category = "Scene"
	bl_context = "objectmode"
	
	@classmethod
	def poll(self, context):
		return context.scene is not None
	
	def draw(self, context):
		layout = self.layout
		scene = context.scene
		QuickRunSegmentProperties = scene.QuickRun
		
		layout.prop(QuickRunSegmentProperties, "size")
		
		layout.separator()

# Classes in this script
classes = (
	QuickRunObjectProperties,
	QuickRunObjectPanel,
	QuickRunSegmentProperties,
	QuickRunSegmentPanel,
	QuickRunExport
)

def register():
	from bpy.utils import register_class
	
	for c in classes:
		register_class(c)
	
	bpy.types.Object.QuickRun = PointerProperty(type=QuickRunObjectProperties)
	bpy.types.Scene.QuickRun = PointerProperty(type=QuickRunSegmentProperties)
	
	bpy.types.TOPBAR_MT_file_export.append(draw_export)

def unregister():
	from bpy.utils import unregister_class
	
	for c in reversed(classes):
		unregister_class(c)
