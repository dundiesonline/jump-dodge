extends PlayerState

const state_type = PlayerStateType.IDLE;
const state_name = "IDLE";

func get_state_name() -> String:
	return state_name;

func get_state_type() -> int:
	return state_type;

func enter() -> void:
	play_animation(state_type);
	
func do_process(delta: float):
	if action_button_is_pressed():
		return PlayerStateType.RUNNING;
	print("p i");
	return null;
	
	
func do_handle_input(input: InputEvent):
	if input.is_action_pressed("jump"):
		print("a i")
		return PlayerStateType.RUNNING;
	return;

func exit():
	print("x i")
