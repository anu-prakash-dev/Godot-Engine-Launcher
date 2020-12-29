extends Control



func _process(delta):
	if($GUI/back.pressed):
		self.visible = false
