extends Node2D

func _on_spikes_body_entered(body: Node2D) -> void:
	# Verifica se o corpo que entrou na área é o Player
	if body.name == "Player":
		GlobalVars.Bananas = 0
		get_tree().reload_current_scene()  # Recarrega a cena atual
