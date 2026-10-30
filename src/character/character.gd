@tool
extends Node2D

enum Focus { TRUE, FALSE, AUTO }

@export var sprite_frames: SpriteFrames:
	set(val):
		sprite_frames = val
		if self.is_node_ready():
			$AnimatedSprite2D.sprite_frames = val
@export var animation: String:
	set(val):
		animation = val
		if self.is_node_ready():
			$AnimatedSprite2D.animation = val
@export var focus: Focus = Focus.AUTO:
	set(val):
		focus = val
		# TODO implement autofocus
		if self.is_node_ready():
			$AnimatedSprite2D.scale = Vector2(1.0, 1.0) if self.focus != Focus.FALSE else Vector2(0.95, 0.95)
			$AnimatedSprite2D.modulate = Color(1.0, 1.0, 1.0) if self.focus != Focus.FALSE else Color(0.5, 0.5, 0.5)

@export_range(0, 1, 0.5) var anchor_x: float = 0.0:
	set(val):
		anchor_x = val
		if self.is_node_ready():
			$AnimatedSprite2D.offset.x = -self.get_size()[0] * self.anchor_x
@export_range(0, 1, 0.5) var anchor_y: float = 0.0:
	set(val):
		anchor_y = val
		if self.is_node_ready():
			$AnimatedSprite2D.offset.y = -self.get_size()[1] * self.anchor_y

func _ready() -> void:
	# run various is_node_ready() updates
	self.sprite_frames = self.sprite_frames
	self.animation = self.animation
	self.focus = self.focus
	self.anchor_x = self.anchor_x
	self.anchor_y = self.anchor_y
	#print("anchor", $AnimatedSprite2D.offset)

func get_size() -> Vector2:
	return self.sprite_frames.get_frame_texture(self.animation, 0).get_size() if self.sprite_frames else Vector2(0, 0)

func _validate_property(property: Dictionary) -> void:
	if property.name == "animation":
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(self.sprite_frames.get_animation_names()) if self.sprite_frames else ''
		#print('sprite frames list ui:', property.hint_string)
