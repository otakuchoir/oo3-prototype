class_name DialogueLine extends Resource

@export var id: String
@export var speaker: String
@export var quote: String

func _to_string() -> String:
	return str({"id": self.id, 'speaker': self.speaker, 'quote': self.quote})
