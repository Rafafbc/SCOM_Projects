extends Area2D

# Caminho para o arquivo da próxima fase.
@export var next_level_path: String = "res://Cenas_3Islands/Pink_Man_fase_2.tscn"

# Chamado quando o nó entra na árvore de cena pela primeira vez.
func _ready() -> void:
	# Aqui, você pode inicializar configurações, se necessário.
	pass # Replace with function body.

# Chamado a cada quadro. 'delta' é o tempo decorrido desde o quadro anterior.
func _process(delta: float) -> void:
	# Testa se a tecla de pulo (espaço, por padrão) foi pressionada.
	if Input.is_action_just_pressed("ui_accept"):  # "ui_accept" é mapeado para a tecla Espaço por padrão.
		print("Jump")

# Chamado quando um corpo entra na área do Area2D.
func _on_body_entered(body: Node2D) -> void:
	# Verifica se o corpo que entrou é o jogador.
	if body.name == "Player" and Global.abacaxi >= 25:  # Certifique-se de que o nome do jogador é "Player".
		print("Player reached the flag! Loading next level...")

		# Carrega a próxima fase.
		var next_scene = ResourceLoader.load(next_level_path)
		if next_scene:
			await get_tree().create_timer(1.0).timeout
			get_tree().change_scene_to_packed(next_scene)  # Troca para a cena carregada.
		else:
			print("Failed to load the next level. Check the path:", next_level_path)
