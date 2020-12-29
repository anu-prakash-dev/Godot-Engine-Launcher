extends Node2D

var lang = null
var r = false
var w = false
var fast_data = {}
var all_data = []
var list_to_download = []
var f_data = {}
func read_data_to_download():
	var data = read_file("user://data/to_download.data", "table")
	if(data != null):
		var tick = 0
		while not(tick == data.size()):
			make_dir("user://resources/"+data[tick].file_name)
			var dir = Directory.new()
			if not(dir.file_exists("user://resources/"+data[tick].file_name+"/"+data[tick].file_name+".zip")):
				to_download("user://resources/"+data[tick].file_name, data[tick].link, data[tick].file_name)
			else:
				dir.open("user://resources/"+data[tick].file_name)
				dir.list_dir_begin()
				var f2 = dir.get_next()
				dir.remove("user://resources/"+data[tick].file_name+"/"+f2)
				print("Unziping file...")
				var output = []
				var p = define_path()
				p += "/resources/"+data[tick].file_name+"/"
				p += data[tick].file_name
				p += ".zip"
				print(p)
				var x = define_path()+"/resources/"+data[tick].file_name
				if not(dir.dir_exists(x)):
					print("ERR:UPDATER_DIR NOT FOUND!")
				if(OS.get_name() == "X11" or OS.get_name() == "OSX"):
					OS.execute("unzip", [p, "-d", x], true, output)
				elif(OS.get_name() == "Windows"):
					OS.execute(
						'compact',
						['/U', '/I', "/F", "/Q", p],
						true,
						output
					)
				for line in output:
					print(line)
				
				dir.open(OS.get_user_data_dir()+"/resources/"+data[0].file_name)
				dir.list_dir_begin()
				var f = dir.get_next()
				OS.execute("chmod", ["+rwx", OS.get_user_data_dir()+"/resources/"+data[0].file_name+"/"+f])
				#write_file(OS.get_user_data_dir()+"/resources/"+data[0].file_name+"/"+"start.sh", "string", "#!/bin/sh\rcd "+OS.get_user_data_dir()+"/resources/"+data[0].file_name+"\r./"+f)
				#OS.execute("chmod", ["+rwx", OS.get_user_data_dir()+"/resources/"+data[0].file_name+"/start.sh"], false)
				
				if not(dir.file_exists("user://data/installed/"+data[0].file_name+".list")):
					add_installed(data[0].file_name, "user://resources/"+data[0].file_name)
				
			tick += 1
	r = true
func _ready():
	OS.set_window_title("Godot Engine Launcher - Updater")
	load_lang()
	OS.window_borderless = false
	OS.window_size.y = 100
	OS.window_size.x = 200
	var s = OS.get_screen_size()
	var w = OS.get_window_size()
	OS.set_window_position(s*0.5 - w*0.5)
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	get_node("Panel").visible = true
	get_node("Panel2").visible = false

func _process(_delta):
	file_init()
	t_out()
	download_info()
	#check_ping()
	if(get_node("Panel/ok").pressed):
		get_node("Panel2").visible = true
		get_node("Panel").visible = false
		read_data_to_download()

func to_download(path, link, file_name):
	f_data.path = path
	f_data.link = link
	f_data.file_name = file_name
	list_to_download += [f_data]
func file_init():
	if(w == false and list_to_download.size() > 0):
		var status = $HTTPRequest.request(list_to_download[0].link)
		if(status == OK):
			download_file(list_to_download[0].path, list_to_download[0].link, list_to_download[0].file_name)
			list_to_download.remove(0)
		else:
			print("Failed to connect to FTP server:\n"+status)
			get_node("Panel/Label").text = lang.updater_1_panel_failed
			get_node("Panel/ok").text = lang.updater_1_panel_failed1
			while not(all_data.size() == 0):
				all_data.remove(0)
			get_node("Panel").visible = true
			get_node("Panel2").visible = false
	if(r == true and list_to_download.size() == 0 and all_data.size() == 0):
		get_tree().change_scene("res://scenes/EngineList.tscn")
func make_dir(path):
	var dir = Directory.new()
	if not(dir.dir_exists(path)):
		dir.make_dir(path)
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
	elif(type == "buffer"):
		file.store_buffer(data)
	elif(type == "string"):
		file.store_string(data)
	elif(type == "real"):
		file.store_real(data)
	else:
		file.store_line(data)
	file.close()

