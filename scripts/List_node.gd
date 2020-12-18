extends Node2D

var path2 = null

func make(name2, path):
	get_node("Label").text = name2
	path2 = path

func _process(delta):
	if(get_node("Button").pressed):
		get_tree().get_root().get_node("EngineList").set2(path2)
