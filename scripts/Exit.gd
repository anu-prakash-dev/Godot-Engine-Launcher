extends Button

func _process(_delta):
	if(self.pressed):
		get_tree().quit()
