extends Button


func _process(delta):
	if(self.pressed):
		get_node("GUI").visible = true
		get_tree().get_root().get_node("EngineList/Panel/Tab/Installed/GUI").visible = false


func _on_ItemList_nothing_selected():
	if($GUI.visible == true):
		get_tree().get_root().get_node("EngineList/Panel/info").hide()


func _on_ItemList_item_selected(index):
	get_tree().get_root().get_node("EngineList/Panel/info").set2("Version: "+$GUI/ItemList.list[index].file_name+"\nLink: "+$GUI/ItemList.list[index].link)
