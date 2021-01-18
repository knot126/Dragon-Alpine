extends Node

var keymap = {}
var levels = []
var level : int = 0
var debug_level : String = ""

func load_levels():
	var x = XMLParser.new()
	x.open("res://assets/game.xml")
	while (x.get_node_name() != "level"):
		x.read()
	# label.text += "\n"
	while (x.get_node_name() == "level"):
		# label.text += x.get_node_name() + " "
		# label.text += x.get_attribute_name(0) + "="
		# label.text += x.get_attribute_value(0) + "\n"
		levels.append(x.get_attribute_value(0))
		x.read()
		x.read()

func inc_level():
	level = level + 1
