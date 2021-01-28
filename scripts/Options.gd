extends Control

func _ready():
	var button_back = $Main/Back
	var button_mobile = $Main/MobileCtrlToggle
	var button_debug = $Main/DebugCtrlToggle
	
	button_back.connect("pressed", self, "back_to_menu")
	button_mobile.connect("toggled", self, "tog_mobile_controls")
	button_mobile.pressed = g_GameConfig.enable_touch_controls
	button_debug.connect("toggled", self, "tog_dbg_controls")
	button_debug.pressed = g_GameConfig.enable_debug_features

func back_to_menu():
	get_tree().change_scene("res://scenes/Menu.tscn")

func tog_mobile_controls(state):
	g_GameConfig.enable_touch_controls = state

func tog_dbg_controls(state):
	g_GameConfig.enable_debug_features = state
