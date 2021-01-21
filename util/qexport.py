# Quick Run level and segment export
# Copyright (C) 2021 Decent Games

bl_info = {
    "name": "Quick Run Blender Builder",
    "description": "Stage exporter for quick run",
    "author": "Decent Games",
    "version": (0, 0, 3),
    "blender": (2, 80, 0),
    "location": "",
    "warning": "", # used for warning icon and text in addons panel
    "wiki_url": "",
    "tracker_url": "",
    "category": "Development"
}

import bpy
from bpy.props import (StringProperty, IntProperty, BoolProperty, FloatProperty, FloatVectorProperty, EnumProperty, PointerProperty)
from bpy.types import (Panel, Menu, Operator, PropertyGroup)

# Quick Run segment properties

class QuickRunProperties(PropertyGroup):
	colour : FloatVectorProperty(
			
		)
