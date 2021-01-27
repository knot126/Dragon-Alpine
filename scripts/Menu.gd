extends Control

var button_play
var button_options
var button_exit
var button_start_debug
var label_select_debug
# var version_note

func _ready():
	button_play = $Play
	button_options = $Options
	button_exit = $Exit
	button_start_debug = $DEBUG/START
	label_select_debug = $DEBUG/LEVEL
	
	button_play.connect("pressed", self, "start_game")
	button_exit.connect("pressed", self, "exit_game")
	button_options.connect("pressed", self, "start_options")
	button_start_debug.connect("pressed", self, "set_level_and_play")
	
	g_GameConfig.load_levels()
	label_select_debug.text = g_GameConfig.levels[g_GameConfig.level]
	$DEBUG/SYSID.text = OS.get_unique_id()

func start_game():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/Main.tscn")

func start_options():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/Options.tscn")

func exit_game():
	get_tree().quit(0)

func set_level_and_play():
	g_GameConfig.debug_level = label_select_debug.text
	self.start_game()
