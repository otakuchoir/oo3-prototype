@tool extends EditorScript

func _run() -> void:
	var ret = DialogueData.read_json('res://assets/dialogue/example.json')
	print(ret)
