extends CanvasLayer

var debug_expanded = false

func _ready():
	$debug/show.connect("pressed", self, "show_debug")
	$debug.rect_size = Vector2(200, 30)

func _process(delta):
	pass

func updateHud(score, gems, speed):
	$Gems.text = str(gems)
	$Score.text = str(score)
	$Speed.text = str(speed) + "m/s"

func update_debug(params):
	$debug/inf1.text = str(params["dcoli"])

func show_debug():
	if (!debug_expanded):
		$debug.rect_size = Vector2(200, 1280)
	else:
		$debug.rect_size = Vector2(200, 30)
	debug_expanded = !debug_expanded
