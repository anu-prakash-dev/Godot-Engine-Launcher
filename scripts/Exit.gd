extends Button

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################

# here's button to exit from launcher
func _process(_delta):
	if(self.pressed):
		get_tree().quit()
