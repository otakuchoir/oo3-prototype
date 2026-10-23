extends Node2D

@export var focus: bool=false:
	set(val):
		focus = val
		$AnimatedSprite2D.scale = Vector2(1.0, 1.0) if self.focus else Vector2(0.95, 0.95)
		$AnimatedSprite2D.modulate = Color(1.0, 1.0, 1.0) if self.focus else Color(0.5, 0.5, 0.5)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#self.focus = self.focus # update fx


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
