extends KinematicBody2D

onready var state_map = {
	PlayerStateType.IDLE: $PlayerState/Idle,
	PlayerStateType.RUNNING: $PlayerState/Running,
	PlayerStateType.JUMPING: $PlayerState/Jumping,
	PlayerStateType.FALLING: $PlayerState/Falling,
	PlayerStateType.SPINNING: $PlayerState/Spinning
}

onready var collisionShape = $CollisionShape2D;

var current_state: PlayerState;
var prev_state_type;
var _velocity: = Vector2.ZERO; # change to velocity

export var MAX_JUMPS = 2;

const FLOOR_NORMAL: = Vector2.UP; #AUTOLOAD
const running_speed = 300.00;
const jumping_force = 500.00; #TODO different jump force in jumps? have a delay to make spin while falling +100?
const jumping_distance = 300.00;
const falling_distance = 200.00;
const gravity = 1000.00;

var direction = 1;
var spinned: bool = false;
var jumping: bool = false;
var jumps: int = 0;

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
	prev_state_type = current_state.get_state_type();
	current_state.exit();
	
	current_state = state_map[new_state_type];
	print(current_state.get_state_name());
	if current_state.get_state_type() ==  PlayerStateType.RUNNING || current_state.get_state_type() == PlayerStateType.IDLE || current_state.get_state_type() == PlayerStateType.FALLING:
		collisionShape.disabled = false;
#		collisionShape.disabl("disabled", false);
	else:
#		collisionShape.set_deferred("disabled", true);
		collisionShape.disabled = true;
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
		get_node("Sprite").flip_h = false;
	else:
		get_node("Sprite").flip_h = true;

