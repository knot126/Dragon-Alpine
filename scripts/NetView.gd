extends Control

var chat = null

func _ready():
	chat = $Players
	
	$Back.connect("pressed", self, "exit_to_menu")
	
	g_GameServer.server_init()

func _process(delta):
	chat.text = ""
	
	for p in g_GameServer.players.values():
		chat.text += p.name + "\n"


func exit_to_menu():
	get_tree().change_scene("res://scenes/Menu.tscn")
