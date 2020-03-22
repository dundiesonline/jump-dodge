extends Camera2D

func _physics_process(delta: float) -> void:
	self.position.y = self.position.y - 0.5;
