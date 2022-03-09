extends Control

#######################################
#  Copyright © 2020 - 2022 GamePlayer #
#            on MIT License.          #
#######################################

var BASE_URL = "https://downloads.tuxfamily.org/godotengine/"
var DOWNLOAD_OS_EXTENSION = "x11.64"
var _VERSION = "2.3.2"

var CONNECTION_WORKS = false

func _ready():
	""" Load everything what's needed """
	_info("load", 50)
	_check_version()
	_load_installed()
	_load_available()
	_load_metadata()
	load_main()
	load_background()
	_hide_info()
	_check_last_update()

func _check_version():
	""" Reset settings after loading different version of launcher """
	if lib_main.check("user://version" ):
		var _data = lib_main.rdfile("user://version", "var")
		if not(_data == _VERSION):
			lib_main.rmfile("user://version")
			lib_main.rmfile("user://main")
			lib_main.mkfile("user://version", "var", _VERSION)
	else:
		lib_main.rmfile("user://version")
		lib_main.rmfile("user://main")
		lib_main.mkfile("user://version", "var", _VERSION)

func _save_metadata():
	""" Save metadata about packages """
	var _data = []
	var _tick = 0
	while not(_tick == $main/v/tabs/Installed/v/h2/ItemList.get_item_count()):
		_data += [$main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(_tick)]
		_tick += 1

	lib_main.mkfile("user://metadata", "var", _data)

func _load_metadata():
	""" Load metadata about packages """
	if lib_main.check("user://metadata"):
		var _data = lib_main.rdfile("user://metadata", "var")
		var _tick = 0
		for _object in _data:
			$main/v/tabs/Installed/v/h2/ItemList.set_item_metadata(_tick, _object)
			_tick += 1

func _check_os():
	""" Set download settings via OS type """
	if OS.get_name() == "X11":
		DOWNLOAD_OS_EXTENSION = "x11.64"
	elif OS.get_name() == "Windows":
		DOWNLOAD_OS_EXTENSION = "win64.exe"

func _info(_text = "P", _progress = 0):
	""" Set state of loader """
	$Popup/main/s/text.text = _text
	$Popup/main/s/load.value = _progress
	if not($Popup.visible):
		$Popup.popup_centered()
	if not($shell.visible):
		$shell.visible=true

func _hide_info():
	""" Hide message """
	$shell.visible=false
	$Popup.visible=false

func _message(_test = "Unknown exit code: ?"):
	""" Show message from core """
	$Info/main/s/text.text = _test
	$Info.popup_centered()
	$shell.visible = false



func open_settings():
	""" Open settings popup """
	$shell.visible=true
	$Settings.visible=true

func close_launcher():
	""" Stop launcher runtime """
	get_tree().quit(0)

var DOWNLOADING = false

func _download(link = "", chunk_size = 4096):
	""" Download file """
	_info("du", 0)
	$HTTPRequest.download_chunk_size = chunk_size
	$HTTPRequest.request(link)
	DOWNLOADING = true

func _get_HTTPRequest_download_level():
	""" Get download state """
	var procent = (($HTTPRequest.get_downloaded_bytes()/1000000)+0.01)/(($HTTPRequest.get_body_size()/1000000)+0.01)*100
	_info("du", round(procent))

onready var TIME = OS.get_system_time_msecs()
var DOWNLOADING2 = false


func _process(_delta):
	""" Update download state info """
	if DOWNLOADING and OS.get_system_time_msecs() - TIME > 10:
		TIME = OS.get_system_time_msecs()
		_get_HTTPRequest_download_level()
	if DOWNLOADING2 and OS.get_system_time_msecs() - TIME > 10:
		TIME = OS.get_system_time_msecs()
		_get_file_download_level()

func _get_file_download_level():
	""" Get download state """
	var procent = (($file.get_downloaded_bytes()/1000000)+0.01)/(($file.get_body_size()/1000000)+0.01)*100
	_info("du", procent)

