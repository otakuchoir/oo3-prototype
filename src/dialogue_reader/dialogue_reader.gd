class_name DialogueReader extends Node

signal line_updated(next: DialogueLine)
signal end_dialogue

@export var dialogue_path: String = "res://assets/dialogue/oo3-prototype.json"
var line_num: int = 0
var dialogue: DialogueData

func _ready() -> void:
	self.dialogue = DialogueData.read_json(self.dialogue_path)

func current_line() -> DialogueLine:
	return self.dialogue.data[self.line_num] if self.is_in_bounds() else null

func is_in_bounds() -> bool:
	return self.line_num >= 0 && self.line_num < self.dialogue.data.size()

func incr_line() -> DialogueLine:
	self.line_num += 1
	var line = self.current_line()
	if line == null:
		end_dialogue.emit()
	else:
		line_updated.emit(line)
	return line

func decr_line() -> DialogueLine:
	if (self.line_num <= 0):
		return self.current_line()
	self.line_num -= 1
	var line = self.current_line()
	line_updated.emit(line)
	return line
