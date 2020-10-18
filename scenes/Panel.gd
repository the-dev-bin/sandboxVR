extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var objects = [
	#"res://scenes/Cube.tscn"
	"Test"
]
# Called when the node enters the scene tree for the first time.
func _ready():
	for object in objects:
		$ItemList.add_item(object)
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
