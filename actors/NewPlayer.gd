extends KinematicBody2D

onready var state_map = {
	PlayerStateType.IDLE: $PlayerState/Idle,
	PlayerStateType.RUNNING: $PlayerState/Running,
	PlayerStateType.JUMPING: $PlayerState/Jumping
}

var current_state: PlayerState;
var prev_state_type;
var _velocity: = Vector2.ZERO; # change to velocity

const FLOOR_NORMAL: = Vector2.UP; #AUTOLOAD
const running_speed = 300.00;
const jumping_force = 500.00;
const gravity = 1000.00;

var loop = 0;
var direction = 1;

func _ready() -> void:
	current_state = state_map[PlayerStateType.IDLE];
	current_state.enter();
	pass

func _input(event: InputEvent) -> void:
	var new_state_type = current_state.handle_input(event);
	if new_state_type != null:
		change_state(new_state_type);
	
func _physics_process(delta: float) -> void:
	print("PP");
	update_direction();
	
	var new_state_type = current_state.physics_process(delta);
	
	if new_state_type != null:
		change_state(new_state_type);
	else:
		update_state_type();

func change_state(new_state_type) -> void:
	prev_state_type = current_state.get_state_type();
	current_state.exit();
	current_state = state_map[new_state_type];
	current_state.enter();

func update_state_type() -> void:
	if is_on_floor() and (current_state.get_state_type() != PlayerStateType.RUNNING and current_state.get_state_type() != PlayerStateType.IDLE):
		change_state(PlayerStateType.RUNNING);

func update_direction() -> void:
	if is_on_wall():
		direction *= -1;
		flip_sprite();

func flip_sprite() -> void:
	if direction > 0:
		get_node("AnimatedSprite").flip_h = false;
	else:
		get_node("AnimatedSprite").flip_h = true;

