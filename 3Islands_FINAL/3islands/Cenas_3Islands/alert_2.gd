extends Node2D

@onready var textura2: Sprite2D = $textura2
@onready var area2: Area2D = $Area2

const lines : Array[String] = [
"Viajante, o desconhecido o chama.",
"As frutas rubras guardam o enigma da passagem.",
"Mas cuidado: as serras devoram todos os seus abacaxis.",
"Os espinhos pontiagudos reclamarão suas melancias.",
"Os túneis esquecidos murmuram segredos perdidos.",
"A colheita completa revelará o destino oculto."  
]

func _unhandled_input(event):
	if area2.get_overlapping_bodies().size() > 0:
		textura2.show()
		if event.is_action_pressed("interact") && !DialogManager.is_message_active:
			textura2.hide()
			DialogManager.start_message(global_position, lines)
	else:
		textura2.hide()
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active = false
