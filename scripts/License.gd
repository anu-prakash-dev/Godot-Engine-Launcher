extends Control

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################


# just license
func _process(delta):
	if($GUI/back.pressed):
		self.visible = false
