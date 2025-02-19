extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file : String

var dialogues = []

func _ready():
	play()

func play():
	dialogues = load_dialogue()

func load_dialogue():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		return parse_json(file.get_as_text())
