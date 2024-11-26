extends Area2D

# Chamado quando o nó entra na cena pela primeira vez.
func _ready() -> void:
	
	pass


# Função chamada quando um corpo entra na área de colisão.
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":	
		
		# Aguarda 1 segundo antes de reiniciar a cena.
		await get_tree().create_timer(0.5).timeout

		# Reinicia a cena após o atraso.
		Global.reiniciar_cena()
		Global.melancia = 0;
