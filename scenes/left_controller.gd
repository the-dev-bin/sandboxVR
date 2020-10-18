extends ARVRController

onready var grab_area = $grab_area
onready var grab_pos_node = $grab_pos
onready var hand_mesh = $hand
onready var teleport_raycast = $ray_cast

var controller_velocity = Vector3(0, 0, 0)
var prior_controller_position = Vector3(0, 0, 0)
var prior_controller_velocities = []

var held_object = null
var held_object_data = {"mode":RigidBody.MODE_RIGID, "layer":1, "mask":1}

var grab_mode = "AREA"
var teleport_pos
var teleport_mesh
var teleport_button_down

const CONTROLLER_DEADZONE = 0.65

const MOVEMENT_SPEED = 1.5

var directional_movement = false

func _ready():
	teleport_mesh = get_tree().root.get_node("Game/teleport_mesh")
	teleport_button_down = false

	grab_mode = "AREA"
	get_node("sleep_area").connect("body_entered", self, "sleep_area_entered")
	get_node("sleep_area").connect("body_exited", self, "sleep_area_exited")

	connect("button_pressed", self, "button_pressed")
	connect("button_release", self, "button_released")


func _physics_process(delta):

	if teleport_button_down:
		print("TELEPORTATION ACTIVATE")
		if teleport_raycast.is_colliding():
			print("raycast colliding")
			if teleport_raycast.get_collider() is StaticBody:
				print("Static body intersecting")
				if teleport_raycast.get_collision_normal().y >= 0.85:
					teleport_pos = teleport_raycast.get_collision_point()
					teleport_mesh.global_transform.origin = teleport_pos


	# Controller velocity
	# --------------------
	if get_is_active():
		controller_velocity = Vector3(0, 0, 0)

		if prior_controller_velocities.size() > 0:
			for vel in prior_controller_velocities:
				controller_velocity += vel

			# Get the average velocity, instead of just adding them together.
			controller_velocity = controller_velocity / prior_controller_velocities.size()

		prior_controller_velocities.append((global_transform.origin - prior_controller_position) / delta)

		controller_velocity += (global_transform.origin - prior_controller_position) / delta
		prior_controller_position = global_transform.origin

		if prior_controller_velocities.size() > 30:
			prior_controller_velocities.remove(0)

	# --------------------

	if held_object:
		var held_scale = held_object.scale
		held_object.global_transform = grab_pos_node.global_transform
		held_object.scale = held_scale


	# Directional movement
	# --------------------
	# NOTE: you may need to change this depending on which VR controllers
	# you are using and which OS you are on.
	var trackpad_vector = Vector2(-get_joystick_axis(1), get_joystick_axis(0))
	var joystick_vector = Vector2(-get_joystick_axis(5), get_joystick_axis(4))

	if trackpad_vector.length() < CONTROLLER_DEADZONE:
		trackpad_vector = Vector2(0, 0)
	else:
		trackpad_vector = trackpad_vector.normalized() * ((trackpad_vector.length() - CONTROLLER_DEADZONE) / (1 - CONTROLLER_DEADZONE))

	if joystick_vector.length() < CONTROLLER_DEADZONE:
		joystick_vector = Vector2(0, 0)
	else:
		joystick_vector = joystick_vector.normalized() * ((joystick_vector.length() - CONTROLLER_DEADZONE) / (1 - CONTROLLER_DEADZONE))

	var forward_direction = get_parent().get_node("player_camera").global_transform.basis.z.normalized()
	var right_direction = get_parent().get_node("player_camera").global_transform.basis.x.normalized()

	var movement_vector = (trackpad_vector + joystick_vector).normalized()

	var movement_forward = forward_direction * movement_vector.x * delta * MOVEMENT_SPEED
	var movement_right = right_direction * movement_vector.y * delta * MOVEMENT_SPEED

	movement_forward.y = 0
	movement_right.y = 0

	if movement_right.length() > 0 or movement_forward.length() > 0:
		get_parent().translate(movement_right + movement_forward)
		directional_movement = true
	else:
		directional_movement = false
	# --------------------


func button_pressed(button_index):
	print(button_index)
	# If the trigger is pressed...
	if button_index == 15:
		if held_object:
			if held_object.has_method("interact"):
				held_object.interact()

		else:
			if not teleport_mesh.visible and not held_object:
				teleport_button_down = true
				teleport_mesh.visible = true
				teleport_raycast.visible = true


	# If the grab button is pressed...
	if button_index == 2:
		if teleport_button_down:
			return

		if not held_object:

			var rigid_body = null

			if grab_mode == "AREA":
				var bodies = grab_area.get_overlapping_bodies()
				if len(bodies) > 0:
					for body in bodies:
						if body is RigidBody:
							if not "NO_PICKUP" in body:
								rigid_body = body
								break


			if rigid_body:

				held_object = rigid_body

				held_object_data["mode"] = held_object.mode
				held_object_data["layer"] = held_object.collision_layer
				held_object_data["mask"] = held_object.collision_mask

				held_object.mode = RigidBody.MODE_STATIC
				held_object.collision_layer = 0
				held_object.collision_mask = 0

				hand_mesh.visible = false

				if held_object.has_method("picked_up"):
					held_object.picked_up()
				if "controller" in held_object:
					held_object.controller = self


		else:

			held_object.mode = held_object_data["mode"]
			held_object.collision_layer = held_object_data["layer"]
			held_object.collision_mask = held_object_data["mask"]

			held_object.apply_impulse(Vector3(0, 0, 0), controller_velocity)

			if held_object.has_method("dropped"):
				held_object.dropped()

			if "controller" in held_object:
				held_object.controller = null

			held_object = null
			hand_mesh.visible = true


	# If the menu button is pressed...
	if button_index == 1:
		if grab_mode == "AREA":
			grab_mode = "RAYCAST"

		elif grab_mode == "RAYCAST":
			grab_mode = "AREA"


func button_released(button_index):

	# If the trigger button is released...
	if button_index == 15:

		if teleport_button_down:

			if teleport_pos and teleport_mesh.visible:
				var camera_offset = get_parent().get_node("player_camera").global_transform.origin - get_parent().global_transform.origin
				camera_offset.y = 0

				get_parent().global_transform.origin = teleport_pos - camera_offset

			teleport_button_down = false
			teleport_mesh.visible = false
			teleport_raycast.visible = false
			teleport_pos = null


func sleep_area_entered(body):
	if "can_sleep" in body:
		body.can_sleep = false
		body.sleeping = false

func sleep_area_exited(body):
	if "can_sleep" in body:
		body.can_sleep = true
