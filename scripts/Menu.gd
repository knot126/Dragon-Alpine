extends Control

onready var button_play = $Play
onready var button_options = $Options
onready var button_exit = $Exit
onready var button_net = $Networking
onready var button_start_debug = $DEBUG/START
onready var label_select_debug = $DEBUG/LEVEL
onready var button_connect_debug = $DEBUG/CONNECT
onready var buttons = [$Play, $Options, $Networking, $Exit]
# var version_note

func _ready():
	button_play.connect("pressed", self, "start_game")
	button_exit.connect("pressed", self, "exit_game")
	button_options.connect("pressed", self, "start_options")
	button_net.connect("pressed", self, "start_network")
	
	g_GameConfig.load_levels()
	
	if (g_GameConfig.enable_demo_mode):
		buttons = [$Play, $Exit]
		$Options.free()
		$Networking.free()
		$Play.text = "Play Demo"
	
	if (g_GameConfig.enable_debug_features):
		button_start_debug.connect("pressed", self, "set_level_and_play")
		button_connect_debug.connect("pressed", self, "do_server_routine")
		label_select_debug.text = g_GameConfig.levels[g_GameConfig.level]
		$DEBUG/SYSID.text = OS.get_unique_id()
	else:
		$DEBUG.free()
	
	var v = 0
	for b in buttons:
		b.rect_position += Vector2(0, v)
		v += 60

func _process(delta):
	# This is only used for network stuff
	
	if (g_GameConfig.enable_debug_features):
		if (g_GameServer.connection_info["status"] == "Failed"):
			$DEBUG/NETLAB.text = "Failed to connect to " + $DEBUG/NETADDR.text + "!"
		elif (g_GameServer.connection_info["status"] == "Waiting"):
			$DEBUG/NETLAB.text = "Connecting..."
		elif (g_GameServer.connection_info["status"] == "Connected"):
			$DEBUG/NETLAB.text = "Connected to " + $DEBUG/NETADDR.text + "!"

func start_game():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/Main.tscn")

func start_options():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/Options.tscn")

func start_network():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/NetMenu.tscn")

func exit_game():
	get_tree().quit(0)

func set_level_and_play():
	g_GameConfig.debug_level = label_select_debug.text
	self.start_game()

func do_server_routine():
	if ($DEBUG/SERVER.pressed):
		get_tree().change_scene("res://scenes/NetView.tscn")
	else:
		g_GameServer.client_init($DEBUG/NETADDR.text)
