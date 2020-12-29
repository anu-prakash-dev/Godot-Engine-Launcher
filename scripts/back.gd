extends Button


func _process(delta):
	if(self.pressed):
		get_tree().get_root().get_node("EngineList/Panel/import").visible = false
