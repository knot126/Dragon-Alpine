extends Control

var button
var label

func _ready():
	button = $Button
	label = $Label
	
	button.connect("pressed", self, "OnButtonPress")
	
	var x = LevelParser.new()
	x.open("res://assets/game.xml")
	while (x.get_node_name() != "level"):
		x.read()
	label.text = x.get_node_name()
	label.text += x.get_attribute_name(0)

func OnButtonPress():
	get_tree().change_scene("res://scenes/Main.tscn")
