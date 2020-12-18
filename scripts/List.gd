extends Control

var list = []
var cx = 0
var cy = 0

func make_new(data):
	var instance = load("res://scenes/List_node.tscn")
	var obj = instance.new()
	obj.name = data.name
	add_child(obj)
	get_node(data.name).position.x = data.x
	get_node(data.name).position.y = data.y
	get_node(data.name).make(data.text, data.path)
func add(name2, path):
	if not(list.size() >= 20):
		list += [name2]
		cx += 105
		if(cx >= 1000):
			cy += 105
			cx = 0
		make_new({"path":path,"name":name2, "x":(cx+18), "y":(cy+85), "text":name2})
	
func _ready():
	if not(read_file("user://data/installed.list", "json") == null):
		var c = read_file("user://data/installed.list", "json")
		var tick = 0
		if(c.size() > 0):
			while not(c.size()==tick):
				var path = c[tick][0]
				var text = c[tick][1]
				add(text, path)
				tick += 1


func make_dir(path):
	var dir = Directory.new()
	if not(dir.dir_exists(path)):
		dir.make_dir(path)
func read_file(path, type):
	var data = null
	var file = File.new()
	var dir = Directory.new()
	if(dir.file_exists(path)):
		file.open(path, File.READ)
		if(type == "json"):
			data = to_json(file.get_line())
		else:
			data = file.get_as_text()
		file.close()
	return data
func write_file(path, type, data):
	var file = File.new()
	file.open(path, File.WRITE)
	if(type == "json"):
		var json = parse_json(data)
		file.store_line(json)
	else:
		file.store_line(data)
	file.close()
