extends CanvasLayer

var version_note

func _ready():
	version_note = $VersionNote
	version_note.text = "Quick Run version " + g_GameConfig.get_game_version_string()
