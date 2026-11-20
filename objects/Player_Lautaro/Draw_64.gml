var p_vida  = clamp(vida / vida_maxima, 0, 1);
var p_furia = clamp(furia / furia_maxima, 0, 1);

draw_set_color(c_red);
draw_rectangle(20, 20, 220, 45, false);

draw_set_color(c_lime);
draw_rectangle(20, 20, 20 + 200 * p_vida, 45, false);

draw_set_color(c_white);
draw_text(20, 50, "Vida: " + string(vida) + " / " + string(vida_maxima));

// -------- Furia --------
draw_set_color(c_black);
draw_rectangle(20, 85, 220, 105, false);

draw_set_color(furia_activa ? c_orange : c_blue);
draw_rectangle(20, 85, 20 + 200 * p_furia, 105, false);

draw_set_color(c_white);
if (furia_activa)
{
	var seg = ceil(tiempo_furia / game_get_speed(gamespeed_fps));
	draw_text(20, 108, "¡FURIA ACTIVA! " + string(seg) + " s");
}
else if (furia >= furia_maxima)
{
	draw_text(20, 108, "Furia lista: presiona R");
}
else
{
	draw_text(20, 108, "Furia: " + string(floor(furia)) + " / " + string(furia_maxima));
}

draw_set_color(c_white);
