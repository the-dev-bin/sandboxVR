extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SWORD_DAMAGE = 20


var controller

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area.connect("body_entered",self,"body_entered_sword",["01"])
	$Area2.connect("body_entered",self,"body_entered_sword",["02"])
	pass # Replace with function body.

func picked_up():
	pass
	
func dropped():
	pass
	
func body_entered_sword(body,number):
	if body == self:
		pass
	else:
		var sword_part = null
		if number == "01":
			sword_part = get_node("Area")
		elif number == "02":
			sword_part = get_node("Area2")
		
		if body.has_method("damage"):
			body.damage(sword_part.global_transform.looking_at(body.global_transform.origin, Vector3(0, 1, 0)), SWORD_DAMAGE)

			get_node("AudioStreamPlayer3D").play()

		elif body.has_method("apply_impulse"):

			var direction_vector = sword_part.global_transform.origin - body.global_transform.origin

			if not controller:
				body.apply_impulse(direction_vector.normalized(), direction_vector.normalized() * self.linear_velocity)
			else:
				body.apply_impulse(direction_vector.normalized(), direction_vector.normalized() * controller.controller_velocity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
