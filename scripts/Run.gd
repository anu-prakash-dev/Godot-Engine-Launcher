extends Button


var sltd = {"path":null, "file_name":null}

func _process(_delta):
	if(self.pressed):
		if not(sltd.path == null):
			var dir = Directory.new()
			dir.open(OS.get_user_data_dir()+"/resources/"+sltd.file_name)
			dir.list_dir_begin()
			var f = dir.get_next()
			print(f)
			print("."+OS.get_user_data_dir()+"/resources/"+sltd.file_name+"/"+f)
			#OS.shell_open("."+OS.get_user_data_dir()+"/resources/"+sltd.file_name+"/"+f)
			var output = []
			#OS.execute("cd", [OS.get_user_data_dir()+"/resources/"+sltd.file_name], true, output)
			OS.execute("chmod", ["+x", ""+OS.get_user_data_dir()+"/resources/"+sltd.file_name+"/"+f], false)
			#OS.execute("cd", ["'"+OS.get_user_data_dir()+"/resources/"+sltd.file_name+"'"], false)
			
			OS.execute("bash", ["help"], true, output)
			for line in output:
				print(line)
			print(output)
			#get_tree().quit()

func reload():
	pass
