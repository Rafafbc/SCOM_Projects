extends Control

func _ready() -> void:
	# Inicia a animação ao inicializar a cena
	$CanvasLayer/AnimatedSprite2D_Kiwi.play("count-Kiwi")

func _process(_delta: float) -> void:
	$CanvasLayer/Label.text = "Frutas: " + str(GlobalVars.Kiwis)
