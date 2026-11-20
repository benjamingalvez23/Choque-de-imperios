// ----- barra de 4 casillas (siempre visible) -----
var tam = 48, sep = 8;
var bx = 20, by = display_get_gui_height() - tam - 20;
for (var i = 0; i < 4; i++) {
    var xx = bx + i * (tam + sep);
    draw_set_color(c_white);
    draw_rectangle(xx, by, xx + tam, by + tam, true);
    draw_text(xx + 3, by + 2, string(i + 1));
    draw_text(xx + 3, by + 22, string_copy(global.barra[i], 1, 5));
}

if (!abierto) exit;

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// fondo oscuro
draw_set_alpha(0.75);
draw_set_color(c_black);
draw_rectangle(0, 0, gw, gh, false);
draw_set_alpha(1);

// el inventario se dibuja en un lienzo de 512x342 y se escala a la pantalla
var esc  = min(gw / 512, gh / 342);
var offx = (gw - 512 * esc) / 2;
var offy = (gh - 342 * esc) / 2;
matrix_set(matrix_world, matrix_build(offx, offy, 0, 0, 0, 0, esc, esc, 1));

var azul_titulo = make_color_rgb(70, 85, 120);
var naranja     = make_color_rgb(240, 110, 30);
var azul_asig   = make_color_rgb(80, 160, 255);
var cafe        = make_color_rgb(120, 95, 70);

var lista = global.inv[cat];
var n = array_length(lista);

// ================= PANEL IZQUIERDO =================

// título con flechas naranjas
draw_set_color(azul_titulo);
draw_rectangle(4, 4, 222, 44, false);
draw_set_color(naranja);
draw_triangle(14, 24, 28, 12, 28, 36, false);        // flecha izquierda
draw_triangle(212, 24, 198, 12, 198, 36, false);     // flecha derecha
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(113, 16, nombres_cat[cat]);
draw_set_halign(fa_left);

// zona de la mochila (aquí irá la ilustración)
draw_set_color(c_black);
draw_rectangle(4, 50, 222, 208, false);
// CON SPRITE: draw_sprite(spr_mochila, 0, 113, 129);

// cuadro del ítem seleccionado (esquina inferior izquierda)
draw_set_color(c_dkgray);
draw_rectangle(10, 146, 66, 202, true);
// CON SPRITE: draw_sprite(item.spr, 0, 12, 148);

// caja de descripción
dibujar_marco(4, 214, 218, 124);
if (n > 0) {
    var it = lista[sel];
    if (variable_struct_exists(it, "desc")) {
        draw_text_ext(14, 224, it.desc, 14, 198);
    }
}

// ================= PANEL DERECHO =================
dibujar_marco(230, 4, 278, 334);

// franjas decorativas arriba y abajo
draw_set_color(cafe);
draw_rectangle(240, 10, 498, 22, false);
draw_rectangle(240, 320, 498, 332, false);

if (n == 0) {
    draw_set_color(c_white);
    draw_text(262, 40, "Vacío");
}

for (var i = 0; i < max_vis; i++) {
    var idx = i + scroll;
    if (idx >= n) break;

    var item = lista[idx];
    var yy = 34 + i * 34;

    // cursor (triángulo blanco)
    if (idx == sel) {
        draw_set_color(c_white);
        draw_triangle(244, yy + 2, 244, yy + 16, 256, yy + 9, false);
    }

    // nombre
    draw_set_color(c_white);
    draw_text(262, yy, item.nombre);

    // asignación en azul, debajo del nombre
    var c = barra_buscar(item.nombre);
    if (c != -1) {
        draw_set_color(azul_asig);
        draw_text(262, yy + 14, "Casilla " + string(c + 1));
        draw_set_color(c_white);
    }

    // cantidad a la derecha (las armas no llevan)
    if (cat != 0) {
        draw_set_halign(fa_right);
        draw_text(490, yy, "x" + string(item.cant));
        draw_set_halign(fa_left);
    }
}

// flecha naranja de scroll (solo si hay más ítems abajo)
if (scroll + max_vis < n) {
    draw_set_color(naranja);
    draw_triangle(361, 318, 379, 318, 370, 330, false);
}

draw_set_color(c_white);
matrix_set(matrix_world, matrix_build_identity());