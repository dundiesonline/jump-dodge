extends KinematicBody2D

const FLOOR_NORMAL: = Vector2.UP;
export var gravity: = 1000.00;

var _velocity: = Vector2.ZERO;

export var speed: = Vector2(250.0, 500.0);
const running_speed = 150.00;

var direction = 1;
var jump_times = 0;

func _physics_process(delta: float) -> void:
#	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0;
#	var direction = get_direction();
#	_velocity = calc_move_velocity(_velocity, direction, speed, is_jump_interrupted);
	var new_velocity = _velocity;

	if is_on_floor():
		get_node("AnimatedSprite").play("running")
		jump_times = 0;

	if is_on_wall():
		direction *= -1;
		flip_sprite()

	#lol
	if Input.is_action_just_pressed("jump") and jump_times < 3:
		if jump_times == 0:
			get_node("AnimatedSprite").play("jumping")
			new_velocity.y = speed.y * -1;
		elif jump_times == 1 :
			get_node("AnimatedSprite").play("sommersault")
		elif jump_times == 2 :
			get_node("AnimatedSprite").play("jumping")
			new_velocity.y = speed.y * -1; #more ?
		jump_times += 1;
#		elif jump_times == 2:
#			jump_times = 0;
	
	new_velocity.y += gravity * delta;
	new_velocity.x = direction * running_speed;
	
	_velocity = move_and_slide(new_velocity, FLOOR_NORMAL);
	
func flip_sprite() -> void:
		if direction > 0:
			get_node("AnimatedSprite").flip_h = false;
		else:
			get_node("AnimatedSprite").flip_h = true;

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
		-Input.get_action_strength("jump") if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	);
	
func calc_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:

	var new_velocity = linear_velocity;
	new_velocity.x  = speed.x  * direction.x;
	new_velocity.y += gravity * get_physics_process_delta_time();
	
	if direction.y != 0.0:
		new_velocity.y = speed.y * direction.y;	
	if is_jump_interrupted:
		new_velocity.y = 0;
	
	return new_velocity;
	
