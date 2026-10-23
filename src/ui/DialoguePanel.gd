extends Node2D

var line_num: int = 0
var dialogue: DialogueData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.dialogue = DialogueData.read_json('res://assets/dialogue/oo3-prototype.json')
	self.update()
	#print('inputmap', InputMap.get_actions())

func line() -> DialogueLine:
	return self.dialogue.data[self.line_num]

func update() -> void:
	$quote.text = self.line().quote
	$speaker.text = self.line().speaker
	$line_id.text = "Line ID: "+self.line().id
	SignalBus.dialogue_line_updated.emit(self.line().id)

func incr_line_num(diff=1) -> void:
	self.line_num = max(0, self.line_num + diff)
	if self.line_num >= self.dialogue.data.size():
		# TODO end the game. how to handle this?
		self.line_num = 0
		self.get_tree().quit(0)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") || Input.is_action_just_pressed("leftclick"):
		self.incr_line_num()
		self.update()
	elif Input.is_action_just_pressed("rewind"):
		self.incr_line_num(-1)
		self.update()
