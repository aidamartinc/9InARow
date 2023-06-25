extends Node

var turno_jugador
var ganador_global

var cargar_guardado
var guardado

var file_guardar = "res://guardar.save"	# ruta al archivo donde se almacenan las cosas para guardar
var file_guardar_ajustes = "res://guardar_ajustes.save"

var Tablero0 = []
var Tablero1 = []
var Tablero2 = []
var Tablero3 = []
var Tablero4 = []
var Tablero5 = []
var Tablero6 = []
var Tablero7 = []
var Tablero8 = []
var tablero_final  = []

var es_ganador = []
var ganador = []
var gameover = []
var gameoverfinal
var todos_habilitados
var ultima_jugada

# texturas
var libre
var libre_disabled
var jugador_x 
var jugador_x_disabled 
var jugador_o 
var jugador_o_disabled
var completa 
var empate

var file_l
var file_l_d
var file_x
var file_x_d
var file_o
var file_o_d
	

# Called when the node enters the scene tree for the first time.
func _ready():
	turno_jugador = "o"
	ganador_global = null
	cargar_guardado = false
	guardado = false
	
	
	file_l = "res://Assets/Tiles/original/libre.png"
	file_l_d = "res://Assets/Tiles/original/libre_disabled.png"
	file_x = "res://Assets/Tiles/original/x.png"
	file_x_d = "res://Assets/Tiles/original/x_disabled.png"
	file_o = "res://Assets/Tiles/original/o.png"
	file_o_d = "res://Assets/Tiles/original/o_disabled.png"


	libre = load(file_l)
	libre_disabled = load(file_l_d)
	jugador_x = load(file_x)
	jugador_x_disabled = load(file_x_d)
	jugador_o = load(file_o)
	jugador_o_disabled = load(file_o_d)
	completa = libre_disabled
	empate = libre
	


func nueva():
	turno_jugador = "o"
	ganador_global = null
	cargar_guardado = false
	guardado = false
	var file = FileAccess.open("res://guardar.save", FileAccess.WRITE)
	file.close()
	

func _init():
	for i in range(9):
		Tablero0.append("-")
		Tablero1.append("-")
		Tablero2.append("-")
		Tablero3.append("-")
		Tablero4.append("-")
		Tablero5.append("-")
		Tablero6.append("-")
		Tablero7.append("-")
		Tablero8.append("-")
		tablero_final.append("-")
		es_ganador.append(false)
		ganador.append("-")
		gameover.append(false)
	gameoverfinal = false
	todos_habilitados = true
	ultima_jugada = -1
	

func load_variables(turno, gan):
	turno_jugador = turno
	ganador_global = gan

func load_tablero(nombre, tablero, var1, var2, var3):
	if nombre == "Tablero0":
		Tablero0 = tablero
		es_ganador[0] = var1
		ganador[0] = var3
		gameover[0] = var2
	if nombre == "Tablero1":
		Tablero1 = tablero
		es_ganador[1] = var1
		ganador[1] = var3
		gameover[1] = var2
	if nombre == "Tablero2":
		Tablero2 = tablero
		es_ganador[2] = var1
		ganador[2] = var3
		gameover[2] = var2
	if nombre == "Tablero3":
		Tablero3 = tablero
		es_ganador[3] = var1
		ganador[3] = var3
		gameover[3] = var2
	if nombre == "Tablero4":
		Tablero4 = tablero
		es_ganador[4] = var1
		ganador[4] = var3
		gameover[4] = var2
	if nombre == "Tablero5":
		Tablero5 = tablero
		es_ganador[5] = var1
		ganador[5] = var3
		gameover[5] = var2
	if nombre == "Tablero6":
		Tablero6 = tablero
		es_ganador[6] = var1
		ganador[6] = var3
		gameover[6] = var2
	if nombre == "Tablero7":
		Tablero7 = tablero
		es_ganador[7] = var1
		ganador[7] = var3
		gameover[7] = var2
	if nombre == "Tablero8":
		Tablero8 = tablero
		es_ganador[8] = var1
		ganador[8] = var3
		gameover[8] = var2
	if nombre == "TableroFinal":
		tablero_final = tablero
		gameoverfinal = var2
		todos_habilitados = var1
		ultima_jugada = var3

	

func load_ajustes(x, x_d, o, o_d, l, l_d):
	file_x = x
	file_x_d = x_d
	file_o = o
	file_o_d = o_d
	file_l = l
	file_l_d = l_d
	jugador_x = load(file_x)
	jugador_x_disabled = load(file_x_d)
	jugador_o = load(file_o)
	jugador_o_disabled = load(file_o_d)
	libre = load(file_l)
	libre_disabled = load(file_l_d)


func load_files(cosa, path):
	if cosa == "x":
		file_x = path
		jugador_x = load(file_x)
	elif cosa == "x_d":
		file_x_d = path
		jugador_x_disabled = load(file_x_d)
	elif cosa == "o":
		file_o = path
		jugador_o = load(file_o)
	elif cosa == "o_d":
		file_o_d = path
		jugador_o_disabled = load(file_o_d)
	elif cosa == "l":
		file_l = path
		libre = load(file_l)
	elif cosa == "l_d":
		file_l_d = path
		libre_disabled = load(file_l_d)
