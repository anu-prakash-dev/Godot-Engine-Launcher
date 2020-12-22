extends Node2D

func _ready():
	OS.set_window_title("Godot Engine Launcher")
	make_dir("user://data")
	make_dir("user://resources")
	make_dir("user://data/installed")
	make_dir("user://options")
	make_dir("user://lang")
	installer()
	#write_file("user://data/godot.png", "image", read_file("res://textures/godot.png", "image"))
	var data = [{"a1":"1.1",
 "lb1":"https://downloads.tuxfamily.org/godotengine/1.1/Godot_v1.1_stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/1.1/Godot_v1.1_stable_win64.exe.zip",
 "mb1":""
}, {"a1":"2.0",
 "lb1":"https://downloads.tuxfamily.org/godotengine/2.0/Godot_v2.0_stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/2.0/Godot_v2.0_stable_win64.exe.zip",
 "mb1":""
}, {"a1":"2.1",
 "lb1":"https://downloads.tuxfamily.org/godotengine/2.1/Godot_v2.1-stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/2.1/Godot_v2.1-stable_win64.exe.zip",
 "mb1":""
}, {"a1":"2.1.7",
 "lb1":"https://downloads.tuxfamily.org/godotengine/2.1.7/rc/20200815/Godot_v2.1.7-rc_20200815_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/2.1.7/rc/20200815/Godot_v2.1.7-rc_20200815_win64.exe.zip",
 "mb1":"https://downloads.tuxfamily.org/godotengine/2.1.7/rc/20200815/Godot_v2.1.7-rc_20200815_osx.64.zip"
}, {"a1":"3.0",
 "lb1":"https://downloads.tuxfamily.org/godotengine/3.0/Godot_v3.0-stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/3.0/Godot_v3.0-stable_win64.exe.zip", "mb1":""}, {
 "a1":"3.1",
 "lb1":"https://downloads.tuxfamily.org/godotengine/3.1/Godot_v3.1-stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/3.1/Godot_v3.1-stable_win64.exe.zip",
 "mb1":"https://downloads.tuxfamily.org/godotengine/3.1/Godot_v3.1-stable_osx.64.zip"}, {
 "a1":"3.2",
 "lb1":"https://downloads.tuxfamily.org/godotengine/3.2/Godot_v3.2-stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/3.2/Godot_v3.2-stable_win64.exe.zip",
 "mb1":"https://downloads.tuxfamily.org/godotengine/3.2/Godot_v3.2-stable_osx.64.zip"}, {
 "a1":"3.2.3",
 "lb1":"https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_win64.exe.zip",
 "mb1":"https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_osx.64.zip"}, {
 "a1":"3.2.4 Beta 4",
 "lb1":"https://downloads.tuxfamily.org/godotengine/3.2.4/beta4/Godot_v3.2.4-beta4_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/3.2.4/beta4/Godot_v3.2.4-beta4_win64.exe.zip",
 "mb1":"https://downloads.tuxfamily.org/godotengine/3.2.4/beta4/Godot_v3.2.4-beta4_osx.universal.zip"
 }]
	var d = Directory.new()
	if not(d.file_exists("user://data/resources.list")):
		write_file("user://data/resources.list", "var", data)
	if not(d.file_exists("user://lang/pl.lang")):
		write_file("user://lang/pl.lang", "json", {"updater_1_panel_start":"Pakiety zostaną pobrane!", 
		"updater_1_panel_failed":"Nie udano się połączyć z serwerem.", 
		"updater_1_panel_failed1":"Ponów",
		"updater_2_panel":"Updater rozpoczął pracę...",
		"list_tab_installed":"Zainstalowane",
		"list_tab_all":"Wszystkie",
		"exit":"Wyjście",
		"settings":"Ustawienia",
		"list_1_run":"Uruchom",
		"list_1_reinstall":"Przeinstaluj",
		"list_1_remove":"Usuń",
		"list_2_install":"Zainstaluj",
		"settings_1_runner":"Uruchomienie",
		"settings_1_updater":"Aktualizator",
		"settings_2_1":"Zamknij launcher, podczas rozruchu Godota:\n\nMonitoruj logi Godota:\n\nJęzyk:",
		"settings_2_2":"Wielkość chunku:\n\nUpdate resources.list: <Unavailable>\n\nDownload last version of Godot: <Unavailable>\n\nUpdate launcher when update is available: <Unavailable>",
		"settings_save":"Zapisz",
		"settings_b_wo_s":"Wróć bez zapisu",
		"settings_b_w_s":"Zapisz i wróć",
		"copy":"Kopiuj",
		"list_nothing":"Aktualnie nic nie jest zainstalowane."
		})
	if not(d.file_exists("user://lang/en.lang")):
		write_file("user://lang/en.lang", "json", {
			"updater_1_panel_start":"Resources will be downloaded!", 
		"updater_1_panel_failed":"Failed to connect to server/", 
		"updater_1_panel_failed1":"Try again",
		"updater_2_panel":"Updater started work...",
		"list_tab_installed":"Installed",
		"list_tab_all":"All",
		"exit":"Exit",
		"settings":"Settings",
		"list_1_run":"Run",
		"list_1_reinstall":"Reinstall",
		"list_1_remove":"Remove",
		"list_2_install":"Install",
		"settings_1_runner":"Runner",
		"settings_1_updater":"Updater",
		"settings_2_1":"Close launcher when godot starting:\n\nRecord godot logs:\n\nLanguage:",
		"settings_2_2":"Download chunk size:\n\nUpdate resources.list: <Unavailable>\n\nDownload last version of Godot: <Unavailable>\n\nUpdate launcher when update is available: <Unavailable>",
		"settings_save":"Save",
		"settings_b_wo_s":"Back without save",
		"settings_b_w_s":"Back with save",
		"copy":"Copy",
		"list_nothing":"Actually nothing is installed."
		})
	if not(d.file_exists("user://options/lang.settings")):
		write_file("user://options/lang.settings", "json", {"lang":"en"})
	if not(d.file_exists("user://options/runner.settings")):
		write_file("user://options/runner.settings", "json", {"close_launcher":true, "record_logs":false})
	if not(d.file_exists("user://options/updater.settings")):
		write_file("user://options/updater.settings", "json", {"chunk_size":8192})
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
			data = to_json(file.get_line())
		elif(type == "buffer"):
			data = file.get_buffer()
		elif(type == "image"):
			var image = Image.new()
			image.load(path)
			data = image.get_data()
		else:
			data = file.get_as_text()
		file.close()
	return data

