extends CharacterBody2D

# Declaração de variáveis constantes
const NORMAL_SPEED = 300.0		# velocidade padrão
const BOOSTED_SPEED = 500.0		# Velocidade com o boost
const DOUBLE_CLICK_TIME = 0.5	# Perído máximo entre os cliques para ser considerado um duplo clique
const JUMP_VELOCITY = -430.0	# Velocidade para os saltos
const MAX_JUMPS = 2  			# Máximo de pulos permitidos.

# Declaração de variáveis que de fato variam
var speed = NORMAL_SPEED		# Velocidade atual do jogador
var last_direction_pressed = 0  # Direção da última tecla pressionada (-1 ou 1).
var last_press_time = 0.0  		# Momento em que a última tecla foi pressionada.
var jumps_left = MAX_JUMPS		# Variável para rastrear os pulos restantes.

func _ready() -> void:
	# Garante que o Player seja desenhado na frente de outros objetos
	z_index = 2  # Valor maior que o dos outros objetos (que terão z_index = 0 ou menor)

func _physics_process(delta: float) -> void:
	# Adiciona gravidade.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Checa se o jogador está no chão para resetar os pulos.
	if is_on_floor():
		jumps_left = MAX_JUMPS  # Reseta os pulos disponíveis.

	# Trata o salto.
	if Input.is_action_just_pressed("ui_accept") and jumps_left > 0:
		velocity.y = JUMP_VELOCITY
		jumps_left -= 1  # Reduz o número de pulos disponíveis.

	# Movimento horizontal.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		## Detecta o SHIFT pressionado
		if Input.is_action_pressed("ui_shift"):
			speed = BOOSTED_SPEED
		else:
			speed = NORMAL_SPEED

		# Atualiza a velocidade horizontal.
		velocity.x = direction * speed

		# Ajusta o flip_h para virar o personagem.
		if direction < 0:
			$AnimatedSprite2D.flip_h = true  # Virar para a esquerda.
		else:
			$AnimatedSprite2D.flip_h = false  # Virar para a direita.

		# Troca para 'Run' apenas se estiver no chão.
		if is_on_floor():
			$AnimatedSprite2D.play("Run")
	else:
		velocity.x = 0  # Para o movimento horizontal quando nenhuma tecla for pressionada.
		if is_on_floor():  # Troca para 'Idle' se estiver parado no chão.
			$AnimatedSprite2D.play("Idle")

	# Checa se está no ar.
	if not is_on_floor():
		# Subindo (pulo).
		if velocity.y < 0:
			# Verifica se é um salto duplo para reproduzir a animação apropriada.
			if jumps_left == 1:
				$AnimatedSprite2D.play("Jump")  # Primeiro salto.
			elif jumps_left == 0:
				$AnimatedSprite2D.play("Double-Jump")  # Salto duplo.
		# Descendo (queda).
		elif velocity.y > 0:
			$AnimatedSprite2D.play("Fall")

	move_and_slide()
	
	for platforms in get_slide_collision_count():
		var collision = get_slide_collision(platforms)
		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with(collision, self)
