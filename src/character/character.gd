@tool
class_name Character extends Node2D

@export var sprite_frames: SpriteFrames:
	set(val):
		sprite_frames = val
		if self.is_node_ready():
			_sprite().sprite_frames = val
@export var animation: String:
	set(val):
		animation = val
		if self.is_node_ready():
			_sprite().animation = val
@export var focus: bool = true:
	set(f):
		focus = f
		if self.is_node_ready():
			_focusable().focus = f
@export var autofocus_on_speaker: Array[String]:
	set(f):
		autofocus_on_speaker = f
		if self.is_node_ready():
			_focusable().autofocus_on_speaker = f

@export_range(0, 1, 0.5) var anchor_x: float = 0.0:
	set(val):
		anchor_x = val
		if self.is_node_ready():
			_sprite().offset.x = -self.get_size()[0] * self.anchor_x
@export_range(0, 1, 0.5) var anchor_y: float = 0.0:
	set(val):
		anchor_y = val
		if self.is_node_ready():
			_sprite().offset.y = -self.get_size()[1] * self.anchor_y

func _ready() -> void:
	# run various is_node_ready() updates
	self.sprite_frames = self.sprite_frames
	self.animation = self.animation
	self.autofocus_on_speaker = self.autofocus_on_speaker
	self.focus = self.focus
	self.anchor_x = self.anchor_x
	self.anchor_y = self.anchor_y
	#print("anchor", $AnimatedSprite2D.offset)

func _sprite() -> AnimatedSprite2D:
	return $Focusable/AnimatedSprite2D
func _focusable() -> Focusable:
	return $Focusable

func update_line(line: DialogueLine) -> void:
	_focusable().update_line(line)

func get_size() -> Vector2:
	return self.sprite_frames.get_frame_texture(self.animation, 0).get_size() if self.sprite_frames else Vector2(0, 0)

func _validate_property(property: Dictionary) -> void:
	if property.name == "animation":
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(self.sprite_frames.get_animation_names()) if self.sprite_frames else ''
		#print('sprite frames list ui:', property.hint_string)
