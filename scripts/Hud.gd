extends Control

signal hud_init_game_debug

var debug_expanded = false
var debug_window = null
var text_message = null

func _ready():
	debug_window = $DbgWindow
	text_message = $Message
	
	self.connect("hud_init_game_debug", self, "debug_hud_init")
	self.connect("hud_message", self, "show_message")
	
	if (g_GameConfig.enable_debug_features):
		emit_signal("hud_init_game_debug")
	else:
		debug_window.free()
	
	self.hide_message()

func _process(delta):
	pass

func _input(event):
	if (debug_window):
		if (event is InputEventScreenDrag) and (debug_window.has_focus()):
			debug_window.rect_position += event.relative

## DEBUGGING HUD FUNCTIONS ##

func debug_hud_init():
	debug_window.get_node("show").connect("pressed", self, "show_debug")
	debug_window.get_node("Main/setpos").connect("pressed", self, "set_player_pos")
	debug_window.rect_size = Vector2(200, 50)
	debug_window.get_node("Main").visible = false

func update_hud(score, gems, speed):
	$Gems.text = str(gems)
	$Score.text = str(score)
	$Speed.text = str(speed) + "m/s"

func update_debug(params):
	if (debug_window):
		pass

func show_debug():
	if (!debug_expanded):
		debug_window.rect_size = Vector2(200, 520)
		debug_window.get_node("Main").visible = true
	else:
		debug_window.rect_size = Vector2(200, 50)
		debug_window.get_node("Main").visible = false
	debug_expanded = !debug_expanded

func set_player_pos():
	var a = []
	for c in Array(debug_window.get_node("Main/pos").text.split(" ")): a.append(int(c))
	get_tree().get_root().get_node("GameSpace").set_pos(Vector3(a[0], a[1], a[2]))

## MESSAGES ##

func show_message(message):
	text_message.text = message
	text_message.visible = true

func hide_message():
	text_message.visible = false
