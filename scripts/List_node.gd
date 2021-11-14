extends Node2D

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################

# here's scene node to accept making path
var path2 = null

func make(name2, path):
	get_node("Label").text = name2
	path2 = path

func _process(_delta):
	if(get_node("Button").pressed):
		get_tree().get_root().get_node("EngineList").set2(path2)