func _on_HTTPRequest_request_completed(_result, _response_code, _headers, _body):
	""" Save all available versions after fetching """
	DOWNLOADING = false
	_info("P", 50)
	if _response_code == 200:
		CONNECTION_WORKS = true
		var _decoded = _body.get_string_from_utf8()
		var _debuild_by_versions = _decoded.split('<tr><td class="n"><a href="', true)
		var _real_debuild = []
		var a
		$main/v/tabs/Available/v/h/ItemList.clear()
		for _object in _debuild_by_versions:
			a = _object.split('/">', true)
			if not(a[0] == "media" or a[0] == "patreon" or a[0] == "testing" or a[0] == "toolchains" or a[0] == "ParentDirectory" or a[0] == ".."):
				_real_debuild += [a[0]]
				var open = false
				for _item in range($main/v/tabs/Installed/v/h2/ItemList.get_item_count()):
					if $main/v/tabs/Installed/v/h2/ItemList.get_item_text(_item) == str(a[0]):
						open = true
						break
				$main/v/tabs/Available/v/h/ItemList.add_item(str(a[0]), load("res://textures/godot.png"))
				$main/v/tabs/Available/v/h/ItemList.set_item_disabled($main/v/tabs/Available/v/h/ItemList.get_item_count()-1, open)
		$main/v/tabs/Available/v/h/ItemList.remove_item(0)
		lib_main.mkfile("user://last_reload", "var", OS.get_system_time_secs())
		_hide_info()
		_exit_tree()
	else:
		_message("Failed to connect to the network, error "+str(_response_code)+".")
		CONNECTION_WORKS = false

func _exit_tree():
	""" Save configuration on exit """
	lib_main.mkfile("user://installed", "var", $main/v/tabs/Installed/v/h2/ItemList.items)
	lib_main.mkfile("user://available", "var", $main/v/tabs/Available/v/h/ItemList.items)
	_save_metadata()

var INSTALLED_VER = []

func _load_installed():
	""" Load all versions in installed tab """
	if lib_main.check("user://installed"):
		INSTALLED_VER = []
		$main/v/tabs/Installed/v/h2/ItemList.items = lib_main.rdfile("user://installed", "var")

		var _tick = 0
		while not _tick == $main/v/tabs/Installed/v/h2/ItemList.get_item_count():
			$main/v/tabs/Installed/v/h2/ItemList.set_item_icon(_tick, load("res://textures/godot.png"))
			INSTALLED_VER += [$main/v/tabs/Installed/v/h2/ItemList.get_item_text(_tick)]
			_tick += 1

func _load_available():
	""" Load all versions in available tab """
	if lib_main.check("user://available"):
		$main/v/tabs/Available/v/h/ItemList.items = lib_main.rdfile("user://available", "var")

		var _tick = 0
		while not _tick == $main/v/tabs/Available/v/h/ItemList.get_item_count():
			$main/v/tabs/Available/v/h/ItemList.set_item_icon(_tick, load("res://textures/godot.png"))
			$main/v/tabs/Available/v/h/ItemList.set_item_disabled(_tick, INSTALLED_VER.has($main/v/tabs/Available/v/h/ItemList.get_item_text(_tick)))
			_tick += 1

func _check_last_update():
	""" Report outdated version list """
	if not lib_main.check("user://last_reload"):
		lib_main.mkfile("user://last_reload", "var", -1)
		_message("ff")
	else:
		var _data = lib_main.rdfile("user://last_reload", "var")
		if OS.get_system_time_secs()-1209600 > _data:
			_message("ff")


func close_message():
	""" Close message """
	$Info.hide()
	$shell.visible=false
	$Popup.hide()
	$Settings.hide()


func reload_list():
	""" Load new version list """
	_download("https://downloads.tuxfamily.org/godotengine/", $Settings/main/v/tabs/Launcher/v/chunk/chunk.value)



