extends Node2D

var resources = null
var installed = null

func _ready():
	OS.set_window_title("Godot Engine Launcher")
	OS.window_borderless = false
	OS.window_size.x = 1000
	OS.window_size.y = 600
	var s = OS.get_screen_size()
	var w = OS.get_window_size()
	OS.set_window_position(s*0.5 - w*0.5)
	read_source()
	load_lang()
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
			data = parse_json(file.get_line())
		elif(type == "table"):
			data = [parse_json(file.get_line())]
		elif(type == "var"):
			data = file.get_var()
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
	elif(type == "var"):
		file.store_var(data)
	else:
		file.store_line(data)
	file.close()

func read_source():
	resources = read_file("res://data/resources.list", "var")
	installed = null

func load_lang():
	var i = read_file("user://options/lang.settings", "json")
	var lang = read_file("user://lang/"+i.lang+".lang", "json")
	$Panel/Tab/Installed.text = lang.list_tab_installed
	$Panel/Tab/to_download.text = lang.list_tab_all
	$Panel/Tab/Installed/GUI/Run.text = lang.list_1_run
	$Panel/Tab/Installed/GUI/Reinstall.text = lang.list_1_reinstall
	$Panel/Tab/Installed/GUI/Remove.text = lang.list_1_remove
	$Panel/Tab/to_download/GUI/Install.text = lang.list_2_install
	$Panel/Exit.text = lang.exit
	$Panel/Settings.text = lang.settings
	get_node("Panel/Settings/GUI/Panel/Back with saving").text = lang.settings_b_w_s
	get_node("Panel/Settings/GUI/Panel/Back without saving").text = lang.settings_b_wo_s
	$Panel/Settings/GUI/Panel/Save.text = lang.settings_save
	$Panel/Settings/GUI/Panel/main.text = lang.settings
	$Panel/Settings/GUI/Panel/Runner/Label.text = lang.settings_1_runner
	$Panel/Settings/GUI/Panel/Updater/Label.text = lang.settings_1_updater
	$Panel/Settings/GUI/Panel/Runner/Label2.text = lang.settings_2_1
	$Panel/Settings/GUI/Panel/Updater/Label2.text = lang.settings_2_2
	$Panel/LOG_GUI/Panel/copy.text = lang.copy
