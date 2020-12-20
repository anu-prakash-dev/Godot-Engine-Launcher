extends Node2D


func _ready():
	var r = OS.execute("cd", ["/home/gameplayer/.local/share/godot/app_userdata/Godot_Engine_Launcher/resources/Godot_3.2.3"], true)
	var p = OS.execute("sh", ["/home/gameplayer/.local/share/godot/app_userdata/Godot_Engine_Launcher/resources/Godot_3.2.3/start.sh"], true)
	var x = OS.shell_open("./home/gameplayer/.local/share/godot/app_userdata/Godot_Engine_Launcher/resources/Godot_3.2.3/Godot_v3.2.3-stable_x11.64")
	var q = OS.shell_open("cd /home/gameplayer/.local/share/godot/app_userdata/Godot_Engine_Launcher/resources/Godot_3.2.3 && ./Godot_v3.2.3-stable_x11.64")
	#var y = OS.execute(".", ["/home/gameplayer/.local/share/godot/app_userdata/Godot_Engine_Launcher/resources/Godot_3.2.3/Godot_v3.2.3-stable_x11.64"], true)
	print(r)
	print(p)
	print(q)
	print(x)
	#print(y)
	print("------")
	var output = []
	OS.execute(
		'/usr/bin/env',
		['/home/gameplayer/.local/share/godot/app_userdata/Godot_Engine_Launcher/resources/Godot_3.2.3/Godot_v3.2.3-stable_x11.64', '-p'],
		false
	)
	print(output)
