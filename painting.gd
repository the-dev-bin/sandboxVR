extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var drawing_stuff
var flash_timer = -99

func _physics_process(delta):
	if flash_timer > 0:
		flash_timer -= delta
		drawing_stuff.add_vertex($paint_pos.global_transform.origin)
	if flash_timer <= 0 and flash_timer != 99:
		drawing_stuff.end()
		



# Called when the node enters the scene tree for the first time.
func _ready():
	drawing_stuff = get_tree().root.get_node("Game/painter")
	
	
func interact():
	drawing_stuff.begin(2)
	drawing_stuff.set_color(Color(1.0,0,0))
	flash_timer = 15


func picked_up():
	drawing_stuff.clear()
	print("picked up!")
	
func dropped():
	print("dropped!")

