if(instance_exists(Player_Lautaro)){
	var objetivo_x = Player_Lautaro.x;
	var objetivo_y = Player_Lautaro.y;
	
	var cam_x = camera_get_view_x(cam);
	var cam_y = camera_get_view_y(cam);

    // Tamaño de la cámara
    var ancho = camera_get_view_width(cam);
    var alto = camera_get_view_height(cam);

    // Calcular posición para centrar al jugador
    var nueva_x = objetivo_x - ancho / 2;
    var nueva_y = objetivo_y - alto / 2;

    // Movimiento suave
    nueva_x = lerp(cam_x, nueva_x, velocidad);
    nueva_y = lerp(cam_y, nueva_y, velocidad);

    // Actualizar cámara
    camera_set_view_pos(cam, nueva_x, nueva_y);
}