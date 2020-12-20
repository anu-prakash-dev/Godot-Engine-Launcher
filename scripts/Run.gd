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
			#OS.execute("chmod", ["+x", ""+OS.get_user_data_dir()+"/resources/"+sltd.file_name+"/"+f], false)
			#OS.execute("cd", ["'"+OS.get_user_data_dir()+"/resources/"+sltd.file_name+"'"], false)
			print("-|-")
			print(read_file(OS.get_user_data_dir()+"/resources/"+sltd.file_name+"/start.sh", ""))
			OS.execute(
			'/usr/bin/env',
			[OS.get_user_data_dir()+"/resources/"+sltd.file_name+"/"+f, '-p'],
			false
			)
			get_tree().quit()

func reload():
	pass

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
