(*Creamos la matriz*)
let matriz_juego = Array.make_matrix 11 11 "0";;
(*Creamos un array de numeros del 1-9 para prepararnos para el relleno de entrada*)
Random.self_init();;
let shuffle = Array.sort(fun _ _ -> (Random.int 3) - 1);;
let a = Array.init 13 (fun i ->i+1);;
let array_complete = [|"1";"2";"3";"4";"5";"6";"7";"8";"9"|];;
let array_temp_complete = ref "0";;
Array.set a 9 1;;
Array.set a 10 5;;
Array.set a 11 0;;
Array.set a 12 0;;
shuffle a; a;; (*Sacudimos el arreglo para desordenar los numeros*)
shuffle a; a;; (*Sacudimos el arreglo para desordenar los numeros*)

print_int a.(0);;
print_int a.(1);;
print_int a.(2);;
print_int a.(3);;
print_int a.(4);;
print_int a.(5);;
print_int a.(6);;
print_int a.(7);;
print_int a.(8);;
print_int a.(9);;
print_int a.(10);;
print_int a.(11);;
print_string "\n";;
(*Imprimimos la matriz inicializada en 0*)
for i = 0 to 10 do
	for j = 0 to 10 do
		print_string "[";
		if j == 3 || j == 7 then matriz_juego.(i).(j) <- " " ;
		if i == 3 || i == 7 then matriz_juego.(i).(j) <- " " ;
		print_string matriz_juego.(i).(j);
		print_string "]";
	done;
	print_string "\n";
done;;

