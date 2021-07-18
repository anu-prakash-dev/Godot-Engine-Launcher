extends Control

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################

# here's Control node to copy launcher log to clipboard
func _process(_delta):
	if($Panel/ok.pressed):
		self.visible = false
	if($Panel/copy.pressed):
		OS.clipboard = $Panel/log.text
func show2(log2):
	$Panel/log.text = log2
	self.visible = true
