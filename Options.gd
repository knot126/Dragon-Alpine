extends Control

func _ready():
	var button_back = $Back
	
	button_back.connect("pressed", self, "back_to_menu")

func back_to_menu():
	get_tree().change_scene("res://scenes/Menu.tscn")
