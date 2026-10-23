extends AnimationPlayer

# Dictionary[String, Array[String]]: "Parse error: nested typed collections are not supported." booooo
var animations_by_line_id: Dictionary[String, Array] = {}

# _init runs before _ready
func _init() -> void:
	for animname in get_animation_list():
		var parts = animname.split(" ", true, 1)
		if parts.size() >= 2:
			var id = parts[0]
			animations_by_line_id.get_or_add(id, []).append(animname)
	SignalBus.dialogue_line_updated.connect(_on_dialogue_line_updated)

func _on_dialogue_line_updated(id: String) -> void:
	var names = animations_by_line_id.get(id, [])
	print("dialogue line updated", str(id), names)
	for animname in names:
		print("play animation ", id, ", ", animname)
		self.play(animname)
