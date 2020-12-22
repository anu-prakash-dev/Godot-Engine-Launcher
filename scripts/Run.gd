extends Button


var sltd = {"path":null, "file_name":null}
var a1 = true
onready var time = OS.get_system_time_msecs()

func _process(_delta):
	if(self.pressed and a1 == true):
		if not(sltd.path == null):
			var set1 = read_file("user://options/runner.settings", "json")
			var dir = Directory.new()
			dir.open(OS.get_user_data_dir()+"/resources/"+sltd.file_name)
			dir.list_dir_begin()
			var f = dir.get_next()
			print(f)
			print(""+OS.get_user_data_dir()+"/resources/"+sltd.file_name+"/"+f)
			#OS.shell_open("."+OS.get_user_data_dir()+"/resources/"+sltd.file_name+"/"+f)
			var output = []
			#OS.execute("cd", [OS.get_user_data_dir()+"/resources/"+sltd.file_name], true, output)
			#OS.execute("chmod", ["+x", ""+OS.get_user_data_dir()+"/resources/"+sltd.file_name+"/"+f], false)
			#OS.execute("cd", ["'"+OS.get_user_data_dir()+"/resources/"+sltd.file_name+"'"], false)
			print("-|-")
			#print(read_file(OS.get_user_data_dir()+"/resources/"+sltd.file_name+"/start.sh", ""))
			if(set1.record_logs == false):
				if(OS.get_name() == "X11"):
					OS.execute(
					'/usr/bin/env',
					[OS.get_user_data_dir()+"/resources/"+sltd.file_name+"/"+f, '-p'],
					false
					)
				elif(OS.get_name() == "OSX"):
					OS.execute(
						'/user/bin/env',
						[OS.get_user_data_dir()+"/resources/"+sltd.file_name+"/"+f, '-p'],
						false
					)
				elif(OS.get_name() == "Windows"):
					OS.execute(
						'start',
						[OS.get_user_data_dir()+"/resources/"+sltd.file_name+"/"+f, '-p'],
						false
					)
			else:
				OS.window_borderless = true
				OS.window_size.x = 1
				OS.window_size.y = 1
				OS.window_position.x = 1
				OS.window_position.y = 1
				print("\n'"+sltd.file_name+"' OUTPUT:")
				if(OS.get_name() == "X11"):
					OS.execute(
					'/usr/bin/env',
					[OS.get_user_data_dir()+"/resources/"+sltd.file_name+"/"+f, '-p'],
					true, output
					)
				elif(OS.get_name() == "OSX"):
					OS.execute(
					'/usr/bin/env',
					[OS.get_user_data_dir()+"/resources/"+sltd.file_name+"/"+f, '-p'],
					true, output
					)
				elif(OS.get_name() == "Windows"):
					OS.execute(
						'start',
						[OS.get_user_data_dir()+"/resources/"+sltd.file_name+"/"+f, '-p'],
						true,
						output
					)
				make_dir("user://resources/"+sltd.file_name+"_logs")
				var path = "user://resources/"+sltd.file_name+"_logs/"+sltd.file_name+"_log%d"%(OS.get_system_time_secs()/10000)+".log"
				if not(dir.file_exists(path)):
					write_file(path, "", "")
				for line in output:
					write_file(path, "", read_file(path, "")+line+"\n")
					print(line)
				
				OS.window_borderless = false
				OS.window_size.x = 1000
				OS.window_size.y = 600
				var s = OS.get_screen_size()
				var w = OS.get_window_size()
				OS.set_window_position(s*0.5 - w*0.5)
				get_tree().get_root().get_node("EngineList/Panel/LOG_GUI").show2(read_file(path, ""))
			if(set1.close_launcher == true):
				get_tree().quit()
		a1 = false
	if(a1 == false and OS.get_system_time_msecs() - time > 300):
		time = OS.get_system_time_msecs()
		a1 = true

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
func write_file(path, type, data):
	var file = File.new()
	file.open(path, File.WRITE)
	if(type == "json"):
		file.store_line(to_json(data))
	elif(type == "var"):
		file.store_var(data)
	else:
		file.store_line(data)
	file.close()
func make_dir(path):
	var dir = Directory.new()
	if not(dir.dir_exists(path)):
		dir.make_dir(path)
func make_log(output):
	var tick = 0
	var data2 = ""
	while not(tick+1 == output.size()):
		data2 += output[tick]+"\n"
		tick += 1
	return data2
