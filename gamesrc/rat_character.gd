extends CharacterBody2D
@onready var sprite_2d = $Sprite2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var ladder_ray_cast: RayCast2D = $LadderRayCast2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var jump_charge = 0

func _physics_process(delta: float) -> void:
	var ladderCollider = ladder_ray_cast.get_collider()
	if ladderCollider: _ladder_climb(delta)
	else:  _movement(delta)
	
	#set_animation()

	move_and_slide()
	var isLeft = velocity.x > 0
	sprite_2d.flip_h = isLeft
	
func _ladder_climb(delta):
	var direction := Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	animated_sprite_2d.animation = "climb"
	if direction: velocity = direction * SPEED /2
	
	else: velocity = Vector2.ZERO

func _movement(delta):
	animated_sprite_2d.animation = "walk"
	if not is_on_floor():
		velocity += get_gravity() * delta

	#Handle Charge
	if Input.is_action_pressed("ui_down") && Input.get_axis("ui_left", "ui_right") == 0 && is_on_floor():
		jump_charge +=.2
		
		if jump_charge > 10:
			velocity.y = JUMP_VELOCITY * 2
			jump_charge = 0 

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#if velocity: animated_sprite_2d.play("move")
	#else: animated_sprite_2d.play("idle")
	
		
	#if Input.is_action_just_released()
