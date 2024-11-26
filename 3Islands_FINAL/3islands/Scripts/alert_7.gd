extends Node2D

@onready var textura_8: Sprite2D = $textura8
@onready var area_8: Area2D = $Area8


const lines : Array[String] = [
"Viajante, o desconhecido o chama.",
"As frutas rubras guardam o enigma da passagem.",
"Mas cuidado: as serras devoram todos os seus abacaxis.",
"Os espinhos pontiagudos reclamarão suas melancias.",
"Os túneis esquecidos murmuram segredos perdidos.",
"A colheita completa revelará o destino oculto."  
]

func _unhandled_input(event):
	if area_8.get_overlapping_bodies().size() > 0:
		print("OK1")
		textura_8.show()
		if event.is_action_pressed("interact") && !DialogManager.is_message_active:
			print("OK2")
			textura_8.hide()
			DialogManager.start_message(global_position, lines)
	else:
		textura_8.hide()
		print("Não achou nada")
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active = false
