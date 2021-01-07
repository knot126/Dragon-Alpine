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

func _physics_process(delta):
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
