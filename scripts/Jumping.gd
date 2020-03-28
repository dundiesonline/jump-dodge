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
	player.jumps += 1;

func do_process(delta):
	var new_velocity = player._velocity;
	
	if just_started:
		if player.jumps == 1:
			new_velocity.y = player.jumping_force * -1;
			new_velocity.x = player.direction * player.jumping_distance;
		elif player.jumps > 1:
			new_velocity.y = player.second_jumping_force * -1;
			new_velocity.x = player.direction * player.second_jumping_distance;
	
	if player.is_on_wall():
		new_velocity.x = new_velocity.x + (player.direction * player.jumping_hit_wall_bounce_distance);
	
	new_velocity.y += player.gravity * delta;
	
	if new_velocity.y >= 0:
		return PlayerStateType.FALLING;
		
	
	player._velocity = player.move_and_slide(new_velocity, player.FLOOR_NORMAL);
	just_started = false;
	
func do_handle_input(input: InputEvent):
	if input.is_action_pressed("jump"):
		return PlayerStateType.SPINNING;
	return;
