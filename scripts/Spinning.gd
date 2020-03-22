extends PlayerState

const state_type = PlayerStateType.SPINNING;
const state_name = "SPINNING";

var process_loop = 0; #FAKE, FIX THIS SHIT

func get_state_name() -> String:
	return state_name;

func get_state_type() -> int:
	return state_type;

func do_enter(from_state):
	play_animation(state_type);

func do_process(delta):
	if process_loop > 30:
		return PlayerStateType.FALLING;
	
	var new_velocity = player._velocity;
	
	new_velocity.y = 0;
	new_velocity.x = player.direction * player.jumping_distance;
	
	player._velocity = player.move_and_slide(new_velocity, player.FLOOR_NORMAL);
	process_loop += 1;
	print(process_loop);
	
func do_handle_input(input: InputEvent):
	if input.is_action_pressed("jump"):
		print("a s")
		return PlayerStateType.JUMPING;
	return;

func exit():
	process_loop = 0;
	
	
