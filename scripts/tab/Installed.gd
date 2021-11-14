extends Button

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################

# here's button to switch main gui to download tab
func _process(_delta):
	if(self.pressed):
		get_node("GUI").visible = true
		get_tree().get_root().get_node("EngineList/Panel/Tab/to_download/GUI").visible = false
	if($GUI/ItemList.get_item_count() == 0):
		$GUI/Label.visible = true
		$GUI/ItemList.visible = false
	else:
		$GUI/Label.visible = false
		$GUI/ItemList.visible = true


func _on_ItemList_nothing_selected():
	if($GUI.visible == true):
		get_tree().get_root().get_node("EngineList/Panel/info").hide()



func _on_ItemList_item_selected(index):
	get_tree().get_root().get_node("EngineList/Panel/info").set2("Version: "+$GUI/ItemList.list[index].file_name+"\nPath: "+$GUI/ItemList.list[index].path)
