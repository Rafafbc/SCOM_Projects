extends Node2D

@onready var textura: Sprite2D = $textura
@onready var area: Area2D = $Area

const lines : Array[String] = [
	"Bem-vindo, bravo explorador.",
	"As frutas douradas guardam o segredo do progresso.",
	"Sem todos os abacaxis, o caminho permanecerá fechado.",
	"As lâminas giram como um teste à sua coragem.",
	"Tenha cuidado, as serras não têm piedade dos desavisados.",
	"Se todas as frutas forem suas, o caminho se revelará."
]

func _unhandled_input(event):
	if area.get_overlapping_bodies().size() > 0:
		textura.show()
		if event.is_action_pressed("interact") && !DialogManager.is_message_active:
			textura.hide()
			DialogManager.start_message(global_position, lines)
	else:
		textura.hide()
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active = false
