extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var can_double_jump = false  # Controle para permitir o segundo pulo.
var double_jump_timer : Timer  # Timer para controlar a transição de animações
var is_double_jumping = false  # Flag para saber se o double jump foi feito.

func _ready():
	$AnimatedSprite2D.play("Hit")
	# Cria e configura o timer para o Double Jump
	double_jump_timer = Timer.new()
	double_jump_timer.wait_time = 0.8  # Tempo de espera de 0.8 segundos
	double_jump_timer.one_shot = true  # O timer vai rodar apenas uma vez
	# Conectar o sinal "timeout" ao método _on_double_jump_timeout corretamente
	double_jump_timer.timeout.connect(_on_double_jump_timeout)
	add_child(double_jump_timer)

func _physics_process(delta: float) -> void:
	# Adiciona gravidade.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Trata o salto e o double jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			can_double_jump = true  # Após o primeiro salto, permite o double jump.
			$AnimatedSprite2D.play("Jump")  # Animação do primeiro salto.
		elif can_double_jump:  # Executa o double jump.
			velocity.y = JUMP_VELOCITY
			can_double_jump = false  # Desativa o double jump após usá-lo.
			$AnimatedSprite2D.play("Double_Jump")  # Animação do double jump.
			is_double_jumping = true  # Marca que o double jump foi feito.
			double_jump_timer.start()  # Inicia o timer para o double jump.

	# Movimento horizontal.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
		if is_on_floor():
			$AnimatedSprite2D.play("Run")
		# Ajusta o flip horizontal com base na direção.
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		velocity.x = 0
		if is_on_floor():
			$AnimatedSprite2D.play("Idle")

	# Checa se está no ar.
	if not is_on_floor():
		if not is_double_jumping:  # Se não estiver fazendo double jump, toca a animação de queda.
			$AnimatedSprite2D.play("Fall")
		elif is_double_jumping:
			# Se o personagem está no ar após o double jump, mantém a animação de double jump até o timer acabar
			$AnimatedSprite2D.play("Double_Jump")

	# Movimenta o personagem.
	move_and_slide()

	# Reseta o double jump ao tocar o chão.
	if is_on_floor():
		can_double_jump = false
		is_double_jumping = false  # Reseta o estado de double jump quando tocar o chão.

# Função chamada quando o timer de double jump termina.
func _on_double_jump_timeout():
	# O timer acabou, agora o personagem pode cair e tocar a animação de queda se necessário.
	if velocity.y > 0:  # Se estiver caindo, deve tocar a animação de queda.
		$AnimatedSprite2D.play("Fall")
