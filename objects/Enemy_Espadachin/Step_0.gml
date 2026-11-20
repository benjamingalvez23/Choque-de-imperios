if (global.pausa) exit;

// Muerte (da furia al jugador)
if (vida <= 0)
{
	if (instance_exists(objeto_jugador))
	{
		var j = instance_nearest(x, y, objeto_jugador);
		j.ganar_furia(furia_al_morir);
	}
	instance_destroy();
	exit;
}

// Movimiento en curso
if (moviendo)
{
	x += sign(dest_x - x) * min(spd, abs(dest_x - x));
	y += sign(dest_y - y) * min(spd, abs(dest_y - y));
	
	if (x == dest_x && y == dest_y) moviendo = false;
	exit;
}

// Buscar al jugador
if (!instance_exists(objeto_jugador)) exit;
var jugador = instance_nearest(x, y, objeto_jugador);

// Alinearse a la grilla del jugador (una vez, sin esperar a que se detenga)
if (!alineado)
{
	x = jugador.dest_x + round((x - jugador.dest_x) / 32) * 32;
	y = jugador.dest_y + round((y - jugador.dest_y) / 32) * 32;
	dest_x = x;
	dest_y = y;
	alineado = true;
}

// Distancia en casillas
var dcx = round((jugador.x - x) / 32);
var dcy = round((jugador.y - y) / 32);
var adyacente = (abs(dcx) + abs(dcy) == 1);
var dist = point_distance(x, y, jugador.x, jugador.y);

switch (estado)
{
	case "perseguir":
		if (adyacente)
		{
			estado = "preparando";
			timer = tiempo_preparacion;
			break;
		}
		
		if (dist > rango_vision) break;
		
		var mx = 0;
		var my = 0;
		
		if (abs(dcx) >= abs(dcy)) mx = sign(dcx);
		else my = sign(dcy);
		
		// Si está bloqueado, probar el otro eje
		if (!puede_mover(mx, my))
		{
			if (mx != 0) { mx = 0; my = sign(dcy); }
			else { my = 0; mx = sign(dcx); }
		}
		
		if ((mx != 0 || my != 0) && puede_mover(mx, my))
		{
			dest_x = x + mx * 32;
			dest_y = y + my * 32;
			moviendo = true;
		}
	break;
	
	case "preparando":
		timer--;
		if (timer <= 0)
		{
			if (adyacente)
			{
				jugador.recibir_danio(danio);
				show_debug_message("¡JUGADOR GOLPEADO POR ESPADACHIN!");
			}
			estado = "cooldown";
			timer = tiempo_cooldown;
		}
	break;
	
	case "cooldown":
		timer--;
		if (timer <= 0) estado = "perseguir";
	break;
}