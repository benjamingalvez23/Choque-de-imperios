// Si el spawner todavía está apagado...
if (!activo) // Pregunta si no está activo
{
    // Si el tiempo global ya alcanzó el momento de encendido de este spawner...
    if (global.tiempo_juego >= tiempo_activacion) // Compara el tiempo global con su tiempo de activación
    {
        activo = true; // Lo enciende
        contador_spawn = 0; // Hace que su primer enemigo salga de inmediato
    }
}
else // Si ya está encendido...
{
    // Resta 1 al contador en cada paso
    contador_spawn -= 1; // Cada paso baja el contador en 1

    // Cuando el contador llega a 0, toca crear un enemigo
    if (contador_spawn <= 0) // Si el contador terminó...
    {
        // Crea un enemigo exactamente donde está este spawner
        instance_create_layer(x, y, "Instances", obj_enemy); // Crea obj_enemy en la x, y del spawner

        // Reinicia el contador: empieza en 8 segundos y baja 0.05 segundos por cada segundo de juego, sin bajar de 1 segundo
        contador_spawn = room_speed * max(1, 8 - (global.tiempo_juego * 0.05)); // max(1, ...) evita que el tiempo sea menor a 1 segundo
    }
}