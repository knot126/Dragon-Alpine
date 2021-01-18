extends Spatial

const senseitivity = 5
const defSpeed = 1.75
const minSpeed = 1.25
const maxSpeed = 8.0

var gems = 0
var score = 0
var direction = 0.0

var camera = null
var player = null
var hud = null

func _ready():
	camera = $Camera
	player = $Player
	hud = $GameHud
	
	player.set_speed_settings(minSpeed, maxSpeed, defSpeed)

func _process(delta):
	# lol don't use "get_action_strength" here FIXME
	if (Input.get_action_strength("ui_cancel") > 0.1):
		self.leaveGame()

func _physics_process(delta):
	# I just do most everything here since I think that would make some sense?
	# Update at a fixed rate would seem to make sense for e.g. the camera.
	
	# Update camera position
	camera.translation.z = player.translation.z + 4.0
	
	# Update the score
	score = int(-player.translation.z - 2)
	
	# Update the HUD
	hud.updateHud(score, gems, player.get_speed())

func getScore():
	return score

func getGems():
	return gems

func getPlayerPos():
	return player.transform.location

func getMap():
	return g_GameConfig.levels[g_GameConfig.level]

func getMapAndInc():
	g_GameConfig.level += 1
	return self.getMap()

func loadSegment(name):
	pass

func leaveGame():
	get_tree().change_scene("res://scenes/Menu.tscn")
	
	# Savestate
	var f = File.new()
	f.open("user://savegame.txt", File.WRITE)
	f.store_string("[MAIN]\ngems = " + str(gems) + "\nscore = " + str(score) + "\nmap = " + self.getMap())
	f.close()
