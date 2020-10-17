extends ARVROrigin


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var arvr_iface = ARVRServer.find_interface("OpenVR")
	if(arvr_iface and arvr_iface.initialize()):
		get_viewport().arvr = true
		get_viewport().hdr = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
