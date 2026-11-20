draw_set_color(c_purple);
draw_rectangle(x + 4, y + 4, x + 28, y + 28, false);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(x + 16, y - 14, (cerca && !activo) ? "[E] Hablar con " + titulo : titulo);
draw_set_halign(fa_left);
// CON SPRITE: draw_sprite(spr_npc, 0, x, y);