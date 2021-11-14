extends Button

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################

# here's button to open updater
var sltd = null

func _process(_delta):
	if(self.pressed and sltd != null):
		var file = File.new()
		file.open("user://data/to_download.data", File.WRITE)
		file.store_line(to_json(sltd))
		file.close()
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/updater.tscn")
