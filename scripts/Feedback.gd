extends Control

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################

# here's control node to use feedback (actually feedback not working - feedback server stopped/doesn't exist)
var subject = ""
var contents = ""

func _process(delta):
	if($GUI/back.pressed):
		self.visible = false
		$GUI/TextEdit.text = ""
		$GUI/Subject.text = ""
	if($GUI/send.pressed):
		subject = $GUI/Subject.text
		contents = $GUI/TextEdit.text
		self.visible = false
		send()

func send():
	pass
