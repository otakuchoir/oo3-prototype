class_name DialogueData extends Resource

@export var data: Array[DialogueLine]

static func read_json(path: String) -> DialogueData:
	var f = FileAccess.open(path, FileAccess.READ)
	assert(!!f, "dialogue not found: "+path)
	var txt = f.get_as_text()
	var json = JSON.parse_string(txt)
	assert(!!json, "dialogue is not valid json: "+path)
	var ret = DialogueData.new()
	ret.data.assign(range(json.data.size())
		.filter(func(i): return json.data[i].type == "quote")
		.map(func(i):
			var jsonline = json.data[i]
			var line = DialogueLine.new()
			line.quote = jsonline.quote
			line.speaker = jsonline.speaker
			line.id = "oo3-prototype.%03s" % jsonline.id
			return line
			)
	)
	return ret

func _to_string() -> String:
	return str({"data": self.data})
