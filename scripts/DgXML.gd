extends Object

var f : File = File.new()
var c : String

func _find_between_first(string : String, s : String, e : String):
	var a = string.find(s)
	var b = string.find(e)
	return [a, b]

func read(filename = ""):
	f.open(filename, File.READ)
	var c : String = f.get_as_text()
	
	self._find_between_first(c, "<", ">")
	
	f.close()

func write(filename = ""):
	f.open(filename, File.WRITE)
	
	f.close()
