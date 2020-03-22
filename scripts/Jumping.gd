extends PlayerState

const state_type = PlayerStateType.JUMPING;
const state_name = "JUMPING";

var just_started: bool = false;

func get_state_name() -> String:
	return state_name;

func get_state_type() -> int:
	return state_type;

func enter():
	play_animation(state_type);
	just_started = true;

func do_process(delta):
	var new_velocity = player._velocity;
	
	print("j");
	if just_started:
		new_velocity.y = player.jumping_force * -1;
	
	new_velocity.y += player.gravity * delta;
	new_velocity.x = player.direction * player.running_speed;
	
	player._velocity = player.move_and_slide(new_velocity, player.FLOOR_NORMAL);
	just_started = false;
	
	
	
