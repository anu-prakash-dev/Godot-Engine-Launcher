extends Sprite

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################

# here's Sprite script to set the same texture size as window size
func _ready():
	OS.window_size.x = self.texture.get_size().x
	OS.window_size.y = self.texture.get_size().y
	OS.window_borderless = true
	
