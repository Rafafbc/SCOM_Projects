extends Area2D

# Função chamada quando o nó entra na cena.
func _ready() -> void:
	# Toca a animação "Serra" sempre que a cena carregar.
	$AnimatedSprite2D.play("Fruit_Coin")

# Função chamada quando um corpo entra na área de colisão.
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":  # Verifica se quem entrou foi o Player.
		Global.abacaxi += 1
		queue_free()  # Remove o nó (a moeda) da cena.
