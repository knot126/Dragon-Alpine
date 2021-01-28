extends CanvasLayer

var debug_expanded = false
var debug_n

func _ready():
	if (g_GameConfig.enable_debug_features):
		$debug/show.connect("pressed", self, "show_debug")
		$debug.rect_size = Vector2(200, 30)
		debug_n = $debug
	else:
		$debug.free()

func _process(delta):
	pass

func updateHud(score, gems, speed):
	$Gems.text = str(gems)
	$Score.text = str(score)
	$Speed.text = str(speed) + "m/s"

func update_debug(params):
	if (debug_n):
		$debug/inf1.text = str(params["dcoli"])

func show_debug():
	if (!debug_expanded):
		$debug.rect_size = Vector2(200, 1280)
	else:
		$debug.rect_size = Vector2(200, 30)
	debug_expanded = !debug_expanded
