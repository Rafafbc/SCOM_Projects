extends Area2D

@export var fase: int = 2  # Defina 1 para fase1, 2 para fase2, etc.

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if fase == 1:
			GlobalVar.Macas1 += 1
		elif fase == 2:
			GlobalVar.Macas2 += 1
		elif fase == 3:
			GlobalVar.Macas3 += 1
		queue_free()
	else:
		$AnimatedSprite2D.play("Idle")
pass # Replace with function body.
