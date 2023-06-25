extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	if VarGlobales.ganador_global == "o":
		$VBoxContainer/VBoxContainer/Label.text = "GANADOR:"
		$VBoxContainer/VBoxContainer/Casilla0.texture_normal = VarGlobales.jugador_o
	elif VarGlobales.ganador_global == "x":
		$VBoxContainer/VBoxContainer/Label.text = "GANADOR:"
		$VBoxContainer/VBoxContainer/Casilla0.texture_normal = VarGlobales.jugador_x
	elif VarGlobales.ganador_global == "-":
		$VBoxContainer/VBoxContainer/Label.text = "EMPATE"
		$VBoxContainer/VBoxContainer/Casilla0.texture_normal = VarGlobales.empate



func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://Escenas/juego.tscn")
	VarGlobales.nueva()

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu_principal.tscn")
