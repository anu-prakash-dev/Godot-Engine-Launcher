extends Node

##################################
#  Copyright C 2022 GamePlayer   #
# GNU GENERAL PUBLIC LICENSE 3.0 #
##################################

static func mkdir(path):
	""" Make directory """
	var dir = Directory.new()
	if dir.dir_exists(path):
		return false

	dir.make_dir(path)
	return true

static func mkfile(path, type, data):
	""" Make new file or overwrite existing """
	var file = File.new()
	file.open(path, File.WRITE)
	match type:
		"json":
			file.store_line(to_json(data))
		"var":
			file.store_var(data)
		"buffer":
			file.store_buffer(data)
		"string":
			file.store_string(data)
		"real":
			file.store_real(data)
		"script":
			var gd = GDScript.new()
			gd.set_script(data)
			file.store_line(gd)
		"":
			file.store_line(str(data))
	file.close()

static func rdfile(path, type):
	""" Read file """
	var data = null
	var file = File.new()
	var dir = Directory.new()
	if dir.file_exists(path):
		file.open(path, File.READ)
		match type:
			"json":
				data = JSON.parse(file.get_as_text()).result
			"table":
				data = [parse_json(file.get_line())]
			"var":
				data = file.get_var()
			"script":
				data = file.get_script()
			"":
				data = file.get_as_text()
		file.close()
	return data

static func check(path):
	""" Check if file or dir exist """
	var dir = Directory.new()
	if dir.dir_exists(path):
		return true

	if dir.file_exists(path):
		return true

	return false

static func ls(path):
	""" List directory """
	var dir = Directory.new()
	var list = []
	if !dir.dir_exists(path):
		return ["null"]

	dir.open(path)
	dir.list_dir_begin()
	var f = dir.get_next()
	while not f == "":
		if not(f == "." or f == ".."):
			list += [f]
		f = dir.get_next()
	return list

static func rmdir(path, rmfolder = true):
	""" Remove directory totally """
	var dir = Directory.new()
	if dir.dir_exists(path):
		dir.open(path)
		dir.list_dir_begin()
		var data = dir.get_next()
		while not data == "":
			if not(data == "." or data == ".."):
				if dir.current_is_dir():
					rmdir(path+"/"+data)
					dir.remove(path+"/"+data)
				else:
					dir.remove(path+"/"+data)
			data = dir.get_next()
		if rmfolder:
			dir.remove(path)
		return true

	return false

static func load_image(path, quality = 1):
	""" Load image from user:// or res:// path """
	var texture = ImageTexture.new()
	var image = Image.new()
	image.load(path)
	image.resize(image.get_size().x/quality, image.get_size().y/quality)
	texture.create_from_image(image)
	return texture

static func rmfile(path):
	""" Remove file """
	var dir = Directory.new()
	if dir.file_exists(path):
		dir.remove(path)
		return true

	return false

static func cp(from_path, to_path, cpfolder = true):
	""" Copy directory or file """
	if check(from_path):
		if check(to_path) == false and cpfolder:
			mkdir(to_path)
		var dir = Directory.new()
		dir.open(from_path)
		dir.list_dir_begin()
		var data = dir.get_next()
		while not data == "":
			if not(data == "." or data == ".."):
				if dir.current_is_dir():
					cp(from_path+"/"+data, to_path+"/"+data, true)
				else:
					dir.copy(from_path+"/"+data, to_path+"/"+data)
			data = dir.get_next()
		return true

	return false

func cpfile(from_path, to_path):
	""" Copy file """
	var dir = Directory.new()
	dir.copy(from_path, to_path)

func save_image(texture, path):
	""" Save image to png """
	var _image = texture
	_image.save_png(path)

func mk_dummy_image():
	""" Create a dummy image """
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var _image = Image.new()
	_image.crop(50, 50)
	_image.convert(Image.FORMAT_RGB8)
	_image.lock()
	_image.fill(Color(round(rng.randf_range(1, 100))/100, round(rng.randf_range(1, 100))/100, round(rng.randf_range(1, 100))/100))
	_image.unlock()
	var texture_image = ImageTexture.new()
	texture_image.create_from_image(_image)
	return texture_image

func mk_random_boolean():
	""" Create random boolean value """
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random = round(rng.randf_range(0, 1))
	if random == 1:
		return true

	return false

func mk_random_int(from_int = 0, to_int = 1):
	""" Create random int value """
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random = round(rng.randf_range(from_int, to_int))
	return random

func mk_random_float(from_float = 0, to_float = 1):
	""" Create random float value """
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random = rng.randf_range(from_float, to_float)
	return random

func mk_random_vector2(from_vector = Vector2(0, 0), to_vector = Vector2(0, 0)):
	""" Create random Vector2 value """
	var x = mk_random_float(from_vector.x, to_vector.x)
	var y = mk_random_float(from_vector.y, to_vector.y)
	return Vector2(x, y)
