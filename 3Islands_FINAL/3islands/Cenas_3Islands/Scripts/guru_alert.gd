extends Node2D

@onready var textura_guru: Sprite2D = $textura_guru
@onready var area_guru: Area2D = $Area_guru

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
		textura_guru.show()
		if event.is_action_pressed("interact") && !DialogManager.is_message_active:
			textura_guru.hide()
			DialogManager.start_message(global_position, lines)
	else:
		textura_guru.hide()
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active = false
