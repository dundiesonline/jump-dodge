extends PlayerState

const value = PlayerStateType.RUNNING;

func enter():
	print("e r");
	play_animation(value);
	run(player.get_physics_process_delta_time(), true);
	
func do_process(delta):
	if action_button_is_pressed():
		print("a r")
		owner.change_state(PlayerStateType.JUMPING)
		return;
	print("p r");
	run(delta);

func run(delta: float, just_started: bool = false) -> void:
	
	var new_velocity = player._velocity;
	print("r");
	
	new_velocity.y += player.gravity * delta;
	new_velocity.x = player.direction * player.running_speed;
#	print(new_velocity);
	
	player._velocity = player.move_and_slide(new_velocity, player.FLOOR_NORMAL);
	
func do_handle_action_button(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		player.change_state(PlayerStateType.JUMPING);
	return;
 
