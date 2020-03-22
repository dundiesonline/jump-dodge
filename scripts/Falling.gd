extends PlayerState

const state_type = PlayerStateType.FALLING;
const state_name = "FALLING";


func get_state_name() -> String:
	return state_name;

func get_state_type() -> int:
	return state_type;

func do_enter(from_state):
	play_animation(state_type);

func do_process(delta):
	print(player._velocity.y)
	var new_velocity = player._velocity;
	new_velocity.y += player.gravity * delta;
	new_velocity.x = player.direction * player.falling_distance;
	
	player._velocity = player.move_and_slide(new_velocity, player.FLOOR_NORMAL);
	
	
func do_handle_input(input: InputEvent):
	print(player._velocity.y)
	if input.is_action_pressed("jump"):
		return PlayerStateType.SPINNING;
	return;