func file_success(_result, response_code, _headers, _body):
	""" Install file after download """
	DOWNLOADING2 = false
	if response_code == 200:
		CONNECTION_WORKS = true
		if not lib_main.check("user://binaries"):
			lib_main.mkdir("user://binaries")
		if not lib_main.check("user://binaries/"+$main/v/tabs/Available/v/h/ItemList.get_item_text(AVAILABLE_SELECTED)):
			lib_main.mkdir("user://binaries/"+$main/v/tabs/Available/v/h/ItemList.get_item_text(AVAILABLE_SELECTED))

		var file = File.new()
		var _end_point = "64"
		var _os = "x11"
		if OS.get_name() == "X11":
			_end_point = "64"
			_os = "x11"
		elif OS.get_name() == "Windows":
			_end_point = "exe"
			_os = "win64"
		file.open("user://binaries/"+$main/v/tabs/Available/v/h/ItemList.get_item_text(AVAILABLE_SELECTED)+"/package.zip", File.WRITE)
		file.store_buffer(_body)
		file.close()
		var _default_file_name = "Godot_v"+$main/v/tabs/Available/v/h/ItemList.get_item_text(AVAILABLE_SELECTED)+"-stable_"+_os+"."+_end_point
		if OS.get_name() == "X11":
# warning-ignore:return_value_discarded
			OS.execute("unzip", [OS.get_user_data_dir()+"/binaries/"+$main/v/tabs/Available/v/h/ItemList.get_item_text(AVAILABLE_SELECTED)+"/package.zip", "-d", OS.get_user_data_dir()+"/binaries/"+$main/v/tabs/Available/v/h/ItemList.get_item_text(AVAILABLE_SELECTED)], false)
		elif OS.get_name() == "Windows":
# warning-ignore:return_value_discarded
			OS.execute(
				'compact',
				['/U', '/I', '/F', '/Q', OS.get_user_data_dir()+"/binaries/"+$main/v/tabs/Available/v/h/ItemList.get_item_text(AVAILABLE_SELECTED)+"/package.zip"],
				false
			)

		$main/v/tabs/Installed/v/h2/ItemList.add_item($main/v/tabs/Available/v/h/ItemList.get_item_text(AVAILABLE_SELECTED), load("res://textures/godot.png"))
		$main/v/tabs/Installed/v/h2/ItemList.set_item_metadata($main/v/tabs/Installed/v/h2/ItemList.get_item_count()-1, OS.get_user_data_dir()+"/binaries/"+$main/v/tabs/Available/v/h/ItemList.get_item_text(AVAILABLE_SELECTED))

		$main/v/tabs/Available/v/h/ItemList.set_item_disabled(AVAILABLE_SELECTED, true)

		_exit_tree()
		_hide_info()
	else:
		_message("Connection refused, error "+str(response_code)+".\nPlease check if server contains package\nor if you have stable internet\nconnection.")
		CONNECTION_WORKS = false

func _download_file(_url = "", _chunk_size = 4096):
	""" Download file """
	$file.download_chunk_size = _chunk_size
	$file.request(_url)

func _on_download_pressed():
	""" Download Godot version """
	if not AVAILABLE_SELECTED == -1:
		if not $main/v/tabs/Available/v/h/ItemList.is_item_disabled(AVAILABLE_SELECTED):
			DOWNLOADING2 = true
			if not int($main/v/tabs/Available/v/h/ItemList.get_item_text(AVAILABLE_SELECTED)) < 2.1:
				_download_file(BASE_URL+$main/v/tabs/Available/v/h/ItemList.get_item_text(AVAILABLE_SELECTED)+"/Godot_v"+$main/v/tabs/Available/v/h/ItemList.get_item_text(AVAILABLE_SELECTED)+"-stable_"+DOWNLOAD_OS_EXTENSION+".zip", $Settings/main/v/tabs/Launcher/v/chunk/chunk.value)
			else:
				_download_file(BASE_URL+$main/v/tabs/Available/v/h/ItemList.get_item_text(AVAILABLE_SELECTED)+"/Godot_v"+$main/v/tabs/Available/v/h/ItemList.get_item_text(AVAILABLE_SELECTED)+"_stable_"+DOWNLOAD_OS_EXTENSION+".zip", $Settings/main/v/tabs/Launcher/v/chunk/chunk.value)

