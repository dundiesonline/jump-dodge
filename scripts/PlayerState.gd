extends Node
class_name PlayerState

onready var player = owner;
onready var animated_sprite: AnimatedSprite = player.get_node("AnimatedSprite");

const state_animation_map = {
	PlayerStateType.IDLE: "idle",
	PlayerStateType.RUNNING: "running",
	PlayerStateType.JUMPING: "jumping"
};

func enter() -> void:
	return
	
func process(delta: float) -> void:
#	do_handle_action_button(delta);
	do_process(delta);
	do_post_process(delta);
	return;

func do_process(delta: float) -> void:
	return
	
func do_post_process(delta: float) -> void:
	return;

func action_button_is_pressed() -> bool:
	return Input.is_action_just_pressed("jump");

func do_handle_action_button(delta: float) -> void:
	return

# Clean up the PlayerState. Reinitialize values like a timer
func exit() -> void:
	return

func play_animation(state_type: int):
	animated_sprite.play(state_animation_map[state_type]);
