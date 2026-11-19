var muro_tocado = instance_place(x, y, obj_muro);

if (muro_tocado != noone) // Si está tocando un muro...
{
    speed = 0; // Se detiene
    // Cuenta regresiva
    contador_ataque -= 1; // Resta 1 al contador en cada paso

    // Cuando llega a 0 puede atacar
    if (contador_ataque <= 0) // Si el contador terminó...
    {
        muro_tocado.vida -= damage_enemy; // Le quita vida al muro que está tocando
        // reinicio de cuenta regresiva
        contador_ataque = tiempo_ataque; // Reinicia el contador
    }
}
else // Si no toca el muro
{
    // Verifica que el objeto muro exista
    if (instance_exists(objetivo)) // Si el muro objetivo todavía existe...
    {
        if (x < objetivo.x) // Si el enemigo está a la izquierda del punto...
        {
            x += velocidad; // Se mueve a la derecha
        }
        else if (x > objetivo.x) // Si está a la derecha del punto...
        {
            x -= velocidad; // Se mueve a la izquierda
        }
        else if (y < objetivo.y) // Si ya está alineado en X y está arriba del punto...
        {
            y += velocidad; // Se mueve hacia abajo
        }
        else if (y > objetivo.y) // Si ya está alineado en X y está abajo del punto...
        {
            y -= velocidad; // Se mueve hacia arriba
        }
    }
    else // Si fue destruido, busca el muro más cercano nuevamente
    {
        objetivo = instance_nearest(x, y, obj_muro); // Elige el muro más cercano
    }
}

if (vida <= 0)                                    // si la vida llegó a 0 o menos...
{
    instance_destroy();                           // ...el enemigo muere
}