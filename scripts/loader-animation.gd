extends Sprite


func _ready():
	OS.window_size.x = self.texture.get_size().x
	OS.window_size.y = self.texture.get_size().y
	OS.window_borderless = true
	
