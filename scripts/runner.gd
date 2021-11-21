extends Control

var _base_url = "https://downloads.tuxfamily.org/godotengine/"
var _current_os = "x11.64"


var _is_connection_works = false

func _ready():
	_info("load", 50)
	_load_installed()
	_load_available()
	_load_metadata()
	load_main()
	_hide_info()
	_check_last_update()
	

func _save_metadata():
	var _data = []
	var _tick = 0
	while not(_tick == $main/v/tabs/Installed/v/h2/ItemList.get_item_count()):
		_data += [$main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(_tick)]
		_tick += 1
	
	lib_main.mkfile("user://metadata", "var", _data)

func _load_metadata():
	if(lib_main.check("user://metadata")):
		var _data = lib_main.rdfile("user://metadata", "var")
		var _tick = 0
		for _object in _data:
			$main/v/tabs/Installed/v/h2/ItemList.set_item_metadata(_tick, _object)
			_tick += 1

func _check_os():
	if(OS.get_name() == "X11"):
		_current_os = "x11.64"
	elif(OS.get_name() == "Windows"):
		_current_os = "win64.exe"
	elif(OS.get_name() == "OSX"):
		_current_os = "osx.universal"

func _info(_text = "P", _progress = 0):
	$Popup/main/s/text.text = _text
	$Popup/main/s/load.value = _progress
	if not($Popup.visible):
		$Popup.popup_centered()
	if not($shell.visible):
		$shell.visible=true

func _hide_info():
	$shell.visible=false
	$Popup.visible=false

func _message(_test = "Unknown exit code: ?"):
	$Info/main/s/text.text = _test
	$Info.popup_centered()
	$shell.visible = false
	print(_test)

func close_settings_menu():
	$Settings.hide()
	if($shell.visible and not($Popup.visible)):
		$shell.visible = false

func open_settings():
	$shell.visible=true
	$Settings.visible=true

func close_launcher():
	get_tree().quit(0)

var _is_downloading = false

func _download(link = "", chunk_size = 4096):
	_info("du", 0)
	$HTTPRequest.download_chunk_size = chunk_size
	$HTTPRequest.request(link)
	_is_downloading = true

func _get_HTTPRequest_download_level():
	var procent = $HTTPRequest.get_downloaded_bytes()/1000000
	_info("du", round(procent))

onready var time = OS.get_system_time_msecs()
var _is_downloading2 = false


func _process(_delta):
	if(_is_downloading and OS.get_system_time_msecs() - time > 10):
		time = OS.get_system_time_msecs()
		_get_HTTPRequest_download_level()
	if(_is_downloading2 and OS.get_system_time_msecs() - time > 10):
		time = OS.get_system_time_msecs()
		_get_file_download_level()

func _get_file_download_level():
	var procent = 45-45/(($file.get_downloaded_bytes()/1000000)+0.01)
	_info("du", procent)

func _on_HTTPRequest_request_completed(_result, _response_code, _headers, _body):
	_is_downloading = false
	_info("P", 50)
	if(_response_code == 200):
		_is_connection_works = true
		var _decoded = _body.get_string_from_utf8()
		var _debuild_by_versions = _decoded.split('<tr><td class="n"><a href="', true)
		var _real_debuild = []
		var a
		$main/v/tabs/Available/v/h/ItemList.clear()
		for _object in _debuild_by_versions:
			a = _object.split('/">', true)
			if not(a[0] == "media" or a[0] == "patreon" or a[0] == "testing" or a[0] == "toolchains" or a[0] == "ParentDirectory" or a[0] == ".."):
				_real_debuild += [a[0]]
				$main/v/tabs/Available/v/h/ItemList.add_item(str(a[0]), load("res://textures/godot.png"))
		$main/v/tabs/Available/v/h/ItemList.remove_item(0)
		lib_main.mkfile("user://last_reload", "var", OS.get_system_time_secs())
		_hide_info()
		_exit_tree()
	else:
		_message("Failed to connect to the network, error "+str(_response_code)+".")
		print("No internet connection: "+str(_response_code))
		_is_connection_works = false

