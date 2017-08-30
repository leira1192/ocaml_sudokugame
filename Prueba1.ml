let numero1 = "0";;
let numero = int_of_string numero1;;
print_int numero;;

Random.self_init();;
let aleatorio = 0;;
print_int aleatorio;;
let aleatorio2 = Random.int 9;;
print_int aleatorio2;;
let aleatorio3 = Random.int 9;;
print_int aleatorio3;;
print_string "\n";;


  let s = Array.make 8 ' ' in
  for i=0 to 7 do 
        s.[i] <- Random.int (9)
  done;;


#load "unix.cma";;
#directory "+threads";;
#load "threads.cma";;
let seconds = read_float ();;
print_endline "Sleeping...";;
Thread.delay seconds;; (* number is in seconds ... but accepts fractions *)
print_endline "Awake!";;

