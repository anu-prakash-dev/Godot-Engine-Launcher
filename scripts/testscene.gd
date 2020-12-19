extends Node2D


func _ready():
	var output = []
	print(OS.get_user_data_dir())
	var path = "/home/gameplayer/.local/share/godot/app_userdata/Godot Engine Launcher/resources/Godot_3.2.3/Godot_v3.2.3-stable_x11.64"
	OS.execute("chmod", ["+rwx", path], false)
	var res = OS.execute(".", [path], true, output)
	print(res)