func _exit_tree():
	lib_main.mkfile("user://installed", "var", $main/v/tabs/Installed/v/h2/ItemList.items)
	lib_main.mkfile("user://available", "var", $main/v/tabs/Available/v/h/ItemList.items)
	_save_metadata()

func _load_installed():
	if(lib_main.check("user://installed")):
		$main/v/tabs/Installed/v/h2/ItemList.items = lib_main.rdfile("user://installed", "var")
		
		var _tick = 0
		while not(_tick == $main/v/tabs/Installed/v/h2/ItemList.get_item_count()):
			$main/v/tabs/Installed/v/h2/ItemList.set_item_icon(_tick, load("res://textures/godot.png"))
			_tick += 1

func _load_available():
	if(lib_main.check("user://available")):
		$main/v/tabs/Available/v/h/ItemList.items = lib_main.rdfile("user://available", "var")
		
		var _tick = 0
		while not(_tick == $main/v/tabs/Available/v/h/ItemList.get_item_count()):
			$main/v/tabs/Available/v/h/ItemList.set_item_icon(_tick, load("res://textures/godot.png"))
			_tick += 1

func _check_last_update():
	if not(lib_main.check("user://last_reload")):
		lib_main.mkfile("user://last_reload", "var", -1)
		_message("The resources list is out-to-date, please update it to see the newest versions of godot engine - use 'Reload' button.")
	else:
		var _data = lib_main.rdfile("user://last_reload", "var")
		if(OS.get_system_time_secs()-1209600 > _data):
			_message("The resources list is out-to-date, please update it to see the newest versions of godot engine - use 'Reload' button.")


func close_message():
	$Info.hide()
	$shell.visible=false


func reload_list():
	_download("https://downloads.tuxfamily.org/godotengine/", $Settings/main/v/tabs/Launcher/v/chunk/chunk.value)
	


func file_success(_result, response_code, _headers, _body):
	_is_downloading2 = false
	if(response_code == 200):
		_is_connection_works = true
		if not(lib_main.check("user://binaries")):
			lib_main.mkdir("user://binaries")
		if not(lib_main.check("user://binaries/"+$main/v/tabs/Available/v/h/ItemList.get_item_text(_is_available_selected))):
			lib_main.mkdir("user://binaries/"+$main/v/tabs/Available/v/h/ItemList.get_item_text(_is_available_selected))
		
		var file = File.new()
		var _end_point = "64"
		var _os = "x11"
		if(OS.get_name() == "X11"):
			_end_point = "64"
			_os = "x11"
		elif(OS.get_name() == "Windows"):
			_end_point = "exe"
			_os = "win64"
		elif(OS.get_name() == "OSX"):
			_end_point = "app"
			_os = "osx"
		file.open("user://binaries/"+$main/v/tabs/Available/v/h/ItemList.get_item_text(_is_available_selected)+"/package.zip", File.WRITE)
		file.store_buffer(_body)
		file.close()
		var _default_file_name = "Godot_v"+$main/v/tabs/Available/v/h/ItemList.get_item_text(_is_available_selected)+"-stable_"+_os+"."+_end_point
		if(OS.get_name() == "X11" or OS.get_name() == "OSX"):
# warning-ignore:return_value_discarded
			OS.execute("unzip", [OS.get_user_data_dir()+"/binaries/"+$main/v/tabs/Available/v/h/ItemList.get_item_text(_is_available_selected)+"/package.zip", "-d", OS.get_user_data_dir()+"/binaries/"+$main/v/tabs/Available/v/h/ItemList.get_item_text(_is_available_selected)], false)
		elif(OS.get_name() == "Windows"):
