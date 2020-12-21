extends Control

var set1 = true
var set2 = true
var a1 = true
onready var time1 = OS.get_system_time_msecs()
var a2 = true
onready var time2 = OS.get_system_time_msecs()

func _process(delta):
	if($cgs.pressed and a1 == true):
		set1 = not(set1)
		time1 = OS.get_system_time_msecs()
		a1 = false
	if(set1 == true):
		$cgs.text = "+"
		$cgs.modulate.r = 0
		$cgs.modulate.g = 1
		$cgs.modulate.b = 0
	else:
		$cgs.text = "-"
		$cgs.modulate.r = 1
		$cgs.modulate.g = 0
		$cgs.modulate.b = 0
		
	if(a1 == false and OS.get_system_time_msecs() - time1 > 300):
		a1 = true
	if($rgl.pressed and a2 == true):
		set2 = not(set2)
		time2 = OS.get_system_time_msecs()
		a2 = false
	if(set2 == true):
		$rgl.text = "+"
		$rgl.modulate.r = 0
		$rgl.modulate.g = 1
		$rgl.modulate.b = 0
	else:
		$rgl.text = "-"
		$rgl.modulate.r = 1
		$rgl.modulate.g = 0
		$rgl.modulate.b = 0
	if(a2 == false and OS.get_system_time_msecs() - time2 > 300):
		a2 = true
