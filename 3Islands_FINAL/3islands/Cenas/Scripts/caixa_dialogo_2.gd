extends MarginContainer

@onready var text_label2: Label = $label_margin/text_label  
@onready var letter_timer_display2: Timer = $letter_timer_display

const MAX_WIDTH = 256

var text = ""
var letter_index = 0

var letter_display_timer := 0.07
var space_display_timer := 0.05
var punctuaction_display_timer := 0.02

signal text_display_finished()

func _ready():
	print("Text Label:", text_label2)
	if text_label2 == null:
		print("Erro: O nó 'text_label' não foi encontrado. Verifique o caminho no editor.")

func display_text(text_to_display: String):
	if text_label2 == null:
		print("Erro: text_label está null.")
		return
	text = text_to_display
	text_label2.text = text_to_display
	
	await resized
	
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		text_label2.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y =size.y
		
	global_position.x -= size.x / 2
	global_position.y -= size.y + 50
	text_label2.text = ""
	display_letter()
	
func display_letter():
	text_label2.text += text[letter_index]
	letter_index += 1
	
	if letter_index >= text.length():
		text_display_finished.emit()
		return
		
	match text[letter_index]:
		"!", "?", ",", ".":
			letter_timer_display2.start(punctuaction_display_timer)
		" ":
			letter_timer_display2.start(space_display_timer)
		_:
			letter_timer_display2.start(letter_display_timer)
			

func _on_letter_timer_display_timeout() -> void:
	display_letter()
