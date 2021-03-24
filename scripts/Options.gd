extends Control

func _ready():
	var button_back = $Main/Back
	var button_mobile = $Main/MobileCtrlToggle
	var button_debug = $Main/DebugCtrlToggle
	var button_demo = $Main/DemoCtrlToggle
	var button_smashhit = $Main/SmashHitToggle
	
	button_back.connect("pressed", self, "back_to_menu")
	
	# Mobile controls button
	button_mobile.connect("toggled", self, "tog_mobile_controls")
	button_mobile.pressed = g_GameConfig.enable_touch_controls
	
	# Debug mode button
	button_debug.connect("toggled", self, "tog_dbg_controls")
	button_debug.pressed = g_GameConfig.enable_debug_features
	
	# Demo mode setting
	button_demo.connect("toggled", self, "tog_demo_controls")
	button_demo.pressed = g_GameConfig.enable_demo_mode
	
	# Smash Hit compatibility setting
	button_smashhit.connect("toggled", self, "tog_smashhit_controls")
	button_smashhit.pressed = g_GameConfig.smash_hit_compat_set

func back_to_menu():
	get_tree().change_scene("res://scenes/Menu.tscn")

func tog_mobile_controls(state):
	g_GameConfig.enable_touch_controls = state

func tog_dbg_controls(state):
	g_GameConfig.enable_debug_features = state

func tog_demo_controls(state):
	g_GameConfig.enable_demo_mode = state

func tog_smashhit_controls(state):
	g_GameConfig.smash_hit_compat_set = state
