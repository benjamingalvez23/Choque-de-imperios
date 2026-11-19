draw_self();

// Solo se dibuja cuando la vida sea mernor a 100
if (vida < vida_max){
	 // Revisa la id del muro
    switch (id_muro)
    {
        case 1: // Muro Norte
		    // x1=352 y x2=992: 640 px de largo, igual que el muro | y1=68 y y2=84: 16 px de grosor, 12 px sobre el muro (que empieza en y=96)
		    draw_healthbar(352, 68, 992, 84, vida, c_black, c_red, c_green, 0, true, true);
		    break;

        case 2: // Muro este
            // x1=1004 y x2=1020: 16 px de grosor, 12 px a la derecha del muro | y1=192 y y2=608: 416 px de largo, igual que el muro
            draw_healthbar(1004, 192, 1020, 608, vida, c_black, c_red, c_green, 3, true, true);
            break;

        case 3: // Muro Sur
            // x1=352 y x2=992: 640 px de largo, igual que el muro | y1=684 y y2=700: 16 px de grosor, 12 px bajo el muro
            draw_healthbar(352, 684, 992, 700, vida, c_black, c_red, c_green, 0, true, true);
            break;

        case 4: // Muro Oeste
            // x1=324 y x2=340: 16 px de grosor, 12 px a la izquierda del muro | y1=192 y y2=608: 416 px de largo, igual que el muro
            draw_healthbar(324, 192, 340, 608, vida, c_black, c_red, c_green, 3, true, true);
            break;
    }
}