extends Node

signal hud_message(message)

var levels = []
var level : int = 0
var debug_level : String = ""
var game_version = [0, 0, 5, "-dev0"]
var enable_touch_controls : bool = true
var enable_debug_features : bool = true
var enable_demo_mode      : bool = false
var enable_name_hide      : bool = false

func _ready():
	if (enable_demo_mode):
		game_version[3] = "-demo"
		enable_debug_features = false
		enable_touch_controls = false
	self.load_levels()

func load_levels():
	var x = XMLParser.new()
	x.open("res://assets/game.xml")
	while (x.get_node_name() != "level"):
		x.read()
	while (x.get_node_name() == "level"):
		levels.append(x.get_attribute_value(0))
		x.read()
		x.read()

func inc_level():
	level = level + 1

func get_game_version_string():
	return str(game_version[0]) + "." + str(game_version[1]) + "." + str(game_version[2]) + game_version[3]
