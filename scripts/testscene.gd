extends Node2D

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################

# here's scene node script to configure Godot Engine versions
var sltd = {"path":"user://resources/Godot_3.2.3", "file_name":"Godot_3.2.3"}

func _ready():
	var dir = Directory.new()
	var file = File.new()
	var list = []
	file.open("user://data/installed.list", File.READ)
	list = file.get_var()
	file.close()
	dir.open("user://resources/"+sltd.file_name)
	print("deleting files")
	if not(dir.file_exists("godot.png")):
		dir.list_dir_begin()
		var ff = dir.get_next()
		while not(ff == ""):
			print(ff)
			dir.remove(ff)
			ff = dir.get_next()
		dir.open("user://resources")
		dir.remove(sltd.file_name)
	print("fixing issues")
	var tick = 0
	var list2 = []
	
	var d = {"path":sltd.path, "version":sltd.file_name}
	while not(tick == list.size()):
		if not(list.find(d, tick)):
			list2 += [list[tick]]
		tick += 1
	print(list2)
	file.open("user://data/installed.list", File.WRITE)
	file.store_var(list2)
	file.close()
