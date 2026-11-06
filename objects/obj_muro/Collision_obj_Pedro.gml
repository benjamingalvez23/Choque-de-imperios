// Si el jugador mantiene presionada M y la vida del muro no esta completa
// suma 1 al contador de reparar
if (keyboard_check(ord("M")) && vida < vida_max){
    contador_reparar += 1;
	// Al completar los 3 segundos, suma 10 al muro, sin pasar el maximo
    if (contador_reparar >= tiempo_reparar){
        vida = min(vida + 10, vida_max);
        contador_reparar = 0;
    }
} else { // Si no se pulsa la tecla M o el muro este reparado, el contador vuelva a 0
    contador_reparar = 0;
}

