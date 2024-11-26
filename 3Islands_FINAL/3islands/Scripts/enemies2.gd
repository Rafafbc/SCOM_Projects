extends CharacterBody2D

const PLANT_BULLET = preload("res://Scenes/Scene2/plant_bullet2.tscn")

@onready var plant: AnimatedSprite2D = $plant
@onready var bullet_spawn_point: Marker2D = $bullet_spawn_point
@onready var player_detector_left: RayCast2D = $player_detector_left
@onready var player_detector_right: RayCast2D = $player_detector_right

var shoot_timer: Timer  # Temporizador para controlar o disparo

func _ready():
	# Cria e configura o Timer dinamicamente
	shoot_timer = Timer.new()
	shoot_timer.wait_time = 0.5  # Tempo entre disparos
	shoot_timer.one_shot = true  # Dispara apenas uma vez
	add_child(shoot_timer)  # Adiciona o Timer à árvore de nós

func _physics_process(_delta):
	# Verifica colisão e se o Timer não está ativo
	if (player_detector_left.is_colliding() or player_detector_right.is_colliding()) and shoot_timer.time_left == 0:
		if player_detector_left.is_colliding():		# Caso Timer não ativo, verifica colisão com o Player
			plant.flip_h = false					# Ajusta o inimigo para a Esquerda
		elif player_detector_right.is_colliding():
			plant.flip_h = true						# Ajusta o inimigo para a Direita
		
		$plant.play("Attack-Plant")
		spawn_bullet_plant()
		shoot_timer.start()  # Inicia o Timer para limitar disparos consecutivos

func spawn_bullet_plant():
	var new_bullet_plant = PLANT_BULLET.instantiate()
	new_bullet_plant.global_position = Vector2(-345, -115)
	
	# Determina a direção da bala com base no flip do inimigo
	if plant.flip_h:
		new_bullet_plant.direction = Vector2.RIGHT  # Direção para a direita
	else:
		new_bullet_plant.direction = Vector2.LEFT  # Direção para a esquerda

	add_child(new_bullet_plant)
