extends AnimatableBody2D

@onready var falling_platform_anim := $"falling-platform_anim" as AnimationPlayer
@onready var quake_anim := $quake_anim as AnimationPlayer
@onready var respawn_timer := $respawn_timer as Timer
@onready var respawn_position := global_position

@export var reset_timer := 3.0

var velocity = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_triggered := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Inicia a animação ao inicializar a cena
	falling_platform_anim.play("platform_anim")
	
	set_physics_process(false)

func _physics_process(delta):
	velocity.y += gravity * delta
	position += velocity * delta
	
	
func has_collided_with(collision: KinematicCollision2D, collider: CharacterBody2D):
	if !is_triggered:
		is_triggered = true
		quake_anim.play("quake")
		velocity = Vector2.ZERO


func _on_quake_anim_animation_finished(anim_name: StringName) -> void:
	set_physics_process(true)
	respawn_timer.start(reset_timer)


func _on_respawn_timer_timeout():
	set_physics_process(false)
	global_position = respawn_position
	if is_triggered:
		var spawn_tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
		spawn_tween.tween_property($texture, "scale", Vector2(1.5,1.5), 0.5).from(Vector2(0,0))
	is_triggered = false