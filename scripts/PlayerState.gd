extends Node
class_name PlayerState

onready var player = owner;
onready var animation_player: AnimationPlayer = player.get_node("AnimationPlayer");
onready var player_state_history = player.state_history;

const state_animation_map = {
	PlayerStateType.IDLE: "idle",
	PlayerStateType.RUNNING: "running",
	PlayerStateType.JUMPING: "jumping",
	PlayerStateType.FALLING: "falling",
	PlayerStateType.SPINNING: "spinning"
};

func enter(from_state = null) -> void:
	do_enter(from_state);

func do_enter(from_state) -> void:
	pass;

func handle_input(input: InputEvent):
	return do_handle_input(input);
	
func do_handle_input(input: InputEvent):
	pass;
	
func physics_process(delta: float):
	return do_process(delta);

func do_process(delta: float):
	return null;
	
func do_post_process(delta: float) -> void:
	return;

func action_button_is_pressed() -> bool:
	return Input.is_action_just_pressed("jump");

func do_handle_action_button(delta: float) -> void:
	return

# Clean up the PlayerState. Reinitialize values like a timer
func exit(to_state) -> void:
	do_exit(to_state);

func do_exit(to_state) -> void:
	pass;

func play_animation(state_type: int):
	animation_player.play(state_animation_map[state_type]);
	
#move to player
func contains_in_range_history(state: int, in_range: int) -> bool:
	for index in in_range:
		if state == player_state_history[index]:
			return true;
	return false;

func is_state_in_history(state: int, position: int) -> bool:
	position -= 1;
	print(player_state_history)
	print(state)
	print(player_state_history[position])
	return state == player_state_history[position];
