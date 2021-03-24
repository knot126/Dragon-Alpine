extends Node

class_name TextureManager

const loadTextures = ["fern", "pebble", "rock1"]

var loaded : bool = false
var textures = {
	textures = {},
}

func init():
	if (!loaded):
		for t in loadTextures:
			textures.textures[t] = load("res://assets/textures/" + t + ".jpg")
			textures.textures[t].flags = Texture.FLAGS_DEFAULT
			print("Loaded texture: ", t)

func get(n : String):
	if (!textures.textures.has(n)):
		return null
	
	return textures.textures[n]
