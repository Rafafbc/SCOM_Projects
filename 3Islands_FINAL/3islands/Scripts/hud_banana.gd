extends Control

func _ready() -> void:
	# Inicia a animação ao inicializar a cena
	$CanvasLayer/AnimatedSprite2D_Banana.play("count-Banana")

func _process(delta: float) -> void:
	$CanvasLayer/Label.text = "Frutas: " + str(GlobalVars.Kiwis + GlobalVars.Bananas)
