extends Node

@onready var caixa_dialogo2_scene = preload("res://Cenas_3Islands/caixa_dialogo_2.tscn")
var message_lines2 : Array[String] = []
var current_line2 = 0

var dialog_box2
var dialog_box_position2 := Vector2.ZERO

var is_message_active2 := false
var can_advance_message2 := false

func start_message(position: Vector2, lines: Array[String]):
	if is_message_active2:
		return
		
	message_lines2 = lines
	dialog_box_position2 = position
	show_text()
	is_message_active2 = true
	

func show_text():
	dialog_box2 = caixa_dialogo2_scene.instantiate()
	dialog_box2.text_display_finished.connect(_on_all_text_displayed)
	get_tree().root.add_child(dialog_box2)
	dialog_box2.global_position = dialog_box_position2
	dialog_box2.display_text(message_lines2[current_line2])
	can_advance_message2 = false
	

func _on_all_text_displayed():
	can_advance_message2 = true
	
func _unhandled_input(event2):
	if(event2.is_action_pressed("advance_message") && is_message_active2 && can_advance_message2):
		dialog_box2.queue_free()
		current_line2 += 1
		if current_line2 >= message_lines2.size():
			is_message_active2 = false
			current_line2 = 0
			return
		show_text()
		
		
	
