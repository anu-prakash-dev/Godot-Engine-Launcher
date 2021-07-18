extends Node2D

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################

# here's startup node to generate launcher filesystem | intialize OS info
const version = "1.2"

func _ready():
	var d = Directory.new()
	OS.set_window_title("Godot Engine Launcher")
	make_dir("user://data")
	make_dir("user://resources")
	make_dir("user://data/installed")
	make_dir("user://options")
	make_dir("user://lang")
	if not(d.file_exists("user://options/version.settings")):
		write_file("user://options/version.settings", "", version)
		write_file("user://options/updater.settings", "json", {"chunk_size":8192})
		write_file("user://options/runner.settings", "json", {"close_launcher":true, "record_logs":false})
		write_file("user://options/lang.settings", "json", {"lang":"en"})
		d.remove("user://lang/pl.lang")
		d.remove("user://lang/en.lang")
	installer()
	#write_file("user://data/godot.png", "image", read_file("res://textures/godot.png", "image"))
	var res_data = load("res://scripts/data/resources_data.gd").new()
	var data = res_data.data
	#print(data)
	if(d.file_exists("user://options/version.settings")):
		var dd = read_file("user://options/version.settings", "")
		if not(dd == version):
			get_tree().change_scene("res://scenes/clearprefix.tscn")
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
		"list_nothing":"Aktualnie nic nie jest zainstalowane.",
		"af":"Importuj",
		"back":"Wróć",
		"np":"Nazwa:\n\nŚcieżka:",
		"paste":"Wklej"
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
		"list_nothing":"Actually nothing is installed.",
		"af":"Add from file",
		"back":"Back",
		"np":"Name:\n\nPath:",
		"paste":"Paste"
		})

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
		var dir = Directory.new()
		dir.copy("res://packages/unzip/windows/bin/unzip.exe", "user://packages/unzip/windows/unzip.exe")
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
