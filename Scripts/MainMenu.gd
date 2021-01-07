extends Control

var button
var label

func _ready():
	button = $Button
	label = $Label
	
	button.connect("pressed", self, "OnButtonPress")
	
	var x = LevelParser.new()
	x.open("res://Assets/game.xml")
	while (x.get_node_name() != "level"):
		x.read()
	label.text = x.get_node_name()

#func _process(delta):
#	ac += delta
#	get_node("Label").text = str(ac)

func OnButtonPress():
	get_tree().change_scene("res://Scenes/Main.tscn")
