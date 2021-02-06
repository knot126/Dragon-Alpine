extends Node

class_name QAudio

var audio = null

func open(path : String):
	audio = AudioStreamPlayer.new()
	var file = File.new()
	
	file.open("res://assets/" + path + ".ogg", File.READ)
	
	audio.stream = AudioStreamOGGVorbis.new()
	audio.stream.set_data(file.get_buffer(file.get_len()))
	audio.loop = true
	
	file.close()

func play():
	if (audio):
		audio.playing = true

func pause():
	if (audio):
		audio.playing = false

func let():
	audio.free()
	self.free()
