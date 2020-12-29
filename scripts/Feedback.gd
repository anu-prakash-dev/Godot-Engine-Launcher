extends Control

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
