extends Control

@onready var tablero_final = get_tree().get_first_node_in_group("tablero_final")
@onready var tableros_juego = get_tree().get_nodes_in_group("tablero_juego")
@onready var ver_turnos = get_tree().get_first_node_in_group("ver_turno")

var tablero : Array
var casillas : Array

var es_ganador = false
var ganador = "-"
var gameover = false


func _ready():
	es_ganador = false
	ganador = "-"
	gameover = false
	_inicio_tablero()
	if VarGlobales.cargar_guardado == true:
		_load()
		VarGlobales.guardado = false
	
	_pinta_tablero()

	
func _habilitar_tablero(habilitado : bool):
	for casilla in range(9):
		casillas[casilla].set_disabled(!habilitado)
		if (!habilitado):
			if (tablero[casilla] == "x"):
				casillas[casilla].texture_disabled = VarGlobales.jugador_x_disabled
			elif(tablero[casilla] == "o"):
				casillas[casilla].texture_disabled =  VarGlobales.jugador_o_disabled
			else:
				casillas[casilla].texture_disabled =  VarGlobales.libre_disabled


func _inicio_tablero():	
	tablero = [
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
	_pinta_tablero()
	_habilitar_tablero(true)

func save():
	var dict = {
		#"parent": get_parent().get_path(),
		"tablero": get_name(),
		"casilla0": tablero[0],
		"casilla1": tablero[1],
		"casilla2": tablero[2],
		"casilla3": tablero[3],
		"casilla4": tablero[4],
		"casilla5": tablero[5],
		"casilla6": tablero[6], 
		"casilla7": tablero[7],
		"casilla8": tablero[8],
		"var1": es_ganador,
		"var2": gameover,
		"var3": ganador
	}
	return dict

func _load():
	var tableros = get_tree().get_nodes_in_group("tablero_juego")
	for i in range(9):
		var nombre = tableros[i].get_name()
		print(nombre)
		if nombre == get_name():
			if get_name() == "Tablero0":
				tableros[i].tablero = VarGlobales.Tablero0
				es_ganador = VarGlobales.es_ganador[0]
				ganador = VarGlobales.ganador[0]
				gameover = VarGlobales.gameover[0]
			if get_name() == "Tablero1":
				tablero = VarGlobales.Tablero1
				es_ganador = VarGlobales.es_ganador[1]
				ganador = VarGlobales.ganador[1]
				gameover = VarGlobales.gameover[1]
			if get_name() == "Tablero2":
				tablero = VarGlobales.Tablero2
				es_ganador = VarGlobales.es_ganador[2]
				ganador = VarGlobales.ganador[2]
				gameover = VarGlobales.gameover[2]
			if get_name() == "Tablero3":
				tablero = VarGlobales.Tablero3
				es_ganador = VarGlobales.es_ganador[3]
				ganador = VarGlobales.ganador[3]
				gameover = VarGlobales.gameover[3]
			if get_name() == "Tablero4":
				tablero = VarGlobales.Tablero4
				es_ganador = VarGlobales.es_ganador[4]
				ganador = VarGlobales.ganador[4]
				gameover = VarGlobales.gameover[4]
			if get_name() == "Tablero5":
				tablero = VarGlobales.Tablero5
				es_ganador = VarGlobales.es_ganador[5]
				ganador = VarGlobales.ganador[5]
				gameover = VarGlobales.gameover[5]
			if get_name() == "Tablero6":
				tablero = VarGlobales.Tablero6
				es_ganador = VarGlobales.es_ganador[6]
				ganador = VarGlobales.ganador[6]
				gameover = VarGlobales.gameover[6]
			if get_name() == "Tablero7":
				tablero = VarGlobales.Tablero7
				es_ganador = VarGlobales.es_ganador[7]
				ganador = VarGlobales.ganador[7]
				gameover = VarGlobales.gameover[7]
			if get_name() == "Tablero8":
				tablero = VarGlobales.Tablero8
				es_ganador = VarGlobales.es_ganador[8]
				ganador = VarGlobales.ganador[8]
				gameover = VarGlobales.gameover[8]


func _pinta_tablero():
	for casilla in range(9):
		if tablero[casilla] == "-":
			casillas[casilla].texture_normal =  VarGlobales.libre
		elif tablero[casilla] == "o":
			casillas[casilla].texture_normal =  VarGlobales.jugador_o
		elif tablero[casilla] == "x":
			casillas[casilla].texture_normal =  VarGlobales.jugador_x


func _mover(casilla : int):
	tablero[casilla] = VarGlobales.turno_jugador
	tablero_final.ultima_jugada = casilla
	_pinta_tablero()
	_gameover()


func _cambio_turno():
	if VarGlobales.turno_jugador =="o":
		VarGlobales.turno_jugador = "x"
		ver_turnos._cambia_turno()
	else:
		VarGlobales.turno_jugador = "o"
		ver_turnos._cambia_turno()


func _fila_completa() -> bool:
	es_ganador = false
	for fila in range(3):
		var cuenta_aux = 0
		for columna in range(3):
			if tablero[(fila*3) + columna] == VarGlobales.turno_jugador:
				cuenta_aux += 1
			else:
				cuenta_aux = 0
		if cuenta_aux == 3:
			es_ganador = true
	
	return es_ganador


func _columna_completa() -> bool:
	es_ganador = false
	for fila in range(3):
		var cuenta_aux = 0
		for columna in range(3):
			if tablero[(columna*3) + fila] == VarGlobales.turno_jugador:
				cuenta_aux += 1
			else:
				cuenta_aux = 0
		if cuenta_aux == 3:
			es_ganador = true
	
	return es_ganador


func _diagonal_completa() -> bool:
	es_ganador = false
	var jugador = VarGlobales.turno_jugador
	if (tablero[0] == jugador && tablero[4] == jugador && tablero[8] == jugador): 
		es_ganador = true
	
	if (tablero[6] == jugador && tablero[4] == jugador && tablero[2] == jugador):
		es_ganador = true
		
	return es_ganador


func _tablero_completo():
	for casilla in range(9):
		if tablero[casilla] == "-":
			return false
	return true


func _gameover() -> bool:
	if (_fila_completa() || _columna_completa() || _diagonal_completa()):
		gameover = true
		ganador = VarGlobales.turno_jugador
	elif _tablero_completo():
		gameover = true
		ganador = "/"
		
	return gameover


func _on_casilla_0_button_up():
	if (tablero[0]== "-"):
		_mover(0)
		var nombre_tablero
		for i in range(9):
			nombre_tablero = tableros_juego[i].get_name()
			if nombre_tablero.ends_with(str(tablero_final.ultima_jugada)):
				if (tableros_juego[i].gameover):
					tablero_final.todos_habilitados = true
					tablero_final._habilitar_tableros()
				else:
					tablero_final.todos_habilitados = false
					tablero_final._habilitar_tableros()
				
		_cambio_turno()

func _on_casilla_1_button_up():
	if (tablero[1]== "-"):
		_mover(1)
		var nombre_tablero
		for i in range(9):
			nombre_tablero = tableros_juego[i].get_name()
			if nombre_tablero.ends_with(str(tablero_final.ultima_jugada)):
				if (tableros_juego[i].gameover):
					tablero_final.todos_habilitados = true
					tablero_final._habilitar_tableros()
				else:
					tablero_final.todos_habilitados = false
					tablero_final._habilitar_tableros()
					
		_cambio_turno()

func _on_casilla_2_button_up():
	if (tablero[2]== "-"):
		_mover(2)
		var nombre_tablero
		for i in range(9):
			nombre_tablero = tableros_juego[i].get_name()
			if nombre_tablero.ends_with(str(tablero_final.ultima_jugada)):
				if (tableros_juego[i].gameover):
					tablero_final.todos_habilitados = true
					tablero_final._habilitar_tableros()
				else:
					tablero_final.todos_habilitados = false
					tablero_final._habilitar_tableros()
					
		_cambio_turno()

func _on_casilla_3_button_up():
	if (tablero[3]== "-"):
		_mover(3)
		var nombre_tablero
		for i in range(9):
			nombre_tablero = tableros_juego[i].get_name()
			if nombre_tablero.ends_with(str(tablero_final.ultima_jugada)):
				if (tableros_juego[i].gameover):
					tablero_final.todos_habilitados = true
					tablero_final._habilitar_tableros()
				else:
					tablero_final.todos_habilitados = false
					tablero_final._habilitar_tableros()
					
		_cambio_turno()

func _on_casilla_4_button_up():
	if (tablero[4]== "-"):
		_mover(4)
		var nombre_tablero
		for i in range(9):
			nombre_tablero = tableros_juego[i].get_name()
			if nombre_tablero.ends_with(str(tablero_final.ultima_jugada)):
				if (tableros_juego[i].gameover):
					tablero_final.todos_habilitados = true
					tablero_final._habilitar_tableros()
				else:
					tablero_final.todos_habilitados = false
					tablero_final._habilitar_tableros()
					
		_cambio_turno()

func _on_casilla_5_button_up():
	if (tablero[5]== "-"):
		_mover(5)
		var nombre_tablero
		for i in range(9):
			nombre_tablero = tableros_juego[i].get_name()
			if nombre_tablero.ends_with(str(tablero_final.ultima_jugada)):
				if (tableros_juego[i].gameover):
					tablero_final.todos_habilitados = true
					tablero_final._habilitar_tableros()
				else:
					tablero_final.todos_habilitados = false
					tablero_final._habilitar_tableros()
					
		_cambio_turno()
	
func _on_casilla_6_button_up():
	if (tablero[6]== "-"):
		_mover(6)
		var nombre_tablero
		for i in range(9):
			nombre_tablero = tableros_juego[i].get_name()
			if nombre_tablero.ends_with(str(tablero_final.ultima_jugada)):
				if (tableros_juego[i].gameover):
					tablero_final.todos_habilitados = true
					tablero_final._habilitar_tableros()
				else:
					tablero_final.todos_habilitados = false
					tablero_final._habilitar_tableros()
					
		_cambio_turno()

func _on_casilla_7_button_up():
	if (tablero[7]== "-"):
		_mover(7)
		var nombre_tablero
		for i in range(9):
			nombre_tablero = tableros_juego[i].get_name()
			if nombre_tablero.ends_with(str(tablero_final.ultima_jugada)):
				if (tableros_juego[i].gameover):
					tablero_final.todos_habilitados = true
					tablero_final._habilitar_tableros()
				else:
					tablero_final.todos_habilitados = false
					tablero_final._habilitar_tableros()
					
		_cambio_turno()

func _on_casilla_8_button_up():
	if (tablero[8]== "-"):
		_mover(8)
		var nombre_tablero
		for i in range(9):
			nombre_tablero = tableros_juego[i].get_name()
			if nombre_tablero.ends_with(str(tablero_final.ultima_jugada)):
				if (tableros_juego[i].gameover):
					tablero_final.todos_habilitados = true
					tablero_final._habilitar_tableros()
				else:
					tablero_final.todos_habilitados = false
					tablero_final._habilitar_tableros()
					
		_cambio_turno()