var AVAILABLE_SELECTED = -1
var INSTALLED_SELECTED = -1

func a_l_n():
	""" Disable download button """
	AVAILABLE_SELECTED = -1
	$main/v/tabs/Available/v/h/options/download.disabled = true

func a_l_s(index):
	""" Enable download button """
	AVAILABLE_SELECTED = index
	$main/v/tabs/Available/v/h/options/download.disabled = false

func i_l_n():
	""" Disable buttons in installed tab """
	INSTALLED_SELECTED = -1
	$main/v/tabs/Installed/v/h2/options/shortcut.text = "shortcut"

	$main/v/tabs/Installed/v/h2/options/shortcut.disabled = true
	$main/v/tabs/Installed/v/h2/options/remove.disabled = true
	$main/v/tabs/Installed/v/h2/options/location.disabled = true
	$main/v/tabs/Installed/v/h2/options/run.disabled = true

func i_l_s(index):
	""" Enable buttons in installed tab """
	$main/v/tabs/Installed/v/h2/options/shortcut.disabled = false
	$main/v/tabs/Installed/v/h2/options/remove.disabled = false
	$main/v/tabs/Installed/v/h2/options/location.disabled = false
	$main/v/tabs/Installed/v/h2/options/run.disabled = false

	INSTALLED_SELECTED = index
	var dir = Directory.new()
	dir.open($main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(INSTALLED_SELECTED))
	dir.list_dir_begin()
	var _filename = ""
	var _f = dir.get_next()
	while not _f == "":
		if not(_f == ".." or _f == "."):
			_filename = _f
			break
		_f = dir.get_next()

	var filepath = $main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(INSTALLED_SELECTED)+"/"+_filename
	if Shortcut.shortcut_exist(filepath):
		$main/v/tabs/Installed/v/h2/options/shortcut.text = "remove shortcut"
	else:
		$main/v/tabs/Installed/v/h2/options/shortcut.text = "shortcut"

func _on_run_pressed():
	""" Start executable Godot file """
	if not INSTALLED_SELECTED == -1:
		var dir = Directory.new()
		dir.open($main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(INSTALLED_SELECTED))
		dir.list_dir_begin()
		var _filename = ""
		var _f = dir.get_next()
		while not _f == "":
			if not(_f == ".." or _f == "."):
				_filename = _f
				break
			_f = dir.get_next()
		if lib_main.check($main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(INSTALLED_SELECTED)+"/package.zip"):
			lib_main.rmfile($main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(INSTALLED_SELECTED)+"/package.zip")
		if OS.get_name() == "X11":
# warning-ignore:return_value_discarded
			OS.execute(
			'/usr/bin/env',
			[$main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(INSTALLED_SELECTED)+"/"+_filename, '-p'],
			false
			)
		elif OS.get_name() == "Windows":
# warning-ignore:return_value_discarded
			OS.execute(
				'start',
				[$main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(INSTALLED_SELECTED)+"/"+_filename, '-p'],
				false
			)
		if $"Settings/main/v/tabs/Launcher/v/close/close".pressed:
			close_launcher()

func _on_remove_pressed():
	""" Remove Godot version """
	if not INSTALLED_SELECTED == -1:
		if Shortcut.SHORTCUTS.has("Godot "+$main/v/tabs/Installed/v/h2/ItemList.get_item_text(INSTALLED_SELECTED)):
			var dir = Directory.new()
			dir.open($main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(INSTALLED_SELECTED))
			dir.list_dir_begin()
			var _filename = ""
			var _f = dir.get_next()
			while not _f == "":
				if not(_f == ".." or _f == "."):
					_filename = _f
					break
				_f = dir.get_next()

			var filepath = $main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(INSTALLED_SELECTED)+"/"+_filename

			Shortcut.remove_shortcut(filepath)

		lib_main.rmdir($main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(INSTALLED_SELECTED))
		$main/v/tabs/Installed/v/h2/ItemList.remove_item(INSTALLED_SELECTED)
		INSTALLED_SELECTED = -1
		_exit_tree()

