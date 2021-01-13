extends Node

var root = null
var game_config = null
var menu_scene = null

func _ready():
	root = get_node("/root")
	menu_scene = preload("res://scenes/Menu.tscn").instance()
	get_tree().change_scene_to(menu_scene)
