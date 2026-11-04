
if (vida <= 0){
    instance_destroy();
}

// Si el jugador no toca el muro, se reinicia el contador
if (!place_meeting(x, y, obj_Pedro)){
    contador_reparar = 0;
}