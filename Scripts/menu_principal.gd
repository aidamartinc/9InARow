extends Control

func _on_jugar_pressed():
	VarGlobales.nueva()
	get_tree().change_scene_to_file("res://Escenas/juego.tscn")


func _on_salir_pressed():
	get_tree().quit()


func _on_opciones_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu_opciones.tscn")


func _on_reanudar_pressed():
	_load()
	VarGlobales.cargar_guardado = true
	get_tree().change_scene_to_file("res://Escenas/juego.tscn")


func _load():
	if FileAccess.file_exists(VarGlobales.file_guardar):
		var file = FileAccess.open(VarGlobales.file_guardar, FileAccess.READ)
		while file.get_position() < file.get_length():
			var json_string = file.get_line()
			var json = JSON.new()
			var _parse_result = json.parse(json_string)
			var node_data = json.get_data()
			if node_data["tablero"] == "var_globales":
				VarGlobales.load_variables(node_data["turno_jugador"], node_data["ganador_global"])
			else:
				var tablero = []
				tablero.append(node_data["casilla0"])
				tablero.append(node_data["casilla1"])
				tablero.append(node_data["casilla2"])
				tablero.append(node_data["casilla3"])
				tablero.append(node_data["casilla4"])
				tablero.append(node_data["casilla5"])
				tablero.append(node_data["casilla6"])
				tablero.append(node_data["casilla7"])
				tablero.append(node_data["casilla8"])
				VarGlobales.load_tablero(node_data["tablero"], tablero, node_data["var1"], node_data["var2"], node_data["var3"])
		file.close()
				
		var dir = DirAccess.open("res://")
		dir.remove(VarGlobales.file_guardar)
	
		
	if FileAccess.file_exists(VarGlobales.file_guardar_ajustes):
		var file_ajustes = FileAccess.open(VarGlobales.file_guardar_ajustes, FileAccess.READ)
		while file_ajustes.get_position() < file_ajustes.get_length():
			var json_string = file_ajustes.get_line()
			var json = JSON.new()
			var _parse_result = json.parse(json_string)
			var data = json.get_data()
			DisplayServer.window_set_mode(data["pantalla_completa"])
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), data["audio_volumen"])
			VarGlobales.load_ajustes(data["x"], data["x_disabled"], data["o"], data["o_disabled"], data["libre"], data["libre_disabled"])
			"""VarGlobales.jugador_o = data["o"]
			VarGlobales.jugador_o_disabled = data["o_disabled"]
			VarGlobales.jugador_x = data["x"]
			VarGlobales.jugador_x_disabled = data["x_disabled"]
			VarGlobales.libre = data["libre"]
			VarGlobales.libre_disabled = data["libre_disabled"]"""
		file_ajustes.close()
		var dir = DirAccess.open("res://")
		dir.remove(VarGlobales.file_guardar_ajustes)

func _process(_delta):
	if VarGlobales.guardado == true:
		$VBoxContainer/Reanudar.visible = true
	else:
		if FileAccess.file_exists(VarGlobales.file_guardar) and FileAccess.file_exists(VarGlobales.file_guardar_ajustes):
			VarGlobales.guardado == true
			$VBoxContainer/Reanudar.visible = true
		else:
			$VBoxContainer/Reanudar.visible = false
		
