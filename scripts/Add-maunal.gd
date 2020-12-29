extends Button


func _process(delta):
	if(self.pressed):
		get_tree().get_root().get_node("EngineList/Panel/import/Panel/name").text = "<name>"
		get_tree().get_root().get_node("EngineList/Panel/import/Panel/path").text = OS.get_user_data_dir()
		get_tree().get_root().get_node("EngineList/Panel/import").visible = true
