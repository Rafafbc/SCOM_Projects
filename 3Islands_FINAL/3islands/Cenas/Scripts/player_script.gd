extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const MAX_JUMPS = 2  # Máximo de pulos permitidos.

var jumps_left = MAX_JUMPS  # Variável para rastrear os pulos restantes.

func _physics_process(delta: float) -> void:
	# Adiciona gravidade.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Checa se o jogador está no chão para resetar os pulos.
	if is_on_floor():
		jumps_left = MAX_JUMPS

	# Trata o salto.
	if Input.is_action_just_pressed("ui_accept") and jumps_left > 0:
		velocity.y = JUMP_VELOCITY
		jumps_left -= 1

		# Verifica se é um salto duplo para reproduzir a animação apropriada.
		if jumps_left == 1:
			$AnimatedSprite2D.play("Jump")  # Primeiro salto.
		elif jumps_left == 0:
			$AnimatedSprite2D.play("Double-Jump")  # Salto duplo. 

	# Movimento horizontal.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED

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


	move_and_slide()
