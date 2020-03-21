extends PlayerState

const value = PlayerStateType.IDLE;

func enter() -> void:
	play_animation(value);
	
func do_process(delta: float) -> void:
	if action_button_is_pressed():
		print("a i")
		owner.change_state(PlayerStateType.RUNNING)
		return;
	print("p i");
	return;
	
func do_handle_action_button(delta: float) -> void:
#	if Input.is_action_just_pressed("jump"):
#		print("a i")
#		owner.change_state(PlayerStateType.RUNNING)
#		return;
	return;

func exit():
	print("x i")
