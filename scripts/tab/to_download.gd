extends Button

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################


# here's button to switch main gui to Installed list
func _process(_delta):
	if(self.pressed):
		get_node("GUI").visible = true
		get_tree().get_root().get_node("EngineList/Panel/Tab/Installed/GUI").visible = false


func _on_ItemList_nothing_selected():
	if($GUI.visible == true):
		get_tree().get_root().get_node("EngineList/Panel/info").hide()


func _on_ItemList_item_selected(index):
	get_tree().get_root().get_node("EngineList/Panel/info").set2("Version: "+$GUI/ItemList.list[index].file_name+"\nLink: "+$GUI/ItemList.list[index].link)
