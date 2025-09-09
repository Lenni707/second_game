extends CharacterBody2D


const SPEED = 120.0
const JUMP_VELOCITY = -200.0

@onready var ani: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	
	if direction:
		ani.play("run")
		velocity.x = direction * SPEED
		if direction == -1:
			ani.flip_h = true
		elif direction == 1:
			ani.flip_h = false
	else:
		ani.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
