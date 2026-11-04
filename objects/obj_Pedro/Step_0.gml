btnDerecha   = keyboard_check(vk_right) || keyboard_check(ord("D"));
btnIzquierda = keyboard_check(vk_left)  || keyboard_check(ord("A"));
btnArriba    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
btnAbajo     = keyboard_check(vk_down)  || keyboard_check(ord("S"));
paso_x = (btnDerecha - btnIzquierda) * velocidad;
paso_y = (btnAbajo - btnArriba) * velocidad;

// Movimiento del Jugador
if (paso_x != 0){
    paso_y = 0;
}
if (btnDerecha){
    sprite_index = spt_right_pedro;
} else if (btnIzquierda){
    sprite_index = spt_left_pedro;
} else if (btnArriba){
    sprite_index = spt_up_pedro;
} else if (btnAbajo){
    sprite_index = spt_down_pedro;
} else{
    sprite_index = spt_idle_pedro;
}

// Colision eje x
if (place_meeting(x + paso_x, y, obj_muro)){
    while (!place_meeting(x + sign(paso_x), y, obj_muro)){
        x += sign(paso_x);
    }
    paso_x = 0;
}
x += paso_x;

// Colision eje y
if (place_meeting(x, y + paso_y, obj_muro)){
    while (!place_meeting(x, y + sign(paso_y), obj_muro)) {
        y += sign(paso_y);
    }
    paso_y = 0;
}
y += paso_y;
