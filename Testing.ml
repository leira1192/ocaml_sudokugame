let iniciarlizar_array x y =
  let z = Array.make_matrix x y 0 in
  for i = 0 to x-1 do
    for j = 0 to y-1 do
      print_int z.(i).(j);
    done;
    print_string " \n"
  done;;
  let z = Array.make_matrix 9 9 0;;
  for i = 0 to 8 do
    for j = 0 to 8 do
      print_int z.(i).(j);
    done;
    print_string " \n"
  done;;



  (*=========================================================================*)
  
let Imprimir_Array Matriz =
  for i = 0 to 9-1 do
    for j = 0 to 9-1 do
      print_int Matriz.(i).(j);
    done;
    print_string " \n"
  done;;
  matrix_multiply 9 9;;
let continuar = ref "s";;

(* PRINT LIST INT *)
let rec print_list_int myList = match myList with
| [] -> print_endline "\n"
| head::body -> 
begin
print_string "[";
print_int head; 
print_string "]";
print_list_int body;
end
;;


if Array.length matrix == 0 then print_string "No tienen nada" else print_string "contiene algo";; 
print_string "\n Final de la lista";;
while !continuar = "s" || !continuar = "S" do
  (
    print_string "Desea reinicar el juego? (s/n) \n";
    continuar := read_line();
    for i = 0 to 2 do
      (
      for j = 0 to 2 do
        (
          print_string "Siuuuu ";
          print_string "    ";
          print_int i;
          print_string "    ";
          print_int j;
          print_string "    ";
          if 1 == 1 then print_string "Vacia" else print_string "Llena";
        )
      done;
      print_string "\n";        
      )
    done;
  )
done;;
print_string "Game Over \n";;
print_string "1 puntito extra ingeniero \n";;
