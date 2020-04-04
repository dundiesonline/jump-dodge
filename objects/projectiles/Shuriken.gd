extends KinematicBody2D

var _velocity: = Vector2.ZERO; # change to velocity

var direction = 1;
const speed = 150.00;
const FLOOR_NORMAL: = Vector2.UP; #AUTOLOAD
onready var animation_player: AnimationPlayer = self.get_node("AnimationPlayer");

func _ready() -> void:
	animation_player.play("spinning")

func _physics_process(delta: float) -> void:
	update_direction();
	var new_velocity = self._velocity;
	
	new_velocity.y = 0;
	new_velocity.x = self.direction * self.speed;
	
	self._velocity = self.move_and_slide(new_velocity, self.FLOOR_NORMAL);

func update_direction() -> void:
	if is_on_wall():
		direction *= -1;
#		flip_sprite();

func flip_sprite() -> void:
	if direction > 0:
		get_node("Sprite").flip_h = false;
	else:
		get_node("Sprite").flip_h = true;
