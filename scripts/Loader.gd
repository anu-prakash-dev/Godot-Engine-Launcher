extends Node2D

onready var request = HTTPRequest.new()

func _ready():
	make_dir("user://data")
	make_dir("user://resources")
	get_tree().change_scene("res://scenes/EngineList.tscn")


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
	var dir = Directory.new()
	file.open(path, File.WRITE)
	if(type == "json"):
		var json = parse_json(data)
		file.store_line(json)
	else:
		file.store_line(data)
	file.close()
func download_file(link, path):
	var file = File.new()
	var http = HTTPRequest.new()
	add_child(http)
	var connection = http.connect("request_completed", self, "_http_request_completed")
	var status = http.request(link)
	if(status == OK):
		pass
	else:
		print("ERROR: Failed connect to server. Trying again with POST option.")
		var body = {"name": "GEL"}
		var s = http.request(link, [], true, HTTPClient.METHOD_POST, body)
func make_list():
	if(read_file("user://data/installed.list", "json") == null):
		pass
