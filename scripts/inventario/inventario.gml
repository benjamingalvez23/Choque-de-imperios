// categorías: 0 = armas, 1 = objetos, 2 = medicinas

function inv_init() {
    global.inv = [ [], [], [] ];        // una lista por categoría
    global.barra = ["", "", "", ""];    // nombre del ítem en cada casilla ("" = vacía)
    global.pausa = false;
	global.trueque_abierto = false;
}

// Más adelante lo usarán los objetos recogibles
function inv_agregar(_cat, _nombre, _cant = 1, _desc = "") {
    var lista = global.inv[_cat];
    for (var i = 0; i < array_length(lista); i++) {
        if (lista[i].nombre == _nombre) {
            if (_cat != 0) lista[i].cant += _cant;   // las armas no se acumulan
            return;
        }
    }
    array_push(lista, { nombre: _nombre, cant: _cant, desc: _desc });
}
// ---------- BARRA ----------
function barra_buscar(_nombre) {
    for (var i = 0; i < 4; i++) {
        if (global.barra[i] == _nombre) return i;
    }
    return -1;   // no está en la barra
}

function barra_asignar(_casilla, _nombre) {
    var previa = barra_buscar(_nombre);
    if (previa != -1) global.barra[previa] = "";   // si ya estaba en otra casilla, se mueve
    global.barra[_casilla] = _nombre;
}

function barra_quitar(_nombre) {
    var p = barra_buscar(_nombre);
    if (p != -1) global.barra[p] = "";
}

function dibujar_marco(_x, _y, _w, _h) {
    draw_set_color(make_color_rgb(120, 95, 70));        // borde café
    draw_rectangle(_x, _y, _x + _w, _y + _h, false);
    draw_set_color(make_color_rgb(70, 50, 35));         // borde interior
    draw_rectangle(_x + 2, _y + 2, _x + _w - 2, _y + _h - 2, false);
    draw_set_color(c_black);                            // fondo
    draw_rectangle(_x + 5, _y + 5, _x + _w - 5, _y + _h - 5, false);
    draw_set_color(c_white);
}
function recogible_cercano() {
    if (!instance_exists(Player_Lautaro)) return noone;
    var p = instance_nearest(Player_Lautaro.x, Player_Lautaro.y, Obj_roca);
    if (p != noone && point_distance(p.x, p.y, Player_Lautaro.x, Player_Lautaro.y) <= p.radio) {
        return p;
    }
	var m =  instance_nearest(Player_Lautaro.x, Player_Lautaro.y, Obj_Mader);
    if (m != noone && point_distance(m.x, m.y, Player_Lautaro.x, Player_Lautaro.y) <= m.radio) {
        return m;
    }
    return noone;
}

// Pasa el ítem al inventario y lo borra del mundo
function recoger(_p) {
    inv_agregar(_p.cat, _p.nombre, _p.cant, _p.desc);
    instance_destroy(_p);
}

// Catálogo de todos los ítems: devuelve su categoría, nombre y descripción
function item_datos(_tipo) {
    switch (_tipo) {

        // ----- ARMAS (cat 0) -----
        case "cuchillo": return { cat:0, nombre:"Cuchillo de piedra", desc:"Filo de piedra amarrado a un mango de madera." };
        case "chuzo":    return { cat:0, nombre:"Chuzo (Lanza)",      desc:"Lanza de coligüe para defender el territorio." };
        case "tupuli":   return { cat:0, nombre:"Tupuli (Hacha)",     desc:"Hecha con madera de Araucaria y piedra volcánica." };

        // ----- OBJETOS (cat 1) -----
        case "piedra":     return { cat:1, nombre:"Piedra",               desc:"Una piedra volcánica." };
        case "madera":     return { cat:1, nombre:"Madera",               desc:"Madera de Araucaria." };
        case "witral":     return { cat:1, nombre:"Witral (Tejido)",      desc:"Tejido que protege de la mala suerte." };
        case "pichunmun":  return { cat:1, nombre:"Pichuñmün (Semillas)", desc:"Semillas para sembrar y recuperar la tierra." };

        // ingredientes para el lawentuchefe
        case "hoja_matico":  return { cat:1, nombre:"Hojas de matico",  desc:"Hojas de matico (palguín). Cicatrizan." };
        case "agua":         return { cat:1, nombre:"Agua limpia",      desc:"Agua limpia para preparar infusiones." };
        case "hoja_llanten": return { cat:1, nombre:"Hojas de llantén", desc:"Hojas frescas de llantén." };
        case "fibra":        return { cat:1, nombre:"Fibra vegetal",    desc:"Fibra para atar y envolver." };
        case "hoja_boldo":   return { cat:1, nombre:"Hojas de boldo",   desc:"Hojas de boldo (foldo)." };
        case "miel":         return { cat:1, nombre:"Miel silvestre",   desc:"Miel recogida del monte." };
        case "canelo":       return { cat:1, nombre:"Corteza de canelo",desc:"Corteza del árbol sagrado, el foye." };
        case "resina":       return { cat:1, nombre:"Resina",           desc:"Resina pegajosa de árbol." };
        case "baya_maqui":   return { cat:1, nombre:"Bayas de maqui",   desc:"Bayas de maqui (këlon)." };
        case "hoja_seca":    return { cat:1, nombre:"Hojas secas",      desc:"Hojas secas para mezclar." };
        case "paico":        return { cat:1, nombre:"Ramitas de paico", desc:"Ramitas de paico." };
        case "ceniza":       return { cat:1, nombre:"Ceniza",           desc:"Ceniza limpia de fogata." };
        case "bailahuen":    return { cat:1, nombre:"Bailahuén",        desc:"Tallos y hojas de bailahuén." };
        case "mineral":      return { cat:1, nombre:"Mineral común",    desc:"Mineral de la cordillera." };

        // ----- MEDICINAS (cat 2) -----
        case "kunulawen":          return { cat:2, nombre:"Künü-Lawen (Planta)",      desc:"Hierba medicinal que restaura vida." };
        case "llucllan":           return { cat:2, nombre:"Llucllan-ngüma (Remedio)", desc:"Remedio que restaura mucha vida." };
        case "agua_matico":        return { cat:2, nombre:"Agua de Matico",           desc:"Cicatrizante y antiinflamatorio." };
        case "cataplasma_llanten": return { cat:2, nombre:"Cataplasma de Llantén",    desc:"Cura rápida de heridas leves." };
        case "infusion_boldo":     return { cat:2, nombre:"Infusión de Boldo",        desc:"Quita la fatiga y el malestar." };
        case "elixir_canelo":      return { cat:2, nombre:"Elixir de Canelo (Foye)",  desc:"Gran curación. Limpia estados negativos." };
        case "tonico_maqui":       return { cat:2, nombre:"Tónico de Maqui",          desc:"Recupera energía y un poco de vida." };
        case "infusion_paico":     return { cat:2, nombre:"Infusión de Paico",        desc:"Cura veneno y toxinas." };
        case "paquete_bailahuen":  return { cat:2, nombre:"Paquete de Bailahuén",     desc:"Restaura la resistencia para explorar." };
    }
    return { cat:1, nombre:"???", desc:"" };
}

