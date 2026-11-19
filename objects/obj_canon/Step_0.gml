if (cooldown > 0)                                 // si todavía hay tiempo de espera pendiente...
{
    cooldown -= 1;                                // ...resta 1 step al cooldown en cada frame
}

if (place_meeting(x, y, obj_Pedro))              // verifica si obj_player está tocando al cañón
{
    if (keyboard_check_pressed(ord("Z")) && cooldown <= 0) // Z presionada (una sola vez) Y cooldown terminado
    {
        cooldown = cooldown_max;                  // reinicia el cooldown a 4 segundos
        image_index = 0;                          // reinicia la animación desde el primer frame
        image_speed = 1;                          // activa la animación de spt_canon

        var _bala = instance_create_layer(x, y, "Instances", obj_proyectil); // crea el proyectil y guarda su id
        _bala.direction = 0;                      // dirección en grados (0 = derecha, 180 = izquierda)
        _bala.speed = 6;                          // velocidad del proyectil en píxeles por step
    }
}