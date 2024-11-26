extends Node2D

# Declara variáveis constantes
const SPEED = 200.0			# Velocidade padrão

# Declara variáveis que de fato variam
var upper_limit = 50.0		# Posição de limite superior para a serra chegar
var lower_limit = 350.0		# Posição de limite inferior para a serra chegar
var direction = 1			# Direção inicial de movimento (1 para descida e -1 para subida)

func _ready() -> void:
	# Inicia a animação ao inicializar a cena
	$saw_on/AnimatedSprite2D_saw_trap.play("saw_trap-animation")
	
	# Garante que a serra seja desenhado na frente da corrente
	$chain.z_index = 0  # Valor 0 para o objeto corrente

func _process(delta: float) -> void:
	# Atualiza o posicionamento vertical da Serra
	$saw_on.position.y += SPEED * direction * delta
	
	# Verifica os limites
	if $saw_on.position.y > lower_limit:
		$saw_on.position.y = lower_limit
		direction = -1				# Inverte a direção para haver a subida
	elif $saw_on.position.y < upper_limit:
		$saw_on.position.y = upper_limit
		direction = 1				# Inverte a direção para haver a decida

func _on_saw_on_body_entered(body: Node2D) -> void:
	# Verifica se o corpo que entrou na área é o Player
	if body.name == "Player":
		GlobalVars.Kiwis = 0
		get_tree().reload_current_scene()  # Recarrega a cena atual
