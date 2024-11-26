extends Node

var abacaxi := 0
var melancia := 0

# Torna 'Frutas' acessível diretamente como uma propriedade dinâmica.
@export var Frutas: int:
	get:
		return abacaxi + melancia


func reiniciar_cena():
	if get_tree() != null:
		get_tree().reload_current_scene()
	else:
		print("Erro: SceneTree não está disponível no momento.")
