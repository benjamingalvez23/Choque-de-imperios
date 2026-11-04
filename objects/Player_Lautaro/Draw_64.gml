
var barra_x = 20;
var barra_y = 20;

var ancho = 200;
var alto = 25;

var porcentaje = vida / vida_maxima;

draw_set_color(c_red);
draw_rectangle(
    barra_x,
    barra_y,
    barra_x + ancho,
    barra_y + alto,
    false
);

draw_set_color(c_lime);
draw_rectangle(
    barra_x,
    barra_y,
    barra_x + (ancho * porcentaje),
    barra_y + alto,
    false
);

draw_set_color(c_white);
draw_text(barra_x, barra_y + 30,
    "Vida: " + string(vida) + " / " + string(vida_maxima)
);

draw_set_color(c_white);

// Posición de la barra
var furia_x = 20;
var furia_y = 85;

// Tamaño
var furia_ancho = 200;
var furia_alto = 20;

// Calcular porcentaje
var porcentaje_furia = furia / furia_maxima;

// Fondo oscuro
draw_set_color(c_black);
draw_rectangle(
    furia_x,
    furia_y,
    furia_x + furia_ancho,
    furia_y + furia_alto,
    false
);

// Barra azul
draw_set_color(c_blue);
draw_rectangle(
    furia_x,
    furia_y,
    furia_x + (furia_ancho * porcentaje_furia),
    furia_y + furia_alto,
    false
);

// Texto
draw_set_color(c_white);
draw_text(furia_x, furia_y + 23,
    "Furia: " + string(furia) + " / " + string(furia_maxima)
);