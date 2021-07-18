extends Panel

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################

# here's small part of code to popup information window
func set2(label):
	self.visible = true
	$Label.text = label
func hide():
	self.visible = false
