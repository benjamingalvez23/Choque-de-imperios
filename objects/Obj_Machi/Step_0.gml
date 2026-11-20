cerca = instance_exists(Player_Lautaro)
     && point_distance(x, y, Player_Lautaro.x, Player_Lautaro.y) <= radio;

// ----- abrir el menú -----
if (!activo) {
    if (cerca && keyboard_check_pressed(ord("E")) && !global.pausa && recogible_cercano() == noone) {
        activo = true;
        global.trueque_abierto = true;
        global.pausa = true;
        ofertas = trueques_de(tipo);
        sel = 0; scroll = 0; mensaje = "";
    }
    exit;
}

// ----- menú abierto -----
var n = array_length(ofertas);
if (keyboard_check_pressed(vk_down)) sel = min(sel + 1, n - 1);
if (keyboard_check_pressed(vk_up))   sel = max(sel - 1, 0);

if (sel >= scroll + max_vis) scroll = sel - max_vis + 1;
if (sel < scroll) scroll = sel;

if (keyboard_check_pressed(vk_enter)) mensaje = trueque_hacer(ofertas[sel]);

if (keyboard_check_pressed(vk_backspace)) {
    activo = false;
    global.trueque_abierto = false;
    global.pausa = false;
}