# warning-ignore:return_value_discarded
			OS.execute(
				'compact',
				['/U', '/I', '/F', '/Q', OS.get_user_data_dir()+"/binaries/"+$main/v/tabs/Available/v/h/ItemList.get_item_text(_is_available_selected)+"/package.zip"],
				false
			)
		
		$main/v/tabs/Installed/v/h2/ItemList.add_item($main/v/tabs/Available/v/h/ItemList.get_item_text(_is_available_selected), load("res://textures/godot.png"))
		$main/v/tabs/Installed/v/h2/ItemList.set_item_metadata($main/v/tabs/Installed/v/h2/ItemList.get_item_count()-1, OS.get_user_data_dir()+"/binaries/"+$main/v/tabs/Available/v/h/ItemList.get_item_text(_is_available_selected))
		#lib_main.rmfile("user://binaries/"+$main/v/tabs/Available/v/h/ItemList.get_item_text(_is_available_selected)+"/package.zip")
		
		
		if(OS.get_name() == "X11" or OS.get_name() == "OSX"):
			var _file = ""
			var dir = Directory.new()
			dir.open("user://binaries/"+$main/v/tabs/Available/v/h/ItemList.get_item_text(_is_available_selected))
			dir.list_dir_begin()
			var _f = dir.get_next()
			while not(_f == ""):
				if not(_f == "." or _f == ".." or _f == "package.zip"):
					_file = _f
					break
# warning-ignore:return_value_discarded
			OS.execute("chmod", ["+rwx", OS.get_user_data_dir()+"/binaries/"+$main/v/tabs/Available/v/h/ItemList.get_item_text(_is_available_selected)+"/"+_file])
		#lib_main.rmfile("user://binaries/"+$main/v/tabs/Available/v/h/ItemList.get_item_text(_is_available_selected)+"/package.zip")
		
		_exit_tree()
		_hide_info()
	else:
		_message("Failed to connect to the network, error "+str(response_code)+".")
		print(_base_url+$main/v/tabs/Available/v/h/ItemList.get_item_text(_is_available_selected)+"/Godot_v"+$main/v/tabs/Available/v/h/ItemList.get_item_text(_is_available_selected)+"-stable_"+_current_os+".zip")
		_is_connection_works = false

func _download_file(_url = "", _chunk_size = 4096):
	$file.download_chunk_size = _chunk_size
	$file.request(_url)

var _is_available_selected = -1

func _on_download_pressed():
	if not(_is_available_selected == -1):
		_is_downloading2 = true
		_download_file(_base_url+$main/v/tabs/Available/v/h/ItemList.get_item_text(_is_available_selected)+"/Godot_v"+$main/v/tabs/Available/v/h/ItemList.get_item_text(_is_available_selected)+"-stable_"+_current_os+".zip", $Settings/main/v/tabs/Launcher/v/chunk/chunk.value)


func a_l_n():
	_is_available_selected = -1


func a_l_s(index):
	_is_available_selected = index

var _is_installed_selected = -1

func i_l_n():
	_is_installed_selected = -1

func i_l_s(index):
	_is_installed_selected = index

var output = []

func _on_run_pressed():
	if not(_is_installed_selected == -1):
		var dir = Directory.new()
		dir.open($main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(_is_installed_selected))
		dir.list_dir_begin()
		var _filename = ""
		var _f = dir.get_next()
		while not(_f == ""):
			if not(_f == ".." or _f == "."):
				_filename = _f
				break
			_f = dir.get_next()
		if not($Settings/main/v/tabs/Launcher/v/log/log.pressed):
			if(OS.get_name() == "X11"):
# warning-ignore:return_value_discarded
				OS.execute(
				'/usr/bin/env',
				[$main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(_is_installed_selected)+"/"+_filename, '-p'],
				false
				)
			elif(OS.get_name() == "OSX"):
# warning-ignore:return_value_discarded
				OS.execute(
					'/user/bin/env',
					[$main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(_is_installed_selected)+"/"+_filename, '-p'],
					false
				)
			elif(OS.get_name() == "Windows"):
# warning-ignore:return_value_discarded
				OS.execute(
					'start',
					[$main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(_is_installed_selected)+"/"+_filename, '-p'],
					false
				)
			
			close_launcher()
		else:
			output = []
			$logging/main/v/log.text=""
			$logging.popup_centered()
			$shell.visible=true
			if(OS.get_name() == "X11"):
