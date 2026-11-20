if (!activo) exit;

var gw = display_get_gui_width();
var gh = display_get_gui_height();

draw_set_alpha(0.75);
draw_set_color(c_black);
draw_rectangle(0, 0, gw, gh, false);
draw_set_alpha(1);

var esc  = min(gw / 512, gh / 342);
var offx = (gw - 512 * esc) / 2;
var offy = (gh - 342 * esc) / 2;
matrix_set(matrix_world, matrix_build(offx, offy, 0, 0, 0, 0, esc, esc, 1));

var azul_titulo = make_color_rgb(70, 85, 120);
var naranja     = make_color_rgb(240, 110, 30);
var cafe        = make_color_rgb(120, 95, 70);

var n = array_length(ofertas);
var t = ofertas[sel];
var rec = item_datos(t.recibe);

// ================= PANEL IZQUIERDO =================
// título
draw_set_color(azul_titulo);
draw_rectangle(4, 4, 222, 44, false);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(113, 16, titulo);
draw_set_halign(fa_left);

// zona del personaje
draw_set_color(c_black);
draw_rectangle(4, 50, 222, 208, false);
// CON SPRITE: draw_sprite(spr_npc_grande, 0, 113, 129);

// caja de detalle
dibujar_marco(4, 214, 218, 124);
draw_set_color(c_white);
draw_text(14, 222, "Recibes: " + rec.nombre);
draw_text(14, 238, "Pide:");
for (var j = 0; j < array_length(t.da); j++) {
    var d = item_datos(t.da[j][0]);
    var tengo = inv_cantidad(d.nombre);
    var necesito = t.da[j][1];
    draw_set_color(tengo >= necesito ? c_lime : c_red);
    draw_text(24, 252 + j * 14, string(necesito) + "x " + d.nombre + " (" + string(tengo) + "/" + string(necesito) + ")");
}
draw_set_color(c_yellow);
draw_text(14, 290, mensaje);
draw_set_color(c_white);
draw_text(14, 308, "Enter: intercambiar");
draw_text(14, 322, "Backspace: salir");

// ================= PANEL DERECHO =================
dibujar_marco(230, 4, 278, 334);
draw_set_color(cafe);
draw_rectangle(240, 10, 498, 22, false);
draw_rectangle(240, 320, 498, 332, false);

for (var i = 0; i < max_vis; i++) {
    var idx = i + scroll;
    if (idx >= n) break;

    var o  = ofertas[idx];
    var r  = item_datos(o.recibe);
    var yy = 34 + i * 34;
    var ya = (o.unico && inv_cantidad(r.nombre) > 0);

    if (idx == sel) {
        draw_set_color(c_white);
        draw_triangle(244, yy + 2, 244, yy + 16, 256, yy + 9, false);
    }

    draw_set_color(ya ? c_gray : c_white);
    draw_text(262, yy, r.nombre);
    if (ya) {
        draw_set_halign(fa_right);
        draw_text(490, yy, "Obtenido");
        draw_set_halign(fa_left);
    }
}

if (scroll + max_vis < n) {
    draw_set_color(naranja);
    draw_triangle(361, 318, 379, 318, 370, 330, false);
}

draw_set_color(c_white);
matrix_set(matrix_world, matrix_build_identity());