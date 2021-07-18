extends Button

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################


# here's button to open feedback gui
func _process(_delta):
	if(self.pressed):
		get_tree().get_root().get_node("EngineList/Panel/Settings/GUI").visible = false
		get_tree().get_root().get_node("EngineList/Panel/Feedback").visible = true