# warning-ignore:return_value_discarded
				OS.execute(
				'/usr/bin/env',
				[$main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(_is_installed_selected)+"/"+_filename, '-p'],
				false,
				output
				)
			elif(OS.get_name() == "OSX"):
# warning-ignore:return_value_discarded
				OS.execute(
					'/user/bin/env',
					[$main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(_is_installed_selected)+"/"+_filename, '-p'],
					true,
					output
				)
			elif(OS.get_name() == "Windows"):
# warning-ignore:return_value_discarded
				OS.execute(
					'start',
					[$main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(_is_installed_selected)+"/"+_filename, '-p'],
					true,
					output
				)
			
			print(output)

func _input(event):
	if(event.is_action_pressed("ui_escape") and $logging.visible):
		$logging.hide()
		$shell.visible=false

func _on_remove_pressed():
	if not(_is_installed_selected == -1):
		lib_main.rmdir($main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(_is_installed_selected))
		$main/v/tabs/Installed/v/h2/ItemList.remove_item(_is_installed_selected)
		_is_installed_selected = -1
		_exit_tree()



func open_file_location():
	if not(_is_installed_selected == -1):
# warning-ignore:return_value_discarded
		OS.shell_open($main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(_is_installed_selected))


func save_settings():
	var _b = $Settings/main/v/tabs/Theme/v/button/color.color
	var _bp = $Settings/main/v/tabs/Theme/v/buttonp/color.color
	var _bf = $Settings/main/v/tabs/Theme/v/buttonf/color.color
	var _background_path = $"Settings/main/v/tabs/Theme/v/background/path".text
	var _background_shade = $"Settings/main/v/tabs/Theme/v/backgroundc/color".color
	var _lines = $Settings/main/v/tabs/Theme/v/lines/color.color
	
	var _save_data = {"lines":_lines, "background_path":_background_path, "background_shade":_background_shade, "b":_b, "bp":_bp, "bf":_bf}
	
	lib_main.mkfile("user://theme", "var", _save_data)
	
	close_settings_menu()

func load_settings():
	if(lib_main.check("user://settings")):
		var _data = lib_main.rdfile("user://settings", "var")
		
		$Settings/main/v/tabs/Theme/v/button/color.color = _data.b
		$Settings/main/v/tabs/Theme/v/buttonp/color.color = _data.bp
		$Settings/main/v/tabs/Theme/v/buttonf/color.color = _data.bf
		$Settings/main/v/tabs/Theme/v/lines/color.color = _data.lines
		$Settings/main/v/tabs/Theme/v/background/path.text = _data.background_path
		$Settings/main/v/tabs/Theme/v/backgroundc/color.color = _data.background_shade
		
		

func save_main():
	var _run = $Settings/main/v/tabs/Launcher/v/log/log.pressed
	var _chunk = $Settings/main/v/tabs/Launcher/v/chunk/chunk.value
	
	var _save_data = {"chunk":_chunk, "run":_run}
	
	lib_main.mkfile("user://main", "var", _save_data)
	
	

func load_main():
	if(lib_main.check("user://main")):
		var _data = lib_main.rdfile("user://main", "var")
		
		$Settings/main/v/tabs/Launcher/v/chunk/chunk.value = _data.chunk
		$Settings/main/v/tabs/Launcher/v/log/log.pressed = _data.run


func _set_theme_item(_name, _object, _value):
	var _f
	_f = self.theme.get_theme_item(Theme.DATA_TYPE_STYLEBOX, _name, _object)
	_f.color = _value
	self.theme.set_theme_item(Theme.DATA_TYPE_STYLEBOX, _name, _object, _f)


func background_file_selected(path):
	$Settings/main/v/tabs/Theme/v/background/path.text = path


func select_background():
	$background.popup_centered()


func _on_Copy_pressed():
	OS.clipboard = $logging/main/v/log.text
