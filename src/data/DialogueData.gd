class_name DialogueData extends Resource

@export var data: Array[DialogueLine]

static func read_json(path: String) -> DialogueData:
	var f = FileAccess.open(path, FileAccess.READ)
	assert(!!f, "dialogue not found: "+path)
	var txt = f.get_as_text()
	var json = JSON.parse_string(txt)
	assert(!!json, "dialogue is not valid json: "+path)
	var ret = DialogueData.new()
	
	# prefix line-ids with their label
	var label = "UNLABELED"  # TODO this should probably throw an error instead
	for i in range(json.data.size()):
		var jsonline = json.data[i]
		match jsonline.type:
			"label":
				label = jsonline.label
			"quote":
				var line = DialogueLine.new()
				line.quote = jsonline.quote
				line.speaker = jsonline.speaker
				line.id = "%s.%03s" % [label, jsonline.id]
				ret.data.append(line)
			_:
				print("unknown dialogue-file line type: %s" % jsonline.type)
	return ret

func _to_string() -> String:
	return str({"data": self.data})
