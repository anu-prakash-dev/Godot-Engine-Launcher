extends Node2D


func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	OS.window_borderless = false
	OS.window_size.y = 100
	get_node("Panel").visible = true
	get_node("Panel2").visible = false

func _process(_delta):
	if(get_node("Panel/ok").pressed):
		get_node("Panel2").visible = true
		get_node("Panel").visible = false
		download_file("user://", "https://raw.githubusercontent.com/GamePlayer-PL/Godot-Engine-Launcher-data/main/all_godot_versions.txt?token=ANTVYC2VSOQDML3EDYGILJ273RNSI", "version.data")
		
		
var list_to_download = []
var f_data = {}
func to_download(path, link, file_name):
	f_data.path = path
	f_data.link = link
	f_data.file_name = file_name
	list_to_download += [f_data]
func file_init():
	if(w == false):
		download_file(list_to_download[0].path, list_to_download[0].link, list_to_download[0].file_name)
		list_to_download.erase(0)
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
var w = false
var data2 = null
var fast_data = {}
var all_data = []
func download_file(to_path, link, file_name):
	w = true
	fast_data.dir = to_path
	fast_data.file = file_name
	fast_data.link = link
	fast_data.type = "file"
	all_data += [fast_data]
	$HTTPRequest.request(link)
func _on_request_completed(result, response_code, headers, body):
	if(all_data.size() > 0):
		var json = parse_json(body.get_string_from_utf8())
		if(all_data[0].type == "file"):
			var file = File.new()
			var dir = Directory.new()
			if(dir.dir_exists(all_data[0].dir)):
				file.open(all_data[0].dir+"/"+all_data[0].file, File.WRITE)
				file.store_line(to_json(body.get_string_from_utf8()))
				file.close()
			all_data.erase(0)
		w = false