func open_file_location():
	""" Open folder where specific version is stored """
	if not INSTALLED_SELECTED == -1:
# warning-ignore:return_value_discarded
		OS.shell_open($main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(INSTALLED_SELECTED))

func save_main():
	""" Save settings configuration """
	var _chunk = $Settings/main/v/tabs/Launcher/v/chunk/chunk.value
	var _cs = $"Settings/main/v/tabs/Launcher/v/close/close".pressed
	var _save_data = {"chunk":_chunk, "cs":_cs}

	lib_main.mkfile("user://main", "var", _save_data)

func load_main():
	""" Load settings configuration """
	if lib_main.check("user://main"):
		var _data = lib_main.rdfile("user://main", "var")
		$"Settings/main/v/tabs/Launcher/v/close/close".pressed = _data.cs
		$Settings/main/v/tabs/Launcher/v/chunk/chunk.value = _data.chunk

func close_settings_menu():
	""" Close settings menu """
	$Settings.hide()
	if $shell.visible and not($Popup.visible):
		$shell.visible = false

func set_background(path = ""):
	""" Set background """
	$"Settings/main/v/tabs/Launcher/v/background/path".text = path

	if lib_main.check(path):
		$"backgroundtexture".texture = lib_main.load_image(path)
	else:
		$"backgroundtexture".texture = null

func update_background(new_text):
	""" Save new background """
	set_background(new_text)
	lib_main.mkfile("user://background", "json", {"background":new_text})

func load_background():
	""" Load background on startup """
	if lib_main.check("user://background"):

		var path = lib_main.rdfile("user://background", "json").background

		if lib_main.check(path):
			$"backgroundtexture".texture = lib_main.load_image(path)
		else:
			$"backgroundtexture".texture = null

		$"Settings/main/v/tabs/Launcher/v/background/path".text = path

func _on_shortcut_pressed():
	""" Create shortcut """
	if not INSTALLED_SELECTED == -1:
		var dir = Directory.new()
		dir.open($main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(INSTALLED_SELECTED))
		dir.list_dir_begin()
		var _filename = ""
		var _f = dir.get_next()
		while not _f == "":
			if not(_f == ".." or _f == "."):
				_filename = _f
				break
			_f = dir.get_next()

		var filepath = $main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(INSTALLED_SELECTED)+"/"+_filename

		Shortcut.create_shortcut(filepath, "Godot "+$main/v/tabs/Installed/v/h2/ItemList.get_item_text(INSTALLED_SELECTED))


func remove_shortcut():
	""" Remove shortcut """
	if not INSTALLED_SELECTED == -1:
		var dir = Directory.new()
		dir.open($main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(INSTALLED_SELECTED))
		dir.list_dir_begin()
		var _filename = ""
		var _f = dir.get_next()
		while not _f == "":
			if not(_f == ".." or _f == "."):
				_filename = _f
				break
			_f = dir.get_next()

		var filepath = $main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(INSTALLED_SELECTED)+"/"+_filename

		Shortcut.remove_shortcut(filepath)


func shortcut_button():
	""" Shortcut signal event """
	if not INSTALLED_SELECTED == -1:
		var dir = Directory.new()
		dir.open($main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(INSTALLED_SELECTED))
		dir.list_dir_begin()
		var _filename = ""
		var _f = dir.get_next()
		while not _f == "":
			if not(_f == ".." or _f == "."):
				_filename = _f
				break
			_f = dir.get_next()

		var filepath = $main/v/tabs/Installed/v/h2/ItemList.get_item_metadata(INSTALLED_SELECTED)+"/"+_filename
		if Shortcut.shortcut_exist(filepath):
			remove_shortcut()
		else:
			_on_shortcut_pressed()
