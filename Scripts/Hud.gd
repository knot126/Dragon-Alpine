extends CanvasLayer

func _ready():
	pass

func _process(delta):
	pass

func updateHud(score, gems, speed):
	$Gems.text = str(gems)
	$Score.text = str(score)
	$Speed.text = str(speed) + "m/s"
