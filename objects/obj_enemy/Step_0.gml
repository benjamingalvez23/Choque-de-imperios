var muro_tocado = instance_place(x, y, obj_muro);

if (muro_tocado != noone)
{
    speed = 0;
	// Cuenta regresiva
    contador_ataque -= 1;
	
	// Cuando llega a 0 puede atacar
    if (contador_ataque <= 0)
    {
        muro_tocado.vida -= damage_enemy;
		// reinicio de cuenta regresiva
        contador_ataque = tiempo_ataque;
    }
} else { // Si no toca el muro
	// Verifica que el objeto muro exista
    if (instance_exists(objetivo))
    {
		// Se dirige a las cordenadas del muro
        move_towards_point(objetivo.x, objetivo.y, velocidad);
    } else { // Si es destruidobusca el muro mas cercano nuevamente
        objetivo = instance_nearest(x, y, obj_muro); 
    }
}