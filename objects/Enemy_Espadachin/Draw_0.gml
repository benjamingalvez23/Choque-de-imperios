image_blend = (estado == "preparando") ? c_red : c_white;
draw_self();

var p = clamp(vida / vida_maxima, 0, 1);

draw_set_color(c_red);
draw_rectangle(x, y - 8, x + 32, y - 4, false);
draw_set_color(c_lime);
draw_rectangle(x, y - 8, x + (32 * p), y - 4, false);
draw_set_color(c_white);