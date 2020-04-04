extends PlayerState

const state_type = PlayerStateType.SLIDING;
const state_name = "SLIDING";

var process_loop = 0; #FAKE, FIX THIS SHIT


func get_state_name() -> String:
	return state_name;

func get_state_type() -> int:
	return state_type;

func do_enter(from_state):
#	player.collision_shape.disabled = true;
	play_animation(state_type);
	
func do_exit(to_state):
	process_loop = 0;
#	player.collision_shape.disabled = false;

func do_process(delta):
#	if process_loop == 15:
#		animation_player.play("spinning_end");
#
	if process_loop > 20:
		return PlayerStateType.RUNNING;
	
	var new_velocity = player._velocity;
	
	new_velocity.y += player.gravity * delta;
	new_velocity.x = player.direction * player.sliding_speed;
	
	player._velocity = player.move_and_slide(new_velocity, player.FLOOR_NORMAL);
	process_loop += 1;
	print("sliding", process_loop)
	
#func do_handle_input(input: InputEvent):
#	if input.is_action_pressed("jump"):
#		print("a s")
#		return PlayerStateType.JUMPING;
#	return;

	
	
