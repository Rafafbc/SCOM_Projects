extends Area2D

# Chamado quando o nó entra na cena pela primeira vez.
func _ready() -> void:
	# Toca a animação "Serra" sempre que a cena carregar.
	$AnimatedSprite2D.play("Serra")


# Função chamada quando um corpo entra na área de colisão.
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# Aguarda 1 segundo antes de reiniciar a cena.
		await get_tree().create_timer(1).timeout


		# Reinicia a cena após o atraso.
		Global.reiniciar_cena()
		
		Global.abacaxi = 0;
