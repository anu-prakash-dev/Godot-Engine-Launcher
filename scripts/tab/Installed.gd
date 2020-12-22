extends Button


func _process(delta):
	if(self.pressed):
		get_node("GUI").visible = true
		get_tree().get_root().get_node("EngineList/Panel/Tab/to_download/GUI").visible = false
	if($GUI/ItemList.get_item_count() == 0):
		$GUI/Label.visible = true
		$GUI/ItemList.visible = false
	else:
		$GUI/Label.visible = false
		$GUI/ItemList.visible = true
