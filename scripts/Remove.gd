extends Button


var sltd = {"path":null, "file_name":null}

func _process(_delta):
	if(self.pressed):
		if not(sltd.path == null):
			print(sltd)
			var dir = Directory.new()
			var file = File.new()
			file.open("user://data/installed.list", File.READ)
			var i = file.get_var()
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
			var d = {"path":sltd.path, "version":sltd.file_name}
			var b = 0
			var dd = null
			print("fixing issues")
			dd = i.find(d)
			print(dd)
			i.remove(dd)
			file.open("user://data/installed.list", File.WRITE)
			file.store_var(i)
			file.close()
			print(d)
			print(i)
			#get_tree().change_scene("res://scenes/EngineList.tscn")
func reload():
	pass
