extends Area2D


func _ready() -> void:
	# Inicia a animação ao inicializar a cena
	$AnimatedSprite2D_kiwi.play("Idle-Kiwi")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GlobalVars.Kiwis += 1
		queue_free()
	pass # Replace with function body.
