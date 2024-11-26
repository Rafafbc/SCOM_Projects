extends Control

func _process(_delta: float) -> void:
	$CanvasLayer/Label.text = "Maças: " + str(GlobalVar.Macas1+GlobalVar.Macas2+GlobalVar.Macas3)
