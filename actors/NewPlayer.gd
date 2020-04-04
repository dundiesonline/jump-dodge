extends KinematicBody2D

onready var state_map = {
	PlayerStateType.IDLE: $PlayerState/Idle,
	PlayerStateType.RUNNING: $PlayerState/Running,
	PlayerStateType.JUMPING: $PlayerState/Jumping,
	PlayerStateType.FALLING: $PlayerState/Falling,
	PlayerStateType.SPINNING: $PlayerState/Spinning,
	PlayerStateType.SLIDING: $PlayerState/Sliding
}

onready var collision_shape = $CollisionShape2D;

var current_state: PlayerState;
var prev_state_type;
var _velocity: = Vector2.ZERO; # change to velocity

var state_history = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

export var MAX_JUMPS = 2;
export var MAX_SPINS = 2;

const FLOOR_NORMAL: = Vector2.UP; #AUTOLOAD
const running_speed = 300.00;

const sliding_speed = 350.00;

const jumping_force = 400.00; #TODO different jump force in jumps? have a delay to make spin while falling +100?
const second_jumping_force = 580.00; #TODO different jump force in jumps? have a delay to make spin while falling +100?

const jumping_distance = 300.00;
const second_jumping_distance = 250.00; #TODO different jump force in jumps? have a delay to make spin while falling +100?const falling_distance = 200.00;

const jumping_hit_wall_bounce_distance = 200.0; #TODO fix bounce when jumping just before wall bounce

const falling_distance = 250.00;
const spinning_distance = 200.00;
const gravity = 1500.00;

var direction = 1;
var spinned: bool = false;
var jumping: bool = false;
var jumps: int = 0;
var spins: int = 0;

func _ready() -> void:
	current_state = state_map[PlayerStateType.RUNNING];
	current_state.enter();
	pass

func _input(event: InputEvent) -> void:
	var new_state_type = current_state.handle_input(event);
	if new_state_type != null:
		change_state(new_state_type);
	
func _physics_process(delta: float) -> void:
#	print("PP");
	update_direction();
	
	var new_state_type = current_state.physics_process(delta);
	
	if new_state_type != null:
		change_state(new_state_type);
	else:
		update_state_type();

func change_state(new_state_type) -> void:
	
	if !is_valid_change_state(new_state_type, current_state.get_state_type()):
		return;
	prev_state_type = current_state.get_state_type();
	current_state.exit(new_state_type);
	
	current_state = state_map[new_state_type];
	current_state.enter(prev_state_type);
	state_history.push_front(new_state_type);
	
	if state_history.size() > 15:
		state_history.remove(15);
#	print(state_history)

func is_valid_change_state(new_state_type: int, current_state_type: int) -> bool:
	if new_state_type == PlayerStateType.JUMPING and jumps == MAX_JUMPS:
		return false;
	if new_state_type == PlayerStateType.SPINNING and spins == MAX_SPINS:
		return false;
	return true;
	
func update_state_type() -> void:
	if is_on_floor() and (current_state.get_state_type() != PlayerStateType.RUNNING and current_state.get_state_type() != PlayerStateType.IDLE and current_state.get_state_type() != PlayerStateType.SLIDING):
		change_state(PlayerStateType.RUNNING);
		jumps = 0;
		spins = 0;

func update_direction() -> void:
	if is_on_wall():
		direction *= -1;
		flip_sprite();

func flip_sprite() -> void:
	if direction > 0:
		get_node("Sprite").flip_h = false;
	else:
		get_node("Sprite").flip_h = true;

