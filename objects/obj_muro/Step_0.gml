
// Si la vida del muro llega a 0, se destruye el muro y el muro invisible
if (vida <= 0){
    with (obj_muro_invisible){
        if (id_invisible == other.id_muro){
            instance_destroy();
        }
    }
	instance_destroy();
}
// Si el jugador no toca el muro se reinicia
if (!place_meeting(x, y, obj_Pedro)){
    contador_reparar = 0;
}