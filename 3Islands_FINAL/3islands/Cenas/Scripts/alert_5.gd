extends Node2D

@onready var textura_5: Sprite2D = $textura5
@onready var area_5: Area2D = $Area5


const lines : Array[String] = [
"Viajante, o desconhecido o chama.",
"As frutas rubras guardam o enigma da passagem.",
"Mas cuidado: as serras devoram todos os seus abacaxis.",
"Os espinhos pontiagudos reclamarão suas melancias.",
"Os túneis esquecidos murmuram segredos perdidos.",
"A colheita completa revelará o destino oculto."  
]

func _unhandled_input(event):
	if area_5.get_overlapping_bodies().size() > 0:
		textura_5.show()
		if event.is_action_pressed("interact") && !DialogManager.is_message_active:
			textura_5.hide()
			DialogManager.start_message(global_position, lines)
	else:
		textura_5.hide()
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active = false
