extends Area2D

# Caminho para o arquivo da próxima fase.
@export var second_scene_path : String = "res://Scenes/Scene2/Virtual_Guy-scene2.tscn"  # Exporta o caminho da cena da tela 2

# Chamado quando o nó entra na árvore de cena pela primeira vez.
func _ready() -> void:
	# Aqui, você pode inicializar configurações, se necessário.
	pass # Replace with function body.

# Chamado a cada quadro. 'delta' é o tempo decorrido desde o quadro anterior.
func _process(_delta: float) -> void:
	# Testa se a tecla de pulo (espaço, por padrão) foi pressionada.
	if Input.is_action_just_pressed("ui_accept"):  # "ui_accept" é mapeado para a tecla Espaço por padrão.
		print("Jump")

# Chamado quando um corpo entra na área do Area2D.
func _on_body_entered(body: Node2D) -> void:
	# Verifica se o corpo que entrou é o jogador, e se a condição de Kiwis coletados foi comprida
	if body.name == "Player" and GlobalVars.Kiwis == 5 and GlobalVars.Bananas == 0:  # Certifique-se de que o nome do jogador é "Player".
		print("Player alcançou o final da tela 1, pode seguir!")

		# Carrega a próxima fase.
		var next_scene = ResourceLoader.load(second_scene_path)
		if next_scene:
			get_tree().change_scene_to_packed(next_scene)  # Troca para a cena carregada.
		else:
			print("Falha ao carregar a próxima tela. Check the path!", second_scene_path)
	
	## Verifica se o corpo que entrou é o jogador, e se a condição de Bananas coletadas foi comprida
	#if body.name == "Player" and GlobalVars.Kiwis == 5 and GlobalVars.Bananas == 7:  # Certifique-se de que o nome do jogador é "Player".
		#print("Player alcançou o final da tela 2, Parabéns!")
#
		## Carrega a próxima fase.
		#var next_scene = ResourceLoader.load(third_scene_path)
		#if next_scene:
			#get_tree().change_scene_to_packed(next_scene)  # Troca para a cena carregada.
		#else:
			#print("Falha ao carregar a próxima tela. Check the path!", third_scene_path)
