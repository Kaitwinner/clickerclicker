extends CharacterBody3D

var speed
const WALK_SPEED = 5.0
const SPRINT_SPEED = 8.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.004

# Head bob
const BOB_FREQ = 2.4
const BOB_AMP = 0.08
var t_bob = 0.0

# FOV
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

# Gravity
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var ray = $head/Camera3D/RayCast3D
@onready var head = $head
@onready var camera = $head/Camera3D

var camera_origin: Vector3

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera_origin = camera.position


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# Rotate player left/right
		rotate_y(-event.relative.x * SENSITIVITY)

		# Rotate camera up/down
		camera.rotation.x -= event.relative.y * SENSITIVITY
		camera.rotation.x = clamp(
			camera.rotation.x,
			deg_to_rad(-60),
			deg_to_rad(75)
		)


func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Sprint
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED

	# Movement input
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(-input_dir.x, 0, -input_dir.y)).normalized()

	if is_on_floor():
		if direction != Vector3.ZERO:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 15.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 15.0)
		else:
			velocity.x = lerp(velocity.x, 0.0, delta * 7.0)
			velocity.z = lerp(velocity.z, 0.0, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)

	# Head bob
	var horizontal_speed = Vector2(velocity.x, velocity.z).length()
	t_bob += delta * horizontal_speed * float(is_on_floor())
	camera.position = camera_origin + _headbob(t_bob)

	# FOV
	var target_fov = BASE_FOV + FOV_CHANGE * clamp(horizontal_speed, 0.0, SPRINT_SPEED)
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)	

	if Input.is_action_just_pressed("interact"):

		if ray.is_colliding():

			var object = ray.get_collider()

			if object.has_method("interact"):
				object.interact()

	move_and_slide()


func _headbob(time):
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2.0) * BOB_AMP
	return pos
