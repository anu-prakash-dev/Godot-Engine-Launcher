extends Panel

###############################
#   Copyright © GamePlayer    #
#        2020 - 2021          #
#   Godot Engine Launcher     #
#    Opensource Project       #
###############################

# here's Panel code to add new Godot Engine version
func _process(_delta):
	if($Import.pressed):
		add_installed($name.text, $path.text)
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/EngineList.tscn")

func add_installed(version, path):
	var list = {"version":version, "path":path}
	write_file("user://data/installed/"+version+".list", "json", list)

func write_file(path, type, data):
	var file = File.new()
	file.open(path, File.WRITE)
	if(type == "json"):
		
		file.store_line(to_json(data))
	elif(type == "var"):
		file.store_var(data)
	elif(type == "buffer"):
		file.store_buffer(data)
	elif(type == "string"):
		file.store_string(data)
	elif(type == "real"):
		file.store_real(data)
	else:
		file.store_line(data)
	file.close()
