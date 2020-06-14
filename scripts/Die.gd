extends PlayerState

const state_type = PlayerStateType.DIE;
const state_name = "DIE";

var process_loop = 0; #FAKE, FIX THIS SHIT

func get_state_name() -> String:
	return state_name;

func get_state_type() -> int:
	return state_type;

func do_enter(from_state):
	process_loop = 0;
	play_animation(state_type);
	

func do_process(delta):
	var new_velocity = player._velocity;
#	new_velocity.y += player.gravity * delta;
#	new_velocity.x = player.direction * player.falling_distance;
#
#	player._velocity = player.move_and_slide(new_velocity, player.FLOOR_NORMAL);
#	process_loop += 1;
	
func do_handle_input(input: InputEvent):
#	print(is_state_in_history(PlayerStateType.FALLING, 1));
#	if input.is_action_pressed("jump"):
#		if process_loop < 10 and is_state_in_history(PlayerStateType.SPINNING, 2):
#			return PlayerStateType.JUMPING;
#		else:
#			return PlayerStateType.SPINNING;
	return;

