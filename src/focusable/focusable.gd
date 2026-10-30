class_name Focusable extends Node

@export var focus: bool = true:
	set(f):
		focus = f
		for c in self.get_children():
			c.scale = Vector2(1.0, 1.0) if self.focus else Vector2(0.95, 0.95)
			c.modulate = Color(1.0, 1.0, 1.0) if self.focus else Color(0.5, 0.5, 0.5)

@export var autofocus_on_speaker: Array[String]

func _ready() -> void:
	self.focus = self.focus

func update_line(line: DialogueLine) -> void:
	self.focus = self.autofocus_on_speaker.size() > 0 && line.speaker in self.autofocus_on_speaker
	#print("autofocus? ", self.focus, line.speaker, self.autofocus_on_speaker)