func download_file(to_path, link, file_name):
	w = true
	fast_data.dir = to_path
	fast_data.file = file_name
	fast_data.link = link
	fast_data.type = "file"
	all_data += [fast_data]
	$HTTPRequest.request(link)
	print("Downloading file '"+file_name+"' started! Link:\n"+link)
func _on_request_completed(result, response_code, headers, body):
	print("Downloading successfull!")
	if(all_data.size() > 0):
		#var json = parse_json(body.get_string_from_utf8())
		if(all_data[0].type == "file"):
			var file = File.new()
			var dir = Directory.new()
			if(dir.dir_exists(all_data[0].dir)):
				file.open(all_data[0].dir+"/"+all_data[0].file+".zip", File.WRITE)
				file.store_buffer(body)
				file.close()
				print("Unziping file...")
				var output = []
				var p = define_path()
				p += "/resources/"+all_data[0].file+"/"
				p += all_data[0].file
				p += ".zip"
				print(p)
				var x = define_path()+"/resources/"+all_data[0].file
				if not(dir.dir_exists(x)):
					print("ERR:UPDATER_DIR NOT FOUND!")
				if(OS.get_name() == "X11" or OS.get_name() == "OSX"):
					OS.execute("unzip", [p, "-d", x], true, output)
				elif(OS.get_name() == "Windows"):
					OS.execute(
						'compact',
						['/U', '/I', '/F', '/Q', p],
						true,
						output
					)
				#unzip(p, x, all_data[0].file+".64")
				for line in output:
					print(line)
				
				dir.open(OS.get_user_data_dir()+"/resources/"+all_data[0].file)
				dir.list_dir_begin()
				var f = dir.get_next()
				OS.execute("chmod", ["+rwx", OS.get_user_data_dir()+"/resources/"+all_data[0].file+"/"+f])
				#write_file(OS.get_user_data_dir()+"/resources/"+all_data[0].file+"/"+"start.sh", "string", "#!/bin/sh\rcd "+OS.get_user_data_dir()+"/resources/"+all_data[0].file+"\r./"+f)
				#OS.execute("chmod", ["+rwx", OS.get_user_data_dir()+"/resources/"+all_data[0].file+"/start.sh"], false)
				add_installed(all_data[0].file, all_data[0].dir)
			all_data.remove(0)
	w = false

func download_info():
	var procent = $HTTPRequest.get_downloaded_bytes()/1000000
	get_node("Panel2/Label").text = lang.updater_2_panel+"\n%d"%procent+" MB"

func define_path():
	return OS.get_user_data_dir()

func add_installed(version, path):
	var list = {"version":version, "path":path}
	var d = Directory.new()
	if not(d.file_exists("user://data/installed/"+version+".list")):
		write_file("user://data/installed/"+version+".list", "json", list)
	
	
onready var time = OS.get_system_time_msecs()
var timeout = 0
func check_ping():
	if(w == true):
		if(OS.get_system_time_msecs() - time > 1000):
			timeout += 1
			time = OS.get_system_time_msecs()
			
	else:
		timeout = 0
	if($HTTPRequest.get_downloaded_bytes() > 0):
		if($HTTPRequest.get_downloaded_bytes()/timeout < 50 and timeout > 100):
			print("Failed to connect to FTP server:\nYour internet is slow!")
			get_node("Panel/Label").text = "Failed connect to FTP server.\nyour internet is slow."
			get_node("Panel/ok").text = lang.updater_1_panel_failed1
			list_to_download = []
			all_data = []
			get_node("Panel").visible = true
			get_node("Panel2").visible = false


func load_lang():
	var i = read_file("user://options/lang.settings", "json")
	lang = read_file("user://lang/"+i.lang+".lang", "json")
	$Panel/Label.text = lang.updater_1_panel_start
	$Panel2/Label.text = lang.updater_2_panel

func t_out():
	if(w == true):
		if($HTTPRequest.timeout):
			print("Connection timed out!")
			get_node("Panel/Label").text = lang.updater_1_panel_failed
			get_node("Panel/ok").text = lang.updater_1_panel_failed1
			while not(all_data.size() == 0):
				all_data.remove(0)
			get_node("Panel").visible = true
			get_node("Panel2").visible = false
