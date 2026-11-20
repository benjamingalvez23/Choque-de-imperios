if (keyboard_check_pressed(ord("E")) && !global.trueque_abierto) {
    var p = abierto ? noone : recogible_cercano();
    if (p != noone) {
        recoger(p);
    } else if (abierto || npc_cercano() == noone) {
        abierto = !abierto;
        global.pausa = abierto;
    }
}
if (!abierto) exit;

if (keyboard_check_pressed(vk_right)) { cat = (cat + 1) mod 3; sel = 0; scroll = 0; }
if (keyboard_check_pressed(vk_left))  { cat = (cat + 2) mod 3; sel = 0; scroll = 0; }

var n = array_length(global.inv[cat]);
sel = clamp(sel, 0, max(n - 1, 0));
if (n > 0) {
    if (keyboard_check_pressed(vk_down)) sel = min(sel + 1, n - 1);
    if (keyboard_check_pressed(vk_up))   sel = max(sel - 1, 0);

    if (sel >= scroll + max_vis) scroll = sel - max_vis + 1;
    if (sel < scroll) scroll = sel;

    if (cat == 0 || cat == 2) {
        var nombre = global.inv[cat][sel].nombre;
        for (var i = 0; i < 4; i++) {
            if (keyboard_check_pressed(ord("1") + i)) barra_asignar(i, nombre);
        }
        if (keyboard_check_pressed(vk_backspace)) barra_quitar(nombre);
    }
}