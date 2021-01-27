extends Control

func _ready():
	var button_back = $Main/Back
	var button_mobile = $Main/MobileCtrlToggle
	
	button_back.connect("pressed", self, "back_to_menu")
	button_mobile.connect("toggled", self, "tog_mobile_controls")
	button_mobile.pressed = g_GameConfig.enable_touch_controls

func back_to_menu():
	get_tree().change_scene("res://scenes/Menu.tscn")

func tog_mobile_controls(state):
	g_GameConfig.enable_touch_controls = state
