extends Control

var debug_expanded = false
var debug_n

func _ready():
	if (g_GameConfig.enable_debug_features):
		debug_n = $DbgWindow
		
		debug_n.get_node("show").connect("pressed", self, "show_debug")
		debug_n.get_node("Main/setpos").connect("pressed", self, "set_player_pos")
		debug_n.rect_size = Vector2(200, 50)
		debug_n.get_node("Main").visible = false
	else:
		debug_n.free()
	
	self.connect("Player.player_dead", self, "show_dead")
	self.hide_dead()

func _process(delta):
	pass

func _input(event):
	if (event is InputEventScreenDrag) and ($DbgWindow.has_focus()):
		$DbgWindow.rect_position += event.relative

func updateHud(score, gems, speed):
	$Gems.text = str(gems)
	$Score.text = str(score)
	$Speed.text = str(speed) + "m/s"

func update_debug(params):
	#if (debug_n):
	#	debug_n.get_node("Main/inf1").text = str(params["dcoli"])
	pass

func show_debug():
	if (!debug_expanded):
		debug_n.rect_size = Vector2(200, 1280)
		debug_n.get_node("Main").visible = true
	else:
		debug_n.rect_size = Vector2(200, 50)
		debug_n.get_node("Main").visible = false
	debug_expanded = !debug_expanded

func show_dead(message):
	$Message.text = message
	$Message.visible = true

func hide_dead():
	$Message.visible = false

func set_player_pos():
	var a = []
	for c in Array($DbgWindow/Main/pos.text.split(" ")): a.append(int(c))
	get_tree().get_root().get_node("GameSpace").set_pos(Vector3(a[0], a[1], a[2]))
