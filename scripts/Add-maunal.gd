extends Button

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################


# here's button to add unregistered Godot Engine version
func _process(_delta):
	if(self.pressed):
		get_tree().get_root().get_node("EngineList/Panel/import/Panel/name").text = "<name>"
		get_tree().get_root().get_node("EngineList/Panel/import/Panel/path").text = OS.get_user_data_dir()
		get_tree().get_root().get_node("EngineList/Panel/import").visible = true
