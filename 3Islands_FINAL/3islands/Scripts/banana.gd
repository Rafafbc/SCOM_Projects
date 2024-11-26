extends Area2D


func _ready() -> void:
	# Inicia a animação ao inicializar a cena
	$AnimatedSprite2D_banana.play("Idle-Banana")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GlobalVars.Bananas += 1
		queue_free()
	pass # Replace with function body.
