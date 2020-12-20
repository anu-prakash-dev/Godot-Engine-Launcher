extends Node2D

func _ready():
	OS.set_window_title("Godot Engine Launcher")
	make_dir("user://data")
	make_dir("user://resources")
	#write_file("user://data/godot.png", "image", read_file("res://textures/godot.png", "image"))
	var data = [{"a1":"Godot_1.1",
 "lb1":"https://downloads.tuxfamily.org/godotengine/1.1/Godot_v1.1_stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/1.1/Godot_v1.1_stable_win64.exe.zip"
}, {"a1":"Godot_2.0",
 "lb1":"https://downloads.tuxfamily.org/godotengine/2.0/Godot_v2.0_stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/2.0/Godot_v2.0_stable_win64.exe.zip"
}, {"a1":"Godot_2.1",
 "lb1":"https://downloads.tuxfamily.org/godotengine/2.1/Godot_v2.1-stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/2.1/Godot_v2.1-stable_win64.exe.zip"
}, {"a1":"Godot_2.1.7",
 "lb1":"https://downloads.tuxfamily.org/godotengine/2.1.7/rc/20200815/Godot_v2.1.7-rc_20200815_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/2.1.7/rc/20200815/Godot_v2.1.7-rc_20200815_win64.exe.zip",
 "mb1":"https://downloads.tuxfamily.org/godotengine/2.1.7/rc/20200815/Godot_v2.1.7-rc_20200815_osx.64.zip"
}, {"a1":"Godot_3.0",
 "lb1":"https://downloads.tuxfamily.org/godotengine/3.0/Godot_v3.0-stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/3.0/Godot_v3.0-stable_win64.exe.zip"}, {
 "a1":"Godot_3.1",
 "lb1":"https://downloads.tuxfamily.org/godotengine/3.1/Godot_v3.1-stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/3.1/Godot_v3.1-stable_win64.exe.zip",
 "mb1":"https://downloads.tuxfamily.org/godotengine/3.1/Godot_v3.1-stable_osx.64.zip"}, {
 "a1":"Godot_3.2",
 "lb1":"https://downloads.tuxfamily.org/godotengine/3.2/Godot_v3.2-stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/3.2/Godot_v3.2-stable_win64.exe.zip",
 "mb1":"https://downloads.tuxfamily.org/godotengine/3.2/Godot_v3.2-stable_osx.64.zip"}, {
 "a1":"Godot_3.2.3",
 "lb1":"https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_win64.exe.zip",
 "mb1":"https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_osx.64.zip"}, {
 "a1":"Godot_3.2.4_Beta_4",
 "lb1":"https://downloads.tuxfamily.org/godotengine/3.2.4/beta4/Godot_v3.2.4-beta4_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/3.2.4/beta4/Godot_v3.2.4-beta4_win64.exe.zip",
 "mb1":"https://downloads.tuxfamily.org/godotengine/3.2.4/beta4/Godot_v3.2.4-beta4_osx.universal.zip"
 }]
	var d = Directory.new()
	write_file("user://data/resources.list", "var", data)
	if not(d.file_exists("user://data/installed.list")):
		write_file("user://data/installed.list", "var", [])
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
		elif(type == "buffer"):
			data = file.get_buffer()
		elif(type == "image"):
			var image = Image.new()
			image.load(path)
			data = image.get_data()
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
	elif(type == "var"):
		file.store_var(data)
	elif(type == "buffer"):
		file.store_buffer(data)
	elif(type == "image"):
		var img = Image.new()
		
		img.save_png(data)
	else:
		file.store_line(data)
	file.close()
