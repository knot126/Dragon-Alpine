extends Node

var players = {}
var connection_info = {"status": "Unused"}
var player_info = {name = "MyTestName", pos = Vector3()}

func _ready():
	var tree = get_tree()
	tree.connect("network_peer_connected", self, "peer_connect")
	tree.connect("network_peer_disconnected", self, "peer_disconnect")
	tree.connect("connected_to_server", self, "on_connect_done")
	tree.connect("server_disconnected", self, "on_kick")
	tree.connect("connection_failed", self, "on_connect_fail")

func reset():
	players = {}

func server_init():
	print("Create server on port 13660, max 12 clients.")
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(13660, 12)
	get_tree().network_peer = peer

func client_init(addr):
	print("Connect to server ", addr, " at port 13660.")
	connection_info["status"] = "Waiting"
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(addr, 13660)
	get_tree().network_peer = peer

func network_stop():
	get_tree().network_peer = null

func peer_connect(id):
	rpc_id(id, "register_player", player_info)

func peer_disconnect(id):
	players.erase(id)

func on_connect_done():
	connection_info["status"] = "Connected"

func on_kick():
	pass

func on_connect_fail():
	connection_info["status"] = "Failed"

remote func register_player(info):
	var id = get_tree().get_rpc_sender_id()
	players[id] = info
