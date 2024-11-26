extends Area2D

var speed = 200
var direction = Vector2.ZERO
@onready var plant: AnimatedSprite2D = $plant	# Referência ao sprite do inimigo (plant)

# Função chamada quando a bala é criada ou começa a se mover
func _ready():
	if plant:
		# Configura a direção inicial com base na orientação do inimigo (flip_h)
		if plant.flip_h:
			direction = Vector2.LEFT  # Move para a esquerda
		else:
			direction = Vector2.RIGHT  # Move para a direita
	else:
		print("Erro: plant não encontrado!")
		return  # Sai da função caso o plant não seja encontrado

# Função para configurar a velocidade e direção da Bala
func _physics_process(delta):
	# Atualiza a posição diretamente com base na direção e velocidade
	position += direction * speed * delta  # "delta" é o tempo de cada frame

func _on_body_entered(_body: Node2D) -> void:
	GlobalVars.Bananas = 0
	get_tree().reload_current_scene()	# recarrega a cena
	queue_free()						# Remove a Bala de cena após a colisão
