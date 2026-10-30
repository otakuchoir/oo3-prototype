extends AnimationPlayer

# Dictionary[String, Array[String]]: "Parse error: nested typed collections are not supported." booooo
var animations_by_line_id: Dictionary[String, Array] = {}

func _ready() -> void:
	for animname in get_animation_list():
		var parts = animname.split(" ", true, 1)
		var id: String
		if parts.size() >= 2:
			id = parts[0]
		else:
			id = animname
		animations_by_line_id.get_or_add(id, []).append(animname)

func update_line(line: DialogueLine) -> void:
	var id = line.id
	var names = animations_by_line_id.get(id, [])
	print("dialogue line updated: %s, %s" % [id, names])
	for animname in names:
		print("play animation %s, %s" % [id, animname])
		self.play(animname)
