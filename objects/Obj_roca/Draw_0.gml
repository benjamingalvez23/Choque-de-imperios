// marcador provisional (se cambia por sprite después)
draw_set_color(c_gray);
draw_rectangle(x + 6, y + 6, x + 26, y + 26, false);
draw_set_color(c_white);

// aviso si el jugador está al alcance
if (instance_exists(Player_Lautaro)
    && point_distance(x, y, Player_Lautaro.x, Player_Lautaro.y) <= radio) {
    draw_set_halign(fa_center);
    draw_text(x + 16, y - 14, "[E] Recoger " + nombre);
    draw_set_halign(fa_left);
}