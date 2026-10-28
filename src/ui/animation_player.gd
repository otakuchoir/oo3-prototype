extends AnimationPlayer

@export var dialogue: DialogueReader

# Dictionary[String, Array[String]]: "Parse error: nested typed collections are not supported." booooo
var animations_by_line_id: Dictionary[String, Array] = {}

# _init runs before _ready
func _init() -> void:
	for animname in get_animation_list():
		var parts = animname.split(" ", true, 1)
		if parts.size() >= 2:
			var id = parts[0]
			animations_by_line_id.get_or_add(id, []).append(animname)

func _ready() -> void:
	self.dialogue.line_updated.connect(self.update_line)
	self.update_line(self.dialogue.current_line())

func update_line(line: DialogueLine) -> void:
	var id = line.id
	var names = animations_by_line_id.get(id, [])
	print("dialogue line updated: %s, %s" % [id, names])
	for animname in names:
		print("play animation %s, %s" % [id, animname])
		self.play(animname)
