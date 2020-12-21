extends Button


var sltd = null

func _process(_delta):
	if(self.pressed):
		if(sltd != null):
			var file = File.new()
			file.open("user://data/to_download.data", File.WRITE)
			file.store_line(to_json(sltd))
			file.close()
			get_tree().change_scene("res://scenes/updater.tscn")
