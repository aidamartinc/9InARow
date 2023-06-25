extends Control

var tableros : Array
var casillas : Array

var tableros_memoria

var escena_final = preload("res://Escenas/menu_ganador.tscn")

var gameover
var todos_habilitados
var ultima_jugada

# Called when the node enters the scene tree for the first time.
func _ready():
	_inicio_tablero()
	gameover = false
	todos_habilitados = true
	ultima_jugada = -1
	if VarGlobales.cargar_guardado == true:
		_load()
		_habilitar_tableros()


func _load():
	tableros = VarGlobales.tablero_final
	gameover = VarGlobales.gameoverfinal
	todos_habilitados = VarGlobales.todos_habilitados
	ultima_jugada = VarGlobales.ultima_jugada

func _inicio_tablero():	
	tableros = [
		"-", "-", "-",
		"-", "-", "-",
		"-", "-", "-"
	]
	
	casillas = [
		$tablero_base/Fila0/Casilla0,
		$tablero_base/Fila0/Casilla1,
		$tablero_base/Fila0/Casilla2,
		$tablero_base/Fila1/Casilla3,
		$tablero_base/Fila1/Casilla4,
		$tablero_base/Fila1/Casilla5,
		$tablero_base/Fila2/Casilla6,
		$tablero_base/Fila2/Casilla7,
		$tablero_base/Fila2/Casilla8
	]
	
	tableros_memoria = get_tree().get_nodes_in_group("tablero_juego")
	_pinta_tablero()


func save():
	var dict = {
		"tablero": get_name(),
		"casilla0": tableros[0],
		"casilla1": tableros[1],
		"casilla2": tableros[2],
		"casilla3": tableros[3],
		"casilla4": tableros[4],
		"casilla5": tableros[5],
		"casilla6": tableros[6], 
		"casilla7": tableros[7],
		"casilla8": tableros[8],
		"var1": todos_habilitados,
		"var2": gameover,
		"var3": ultima_jugada
	}
	return dict

	
func _habilitar_tableros():
	tableros_memoria = get_tree().get_nodes_in_group("tablero_juego")
	_actualiza_tablero()
	var nombre_tablero
	if !todos_habilitados:
		for i in range(9):
			nombre_tablero = tableros_memoria[i].get_name()
			if nombre_tablero.ends_with(str(ultima_jugada)):
				tableros_memoria[i]._habilitar_tablero(true)
			else:
				tableros_memoria[i]._habilitar_tablero(false)
	else:
		for i in range(9):
			for j in range(9):
				nombre_tablero = tableros_memoria[i].get_name()
				if nombre_tablero.ends_with(str(j)):
					if tableros[i] == "-":
						tableros_memoria[i]._habilitar_tablero(true)
					else:
						tableros_memoria[i]._habilitar_tablero(false)
	_pinta_tablero()
	_gameover()
	
func _actualiza_tablero():
	if !gameover:
		var nombre_tablero
		for i in range(9):
			for j in range(9):
				nombre_tablero = tableros_memoria[j].get_name()
				
				if nombre_tablero.ends_with(str(i)):
					if (tableros_memoria[j].gameover && tableros_memoria[j].ganador == "o"):
						tableros[j] = "o"
					elif (tableros_memoria[j].gameover && tableros_memoria[j].ganador == "x"):
						tableros[j] = "x"
					elif (tableros_memoria[j].gameover && tableros_memoria[j].ganador == "/"):
						tableros[j] = "/"

func _pinta_tablero():
	for casilla in range(9):
		if tableros[casilla] == "-":
			casillas[casilla].texture_normal =  VarGlobales.libre
		elif tableros[casilla] == "o":
			casillas[casilla].texture_normal =  VarGlobales.jugador_o
		elif tableros[casilla] == "x":
			casillas[casilla].texture_normal =  VarGlobales.jugador_x
		elif tableros[casilla] == "/":
			casillas[casilla].texture_normal =  VarGlobales.completa

func _fila_completa() -> bool:
	gameover = false
	for fila in range(3):
		var cuenta_aux = 0
		for columna in range(3):
			if tableros[(fila*3) + columna] == VarGlobales.turno_jugador:
				cuenta_aux += 1
			else:
				cuenta_aux = 0
		if cuenta_aux == 3:
			gameover = true
	
	return gameover


func _columna_completa() -> bool:
	gameover = false
	for fila in range(3):
		var cuenta_aux = 0
		for columna in range(3):
			if tableros[(columna*3) + fila] == VarGlobales.turno_jugador:
				cuenta_aux += 1
			else:
				cuenta_aux = 0
		if cuenta_aux == 3:
			gameover = true
	
	return gameover


func _diagonal_completa() -> bool:
	gameover = false
	if (tableros[0] == VarGlobales.turno_jugador && tableros[4] == VarGlobales.turno_jugador && tableros[8] == VarGlobales.turno_jugador): 
		gameover = true
	
	if (tableros[6] == VarGlobales.turno_jugador && tableros[4] == VarGlobales.turno_jugador && tableros[2] == VarGlobales.turno_jugador):
		gameover = true
		
	return gameover


func _tablero_completo():
	for casilla in range(9):
		if tableros[casilla] == "-":
			return false
	return true


func _gameover() -> bool:
	gameover = false
	if (_fila_completa() || _columna_completa() || _diagonal_completa()):
		gameover = true
		VarGlobales.ganador_global = VarGlobales.turno_jugador
		get_tree().change_scene_to_packed(escena_final)
	elif _tablero_completo():
		gameover = true
		VarGlobales.ganador_global = "-"
		get_tree().change_scene_to_packed(escena_final)
	return gameover


func _on_nuevapartida_pressed():
	get_tree().change_scene_to_file("res://Escenas/juego.tscn")


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu_principal.tscn")