// Rellena un Obj_Recogible según su tipo
function recogible_definir(_p, _tipo) {
    var d = item_datos(_tipo);
    _p.cat = d.cat;
    _p.nombre = d.nombre;
    _p.desc = d.desc;
    _p.cant = 1;
}
// cuántos tienes de un ítem (busca en las 3 categorías)
function inv_cantidad(_nombre) {
    for (var c = 0; c < 3; c++) {
        var lista = global.inv[c];
        for (var i = 0; i < array_length(lista); i++) {
            if (lista[i].nombre == _nombre) return lista[i].cant;
        }
    }
    return 0;
}

// quita cantidad de un ítem; si llega a 0 desaparece (y sale de la barra)
function inv_quitar(_nombre, _cant) {
    for (var c = 0; c < 3; c++) {
        var lista = global.inv[c];
        for (var i = 0; i < array_length(lista); i++) {
            if (lista[i].nombre == _nombre) {
                lista[i].cant -= _cant;
                if (lista[i].cant <= 0) {
                    array_delete(lista, i, 1);
                    barra_quitar(_nombre);
                }
                return;
            }
        }
    }
}
// da = lista de [tipo, cantidad] que pide el NPC; recibe = lo que te entrega
function trueque_crear(_da, _recibe, _unico = false) {
    return { da:_da, recibe:_recibe, unico:_unico };
}

function trueques_de(_tipo) {
    if (_tipo == "armas") return [
        trueque_crear([["piedra", 1], ["madera", 1]], "cuchillo", true),
        trueque_crear([["piedra", 2], ["madera", 2]], "chuzo",    true),
        trueque_crear([["madera", 3], ["piedra", 3]], "tupuli",   true)
    ];

    if (_tipo == "medicinas") return [
        trueque_crear([["hoja_matico", 3], ["agua", 1]],        "agua_matico"),
        trueque_crear([["hoja_llanten", 4], ["fibra", 2]],      "cataplasma_llanten"),
        trueque_crear([["hoja_boldo", 3], ["miel", 1]],         "infusion_boldo"),
        trueque_crear([["canelo", 2], ["resina", 2]],           "elixir_canelo"),
        trueque_crear([["baya_maqui", 6], ["hoja_seca", 2]],    "tonico_maqui"),
        trueque_crear([["paico", 3], ["ceniza", 1]],            "infusion_paico"),
        trueque_crear([["bailahuen", 4], ["mineral", 1]],       "paquete_bailahuen")
    ];

    return [];
}

// "" si se puede hacer, o el motivo por el que no
function trueque_puede(_t) {
    var rec = item_datos(_t.recibe);
    if (_t.unico && inv_cantidad(rec.nombre) > 0) return "Ya lo tienes.";
    for (var i = 0; i < array_length(_t.da); i++) {
        var d = item_datos(_t.da[i][0]);
        if (inv_cantidad(d.nombre) < _t.da[i][1]) return "Te faltan materiales.";
    }
    return "";
}

// hace el intercambio y devuelve un mensaje
function trueque_hacer(_t) {
    var motivo = trueque_puede(_t);
    if (motivo != "") return motivo;

    for (var i = 0; i < array_length(_t.da); i++) {
        inv_quitar(item_datos(_t.da[i][0]).nombre, _t.da[i][1]);
    }
    var rec = item_datos(_t.recibe);
    inv_agregar(rec.cat, rec.nombre, 1, rec.desc);
    return "Trato hecho.";
}

// NPC de trueque al alcance del jugador
function npc_cercano() {
    if (!instance_exists(Player_Lautaro)) return noone;
    var n = instance_nearest(Player_Lautaro.x, Player_Lautaro.y, Obj_Machi);
    if (n != noone && point_distance(n.x, n.y, Player_Lautaro.x, Player_Lautaro.y) <= n.radio) return n;
    return noone;
}