extends Control

var chat = null

func _ready():
	chat = $Players
	
	g_GameServer.server_init()

func _process(delta):
	chat.text = ""
	
	for p in g_GameServer.players.values():
		chat.text += p.name + "\n"
