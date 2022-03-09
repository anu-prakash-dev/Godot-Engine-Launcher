extends Node

#######################################
#  Copyright © 2020 - 2022 GamePlayer #
#            on MIT License.          #
#######################################

var ICONPATH = OS.get_user_data_dir()+"/godot.png"

var SHORTCUTS = []

func _ready():
	""" Load configurtion """
	if not lib_main.check("user://godot.png"):
		var texture = load("res://textures/godot.png")
		var img = texture.get_data()
		img.save_png("user://godot.png")
	if lib_main.check("user://shortcuts"):
		SHORTCUTS = lib_main.rdfile("user://shortcuts", "var")

func _save_SHORTCUTS():
	""" Update shortcut database """
	lib_main.mkfile("user://shortcuts", "var", SHORTCUTS)

func create_shortcut(to_file = "", custom_name = ""):
	""" Create new shortcut """
	if lib_main.check(to_file):
		if custom_name == "":
			custom_name = to_file.get_file().get_basename()
		if OS.get_name() == "Windows":
# warning-ignore:return_value_discarded
			OS.execute("powershell", ["$s=(New-Object -COM WScript.Shell).CreateShortcut('%AppData%\\Microsoft\\Windows\\Start Menu\\Programs\\"+custom_name+".lnk');$s.TargetPath='"+to_file+"';$s.IconLocation='"+ICONPATH+"';$s.Save()"])
			SHORTCUTS += [to_file, "%AppData%\\Microsoft\\Windows\\Start Menu\\Programs\\"+custom_name+".lnk", custom_name]
		elif OS.get_name() == "X11":
			var linux_cfg = [
				"[Desktop Entry]",
				"Name="+custom_name,
				"Comment=Game Engine.",
				"Icon="+ICONPATH,
				"Type=Application",
				"StartupNotify=false",
				"Keywords=godot;",
				"Exec="+to_file
			]

			var creation_path = OS.get_user_data_dir()+"/../applications"
			var file = File.new()
			file.open(creation_path+"/"+custom_name+".desktop", File.WRITE)
			for stringx in linux_cfg:
				file.store_line(stringx)
			file.close()

			SHORTCUTS += [to_file, creation_path+"/"+custom_name+".desktop", custom_name]

func remove_damaged_shortcut(to_file = ""):
	""" Patch problem with creating new shortcut with %20 """
	var list = to_file.split(" ", true)
	var end_version = list[list.size()-1]
	var filepath = ""
	list.remove(list.size()-1)
	for obj in list:
		filepath += obj
	filepath += "%20" + end_version
	if lib_main.check(filepath):
		lib_main.rmfile(filepath)


func remove_shortcut(to_file = ""):
	""" Remove shortcut from shortcut folder """
	if SHORTCUTS.has(to_file):
		var _pos = SHORTCUTS.find(to_file)

		lib_main.rmfile(SHORTCUTS[_pos+1])
		remove_damaged_shortcut(SHORTCUTS[_pos+1])

		SHORTCUTS.remove(_pos+2)
		SHORTCUTS.remove(_pos+1)
		SHORTCUTS.remove(_pos)


func get_shortcut_folder():
	""" Get shortcuts location """
	if OS.get_name() == "Windows":
		return "%AppData%\\Microsoft\\Windows\\Start Menu\\Programs"
	elif OS.get_name() == "X11":
		return OS.get_user_data_dir()+"/../applications"

func get_shortcut_extension():
	""" Get shortcut extension (in String) """
	if OS.get_name() == "Windows":
		return "lnk"
	elif OS.get_name() == "X11":
		return "desktop"

func shortcut_exist(to_file = ""):
	""" Check if shortcut is registered """
	return SHORTCUTS.has(to_file)