extends Button

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################

# here's button to open settings menu
var lang_select = "en"

func _ready():
	load_settings()

func _process(_delta):
	if(self.pressed):
		$GUI.visible = true
		load_settings()
	if($GUI/Panel/Save.pressed):
		save_settings()
	if(get_node("GUI/Panel/Back with saving").pressed):
		save_settings()
		get_tree().change_scene("res://scenes/EngineList.tscn")
func load_settings():
	var set1 = read_file("user://options/lang.settings", "json")
	var set2 = read_file("user://options/runner.settings", "json")
	var set3 = read_file("user://options/updater.settings", "json")
	#$GUI/Panel/Runner/lang.select(get_node("GUI/Panel/Runner/lang").)
	$GUI/Panel/Runner.set1 = set2.close_launcher
	$GUI/Panel/Runner.set2 = set2.record_logs
	$GUI/Panel/Updater.dcs = set3.chunk_size
	lang_select = set1.lang

func save_settings():
	var s1 = {"lang":lang_select}
	write_file("user://options/lang.settings", "json", s1)
	var s2 = {"close_launcher":$GUI/Panel/Runner.set1, "record_logs":$GUI/Panel/Runner.set2}
	write_file("user://options/runner.settings", "json", s2)
	var s3 = {"chunk_size":$GUI/Panel/Updater.dcs}
	write_file("user://options/updater.settings", "json", s3)
	

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
		file.store_line(to_json(data))
	elif(type == "var"):
		file.store_var(data)
	else:
		file.store_line(data)
	file.close()


func _on_lang_item_selected(index):
	lang_select = $GUI/Panel/Runner/lang.get_item_text(index)
