class_name DialoguePanel extends Node2D

signal incr_line
signal decr_line

@export var line: DialogueLine:
	set(l):
		assert(l != null)
		line = l
		$quote.text = self.line.quote
		$speaker.text = self.line.speaker
		$line_id.text = "Line ID: "+self.line.id

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") || Input.is_action_just_pressed("leftclick"):
		self.incr_line.emit()
	elif Input.is_action_just_pressed("rewind"):
		self.decr_line.emit()

func update_line(l: DialogueLine) -> void:
	self.line = l
