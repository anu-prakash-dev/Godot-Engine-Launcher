extends Button

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################


# here's button to back to main gui from import menu
func _process(delta):
	if(self.pressed):
		get_tree().get_root().get_node("EngineList/Panel/import").visible = false