func write_file(path, type, data):
	var file = File.new()
	var dir = Directory.new()
	file.open(path, File.WRITE)
	if(type == "json"):
		file.store_line(to_json(data))
	elif(type == "var"):
		file.store_var(data)
	elif(type == "buffer"):
		file.store_buffer(data)
	elif(type == "image"):
		var img = Image.new()
		
		img.save_png(data)
	else:
		file.store_line(data)
	file.close()

func installer():
	make_dir("user://packages")
	make_dir("user://packages/unzip")
	if(OS.get_name() == "Windows"):
		print("Running app on Windows:")
		make_dir("user://packages/unzip/windows")
		write_file("user://packages/unzip/windows/unzip.exe", "buffer", read_file("res://packages/unzip/windows/bin/unzip.exe", "buffer"))
	elif(OS.get_name() == "X11"):
		print("Running app on Linux/X11:")
		make_dir("user://packages/unzip/linux")
		print("PLEASE CHECK UNZIP COMMAND IN TERMINAL, IF YOU DON'T HAVE COMMAND, THEN PLEASE INSTALL RIGHT NOW.")
	elif(OS.get_name() == "OSX"):
		print("Running app on MacOSX:")
		make_dir("user://packages/unzip/osx")
		print("PLEASE CHECK UNZIP COMMAND IN TERMINAL, IF YOU DON'T HAVE COMMAND, THEN PLEASE INSTALL RIGHT NOW.")
	else:
		print("Unknown OS, exiting...")
		get_tree().quit()
