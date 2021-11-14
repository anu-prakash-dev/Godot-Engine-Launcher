extends ItemList

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################

# here's ItemList code to show up Available Godot versiosn to download
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
var list = []
func _ready():
	self.clear()
	var dir = Directory.new()
	dir.open("user://data/installed")
	dir.list_dir_begin()
	var f = dir.get_next()
	#print(res)
	while not(f == ""):
		if not(f == "." or f == ".."):
			var data = read_file("user://data/installed/"+f, "json")
			print(data)
			if not(data == null):
				var d = data.version
				print(d)
				list += [{"file_name":data.version, "path":data.path}]
				add_item(""+data.version, load("res://textures/godot.png"), true)
		f = dir.get_next()

func _on_ItemList_item_selected(index):
	get_tree().get_root().get_node("EngineList/Panel/Tab/Installed/GUI/Run").sltd = list[index]
	get_tree().get_root().get_node("EngineList/Panel/Tab/Installed/GUI/Remove").sltd = list[index]
	get_tree().get_root().get_node("EngineList/Panel/Tab/Installed/GUI/Run").reload()
	get_tree().get_root().get_node("EngineList/Panel/Tab/Installed/GUI/Remove").reload()
	get_tree().get_root().get_node("EngineList/Panel/Tab/Installed/GUI/Reinstall").sltd = list[index]
	get_tree().get_root().get_node("EngineList/Panel/Tab/Installed/GUI/Shortcut").sltd = list[index]
