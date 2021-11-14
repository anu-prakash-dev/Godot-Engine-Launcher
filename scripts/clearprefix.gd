extends Node2D

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################


# here's scene node to reset launcher prefix when prefix is broken
func _ready():
	OS.window_borderless = false
	OS.window_size.x = 200
	OS.window_size.y = 100

func _process(_delta):
	if($Panel/no.pressed):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/Loader.tscn")
	if($Panel/yes.pressed):
		clear()
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/Loader.tscn")
func clear():
	var dir = Directory.new()
	dir.open("user://lang/")
	dir.list_dir_begin()
	var f = dir.get_next()
	while not(f == ""):
		if not(f == "." or f == ".."):
			dir.remove(f)
		f = dir.get_next()
	dir.remove("user://options/lang.settings")
	dir.remove("user://options/runner.settings")
	dir.remove("user://options/updater.settings")
	dir.remove("user://data/resources.list")
	dir.remove("user://options/version.settings")
