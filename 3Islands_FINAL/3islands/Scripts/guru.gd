extends CharacterBody2D

func _ready() -> void:
	# Ajusta o flip_h para virar o sprite do Guru.
	$AnimatedSprite2D2.flip_h = true
	
func _physics_process(delta: float) -> void:
	# Adiciona gravidade.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Mantem a animação em 'Idle' quando parado no chão
	if is_on_floor():
		$AnimatedSprite2D2.play("Idle")
