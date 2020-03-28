extends PlayerState

const state_type = PlayerStateType.SPINNING;
const state_name = "SPINNING";

var process_loop = 0; #FAKE, FIX THIS SHIT


func get_state_name() -> String:
	return state_name;

func get_state_type() -> int:
	return state_type;

func do_enter(from_state):
#	player.collision_shape.disabled = true;
	play_animation(state_type);
	player.spins += 1;
	
func do_exit(to_state):
	process_loop = 0;
#	player.collision_shape.disabled = false;

func do_process(delta):
	if process_loop == 15:
		animation_player.play("spinning_end");
		
	if process_loop > 20:
		return PlayerStateType.FALLING;
	
	var new_velocity = player._velocity;
	
	new_velocity.y = 0;
	new_velocity.x = player.direction * player.spinning_distance;
	
	player._velocity = player.move_and_slide(new_velocity, player.FLOOR_NORMAL);
	process_loop += 1;
	
func do_handle_input(input: InputEvent):
	if input.is_action_pressed("jump"):
		print("a s")
		return PlayerStateType.JUMPING;
	return;

	
	
