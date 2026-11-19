// Si la variable global del contador de spawners todavía no existe...
if (!variable_global_exists("contador_spawners")) // Pregunta si ya fue creada por otro spawner
{
    global.contador_spawners = 0; // La crea en 0
}

// Cada spawner recibe un número de orden: el primero 0, el segundo 1... hasta el 11
orden = global.contador_spawners; // Toma el número actual del contador

// Suma 1 al contador para que el siguiente spawner reciba el número siguiente
global.contador_spawners += 1; // Así cada spawner tiene un orden distinto

// Segundo del juego en el que este spawner se enciende (cada uno 10 segundos después del anterior)
tiempo_activacion = orden * 10; // Orden 0 = 0 s, orden 1 = 10 s, orden 2 = 20 s... orden 11 = 110 s

// Indica si el spawner ya empezó a trabajar
activo = false; // Empieza apagado

// Contador de pasos hasta el siguiente enemigo
contador_spawn = 0; // Se llena cuando el spawner se activa