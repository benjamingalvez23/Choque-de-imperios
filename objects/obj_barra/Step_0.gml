
if (!instance_exists(muro)) // Si el muro ya no existe (fue destruido)...
{
    instance_destroy(); // ...la barra también se destruye
    exit;               // Termina el evento aquí para no leer variables de un muro inexistente
}

x = muro.x - sprite_get_width(spt_barra) / 2; // Coloca la barra centrada horizontalmente respecto al muro
y = muro.bbox_top - 14;                       // Coloca la barra 14 píxeles arriba del límite superior del muro

visible = (muro.vida < muro.vida_max); // La barra solo se ve si el muro tiene menos de 100 de vida

if (muro.vida >= 70) // Si la vida del muro es 70 o más...
{
    image_index = 0; // ...muestra el frame 0 (verde)
}
else if (muro.vida >= 40) // Si no, pero la vida es 40 o más (entre 40 y 60)...
{
    image_index = 1; // ...muestra el frame 1 (amarillo)
}
else // Si la vida es menor a 40 (entre 0 y 30)...
{
    image_index = 2; // ...muestra el frame 2 (rojo)
}

image_xscale = max(muro.vida, 0) / muro.vida_max; // Estira la barra en X según la vida (vida 50 = 0.5 = mitad de ancho)