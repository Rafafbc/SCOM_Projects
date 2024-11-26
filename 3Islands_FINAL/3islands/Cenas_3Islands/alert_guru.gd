extends Node2D

@onready var textura: Sprite2D = $textura
@onready var area_guru: Area2D = $Area2D



const lines : Array[String] = [
"Viajante, o desconhecido o chama.",
"As frutas rubras guardam o enigma da passagem.",
"Mas cuidado: as serras devoram todos os seus abacaxis.",
"Os espinhos pontiagudos reclamarão suas melancias.",
"Os túneis esquecidos murmuram segredos perdidos.",
"A colheita completa revelará o destino oculto."  
]

func _unhandled_input(event):
	if area_guru.get_overlapping_bodies().size() > 0:
		textura.show()
		if event.is_action_presse("interact") && !DialogManager.is_message_active:
			textura.hide()
			DialogManager.start_message(global_position, lines)
	else:
		textura.hide()
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active = false
