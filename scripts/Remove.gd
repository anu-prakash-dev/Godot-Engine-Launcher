extends Button

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################

# here's button script to fix issues with downloaded files - fix patch
var sltd = {"path":null, "file_name":null}

func _process(_delta):
	if(self.pressed):
		if not(sltd.path == null):
			var dir = Directory.new()
			var file = File.new()
			var list = []
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
			dir.remove("user://data/installed/"+sltd.file_name+".list")
			get_tree().change_scene("res://scenes/EngineList.tscn")
func reload():
	pass
