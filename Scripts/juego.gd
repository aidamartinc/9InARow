extends Control

#Control de los botones
func _on_pausa_pressed():
	get_tree().paused = true
	_menu_pausa_visibilidad(true)

func _on_reanudar_pressed():
	_menu_pausa_visibilidad(false)
	get_tree().paused = false

func _on_nueva_pressed():
	get_tree().paused = false
	VarGlobales.nueva()
	get_tree().change_scene_to_file("res://Escenas/juego.tscn")


func _on_salir_pressed():
	if !VarGlobales.guardado:
		$menu_pausa/general/botones.visible = false
		$menu_pausa/general/conf_salida.visible = true
	else:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://Escenas/menu_principal.tscn")

func _on_si_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Escenas/menu_principal.tscn")

func _on_no_pressed():
	$menu_pausa/general/botones.visible = true
	$menu_pausa/general/conf_salida.visible = false

func _menu_pausa_visibilidad(pausado : bool):
	$TablerosJuego.visible = !pausado
	$TableroFinal.visible = !pausado
	$menu_pausa/pausa.visible = !pausado
	$menu_pausa/general.visible = pausado


func _on_guardar_pressed():
	save()
	VarGlobales.guardado = true
	$menu_pausa/general/botones/guardar/Confirmacion.visible = true

		
func save():
	var save_game = FileAccess.open(VarGlobales.file_guardar, FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("tablero_juego")
	for node in save_nodes:
		var node_data = node.save()
		save_game.store_line(JSON.stringify(node_data))
	save_nodes = get_tree().get_first_node_in_group("tablero_final")
	var node_data = save_nodes.save()
	save_game.store_line(JSON.stringify(node_data))
	
	var dict = {
		"tablero": "var_globales",
		"turno_jugador": VarGlobales.turno_jugador,
		"ganador_global": VarGlobales.ganador_global
	}
	save_game.store_line(JSON.stringify(dict))
	save_game.close()	
	
	var save_ajustes = FileAccess.open(VarGlobales.file_guardar_ajustes, FileAccess.WRITE)
	var dict_ajustes =  {
		"pantalla_completa": DisplayServer.window_get_mode(),
		"audio_volumen": AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")),
		"x": VarGlobales.file_x,
		"x_disabled": VarGlobales.file_x_d,
		"o": VarGlobales.file_o,
		"o_disabled": VarGlobales.file_o_d,
		"libre": VarGlobales.file_l,
		"libre_disabled": VarGlobales.file_l_d
	}
	save_ajustes.store_line(JSON.stringify(dict_ajustes))
	save_ajustes.close()
	
		

