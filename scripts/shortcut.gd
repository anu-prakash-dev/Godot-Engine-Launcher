extends Node

#######################################
#  Copyright © 2020 - 2022 GamePlayer #
#            on MIT License.          #
#    If you respect me, put a small   #
# information about me, when you will #
#       use some stuff from here.     #
#######################################

var icon_path = OS.get_user_data_dir()+"/godot.png"

var shortcuts = []

func _ready():
	if not(lib_main.check("user://godot.png")):
		var texture = load("res://textures/godot.png")
		var img = texture.get_data()
		img.save_png("user://godot.png")
	if(lib_main.check("user://shortcuts")):
		shortcuts = lib_main.rdfile("user://shortcuts", "var")

func _save_shortcuts():
	lib_main.mkfile("user://shortcuts", "var", shortcuts)

func create_shortcut(to_file = "", custom_name = ""):
	if(lib_main.check(to_file)):
		if(custom_name == ""):
			custom_name = to_file.get_file().get_basename()
		if(OS.get_name() == "Windows"):
# warning-ignore:return_value_discarded
			OS.execute("powershell", ["$s=(New-Object -COM WScript.Shell).CreateShortcut('%AppData%\\Microsoft\\Windows\\Start Menu\\Programs\\"+custom_name+".lnk');$s.TargetPath='"+to_file+"';$s.IconLocation='"+icon_path+"';$s.Save()"])
			shortcuts += [to_file, "%AppData%\\Microsoft\\Windows\\Start Menu\\Programs\\"+custom_name+".lnk", custom_name]
		elif(OS.get_name() == "OSX"):
			pass
		elif(OS.get_name() == "X11"):
			var linux_cfg = [
				"[Desktop Entry]",
				"Name="+custom_name,
				"Comment=Game Engine.",
				"Icon="+icon_path,
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
			
			shortcuts += [to_file, creation_path+"/"+custom_name+".desktop", custom_name]

func remove_shortcut(to_file = ""):
	if(shortcuts.has(to_file)):
		var _pos = shortcuts.find(to_file)
		
		lib_main.rmfile(shortcuts[_pos+1])
		
		shortcuts.remove(_pos+2)
		shortcuts.remove(_pos+1)
		shortcuts.remove(_pos)


func get_shortcut_folder():
	if(OS.get_name() == "Windows"):
		return "%AppData%\\Microsoft\\Windows\\Start Menu\\Programs"
	elif(OS.get_name() == "OSX"):
		return "/"
	elif(OS.get_name() == "X11"):
		return OS.get_user_data_dir()+"/../applications"

func get_shortcut_extension():
	if(OS.get_name() == "Windows"):
		return "lnk"
	elif(OS.get_name() == "OSX"):
		return "null"
	elif(OS.get_name() == "X11"):
		return "desktop"
