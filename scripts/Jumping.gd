extends PlayerState

const state_type = PlayerStateType.JUMPING;
const state_name = "JUMPING";

var just_started: bool = false;

func get_state_name() -> String:
	return state_name;

func get_state_type() -> int:
	return state_type;

func do_enter(from_state):
	play_animation(state_type);
	just_started = true;

func do_process(delta):
	var new_velocity = player._velocity;
	
	print("j");
	if just_started:
		new_velocity.y = player.jumping_force * -1;
	
	new_velocity.y += player.gravity * delta;
	
	if new_velocity.y >= 0:
		return PlayerStateType.FALLING;
		
	new_velocity.x = player.direction * player.jumping_distance;
	
	player._velocity = player.move_and_slide(new_velocity, player.FLOOR_NORMAL);
	just_started = false;
	
func do_handle_input(input: InputEvent):
	if input.is_action_pressed("jump"):
		print("a i")
		return PlayerStateType.SPINNING;
	return;
