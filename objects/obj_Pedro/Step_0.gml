btnDerecha   = keyboard_check(vk_right);
btnIzquierda = keyboard_check(vk_left);
btnArriba    = keyboard_check(vk_up);
btnAbajo     = keyboard_check(vk_down);

if (btnDerecha) {
    x += 4;
	sprite_index = spt_right_pedro;
}
else if (btnIzquierda) {
    x -= 4;
	sprite_index = spt_left_pedro;
}
else if (btnArriba) {
    y -= 4;
	sprite_index = spt_up_pedro;
}
else if (btnAbajo) {
    y += 4;
	sprite_index = spt_down_pedro;
}
else{
	sprite_index = spt_idle_pedro;
}