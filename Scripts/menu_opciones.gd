extends Control

var master_bus = AudioServer.get_bus_index("Master")


func _ready():
	pass


func _on_full_screen_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_volumen_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)

func _on_accesibilidad_pressed():
	$VBoxContainer.visible = false
	$Custom.visible = true


func _on_volver_pressed():
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
	get_tree().change_scene_to_file("res://Escenas/menu_principal.tscn")


func _on_x_1_pressed():
	VarGlobales.load_files("x", "res://Assets/Tiles/original/x.png")
	VarGlobales.load_files("x_d", "res://Assets/Tiles/original/x_disabled.png")
	$AjustesTexturas/CasillasJugadores/X/TexturaX.texture_normal = VarGlobales.jugador_x

func _on_x_2_pressed():
	VarGlobales.load_files("x", "res://Assets/Tiles/princesa/x.png")
	VarGlobales.load_files("x_d", "res://Assets/Tiles/princesa/x_disabled.png")
	$AjustesTexturas/CasillasJugadores/X/TexturaX.texture_normal = VarGlobales.jugador_x
	
func _on_x_3_pressed():
	VarGlobales.load_files("x", "res://Assets/Tiles/daltonicos/x.png")
	VarGlobales.load_files("x_d", "res://Assets/Tiles/daltonicos/x_disabled.png")
	$AjustesTexturas/CasillasJugadores/X/TexturaX.texture_normal = VarGlobales.jugador_x



func _on_o_1_pressed():
	VarGlobales.load_files("o", "res://Assets/Tiles/original/o.png")
	VarGlobales.load_files("o_d", "res://Assets/Tiles/original/o_disabled.png")
	$AjustesTexturas/CasillasJugadores/O/TexturaO.texture_normal = VarGlobales.jugador_o


func _on_o_2_pressed():
	VarGlobales.load_files("o", "res://Assets/Tiles/princesa/o.png")
	VarGlobales.load_files("o_d", "res://Assets/Tiles/princesa/o_disabled.png")
	$AjustesTexturas/CasillasJugadores/O/TexturaO.texture_normal = VarGlobales.jugador_o

func _on_o_3_pressed():
	VarGlobales.load_files("o", "res://Assets/Tiles/daltonicos/o.png")
	VarGlobales.load_files("o_d", "res://Assets/Tiles/daltonicos/o_disabled.png")
	$AjustesTexturas/CasillasJugadores/O/TexturaO.texture_normal = VarGlobales.jugador_o


func _on_volver_2_pressed():
	$AjustesTexturas.visible = false
	$Custom.visible = true

func _on_original_toggled(button_pressed):
	if button_pressed == true:
		VarGlobales.load_files("x", "res://Assets/Tiles/original/x.png")
		VarGlobales.load_files("x_d", "res://Assets/Tiles/original/x_disabled.png")
		VarGlobales.load_files("o", "res://Assets/Tiles/original/o.png")
		VarGlobales.load_files("o_d", "res://Assets/Tiles/original/o_disabled.png")
		VarGlobales.load_files("l", "res://Assets/Tiles/original/libre.png")
		VarGlobales.load_files("l_d", "res://Assets/Tiles/original/libre_disabled.png")
		$Custom/Princesa/princesa.button_pressed = false
		$Custom/Daltonicos/daltonicos.button_pressed = false


func _on_princesa_toggled(button_pressed):
	if (button_pressed):
		VarGlobales.load_files("x", "res://Assets/Tiles/princesa/x.png")
		VarGlobales.load_files("x_d", "res://Assets/Tiles/princesa/x_disabled.png")
		VarGlobales.load_files("o", "res://Assets/Tiles/princesa/o.png")
		VarGlobales.load_files("o_d", "res://Assets/Tiles/princesa/o_disabled.png")
		VarGlobales.load_files("l", "res://Assets/Tiles/princesa/libre.png")
		VarGlobales.load_files("l_d", "res://Assets/Tiles/princesa/libre_disabled.png")
		$Custom/Original/original.button_pressed = false
		$Custom/Daltonicos/daltonicos.button_pressed = false


func _on_daltonicos_toggled(button_pressed):
	if (button_pressed):
		VarGlobales.load_files("x", "res://Assets/Tiles/daltonicos/x.png")
		VarGlobales.load_files("x_d", "res://Assets/Tiles/daltonicos/x_disabled.png")
		VarGlobales.load_files("o", "res://Assets/Tiles/daltonicos/o.png")
		VarGlobales.load_files("o_d", "res://Assets/Tiles/daltonicos/o_disabled.png")
		VarGlobales.load_files("l", "res://Assets/Tiles/daltonicos/libre.png")
		VarGlobales.load_files("l_d", "res://Assets/Tiles/daltonicos/libre_disabled.png")
		$Custom/Original/original.button_pressed = false
		$Custom/Princesa/princesa.button_pressed = false
		



func _on_ir_a_personalizado_pressed():
	$Custom.visible = false
	$AjustesTexturas.visible = true
	$AjustesTexturas/CasillasJugadores/O/TexturaO.texture_normal = VarGlobales.jugador_o
	$AjustesTexturas/CasillasJugadores/X/TexturaX.texture_normal = VarGlobales.jugador_x


func _on_volver_3_pressed():
	$Custom.visible = false
	$VBoxContainer.visible = true
