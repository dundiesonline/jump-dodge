extends PlayerState

const state_type = PlayerStateType.RUNNING;
const state_name = "RUNNING";

func get_state_name() -> String:
	return state_name;

func get_state_type() -> int:
	return state_type;

func do_enter(from_state):
	play_animation(state_type);
	
func do_process(delta):
	var new_velocity = player._velocity;
	
	new_velocity.y += player.gravity * delta;
	new_velocity.x = player.direction * player.running_speed;
	
	player._velocity = player.move_and_slide(new_velocity, player.FLOOR_NORMAL);

	
func do_handle_input(input: InputEvent):
	if input.is_action_pressed("jump"):
		print("a r")
		return PlayerStateType.JUMPING;
	return;
