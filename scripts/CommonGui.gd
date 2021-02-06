extends CanvasLayer

var version_note
var fps_count

func _ready():
	version_note = $VersionNote
	fps_count = $Fps
	
	version_note.text = "Quick Run version " + g_GameConfig.get_game_version_string()
	
	version_note.rect_position.x = (get_viewport().get_visible_rect().size.x / 2) - (version_note.rect_size.x / 2)

func _process(delta):
	if (delta > 0):
		fps_count.text = str(floor(1 / delta + 0.5))
