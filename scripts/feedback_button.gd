extends Button


func _process(_delta):
	if(self.pressed):
		get_tree().get_root().get_node("EngineList/Panel/Settings/GUI").visible = false
		get_tree().get_root().get_node("EngineList/Panel/Feedback").visible = true
