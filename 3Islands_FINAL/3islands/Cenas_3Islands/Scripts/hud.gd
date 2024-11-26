extends Control

func _process(_delta):
	
	$CanvasLayer/Label.text = "Frutas: " + str(Global.Frutas)
	