(*Iniciamos las variables controladoras del juego*)
let continuar = ref "s";;
let continuar_nivel = ref "s";;
let validacion = ref true;;
let ayuda = ref 1;;
let nivel_de_ayuda = ref "1";;
let opciones_nivel = ref "0";;
let posicion_x = ref "0";;
let posicion_y = ref "0";;
let numero_ingresado = ref "0";;
let numero_ingresado_flag = ref false;;
let contador_win = ref 0;;
let completo = ref false;;
let contador_completar_cubo = ref false;;
(*Fin de las variables controladoras del juego*)
let dificultad = ref "1";;
let level =  0;;
#load "unix.cma";;
#directory "+threads";;
#load "threads.cma";;
let seconds = ref " ";;
let temporal = ref "0";;
let xx = ref 0;;
let yy = ref 0;;
(*Empezamos el juego*)
while !continuar = "s" || !continuar = "S" do
  (
  	print_string "\nElija el nivel de dificultad: \n 1. Facil \n 2. Intermedio \n";
  	dificultad := read_line();
  	continuar_nivel := "s";
  	match !dificultad with
  	| "1" -> ((*Opcion 1 de nivel de dificultad*)
	print_string "\n ====== Nivel de dificultad Facil ====== \n";
	print_string " Bienvenido \n";
	while !continuar_nivel = "s" || !continuar_nivel = "S" do
	  	while !ayuda >= 1 do
			for i = 0 to 10 do
		  		for j = 0 to 10 do
		  			match matriz_juego.(i).(j) with
		  			| "0" -> matriz_juego.(i).(j) <- string_of_int a.(Random.int 13);
		  			| _ -> print_string "";
		  			;
		  		done;
		  	done;
	  		ayuda := !ayuda - 1;
	  	done;
		(*Validacion del autocompletado por filas y columnas*)
		while !validacion do
			for i = 0 to 10 do
			 	for j = 0 to 10 do
			 		if matriz_juego.(i).(j) = "0" || matriz_juego.(i).(j) = " " then print_string "" else (
			 			for y = i+1 to 10 do
			 				if matriz_juego.(i).(j) = matriz_juego.(y).(j) && matriz_juego.(y).(j) != "0" then (
			 					matriz_juego.(y).(j) <- "0";
			 					if !numero_ingresado_flag then (
									numero_ingresado_flag := false;
									(*print_string "El numero que ingreso tiene conflicto con otro, se dio orden de prioridad \n";*)
								);
			 				);
			 			done;
			 			for x = j+1 to 10 do
			 				if matriz_juego.(i).(j) = matriz_juego.(i).(x) && matriz_juego.(i).(x) != "0" then (
			 					matriz_juego.(i).(x) <- "0";
			 					if !numero_ingresado_flag then (
									numero_ingresado_flag := false;
									(*print_string "El numero que ingreso tiene conflicto con otro, se dio orden de prioridad \n";*)
								);
			 				);
			 			done;	 			
			 		);	
			 	done;	 			
			done;
			(*Validacion del autocompletado por cubos*)
			for i = 0 to 2 do
				for j = 0 to 2 do
					xx := i + (i*3);
					yy := j + (j*3);
					for k = !xx to !xx + 2 do
						for z = !yy to !yy + 2 do
							for a = !xx to !xx + 2 do
								for b = !yy to !yy + 2 do
									if a == k && b == z then print_string "" 
									else(
										if matriz_juego.(k).(z) = matriz_juego.(a).(b) && matriz_juego.(a).(b) != "0" then (
											matriz_juego.(a).(b) <- "0";
											if !numero_ingresado_flag then (
												numero_ingresado_flag := false;
												(*print_string "El numero que ingreso tiene conflicto con otro, se dio orden de prioridad \n";*)
											);
										);
									); 
								done;
							done;				
						done;				 								
					done;				 				 			
				done;			 			 		
			done;
			validacion := false;
			numero_ingresado_flag := false;
		done;
		(*Print del sudoku*)
		print_string "\n";
		contador_win := 0;
	  	for i = 0 to 10 do
			for j = 0 to 10 do
				print_string "[";
				print_string matriz_juego.(i).(j);
				print_string "]";
				if matriz_juego.(i).(j) = "0" then contador_win := !contador_win + 1;
			done;
			print_string "\n";
		done;
		if !contador_win == 0 then print_string "GANASTEEEEEEE.!!!!!!";
		print_string "\n 1. Ayuda \n 2. Ingresar numero \n 3. Salir \n Elija una Opcion: ";
		opciones_nivel := read_line();
		match !opciones_nivel with
		| "0" -> print_string "Favor elegir una opcion";
		| "1" ->(
			print_string "Indicar el nivel de ayuda que desea (1-10): ";
			nivel_de_ayuda := read_line();
			ayuda := int_of_string !nivel_de_ayuda;
			validacion := true;
		);
		| "2" ->(
			print_string "Ingrese x: ";
			posicion_y := read_line();
			print_string "Ingrese y: ";
			posicion_x := read_line();
			print_string "Ingrese el numero que desea ingresar: ";
			numero_ingresado := read_line();
			matriz_juego.(int_of_string !posicion_x).(int_of_string !posicion_y) <- !numero_ingresado;
			numero_ingresado_flag := true;
			validacion := true;
		);
		| "3" -> (continuar_nivel := "n";);
		| _ -> print_string "Error";
	done;
	);
	(*============ Final de nivel facil =============*)
  	| "2" -> (
	Array.set a 0 1;
	Array.set a 1 2;
	Array.set a 2 3;
	Array.set a 3 4;
	Array.set a 4 5;
	Array.set a 5 6;
	Array.set a 6 7;
	Array.set a 7 8;
	Array.set a 8 9;
	Array.set a 9 0;
	Array.set a 10 0;
	Array.set a 11 0;
	Array.set a 12 0;
	shuffle a;
	(*Print de los numeros para el nivel intermedio*)
	  	print_string "\n ====== Nivel de dificultad Intermedio ====== \n";
	print_string " X_X Que mal en este nivel no hay ayudas X_X \n";
	while !continuar_nivel = "s" || !continuar_nivel = "S" do
	  	while !ayuda >= 1 do
			for i = 0 to 10 do
		  		for j = 0 to 10 do
		  			match matriz_juego.(i).(j) with
		  			| "0" -> matriz_juego.(i).(j) <- string_of_int a.(Random.int 13);
		  			| _ -> print_string "";
		  			;
		  		done;
		  	done;
	  		ayuda := !ayuda - 1;
	  	done;
		(*Validacion del autocompletado por filas y columnas*)
		while !validacion do
			for i = 0 to 10 do
			 	for j = 0 to 10 do
			 		if matriz_juego.(i).(j) = "0" || matriz_juego.(i).(j) = " " then print_string "" else (
			 			for y = i+1 to 10 do
			 				if matriz_juego.(i).(j) = matriz_juego.(y).(j) && matriz_juego.(y).(j) != "0" then (
			 					matriz_juego.(y).(j) <- "0";
			 					if !numero_ingresado_flag then (
									numero_ingresado_flag := false;
									(*print_string "El numero que ingreso tiene conflicto con otro, se dio orden de prioridad \n";*)
								);
			 				);
			 			done;
			 			for x = j+1 to 10 do
			 				if matriz_juego.(i).(j) = matriz_juego.(i).(x) && matriz_juego.(i).(x) != "0" then (
			 					matriz_juego.(i).(x) <- "0";
			 					if !numero_ingresado_flag then (
									numero_ingresado_flag := false;
									(*print_string "El numero que ingreso tiene conflicto con otro, se dio orden de prioridad \n";*)
								);
			 				);
			 			done;	 			
			 		);	
			 	done;	 			
			done;
			(*Validacion del autocompletado por cubos*)
			for i = 0 to 2 do
				for j = 0 to 2 do
					xx := i + (i*3);
					yy := j + (j*3);
					for k = !xx to !xx + 2 do
						for z = !yy to !yy + 2 do
							for a = !xx to !xx + 2 do
								for b = !yy to !yy + 2 do
									if a == k && b == z then print_string "" 
									else(
										if matriz_juego.(k).(z) = matriz_juego.(a).(b) && matriz_juego.(a).(b) != "0" then (
											matriz_juego.(a).(b) <- "0";
											if !numero_ingresado_flag then (
												numero_ingresado_flag := false;
												(*print_string "El numero que ingreso tiene conflicto con otro, se dio orden de prioridad \n";*)
											);
										);
									); 
								done;
							done;				
						done;				 								
					done;				 				 			
				done;			 			 		
			done;
			validacion := false;
			numero_ingresado_flag := false;
		done;
		(*Print del sudoku*)
		print_string "\n";
		contador_win := 0;
	  	for i = 0 to 10 do
			for j = 0 to 10 do
				print_string "[";
				print_string matriz_juego.(i).(j);
				print_string "]";
				if matriz_juego.(i).(j) = "0" then contador_win := !contador_win + 1;
			done;
			print_string "\n";
		done;
		if !contador_win == 0 then print_string "GANASTEEEEEEE.. eres un crack.. pero no menos que yo..!!!!!!";
		print_string "\n 1. Ingresar numero \n 2. Rendirse y resolver \n 3. Salir \n Elija una Opcion: ";
		opciones_nivel := read_line();
		match !opciones_nivel with
		| "0" -> print_string "Favor elegir una opcion";
		| "1" ->(
			print_string "Ingrese x: ";
			posicion_y := read_line();
			print_string "Ingrese y: ";
			posicion_x := read_line();
			print_string "Ingrese el numero que desea ingresar: ";
			numero_ingresado := read_line();
			matriz_juego.(int_of_string !posicion_x).(int_of_string !posicion_y) <- !numero_ingresado;
			numero_ingresado_flag := true;
			validacion := true;
		);
		| "2" -> (
			continuar_nivel := "n";
			print_string "No eres tan bueno como crees \n";
			completo := true;
			while !completo do
				for i = 0 to 2 do
					for j = 0 to 2 do
						xx := i + (i*3);
						yy := j + (j*3);
						for k = !xx to !xx + 2 do
							for z = !yy to !yy + 2 do
								if matriz_juego.(k).(z) = "0" then(
									for aa = !xx to !xx + 2 do
										for bb = !yy to !yy + 2 do
											for cc = 0 to 8 do
												if matriz_juego.(aa).(bb) = array_complete.(cc) then (
													contador_completar_cubo := true;
												) else (
													if !contador_completar_cubo = false	then array_temp_complete := array_complete.(cc);
												);
											done;
											if !contador_completar_cubo = false	then matriz_juego.(aa).(bb) <- !array_temp_complete;														
										done;												
									done;
								);				
							done;				 								
						done;				 				 			
					done;			 			 		
				done;
				validacion := true;
				while !validacion do
					for i = 0 to 10 do
					 	for j = 0 to 10 do
					 		if matriz_juego.(i).(j) = "0" || matriz_juego.(i).(j) = " " then print_string "" else (
					 			for y = i+1 to 10 do
					 				if matriz_juego.(i).(j) = matriz_juego.(y).(j) && matriz_juego.(y).(j) != "0" then (
					 					matriz_juego.(y).(j) <- "0";
					 					if !numero_ingresado_flag then (
											numero_ingresado_flag := false;
											(*print_string "El numero que ingreso tiene conflicto con otro, se dio orden de prioridad \n";*)
										);
					 				);
					 			done;
					 			for x = j+1 to 10 do
					 				if matriz_juego.(i).(j) = matriz_juego.(i).(x) && matriz_juego.(i).(x) != "0" then (
					 					matriz_juego.(i).(x) <- "0";
					 					if !numero_ingresado_flag then (
											numero_ingresado_flag := false;
											(*print_string "El numero que ingreso tiene conflicto con otro, se dio orden de prioridad \n";*)
										);
					 				);
					 			done;	 			
					 		);	
					 	done;	 			
					done;
					(*Validacion del autocompletado por cubos*)
					for i = 0 to 2 do
						for j = 0 to 2 do
							xx := i + (i*3);
							yy := j + (j*3);
							for k = !xx to !xx + 2 do
								for z = !yy to !yy + 2 do
									for a = !xx to !xx + 2 do
										for b = !yy to !yy + 2 do
											if a == k && b == z then print_string "" 
											else(
												if matriz_juego.(k).(z) = matriz_juego.(a).(b) && matriz_juego.(a).(b) != "0" then (
													matriz_juego.(a).(b) <- "0";
													if !numero_ingresado_flag then (
														numero_ingresado_flag := false;
														(*print_string "El numero que ingreso tiene conflicto con otro, se dio orden de prioridad \n";*)
													);
												);
											); 
										done;
									done;				
								done;				 								
							done;				 				 			
						done;			 			 		
					done;
					validacion := false;
					numero_ingresado_flag := false;

				done;
				contador_win := 0;
				for i = 0 to 10 do
					for j = 0 to 10 do
						if matriz_juego.(i).(j) = "0" then contador_win := !contador_win + 1;
					done;
					print_int !contador_win;
					print_string "\n";
				done;
				(*if !contador_win > 10 then completo := false;*)
				completo := false;
			done;
			print_string "============ Solucion ============ \n";
			for i = 0 to 10 do
				for j = 0 to 10 do
					print_string "[";
					print_string matriz_juego.(i).(j);
					print_string "]";
					if matriz_juego.(i).(j) = "0" then contador_win := !contador_win + 1;
				done;
				print_string "\n";
			done;
			continuar_nivel := "n";
		);
		| "3" -> (
			continuar_nivel := "n";
		);
		| _ -> print_string "Error";
	done;	
  	);
  	| _ -> print_string "Error, nivel invalido \n";
  	print_string "Desea intentar de nuevo? (s/n) \n";
    continuar := read_line();
  )
done;;
print_string "Game Over \n";;
print_string "1 puntito extra ingeniero \n";;
