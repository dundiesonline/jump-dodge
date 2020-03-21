extends PlayerState

const value = PlayerStateType.JUMPING;

var jump_start: bool;

func enter():
	play_animation(value);
	jump(player.get_physics_process_delta_time(), true)

func do_process(delta):
	jump(delta);
	
func jump(delta: float, just_started: bool = false) -> void:
	var new_velocity = player._velocity;
	
	print("j");
	if just_started:
		new_velocity.y = player.jumping_force * -1;
	
	new_velocity.y += player.gravity * delta;
	new_velocity.x = player.direction * player.running_speed;
	
	player._velocity = player.move_and_slide(new_velocity, player.FLOOR_NORMAL);
	

func do_handle_action_button(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		player.change_state(PlayerStateType.JUMPING)
	return;
